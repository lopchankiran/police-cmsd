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
  <title>Traffic & Citations</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: #f0f4fa;
      font-family: 'Segoe UI', sans-serif;
    }
    .card-traffic {
      background: #fff;
      border-radius: 1rem;
      padding: 1.5rem;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
      transition: all 0.2s ease-in-out;
      border-left: 5px solid #0d6efd22;
    }
    .card-traffic:hover {
      transform: scale(1.02);
      border-left-color: #0d6efd;
      box-shadow: 0 6px 24px rgba(13, 110, 253, 0.12);
    }
    .card-traffic i {
      font-size: 2rem;
      color: #0d6efd;
      margin-bottom: 12px;
    }
    .card-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #183868;
    }
    .card-text {
      font-size: 0.97rem;
      color: #5a6371;
    }
  </style>
</head>
<body>
<div class="container py-5">
  <h3 class="mb-4"><i class="fas fa-car-side me-2"></i>Traffic & Citations</h3>
  <div class="row g-4">

    <!-- Check Plate -->
    <div class="col-md-6">
      <a href="https://www.service.nsw.gov.au/transaction/check-vehicle-registration" target="_blank" class="text-decoration-none text-dark">
        <div class="card-traffic text-center h-100">
          <i class="fas fa-id-card"></i>
          <h5 class="card-title">Check Plate</h5>
          <p class="card-text">Redirect to Service NSW to verify a vehicle's registration status.</p>
        </div>
      </a>
    </div>

    <!-- Tow Request -->
    <div class="col-md-6">
      <a href="tow_requests.php" class="text-decoration-none text-dark">
        <div class="card-traffic text-center h-100">
          <i class="fas fa-truck-moving"></i>
          <h5 class="card-title">Tow Request</h5>
          <p class="card-text">Submit or review towing requests for abandoned or damaged vehicles.</p>
        </div>
      </a>
    </div>

  </div>
</div>
</body>
</html>
