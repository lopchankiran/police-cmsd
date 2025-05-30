<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();
$username = htmlspecialchars($_SESSION['username'] ?? 'Admin');

// Fetch incident records with officer name
$stmt = $conn->prepare("
    SELECT 
        i.id, i.title, i.description, i.status, i.reported_date,
        o.full_name AS officer_name
    FROM 
        incidents i
    LEFT JOIN 
        officers o ON i.officer_id = o.officer_id
    ORDER BY 
        i.reported_date DESC
");
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Incident Oversight</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: #f8f9fc;
      font-family: 'Segoe UI', sans-serif;
    }
    .container {
      margin-top: 50px;
    }
    table th, table td {
      vertical-align: middle;
    }
    h3 {
      margin-bottom: 25px;
      color: #183868;
    }
  </style>
</head>
<body>
<div class="container">
  <h3><i class="fas fa-briefcase me-2"></i>Incident Oversight</h3>

  <?php if ($result->num_rows > 0): ?>
    <div class="table-responsive">
      <table class="table table-bordered table-striped align-middle">
        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Reported Date</th>
            <th>Officer</th>
          </tr>
        </thead>
        <tbody>
          <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
              <td><?= htmlspecialchars($row['id']) ?></td>
              <td><?= htmlspecialchars($row['title']) ?></td>
              <td><?= htmlspecialchars($row['description']) ?></td>
              <td>
                <span class="badge 
                  <?= $row['status'] === 'open' ? 'bg-success' : ($row['status'] === 'closed' ? 'bg-secondary' : 'bg-warning text-dark') ?>">
                  <?= ucfirst($row['status']) ?>
                </span>
              </td>
              <td><?= date('Y-m-d', strtotime($row['reported_date'])) ?></td>
              <td><?= htmlspecialchars($row['officer_name'] ?? 'Unknown') ?></td>
            </tr>
          <?php endwhile; ?>
        </tbody>
      </table>
    </div>
  <?php else: ?>
    <div class="alert alert-warning">No incident records found.</div>
  <?php endif; ?>
</div>
</body>
</html>
