<?php
session_start();
if (!isset($_SESSION['role'])) {
    header('Location: login.php');
    exit;
}

// Example data
$stats = [
    ['Date' => '2025-05-28', 'Incidents' => 5, 'Reports Filed' => 4],
    ['Date' => '2025-05-29', 'Incidents' => 7, 'Reports Filed' => 6],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Stats Export</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
  <h3>Statistics Report</h3>
  <table class="table table-bordered table-striped bg-white mt-4">
    <thead class="table-primary">
      <tr>
        <th>Date</th>
        <th>Incidents</th>
        <th>Reports Filed</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($stats as $row): ?>
        <tr>
          <td><?= $row['Date'] ?></td>
          <td><?= $row['Incidents'] ?></td>
          <td><?= $row['Reports Filed'] ?></td>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>
</body>
</html>
