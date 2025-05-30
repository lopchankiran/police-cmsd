<?php
session_start();
require_once 'config.php';
$conn = getDbConnection();

// only admins here
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

// ↓↓↓ NEW: Handle the “Add New Shift” POST directly ↓↓↓
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $officer_id = (int)($_POST['officer_id'] ?? 0);
    $date       = $_POST['shift_date']  ?? '';
    $start      = $_POST['start_time']  ?? '';
    $end        = $_POST['end_time']    ?? '';
    $notes      = $_POST['notes']       ?? '';

    if ($officer_id && $date && $start && $end) {
        $ins = $conn->prepare("
            INSERT INTO `shifts`
              (officer_id, shift_date, start_time, end_time, notes)
            VALUES (?,?,?,?,?)
        ");
        $ins->bind_param('issss', $officer_id, $date, $start, $end, $notes);
        $ins->execute();
        $ins->close();
    }
    header('Location: shift_management.php');
    exit;
}

// Filters & fetch
$filter_officer = $_GET['officer_id'] ?? '';
$filter_date    = $_GET['shift_date'] ?? '';

$sql = "
  SELECT s.*, st.full_name
    FROM shifts s
    JOIN staff    st ON s.officer_id = st.id
";
$conds = [];
$params = [];
$types  = '';

if ($filter_officer) {
    $conds[]   = "s.officer_id = ?";
    $params[]  = $filter_officer;
    $types    .= 'i';
}
if ($filter_date) {
    $conds[]   = "s.shift_date = ?";
    $params[]  = $filter_date;
    $types    .= 's';
}
if ($conds) {
    $sql .= " WHERE " . implode(' AND ', $conds);
}
$sql .= " ORDER BY s.shift_date DESC";

$stmt = $conn->prepare($sql);
if ($params) {
    $stmt->bind_param($types, ...$params);
}
$stmt->execute();
$result = $stmt->get_result();
$shifts = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Shift Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
  <!-- Header + Add Modal Trigger -->
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3>Shift Management</h3>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addShiftModal">
      + Add New Shift
    </button>
  </div>

  <!-- Filters -->
  <form class="row g-3 mb-4" method="GET">
    <div class="col-md-3">
      <input type="number" name="officer_id" class="form-control"
             placeholder="Officer ID" value="<?= htmlspecialchars($filter_officer) ?>">
    </div>
    <div class="col-md-3">
      <input type="date" name="shift_date" class="form-control"
             value="<?= htmlspecialchars($filter_date) ?>">
    </div>
    <div class="col-md-3">
      <button class="btn btn-outline-secondary">Filter</button>
      <a href="shift_management.php" class="btn btn-outline-danger">Reset</a>
    </div>
  </form>

  <!-- Shift Table -->
  <div class="table-responsive">
    <table class="table table-bordered table-hover align-middle">
      <thead class="table-dark">
        <tr>
          <th>ID</th>
          <th>Officer</th>
          <th>Date</th>
          <th>Start</th>
          <th>End</th>
          <th>Notes</th>
          <th>Created</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($shifts as $s): ?>
          <tr>
            <td><?= $s['id'] ?></td>
            <td><?= htmlspecialchars($s['full_name']) ?> (ID: <?= $s['officer_id'] ?>)</td>
            <td><?= $s['shift_date'] ?></td>
            <td><?= substr($s['start_time'],0,5) ?></td>
            <td><?= substr($s['end_time'],0,5) ?></td>
            <td><?= htmlspecialchars($s['notes']) ?></td>
            <td><?= $s['created_at'] ?></td>
            <td>
              <!-- You can wire up edit/delete here later -->
              <button class="btn btn-sm btn-warning" disabled>Edit</button>
              <button class="btn btn-sm btn-danger" disabled>Delete</button>
            </td>
          </tr>
        <?php endforeach ?>
      </tbody>
    </table>
  </div>

  <!-- Add Shift Modal -->
  <div class="modal fade" id="addShiftModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <form method="POST" class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add New Shift</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label>Officer ID</label>
            <input type="number" name="officer_id" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Shift Date</label>
            <input type="date" name="shift_date" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Start Time</label>
            <input type="time" name="start_time" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>End Time</label>
            <input type="time" name="end_time" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Notes</label>
            <textarea name="notes" class="form-control" rows="2"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary">Save Shift</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
