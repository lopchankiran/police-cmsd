<?php
session_start();
require_once __DIR__ . '/config.php';

// HTML-escape helper
function h($s) {
    return htmlspecialchars($s, ENT_QUOTES, 'UTF-8');
}

// Only allow forensic officers
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'forensic_officer') {
    header('Location: login.php');
    exit;
}

$db = getDbConnection();
$officer_id = $_SESSION['user_id'] ?? 0;
$username   = h($_SESSION['username'] ?? '');

$errors  = [];
$success = '';

// ─────────────────────────────────────────────────────────────────────────────
// 1) Evidence Upload Handler
// ─────────────────────────────────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['upload_evidence'])) {
    $title       = trim($_POST['title'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $tags        = trim($_POST['tags'] ?? '');
    $file        = $_FILES['evidence_file'] ?? null;

    if ($title === '') {
        $errors[] = 'Title is required.';
    }
    if (!$file || $file['error'] !== UPLOAD_ERR_OK) {
        $errors[] = 'Please select a file to upload.';
    }

    $allowed = ['jpg','jpeg','png','pdf','docx','mp4','avi','mov'];
    $ext     = strtolower(pathinfo($file['name'] ?? '', PATHINFO_EXTENSION));
    if ($file && !in_array($ext, $allowed)) {
        $errors[] = 'Invalid file type. Allowed: ' . implode(', ', $allowed);
    }

    if (empty($errors)) {
        $uploadDir = __DIR__ . '/uploads/';
        if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);

        $newName  = uniqid('evi_') . '.' . $ext;
        $destPath = $uploadDir . $newName;

        if (move_uploaded_file($file['tmp_name'], $destPath)) {
            $relPath = 'uploads/' . $newName;
            $stmt    = $db->prepare(
                "INSERT INTO evidence (officer_id, title, description, file_path, tags)
                 VALUES (?, ?, ?, ?, ?)"
            );
            $stmt->bind_param('issss', $officer_id, $title, $description, $relPath, $tags);
            if ($stmt->execute()) {
    $success = 'Evidence uploaded successfully.';

    // ✅ CORRECT: get the new ID from the connection
    $evidenceId = $db->insert_id;

    // Log chain-of-custody
    $logStmt = $db->prepare(
        "INSERT INTO custody_log (evidence_id, officer_id, action, timestamp)
         VALUES (?, ?, ?, NOW())"
    );
    $action = 'Uploaded evidence';
    $logStmt->bind_param('iis', $evidenceId, $officer_id, $action);
    $logStmt->execute();
    $logStmt->close();
}
 
            else {
                $errors[] = 'Database error: ' . $stmt->error;
                unlink($destPath);
            }
            $stmt->close();
        } else {
            $errors[] = 'Failed to move uploaded file.';
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2) Case Analysis Tool Handler
// ─────────────────────────────────────────────────────────────────────────────
$analysisSummary    = null;
$suspiciousKeywords = [
    'threat','attack','bomb','explosive','weapon','gun','kill','terror'
];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['upload_analysis'])) {
    $aTitle       = trim($_POST['title'] ?? '');
    $aDescription = trim($_POST['description'] ?? '');
    $afile        = $_FILES['evidence_file'] ?? null;

    if ($aTitle === '') {
        $errors[] = 'Analysis title is required.';
    }
    if (!$afile || $afile['error'] !== UPLOAD_ERR_OK) {
        $errors[] = 'Please select a file to analyze.';
    }

    $allowedA = ['txt','log','csv','json','xml'];
    $aExt     = strtolower(pathinfo($afile['name'] ?? '', PATHINFO_EXTENSION));
    if ($afile && !in_array($aExt, $allowedA)) {
        $errors[] = 'Invalid analysis file type. Allowed: ' . implode(', ', $allowedA);
    }

    if (empty($errors)) {
        $aDir = __DIR__ . '/uploads/forensic_analysis/';
        if (!is_dir($aDir)) mkdir($aDir, 0755, true);

        $aName    = uniqid('fanal_') . '.' . $aExt;
        $destPath = $aDir . $aName;

        if (move_uploaded_file($afile['tmp_name'], $destPath)) {
            $relPath = 'uploads/forensic_analysis/' . $aName;
            $content = file_get_contents($destPath);

            // Metadata extraction
            preg_match_all('/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/', $content, $timestamps);
            preg_match_all('/GPS[: ]?(-?\d+\.\d+),\s*(-?\d+\.\d+)/i', $content, $gps);
            preg_match_all('/Device[: ]?([A-Za-z0-9\s]+)/i', $content, $devices);

            // Keyword detection
            $lower = strtolower($content);
            $found = [];
            foreach ($suspiciousKeywords as $kw) {
                if (strpos($lower, $kw) !== false) {
                    $found[] = $kw;
                }
            }

            $metadata = [
                'file_size'          => filesize($destPath),
                'word_count'         => str_word_count($content),
                'timestamps_found'   => count($timestamps[0]),
                'sample_timestamps'  => array_slice($timestamps[0], 0, 5),
                'gps_coords'         => $gps ? array_map(null, $gps[1], $gps[2]) : [],
                'device_info'        => $devices[1] ?? [],
                'suspicious_keywords'=> $found,
            ];

            // Store in forensic_evidence table
            $stmt = $db->prepare(
                "INSERT INTO forensic_evidence
                 (officer_id, title, description, file_path, metadata, content)
                 VALUES (?, ?, ?, ?, ?, ?)"
            );
            $metaJson = json_encode($metadata);
            $stmt->bind_param(
                'isssss',
                $officer_id,
                $aTitle,
                $aDescription,
                $relPath,
                $metaJson,
                $content
            );
            if ($stmt->execute()) {
                $success         = 'File uploaded & analyzed successfully.';
                $analysisSummary = $metadata;
            } else {
                $errors[] = 'DB error: ' . $stmt->error;
                unlink($destPath);
            }
            $stmt->close();
        } else {
            $errors[] = 'Failed to move analysis file.';
        }
    }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3) Fetch Recent Evidence (Upload & Manage tab)
