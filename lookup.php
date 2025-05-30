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
  <title>Lookup Tools</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: #f0f3f8;
      font-family: 'Segoe UI', sans-serif;
    }
    .card-lookup {
      background: #ffffff;
      border: 1px solid #dee2e6;
      border-radius: 1rem;
      padding: 1.5rem;
      transition: all 0.2s ease-in-out;
      box-shadow: 0 4px 12px rgba(0,0,0,0.04);
    }
    .card-lookup:hover {
      transform: scale(1.02);
      border-left: 5px solid #0d6efd;
      box-shadow: 0 8px 20px rgba(13, 110, 253, 0.12);
    }
    .card-lookup i {
      font-size: 2rem;
      color: #0d6efd;
      margin-bottom: 12px;
    }
    .card-title {
      font-size: 1.25rem;
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
  <h3 class="mb-4"><i class="fas fa-search me-2"></i>Lookup Tools</h3>
  <div class="row g-4">

    <!-- Search People (now links to missing.php) -->
    <div class="col-md-4">
      <a href="missing.php" class="text-decoration-none text-dark">
        <div class="card-lookup text-center h-100">
          <i class="fas fa-user"></i>
          <h5 class="card-title">Search Missing Persons</h5>
          <p class="card-text">Find reported missing individuals by name, age, or case ID.</p>
        </div>
      </a>
    </div>

    <!-- Vehicle Registration -->
    <div class="col-md-4">
      <a href="https://www.service.nsw.gov.au/transaction/check-vehicle-registration" target="_blank" class="text-decoration-none text-dark">
        <div class="card-lookup text-center h-100">
          <i class="fas fa-car-side"></i>
          <h5 class="card-title">Vehicle Registration Check</h5>
          <p class="card-text">Open Service NSW tool to verify vehicle plate numbers.</p>
        </div>
      </a>
    </div>

    <!-- View Missing Cases -->
    <div class="col-md-4">
      <a href="missing.php" class="text-decoration-none text-dark">
        <div class="card-lookup text-center h-100">
          <i class="fas fa-binoculars"></i>
          <h5 class="card-title">View All Missing Cases</h5>
          <p class="card-text">Browse and monitor all open missing person reports.</p>
        </div>
      </a>
    </div>

  </div>
</div>
</body>
</html>
