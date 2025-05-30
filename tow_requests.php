<?php
session_start();                                // ← this was missing

// 1) Auth check: only police_officer can access
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'police_officer') {
    header('Location: login.php');
    exit;
}

// 2) DB connection (mimic your shift.php style)
require_once __DIR__ . '/config.php';
$mysqli = getDbConnection();                    // make sure config.php defines getDbConnection()

$officer_id = (int) $_SESSION['user_id'];
$errors     = [];
$success    = '';

// 3) Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $vehicle_plate = trim($_POST['vehicle_plate'] ?? '');
    $location      = trim($_POST['location']      ?? '');
    $reason        = trim($_POST['reason']        ?? '');

    if ($vehicle_plate === '') $errors[] = 'Vehicle plate is required.';
    if ($location      === '') $errors[] = 'Location is required.';

    if (empty($errors)) {
        $stmt = $mysqli->prepare("
          INSERT INTO tow_requests 
            (officer_id, vehicle_plate, location, reason) 
          VALUES (?,?,?,?)
        ");
        $stmt->bind_param('isss',
          $officer_id,
          $vehicle_plate,
          $location,
          $reason
        );
        if ($stmt->execute()) {
            $success = 'Tow request submitted successfully.';
        } else {
            $errors[] = 'Database error: ' . $stmt->error;
        }
        $stmt->close();
    }
}

// 4) Fetch this officer’s requests
$stmt = $mysqli->prepare("
  SELECT vehicle_plate, location, status, request_date
    FROM tow_requests
   WHERE officer_id = ?
ORDER BY request_date DESC
");
$stmt->bind_param('i', $officer_id);
$stmt->execute();
$tow_requests = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Tow Request</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
  <h3 class="mb-4"><i class="fa-solid fa-truck-moving me-2"></i>Tow Request</h3>

  <?php if ($success): ?>
    <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
  <?php endif; ?>

  <?php if ($errors): ?>
    <div class="alert alert-danger">
      <ul>
        <?php foreach ($errors as $e): ?>
          <li><?= htmlspecialchars($e) ?></li>
        <?php endforeach; ?>
      </ul>
    </div>
  <?php endif; ?>

  <form method="post" class="mb-5">
    <div class="row g-3">
      <div class="col-md-4">
        <label class="form-label">Vehicle Plate</label>
        <input type="text" class="form-control" name="vehicle_plate" required>
      </div>
      <div class="col-md-4">
        <label class="form-label">Location</label>
        <input type="text" class="form-control" name="location" required>
      </div>
      <div class="col-md-4">
        <label class="form-label">Reason</label>
        <input type="text" class="form-control" name="reason">
      </div>
    </div>
    <button type="submit" class="btn btn-primary mt-3">Submit Request</button>
  </form>

  <h5>My Tow Request History</h5>
  <table class="table table-bordered table-striped mt-3 bg-white">
    <thead>
      <tr>
        <th>Vehicle Plate</th>
        <th>Location</th>
        <th>Status</th>
        <th>Request Date</th>
      </tr>
    </thead>
    <tbody>
      <?php if ($tow_requests): ?>
        <?php foreach ($tow_requests as $row): ?>
          <tr>
            <td><?= htmlspecialchars($row['vehicle_plate']) ?></td>
            <td><?= htmlspecialchars($row['location']) ?></td>
            <td><?= htmlspecialchars($row['status']) ?></td>
            <td><?= date('d M Y H:i', strtotime($row['request_date'])) ?></td>
          </tr>
        <?php endforeach; ?>
      <?php else: ?>
        <tr><td colspan="4" class="text-center">No requests yet.</td></tr>
      <?php endif; ?>
    </tbody>
  </table>
</div>
</body>
</html>