// ─────────────────────────────────────────────────────────────────────────────
$where       = [];
$params      = [];
$types       = '';
$searchTitle = trim($_GET['search_title'] ?? '');
$filterTags  = trim($_GET['filter_tags'] ?? '');

if ($searchTitle !== '') {
    $where[]  = 'title LIKE ?';
    $params[] = "%{$searchTitle}%";
    $types   .= 's';
}
if ($filterTags !== '') {
    $where[]  = 'FIND_IN_SET(?, tags)';
    $params[] = $filterTags;
    $types   .= 's';
}
$whereSQL = $where ? 'WHERE ' . implode(' AND ', $where) : '';

$sql = "
    SELECT evidence_id, officer_id, title, description, file_path, tags, uploaded_at
      FROM evidence
      {$whereSQL}
     ORDER BY uploaded_at DESC
     LIMIT 15
";
$stmt = $db->prepare($sql);
if ($whereSQL) {
    $stmt->bind_param($types, ...$params);
}
$stmt->execute();
$recent = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

// ─────────────────────────────────────────────────────────────────────────────
// 4) Fetch Chain of Custody Logs
// ─────────────────────────────────────────────────────────────────────────────
$logSql = "
    SELECT cl.id, cl.evidence_id, cl.action, cl.timestamp AS action_time, s.username
      FROM custody_log cl
 LEFT JOIN staff s ON cl.officer_id = s.id
 ORDER BY cl.timestamp DESC
 LIMIT 15
";
$logResult    = $db->query($logSql);
$custody_logs = $logResult ? $logResult->fetch_all(MYSQLI_ASSOC) : [];

// ─────────────────────────────────────────────────────────────────────────────
// 5) Fetch Forensic Evidence List (Analysis tab)
// ─────────────────────────────────────────────────────────────────────────────
$searchTerm = trim($_GET['search_term'] ?? '');
$whereA     = '';
$paramsA    = [];
$typesA     = '';
if ($searchTerm !== '') {
    $whereA   = 'WHERE content LIKE ?';
    $paramsA[] = "%{$searchTerm}%";
    $typesA   = 's';
}
$sqlA = "
    SELECT id, title, description, file_path, metadata, uploaded_at, content
      FROM forensic_evidence
      {$whereA}
     ORDER BY uploaded_at DESC
     LIMIT 20
