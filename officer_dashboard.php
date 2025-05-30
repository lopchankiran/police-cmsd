<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'police_officer') {
    header('Location: login.php');
    exit;
}
$username = htmlspecialchars($_SESSION['username']);
$page = $_GET['page'] ?? 'dashboard';
$file = "{$page}.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Officer Portal</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      display: flex;
      height: 100vh;
      overflow: hidden;
      font-family: 'Segoe UI', sans-serif;
    }
    .sidebar {
      width: 240px;
      background-color: #fff;
      border-right: 1px solid #ddd;
      padding: 20px 10px;
      overflow-y: auto;
      height: 100vh;
      position: fixed;
    }
    .sidebar a {
      display: block;
      padding: 10px 15px;
      margin-bottom: 5px;
      color: #333;
      font-weight: 500;
      border-radius: 5px;
      text-decoration: none;
    }
    .sidebar a:hover, .sidebar a.active {
      background-color: #0d6efd10;
      color: #0d6efd;
    }
    .main-content {
      margin-left: 240px;
      overflow-y: auto;
      width: calc(100% - 240px);
      padding: 30px;
      background: #f5f8fc;
    }
    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background: #fff;
      border-bottom: 1px solid #ddd;
      position: sticky;
      top: 0;
      z-index: 10;
    }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <h5 class="text-center mb-4"><i class="fas fa-user-shield"></i> Officer Portal</h5>
  <a href="?page=dashboard" class="<?= $page == 'dashboard' ? 'active' : '' ?>"><i class="fas fa-home me-2"></i>Dashboard</a>
  <a href="?page=incident" class="<?= $page == 'incident' ? 'active' : '' ?>"><i class="fas fa-file-alt me-2"></i>Incidents</a>
  <a href="?page=lookup" class="<?= $page == 'lookup' ? 'active' : '' ?>"><i class="fas fa-search me-2"></i>Lookup Tools</a>
  <a href="?page=traffic" class="<?= $page == 'traffic' ? 'active' : '' ?>"><i class="fas fa-car me-2"></i>Traffic</a>
  <a href="?page=map" class="<?= $page == 'map' ? 'active' : '' ?>"><i class="fas fa-map me-2"></i>Mapping</a>
  <a href="?page=comm" class="<?= $page == 'comm' ? 'active' : '' ?>"><i class="fas fa-comments me-2"></i>Comm/Reports</a>
  <a href="?page=admin" class="<?= $page == 'admin' ? 'active' : '' ?>"><i class="fas fa-user-cog me-2"></i>Admin/Profile</a>
  <a href="logout.php" class="text-danger"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
  <div class="topbar">
    <h5 class="mb-0">Welcome, Officer <?= $username ?></h5>
  </div>

  <!-- Dynamically load content -->
  <?php
    if (file_exists($file)) {
        include $file;
    } else {
        echo "<div class='alert alert-danger mt-3'>The page <strong>$file</strong> was not found.</div>";
    }
  ?>
</div>

</body>
</html>
