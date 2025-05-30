<?php

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'police_officer') {
    header('Location: login.php');
    exit;
}
$username = htmlspecialchars($_SESSION['username']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Communication & Reports</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background-color: #eef3f8;
      font-family: 'Segoe UI', sans-serif;
    }
    .section-title {
      font-weight: 600;
      color: #2c3e50;
    }
    .card-link {
      text-decoration: none;
      color: inherit;
    }
    .card-link:hover .card {
      background-color: #f1f6ff;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
    }
    .card {
      border-left: 5px solid #0d6efd;
      border-radius: 0.5rem;
      background: #fff;
      transition: 0.3s ease;
    }
    .card-body i {
      font-size: 1.5rem;
      color: #0d6efd;
      margin-right: 12px;
    }
  </style>
</head>
<body>

<div class="container py-5">
  <h3 class="section-title mb-4"><i class="fas fa-comments me-2"></i>Communication & Reports</h3>
  <div class="row g-4">
    
    <!-- Secure Messaging -->
    <div class="col-md-6">
      <a href="messaging.php" class="card-link">
        <div class="card p-3 h-100">
          <div class="card-body d-flex align-items-center">
            <i class="fas fa-envelope"></i>
            <div>
              <h5 class="mb-1">Secure Messaging</h5>
              <p class="mb-0 text-muted small">Send and receive messages within the department.</p>
            </div>
          </div>
        </div>
      </a>
    </div>

    <!-- Stats Reports -->
    <div class="col-md-6">
      <a href="stats_exports.php" class="card-link">
        <div class="card p-3 h-100">
          <div class="card-body d-flex align-items-center">
            <i class="fas fa-chart-line"></i>
            <div>
              <h5 class="mb-1">Statistics Reports</h5>
              <p class="mb-0 text-muted small">Export shift and incident reports easily.</p>
            </div>
          </div>
        </div>
      </a>
    </div>

  </div>
</div>

</body>
</html>