";
$stmt = $db->prepare($sqlA);
if ($whereA) {
    $stmt->bind_param($typesA, ...$paramsA);
}
$stmt->execute();
$evidenceList = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Forensic Analytics Portal</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
    defer
  ></script>
  <style>
    body             { background: #f4f6f9; }
    .card           { border-radius: 1rem; }
    .evidence-link  { text-decoration: underline; color: #0056b3; }
    .tag-badge      { cursor: pointer; }
    .content-row    { display: none; white-space: pre-wrap;
                       background: #f0f0f0; font-family: monospace;
                       max-height: 300px; overflow-y: auto; }
    .badge-suspicious { background-color: #dc3545; color: #fff; }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="#">
      <i class="fas fa-microscope me-2"></i> Forensic Analytics
    </a>
    <span class="navbar-text text-light">
      <i class="fa fa-user me-1"></i><?= $username ?>
    </span>
    <a href="logout.php" class="btn btn-outline-light ms-3">Log Out</a>
  </div>
</nav>

<div class="container mb-5">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs mb-4" id="forensicTabs" role="tablist">
    <li class="nav-item" role="presentation">
      <button
        class="nav-link active"
        id="upload-tab"
        data-bs-toggle="tab"
        data-bs-target="#upload"
        type="button"
        role="tab"
        aria-controls="upload"
        aria-selected="true"
      >
        <i class="fas fa-upload me-1"></i> Upload & Manage Evidence
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="analysis-tab"
        data-bs-toggle="tab"
        data-bs-target="#analysis"
        type="button"
        role="tab"
        aria-controls="analysis"
        aria-selected="false"
      >
        <i class="fas fa-chart-line me-1"></i> Case Analysis Tools
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="reports-tab"
        data-bs-toggle="tab"
        data-bs-target="#reports"
        type="button"
        role="tab"
        aria-controls="reports"
        aria-selected="false"
      >
        <i class="fas fa-file-alt me-1"></i> Generate Reports
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="chain-tab"
        data-bs-toggle="tab"
        data-bs-target="#chain"
        type="button"
        role="tab"
        aria-controls="chain"
        aria-selected="false"
      >
        <i class="fas fa-link me-1"></i> Chain of Custody Tracking
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="collab-tab"
        data-bs-toggle="tab"
        data-bs-target="#collab"
        type="button"
        role="tab"
        aria-controls="collab"
        aria-selected="false"
      >
        <i class="fas fa-comments me-1"></i> Collaboration
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="search-tab"
        data-bs-toggle="tab"
        data-bs-target="#search"
        type="button"
        role="tab"
        aria-controls="search"
        aria-selected="false"
      >
        <i class="fas fa-search me-1"></i> Search & Filter Evidence
      </button>
    </li>
  </ul>

  <div class="tab-content" id="forensicTabsContent">
    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Upload & Manage Evidence Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->
    <div
      class="tab-pane fade show active"
      id="upload"
      role="tabpanel"
      aria-labelledby="upload-tab"
    >
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-white">
          <h4 class="mb-0">
            <i class="fas fa-upload text-primary me-2"></i> Upload Digital Evidence
          </h4>
        </div>
        <div class="card-body">
          <?php if ($errors && isset($_POST['upload_evidence'])): ?>
            <div class="alert alert-danger"><ul class="mb-0">
              <?php foreach ($errors as $e): ?><li><?= h($e) ?></li><?php endforeach; ?>
            </ul></div>
          <?php elseif ($success && isset($_POST['upload_evidence'])): ?>
            <div class="alert alert-success"><?= h($success) ?></div>
          <?php endif; ?>

          <form method="post" enctype="multipart/form-data" class="row g-3 mb-3">
            <div class="col-md-5">
              <label class="form-label">Title</label>
              <input type="text" name="title" class="form-control" required />
            </div>
            <div class="col-md-5">
              <label class="form-label">Tags (comma-separated)</label>
              <input
                type="text"
                name="tags"
                class="form-control"
                placeholder="e.g. video, phone, chat"
              />
            </div>
            <div class="col-md-5">
              <label class="form-label">Evidence File</label>
              <input
                type="file"
                name="evidence_file"
                class="form-control"
                accept=".jpg,.jpeg,.png,.pdf,.docx,.mp4,.avi,.mov"
                required
              />
              <div class="form-text">
                Allowed: JPG, JPEG, PNG, PDF, DOCX, MP4, AVI, MOV.
              </div>
            </div>
            <div class="col-md-12">
              <label class="form-label">Description</label>
              <textarea name="description" class="form-control" rows="2"></textarea>
            </div>
            <div class="col-12 text-end">
              <button class="btn btn-primary" name="upload_evidence" value="1">
                <i class="fas fa-upload me-1"></i> Upload
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Recent Evidence Table -->
      <div class="card shadow-sm">
        <div class="card-header bg-white"><strong>Recent Digital Evidence</strong></div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped table-hover mb-0 align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Officer ID</th>
                  <th>Title</th>
                  <th>Tags</th>
                  <th>Uploaded At</th>
                  <th>File</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($recent)): ?>
                  <tr>
                    <td colspan="7" class="text-center text-muted">No evidence found.</td>
                  </tr>
                <?php else: foreach ($recent as $ev): ?>
                  <tr>
                    <td><?= h($ev['evidence_id']) ?></td>
                    <td><?= h($ev['officer_id']) ?></td>
                    <td><?= h($ev['title']) ?></td>
                    <td>
                      <?php
                        foreach (explode(',', $ev['tags'] ?? '') as $t) {
                          $t = trim($t);
                          if ($t) {
                            echo '<span class="badge bg-info text-dark me-1 tag-badge">'
                               . h($t)
                               . '</span>';
                          }
                        }
                      ?>
                    </td>
                    <td><?= h($ev['uploaded_at']) ?></td>
                    <td>
                      <?php if ($ev['file_path']): ?>
                        <a
                          href="<?= h($ev['file_path']) ?>"
                          class="evidence-link"
                          target="_blank"
                        >View File</a>
                      <?php else: ?>
                        <span class="text-muted">None</span>
                      <?php endif; ?>
                    </td>
                    <td><?= nl2br(h($ev['description'])) ?></td>
                  </tr>
                <?php endforeach; endif; ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Case Analysis Tools Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->
    <div
      class="tab-pane fade"
      id="analysis"
      role="tabpanel"
      aria-labelledby="analysis-tab"
    >
      <div class="container py-3">
        <h2 class="mb-4">Upload and Analyze Forensic Data</h2>

        <?php if ($errors && isset($_POST['upload_analysis'])): ?>
          <div class="alert alert-danger">
            <ul>
              <?php foreach ($errors as $e): ?>
                <li><?= h($e) ?></li>
              <?php endforeach; ?>
            </ul>
          </div>
        <?php endif; ?>

        <?php if ($success && isset($_POST['upload_analysis'])): ?>
          <div class="alert alert-success"><?= h($success) ?></div>
          <div class="card mb-4 p-3 shadow-sm">
            <h5>Analysis Summary</h5>
            <ul>
              <li>
                <strong>File Size:</strong>
                <?= number_format($analysisSummary['file_size'] / 1024, 2) ?> KB
              </li>
              <li>
                <strong>Word Count:</strong>
                <?= $analysisSummary['word_count'] ?>
              </li>
              <li>
                <strong>Timestamps Found:</strong>
                <?= $analysisSummary['timestamps_found'] ?>
              </li>
              <?php if (!empty($analysisSummary['sample_timestamps'])): ?>
                <li>
                  <strong>Sample Timestamps:</strong>
                  <ul class="mb-0">
                    <?php foreach ($analysisSummary['sample_timestamps'] as $ts): ?>
                      <li><?= h($ts) ?></li>
                    <?php endforeach; ?>
                  </ul>
                </li>
              <?php endif; ?>
              <?php if (!empty($analysisSummary['gps_coords'])): ?>
                <li>
                  <strong>GPS Coordinates:</strong>
                  <ul class="mb-0">
                    <?php foreach ($analysisSummary['gps_coords'] as $c): ?>
                      <li><?= h($c[0]) ?>, <?= h($c[1]) ?></li>
                    <?php endforeach; ?>
                  </ul>
                </li>
              <?php endif; ?>
              <?php if (!empty($analysisSummary['device_info'])): ?>
                <li>
                  <strong>Device Info:</strong>
                  <ul class="mb-0">
                    <?php foreach ($analysisSummary['device_info'] as $d): ?>
                      <li><?= h($d) ?></li>
                    <?php endforeach; ?>
                  </ul>
                </li>
              <?php endif; ?>
              <?php if (!empty($analysisSummary['suspicious_keywords'])): ?>
                <li>
                  <strong>Suspicious Keywords Detected:</strong>
                  <?php foreach ($analysisSummary['suspicious_keywords'] as $kw): ?>
                    <span class="badge badge-suspicious me-1"><?= h($kw) ?></span>
                  <?php endforeach; ?>
                </li>
              <?php endif; ?>
            </ul>
          </div>
        <?php endif; ?>

        <form
          method="post"
          enctype="multipart/form-data"
          class="mb-4 row g-3"
        >
          <div class="col-md-5">
            <label class="form-label">Title</label>
            <input
              type="text"
              name="title"
              class="form-control"
              required
            />
          </div>
          <div class="col-md-7">
            <label class="form-label">Description</label>
            <input type="text" name="description" class="form-control" />
          </div>
          <div class="col-md-7">
            <label class="form-label">Upload File (txt, log, csv, json, xml)</label>
            <input
              type="file"
              name="evidence_file"
              class="form-control"
              accept=".txt,.log,.csv,.json,.xml"
              required
            />
          </div>
          <div class="col-md-5 align-self-end">
            <button
              class="btn btn-primary w-100"
              name="upload_analysis"
              value="1"
            >
              <i class="fas fa-upload me-1"></i> Upload & Analyze
            </button>
          </div>
        </form>

        <form method="get" class="mb-4 row g-3">
          <div class="col-md-10">
            <input
              type="text"
              name="search_term"
              class="form-control"
              placeholder="Search within uploaded content"
              value="<?= h($searchTerm) ?>"
            />
          </div>
          <div class="col-md-2">
            <button class="btn btn-secondary w-100" type="submit">
              <i class="fa fa-search me-1"></i> Search
            </button>
          </div>
        </form>

        <h4>Uploaded Evidence</h4>
        <div class="table-responsive">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Uploaded At</th>
                <th>Metadata</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <?php if (empty($evidenceList)): ?>
                <tr>
                  <td colspan="5" class="text-center">No evidence uploaded.</td>
                </tr>
              <?php else: foreach ($evidenceList as $ev): ?>
                <?php $meta = json_decode($ev['metadata'], true); ?>
                <tr>
                  <td><?= h($ev['title']) ?></td>
                  <td><?= h($ev['description']) ?></td>
                  <td><?= h($ev['uploaded_at']) ?></td>
                  <td>
                    File Size: <?= number_format($meta['file_size']/1024,2) ?> KB<br>
                    Words: <?= $meta['word_count'] ?><br>
                    Timestamps: <?= $meta['timestamps_found'] ?><br>
                  </td>
                  <td>
                    <a
                      href="<?= h($ev['file_path']) ?>"
                      class="btn btn-sm btn-outline-primary"
                      target="_blank"
                    >View File</a>
                    <button
                      class="btn btn-sm btn-outline-secondary"
                      type="button"
                      onclick="toggleContent(<?= $ev['id'] ?>)"
                    >View Content</button>
                  </td>
                </tr>
                <tr
                  id="content-<?= $ev['id'] ?>"
                  class="content-row"
                  style="display:none"
                >
                  <td colspan="5"><pre><?= h($ev['content']) ?></pre></td>
                </tr>
              <?php endforeach; endif; ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Generate Reports Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->


<div class="tab-pane fade" id="reports" role="tabpanel" aria-labelledby="reports-tab">
  <div class="card shadow-sm p-3">
    <h5>Generate Forensic Reports</h5>
    <p>Create detailed forensic reports including evidence summaries.</p>

    <form method="post" action="generate_report.php">
      <div class="mb-3">
        <label for="report_type" class="form-label">Report Type</label>
        <select name="report_type" id="report_type" class="form-select">
          <option value="evidence_summary">Evidence Summary</option>
          <option value="full_forensic">Full Forensic Evidence</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-file-pdf me-1"></i> Generate PDF Report
      </button>
    </form>
  </div>
</div>



    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Chain of Custody Tracking Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->
    <div class="tab-pane fade" id="chain" role="tabpanel" aria-labelledby="chain-tab">
      <div class="card shadow-sm">
        <div class="card-header bg-white"><strong>Chain of Custody Log</strong></div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped table-hover mb-0 align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Evidence ID</th>
                  <th>User</th>
                  <th>Action</th>
                  <th>Time</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($custody_logs)): ?>
                  <tr>
                    <td colspan="5" class="text-center text-muted">No logs found.</td>
                  </tr>
                <?php else: foreach ($custody_logs as $log): ?>
                  <tr>
                    <td><?= h($log['id']) ?></td>
                    <td><?= h($log['evidence_id']) ?></td>
                    <td><?= h($log['username'] ?? 'Unknown') ?></td>
                    <td><?= h($log['action']) ?></td>
                    <td><?= h($log['action_time']) ?></td>
                  </tr>
                <?php endforeach; endif; ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Collaboration Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->
    <div
      class="tab-pane fade"
      id="collab"
      role="tabpanel"
      aria-labelledby="collab-tab"
      style="height:750px"
    >
      <iframe
        src="forensic_collab.php"
        style="width:100%; height:100%; border:none;"
      ></iframe>
    </div>

    <!-- ─────────────────────────────────────────────────────────────── -->
    <!-- Search & Filter Evidence Tab -->
    <!-- ─────────────────────────────────────────────────────────────── -->
    <div
      class="tab-pane fade"
      id="search"
      role="tabpanel"
      aria-labelledby="search-tab"
    >
      <div class="card shadow-sm p-3">
        <h5>Search & Filter Evidence</h5>
        <form method="get" class="row g-3 mb-3">
          <div class="col-md-5">
            <input
              type="text"
              name="search_title"
              class="form-control"
              placeholder="Search by Evidence Title"
              value="<?= h($searchTitle) ?>"
            />
          </div>
          <div class="col-md-5">
            <input
              type="text"
              name="filter_tags"
              class="form-control"
              placeholder="Filter by Tag"
              value="<?= h($filterTags) ?>"
            />
          </div>
          <div class="col-md-2">
            <button class="btn btn-secondary w-100" type="submit">
              <i class="fa fa-search me-1"></i> Filter
            </button>
          </div>
        </form>

        <hr />

        <div class="table-responsive">
          <table class="table table-striped table-hover align-middle">
            <thead>
              <tr>
                <th>ID</th>
                <th>Officer ID</th>
                <th>Title</th>
                <th>Tags</th>
                <th>Uploaded At</th>
                <th>File</th>
                <th>Description</th>
              </tr>
            </thead>
            <tbody>
              <?php if (empty($recent)): ?>
                <tr>
                  <td colspan="7" class="text-center text-muted">No evidence found.</td>
                </tr>
              <?php else: foreach ($recent as $ev): ?>
                <tr>
                  <td><?= h($ev['evidence_id']) ?></td>
                  <td><?= h($ev['officer_id']) ?></td>
                  <td><?= h($ev['title']) ?></td>
                  <td>
                    <?php
                      foreach (explode(',', $ev['tags'] ?? '') as $t) {
                        $t = trim($t);
                        if ($t) {
                          echo '<span class="badge bg-info text-dark me-1 tag-badge">'
                             . h($t)
                             . '</span>';
                        }
                      }
                    ?>
                  </td>
                  <td><?= h($ev['uploaded_at']) ?></td>
                  <td>
                    <?php if ($ev['file_path']): ?>
                      <a
                        href="<?= h($ev['file_path']) ?>"
                        class="evidence-link"
                        target="_blank"
                      >View File</a>
                    <?php else: ?>
                      <span class="text-muted">None</span>
                    <?php endif; ?>
                  </td>
                  <td><?= nl2br(h($ev['description'])) ?></td>
                </tr>
              <?php endforeach; endif; ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleContent(id) {
  const el = document.getElementById('content-' + id);
  el.style.display =
    el.style.display === 'none' || el.style.display === ''
      ? 'table-row'
      : 'none';
}
</script>
</body>
</html>
