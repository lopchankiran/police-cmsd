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

// Handle update
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_setting'])) {
    $key = $_POST['setting_key'] ?? '';
    $value = $_POST['setting_value'] ?? '';

    if ($key !== '') {
        $stmt = $conn->prepare("UPDATE settings SET setting_value = ? WHERE setting_key = ?");
        $stmt->bind_param('ss', $value, $key);
        if ($stmt->execute()) {
            $success = "Setting <strong>$key</strong> updated.";
        } else {
            $error = "Update failed.";
        }
        $stmt->close();
    }
}

// Handle delete
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['delete_setting'])) {
    $key = $_POST['setting_key'] ?? '';
    if ($key !== '') {
        $stmt = $conn->prepare("DELETE FROM settings WHERE setting_key = ?");
        $stmt->bind_param('s', $key);
        if ($stmt->execute()) {
            $success = "Setting <strong>$key</strong> deleted.";
        } else {
            $error = "Delete failed.";
        }
        $stmt->close();
    }
}

// Handle add
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['add_setting'])) {
    $key = trim($_POST['new_setting_key'] ?? '');
    $value = trim($_POST['new_setting_value'] ?? '');
    if ($key !== '') {
        $stmt = $conn->prepare("INSERT INTO settings (setting_key, setting_value) VALUES (?, ?)");
        $stmt->bind_param('ss', $key, $value);
        if ($stmt->execute()) {
            $success = "Setting <strong>$key</strong> added.";
        } else {
            $error = "Insert failed (duplicate key?).";
        }
        $stmt->close();
    } else {
        $error = "Key must not be empty.";
    }
}

// Fetch settings
$settings = [];
$result = $conn->query("SELECT * FROM settings ORDER BY setting_key ASC");
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $settings[] = $row;
    }
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>System Settings</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-4">
  <h3 class="mb-4"><i class="fas fa-cogs me-2"></i>System Settings</h3>

  <?php if ($success): ?>
    <div class="alert alert-success"><?= $success ?></div>
  <?php elseif ($error): ?>
    <div class="alert alert-danger"><?= $error ?></div>
  <?php endif; ?>

  <!-- Add New Setting -->
  <form method="post" class="row g-3 mb-4">
    <div class="col-md-4">
      <input type="text" name="new_setting_key" class="form-control" placeholder="New setting key" required>
    </div>
    <div class="col-md-4">
      <input type="text" name="new_setting_value" class="form-control" placeholder="New setting value" required>
    </div>
    <div class="col-md-4">
      <button type="submit" name="add_setting" class="btn btn-success w-100"><i class="fas fa-plus-circle me-1"></i>Add Setting</button>
    </div>
  </form>

  <!-- Settings Table -->
  <?php if (count($settings) > 0): ?>
    <form method="post">
      <table class="table table-bordered align-middle table-hover">
        <thead class="table-light">
          <tr>
            <th>Setting Key</th>
            <th>Value</th>
            <th style="width: 180px;">Actions</th>
          </tr>
        </thead>
        <tbody>
        <?php foreach ($settings as $s): ?>
          <tr>
            <td><?= htmlspecialchars($s['setting_key']) ?></td>
            <td>
              <input type="text" class="form-control" name="setting_value" value="<?= htmlspecialchars($s['setting_value']) ?>">
              <input type="hidden" name="setting_key" value="<?= htmlspecialchars($s['setting_key']) ?>">
            </td>
            <td>
              <div class="d-flex gap-2">
                <button type="submit" name="update_setting" class="btn btn-sm btn-primary"><i class="fas fa-save"></i></button>
                <button type="submit" name="delete_setting" class="btn btn-sm btn-danger" onclick="return confirm('Delete this setting?')"><i class="fas fa-trash-alt"></i></button>
              </div>
            </td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </form>
  <?php else: ?>
    <div class="alert alert-warning">No settings found in the database.</div>
  <?php endif; ?>
</div>

<!-- Scripts -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
