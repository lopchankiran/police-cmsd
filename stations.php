<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>NSW Police Station Finder</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <!-- Leaflet CSS -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css"/>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #e7f1fa 0%, #d7e2ef 100%);
      min-height: 100vh;
    }
    .navbar {
      font-weight: 500;
      background: linear-gradient(90deg, #112d55 0%, #304c73 80%);
      border-bottom: 2.5px solid #b8e3fb22;
    }
    .navbar-brand i {
      color: #ffd900;
      margin-right: 6px;
    }
    #nsw-map {
      width: 100%;
      height: 520px;
      border-radius: 18px;
      box-shadow: 0 8px 32px #90a4ae40;
      margin-bottom: 24px;
      margin-top: 12px;
      z-index: 1;
    }
  </style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow-sm mb-3">
    <div class="container">
      <a class="navbar-brand fw-bold" href="index.php">
        <i class="fas fa-shield-alt"></i>Police NSW CMS
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
              data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item"><a class="nav-link" href="index.php#about">About</a></li>
            <li class="nav-item"><a class="nav-link" href="index.php#alerts">Alerts</a></li>
            <li class="nav-item"><a class="nav-link" href="index.php#features">Features</a></li>
            <li class="nav-item"><a class="nav-link" href="index.php#news-section">News</a></li>
            <li class="nav-item"><a class="nav-link active" href="#">Stations</a></li>
            <li class="nav-item"><a class="nav-link" href="index.php#connect">Connect</a></li>
            <li class="nav-item"><a class="nav-link" href="index.php#contact">Contact</a></li>
            <li class="nav-item ms-3">
              <a class="btn btn-outline-light" href="login.php">
                <i class="fas fa-sign-in-alt"></i> Login
              </a>
            </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container mb-4">
    <h2 class="text-center mb-3 mt-2"><i class="fas fa-map-marked-alt me-2 text-primary"></i>Find Police Stations in NSW</h2>
    <div id="nsw-map"></div>
    <div class="text-center mt-3">
      <p>Click on each marker for station details. This map shows main police stations across NSW.</p>
    </div>
  </div>

  <!-- Bootstrap JS & Leaflet JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
  <script>
  document.addEventListener("DOMContentLoaded", function() {
    var map = L.map('nsw-map').setView([-33.8688, 151.2093], 8); // State-wide view
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // NSW Police stations - Expanded List
    var stations = [
      { name: "Sydney City Police Station", address: "192 Day St, Sydney NSW 2000", lat: -33.8766, lng: 151.2037 },
      { name: "Parramatta Police Station", address: "20 Charles St, Parramatta NSW 2150", lat: -33.8151, lng: 151.0062 },
      { name: "Penrith Police Station", address: "94 Henry St, Penrith NSW 2750", lat: -33.7517, lng: 150.6948 },
      { name: "Newcastle Police Station", address: "77 Scott St, Newcastle NSW 2300", lat: -32.9271, lng: 151.7847 },
      { name: "Wollongong Police Station", address: "Cnr Church & Market St, Wollongong NSW 2500", lat: -34.4278, lng: 150.8947 },
      { name: "Liverpool Police Station", address: "50 Moore St, Liverpool NSW 2170", lat: -33.9206, lng: 150.9256 },
      { name: "Blacktown Police Station", address: "18-20 Second Ave, Blacktown NSW 2148", lat: -33.7684, lng: 150.9086 },
      { name: "Bankstown Police Station", address: "Bankstown City Plaza, Bankstown NSW 2200", lat: -33.9193, lng: 151.0360 },
      { name: "Chatswood Police Station", address: "16-18 Anderson St, Chatswood NSW 2067", lat: -33.7962, lng: 151.1827 },
      { name: "Campbelltown Police Station", address: "Cnr Queen & Cordeaux St, Campbelltown NSW 2560", lat: -34.0686, lng: 150.8138 },
      { name: "Bathurst Police Station", address: "213 Rankin St, Bathurst NSW 2795", lat: -33.4191, lng: 149.5753 },
      { name: "Coffs Harbour Police Station", address: "41 Moonee St, Coffs Harbour NSW 2450", lat: -30.2963, lng: 153.1150 },
      { name: "Dubbo Police Station", address: "180 Brisbane St, Dubbo NSW 2830", lat: -32.2444, lng: 148.6035 },
      { name: "Albury Police Station", address: "539 Smollett St, Albury NSW 2640", lat: -36.0778, lng: 146.9158 },
      { name: "Tamworth Police Station", address: "5-7 Fitzroy St, Tamworth NSW 2340", lat: -31.0904, lng: 150.9298 }
      // Add more stations as needed
    ];

    stations.forEach(function(station) {
      L.marker([station.lat, station.lng])
        .addTo(map)
        .bindPopup(`<b>${station.name}</b><br>${station.address}`);
    });
  });
  </script>
</body>
</html>
