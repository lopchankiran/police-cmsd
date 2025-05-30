<?php
session_start();
if ($_SESSION['role'] !== 'admin') {
    header("Location: login.php");
    exit;
}
require_once 'config.php';
$conn = getDbConnection();

if (isset($_GET['dismiss'])) {
    $id = (int)$_GET['dismiss'];
    $conn->query("UPDATE alerts SET status = 'dismissed' WHERE id = $id");
}

$result = $conn->query("SELECT * FROM alerts WHERE status = 'active' ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Alerts</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">
  <h3><i class="fas fa-bell me-2"></i>Active Alerts</h3>
  <?php if ($result->num_rows > 0): ?>
    <?php while ($alert = $result->fetch_assoc()): ?>
      <div class="alert alert-warning d-flex justify-content-between align-items-center">
        <div>
          <strong><?= htmlspecialchars($alert['title']) ?></strong><br>
          <?= nl2br(htmlspecialchars($alert['message'])) ?>
          <br><small><em><?= $alert['created_at'] ?></em></small>
        </div>
        <a href="?dismiss=<?= $alert['id'] ?>" class="btn btn-sm btn-outline-danger">Dismiss</a>
      </div>
    <?php endwhile; ?>
  <?php else: ?>
    <div class="alert alert-success">No active alerts.</div>
  <?php endif; ?>
</body>
</html>
