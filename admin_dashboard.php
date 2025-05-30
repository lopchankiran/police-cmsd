<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();
$username = htmlspecialchars($_SESSION['username'] ?? 'Admin');

// Fetch case status counts for chart
$caseData = [];
$result = $conn->query("SELECT status, COUNT(*) AS count FROM cases GROUP BY status");
while ($row = $result->fetch_assoc()) {
    $caseData[$row['status']] = $row['count'];
}

// Extract values for chart
$open = $caseData['open'] ?? 0;
$closed = $caseData['closed'] ?? 0;
$pending = $caseData['pending'] ?? 0;

?>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body { background: #f5f8fc; display: flex; min-height: 100vh; margin: 0; }
    .sidebar {
      width: 220px;
      background-color: #2c3e50;
      padding: 20px 0;
      color: #fff;
      position: fixed;
      height: 100vh;
    }
    .sidebar a {
      display: block;
      padding: 12px 20px;
      color: #ccc;
      text-decoration: none;
      font-size: 15px;
    }
    .sidebar a:hover, .sidebar a.active { background-color: #34495e; color: #fff; }
    .main-content {
      margin-left: 220px;
      padding: 30px;
      width: calc(100% - 220px);
    }
    .dashboard-cards .card {
      border: none;
      border-left: 4px solid #0d6efd;
      transition: 0.2s;
      cursor: pointer;
    }
    .dashboard-cards .card:hover {
      box-shadow: 0 0 12px rgba(0,0,0,0.1);
      transform: scale(1.02);
    }
    .dashboard-cards .icon {
      font-size: 1.8rem;
      margin-right: 12px;
    }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <h5 class="text-center text-white mb-4"><i class="fas fa-user-shield me-2"></i>Admin Panel</h5>
  <a href="manage.php"><i class="fas fa-users-cog me-2"></i>User Management</a>
  <a href="log.php"><i class="fas fa-file-alt me-2"></i>Audit Logs</a>
  <a href="reports.php"><i class="fas fa-chart-line me-2"></i>Reports & Analytics</a>
  <a href="messaging.php"><i class="fas fa-envelope me-2"></i>Secure Messaging</a>
  <a href="logout.php" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
  <div class="mb-4">
    <h3 class="fw-bold">Welcome, <?= $username ?></h3>
    <p class="text-muted"><?= date('l, F j, Y') ?></p>
  </div>

  <!-- Top Dashboard Cards -->
  <div class="row dashboard-cards g-4 mb-5">
    <div class="col-md-3">
      <div class="card p-3" onclick="location.href='settings.php'">
        <div class="d-flex align-items-center">
          <i class="fas fa-cogs icon text-primary"></i>
          <div><strong>System Settings</strong></div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card p-3" onclick="location.href='admin_approvals.php'">
        <div class="d-flex align-items-center">
          <i class="fas fa-file-signature icon text-info"></i>
          <div><strong>Permit & Fine Approvals</strong></div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card p-3" onclick="location.href='incident_oversight.php'">
        <div class="d-flex align-items-center">
          <i class="fas fa-briefcase icon text-dark"></i>
          <div><strong>Incident Oversight</strong></div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card p-3" onclick="location.href='shift_management.php'">
        <div class="d-flex align-items-center">
          <i class="fas fa-calendar-check icon text-success"></i>
          <div><strong>Shift Management</strong></div>
        </div>
      </div>
    </div>
  </div>

  <!-- Case Status Chart -->
  <div class="card p-4 shadow-sm">
    <h5 class="mb-4">Case Status Overview</h5>
    <canvas id="caseChart" height="120"></canvas>
  </div>
</div>

<script>
  const ctx = document.getElementById('caseChart').getContext('2d');
  const caseChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['Open', 'Closed', 'Pending'],
      datasets: [{
        label: 'Cases',
        data: [<?= $open ?>, <?= $closed ?>, <?= $pending ?>],
        backgroundColor: ['#0d6efd', '#198754', '#ffc107']
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { position: 'bottom' }
      }
    }
  });
</script>

</body>
</html>
