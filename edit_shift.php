<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();

$success = '';
$error = '';

if (!isset($_GET['id'])) {
    die('Shift ID missing.');
}

$id = intval($_GET['id']);

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $officer_id = intval($_POST['officer_id']);
    $shift_date = $_POST['shift_date'];
    $start_time = $_POST['start_time'];
    $end_time   = $_POST['end_time'];
    $notes      = trim($_POST['notes']);

    $stmt = $conn->prepare("UPDATE shifts SET officer_id = ?, shift_date = ?, start_time = ?, end_time = ?, notes = ? WHERE id = ?");
    $stmt->bind_param("issssi", $officer_id, $shift_date, $start_time, $end_time, $notes, $id);
    
    if ($stmt->execute()) {
        $success = "Shift updated successfully.";
    } else {
        $error = "Update failed: " . $conn->error;
    }
}

// Fetch shift record
$stmt = $conn->prepare("SELECT * FROM shifts WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$shift = $stmt->get_result()->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Shift</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
  <h3>Edit Shift</h3>

  <?php if ($success): ?>
    <div class="alert alert-success"><?= $success ?></div>
  <?php elseif ($error): ?>
    <div class="alert alert-danger"><?= $error ?></div>
  <?php endif; ?>

  <form method="POST">
    <div class="mb-3">
      <label>Officer ID</label>
      <input type="number" name="officer_id" class="form-control" required value="<?= $shift['officer_id'] ?>">
    </div>
    <div class="mb-3">
      <label>Shift Date</label>
      <input type="date" name="shift_date" class="form-control" required value="<?= $shift['shift_date'] ?>">
    </div>
    <div class="mb-3">
      <label>Start Time</label>
      <input type="time" name="start_time" class="form-control" required value="<?= $shift['start_time'] ?>">
    </div>
    <div class="mb-3">
      <label>End Time</label>
      <input type="time" name="end_time" class="form-control" required value="<?= $shift['end_time'] ?>">
    </div>
    <div class="mb-3">
      <label>Notes</label>
      <textarea name="notes" class="form-control"><?= htmlspecialchars($shift['notes']) ?></textarea>
    </div>
    <button class="btn btn-primary">Update Shift</button>
    <a href="shift_management.php" class="btn btn-secondary">Back</a>
  </form>
</body>
</html>
