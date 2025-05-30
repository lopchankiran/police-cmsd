<?php
session_start();

// If already logged in, redirect to relevant portal
if (isset($_SESSION['role'])) {
    switch ($_SESSION['role']) {
        case 'admin':
            header('Location: admin_dashboard.php');
            break;
        case 'police_officer':
            header('Location: officer_dashboard.php');
            break;
        case 'forensic':
            header('Location: forensic_portal.php');
            break;
        default:
            header('Location: staff_home.php');
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Police NSW CMS</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
  <!-- Animate.css -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #e7f1fa 0%, #d7e2ef 100%);
      scroll-behavior: smooth;
      min-height: 100vh;
    }
    header {
      background: linear-gradient(115deg, rgba(6,29,72,0.35) 30%, rgba(39,89,173,0.25)),
                  url('banner-police.jpg') center/cover no-repeat;
      color: #fff;
      padding: 120px 0 80px 0;
      text-shadow: 2px 2px 8px rgba(0,0,0,0.28);
      box-shadow: 0 12px 24px -12px rgba(13,51,115,.13);
    }
    header h1 {
      font-weight: 800;
      animation: fadeInDown 1.1s;
    }
    header p {
      animation: fadeInUp 1.2s;
      font-size: 1.33rem;
      font-weight: 500;
    }
    .down-arrow {
      animation: bounceDown 2s infinite;
      font-size: 2.4rem;
      color: #ffd900;
      margin-top: 40px;
      text-shadow: 0 2px 8px #111b;
      cursor: pointer;
      transition: color 0.2s;
    }
    .down-arrow:hover { color: #fff; }
    @keyframes bounceDown {
      0%, 100% { transform: translateY(0);}
      50% { transform: translateY(15px);}
    }
    .navbar {
      font-weight: 500;
      background: linear-gradient(90deg, #112d55 0%, #304c73 80%);
      border-bottom: 2.5px solid #b8e3fb22;
    }
    .navbar .nav-link.active, .navbar .nav-link:hover {
      color: #ffd900 !important;
      transition: color 0.15s;
    }
    .navbar-brand i {
      color: #ffd900;
      margin-right: 6px;
    }
    .hover-shadow:hover, .hover-shadow:focus {
      box-shadow: 0 10px 32px #0d6efd31, 0 2px 10px #ffd90011;
      border: 2px solid #1586fa2a;
      z-index: 2;
      transition: box-shadow .22s, border .22s;
    }
    #alerts-section {
      background: linear-gradient(90deg,#ebf3fb 70%,#f2e4be 100%);
      border-bottom: 1.5px solid #f0e7ca;
      box-shadow: 0 3px 30px -14px #8c6e2a21;
      padding: 0;
    }
    #alerts .carousel-item{
      min-height: 180px;
      background: linear-gradient(105deg,#f7fafd 55%,#f7e7b4 100%);
      color: #183868;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.18rem; font-weight: 500;
      border-radius: 1rem; box-shadow: 0 4px 20px #81621a13;
      margin: 36px auto 36px auto;
      max-width: 650px;
      opacity: 0.97;
    }
    #alerts .carousel-item .alert-icon {
      font-size: 2.2rem;
      margin-right: 16px;
      color: #f7b32b;
    }
    .alert-title { font-weight: bold; color: #775d1c; }
    .alert-time { font-size: .95rem; color: #6b7ca7; opacity: .75; margin-left: 13px; }
    .news-section {
      margin: 60px auto 36px auto;
      background: linear-gradient(108deg, #e7f1fa 60%, #fffbe8 100%);
      border-radius: 20px;
      box-shadow: 0 8px 32px #d4e4fc25;
      padding: 42px 0 36px 0;
    }
    .news-section h2 {
      font-weight: 800;
      color: #183868;
      margin-bottom: 28px;
    }
    .news-card {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 20px #20427618;
      overflow: hidden;
      margin-bottom: 20px;
      min-height: 170px;
      border-left: 5px solid #1586fa22;
    }
    .news-card:hover {
      box-shadow: 0 10px 36px #1586fa2c;
      border-left: 5px solid #0d6efd;
    }
    .news-img {
      width: 110px;
      height: 110px;
      object-fit: cover;
      border-radius: 14px;
      margin: 16px 22px 16px 0;
      background: #f6fafc;
    }
    .news-body {
      padding: 18px 24px 16px 0;
    }
    .news-title {
      font-weight: 700;
      font-size: 1.18rem;
      margin-bottom: 5px;
      color: #133a64;
    }
    .news-meta {
      font-size: .95rem;
      color: #949da3;
      margin-bottom: 8px;
    }
    .news-desc {
      font-size: 1.06rem;
      color: #204276;
    }
    .news-link {
      color: #0d6efd;
      font-weight: 600;
      font-size: 0.97rem;
      margin-top: 8px;
      display: inline-block;
      transition: color 0.2s;
    }
    .news-link:hover { color: #ffd900;}
    @media (max-width: 768px) {
      .news-img { width: 72px; height: 72px; }
      .news-card { flex-direction: column !important;}
    }
    #about, #contact {
      background: linear-gradient(110deg, #f6fbfd 70%, #e1eaf7 100%);
      border-radius: 16px; margin: 36px auto;
      box-shadow: 0 8px 32px #1d3d5e0d;
      padding: 50px 0;
    }
    h2.text-center {
      font-weight: 800;
      color: #204276;
      margin-bottom: 30px;
    }
    /* About/Feature list, badges, find-station styles etc... (unchanged from previous code) */
    /* --- Enhanced About Section --- */
    @keyframes pulseBadge {
      0%,100% { box-shadow: 0 4px 18px #2740b822; }
      50% { box-shadow: 0 0 32px 8px #ffd90080; }
    }
    @keyframes aboutGlow {
      0% { opacity: .13; }
      100% { opacity: .21; }
    }
    .about-feature-list li {
      list-style: none;
      margin-bottom: 1.02em;
      font-size: 1.17rem;
      font-weight: 500;
      color: #204276;
      display: flex; align-items: center;
      position: relative;
      z-index: 2;
    }
    .about-feature-list li i {
      color: #0d6efd;
      background: #e3f1ff;
      border-radius: 50%;
      margin-right: 15px;
      font-size: 1.35rem;
      padding: 7px;
      border: 1.5px solid #c1e2fa;
      box-shadow: 0 2px 9px #62a4f419;
    }
    .find-station-btn:hover {
      background: linear-gradient(90deg,#ffd900 65%,#1586fa 120%)!important;
      color: #14375a!important;
      box-shadow: 0 8px 32px #0d6efd38!important;
    }
    .about-video-card:hover {
      box-shadow: 0 16px 64px #0078c870!important;
    }
    @media (max-width: 992px) {
      .about-video-card,
      .glass-card {
        min-height: 240px !important;
      }
    }
    @media (max-width: 768px) {
      .about-video-card {
        margin-bottom: 30px !important;
      }
      .glass-card {
        padding: 1.2rem 1.1rem 1.3rem 1.1rem !important;
      }
    }
    /* --- Connect Section --- */
    #connect {
      background: linear-gradient(107deg,#214674 63%,#2e4678 100%);
      color: #fff;
      border-radius: 16px;
      margin: 36px auto;
      box-shadow: 0 8px 32px #0a37650e;
      padding: 58px 0 48px 0;
      overflow: hidden;
      position: relative;
    }
    .connect-content {
      display: flex;
      flex-wrap: wrap;
      gap: 3rem;
      align-items: center;
      justify-content: space-between;
    }
    .connect-details {
      flex: 2 1 320px;
      min-width: 280px;
      text-align: left;
    }
    .connect-details h3 {
      font-weight: 700;
      color: #ffd900;
      margin-bottom: 10px;
      font-size: 1.45rem;
    }
    .connect-details p {
      font-size: 1.15rem;
      margin-bottom: 10px;
      color: #f6f6f9;
    }
    .connect-social {
      display: flex;
      gap: 22px;
      margin-bottom: 16px;
      margin-top: 10px;
    }
    .connect-social a {
      color: #fff;
      font-size: 1.7rem;
      border-radius: 50%;
      width: 48px;
      height: 48px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      background: #193a64;
      transition: background .19s, color .15s, transform .13s;
    }
    .connect-social a:hover {
      background: #ffd900;
      color: #213b60;
      transform: translateY(-2px) scale(1.1);
      text-decoration: none;
    }
    .connect-contact {
      font-size: 1.08rem;
      color: #fffde2;
      margin-bottom: 7px;
    }
    .connect-contact i {
      color: #ffd900;
      margin-right: 8px;
    }
    /* --- Enhanced Contact Card --- */
    .contact-card {
      background: rgba(255,255,255,0.94);
      box-shadow: 0 12px 48px #1586fa18, 0 2px 10px #ffd90009;
      border-radius: 24px;
      padding: 40px 32px 32px 32px;
      margin: 60px auto 0 auto;
      max-width: 470px;
      width: 100%;
      position: relative;
      backdrop-filter: blur(7px);
      animation: fadeInSection 1.2s;
    }
    .contact-card .contact-icon {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 72px; height: 72px;
      margin: -70px auto 18px auto;
      background: linear-gradient(135deg,#fff3,#ffd90044);
      border-radius: 50%;
      box-shadow: 0 4px 24px #ffd90022;
      font-size: 2.6rem;
      color: #194ba4;
      position: absolute; left: 0; right: 0; top: 0;
      transform: translateY(-50%);
    }
    .contact-card h2 {
      color: #133a64;
      text-align: center;
      font-weight: 700;
      margin-bottom: 8px;
      font-size: 2rem;
    }
    .contact-card .contact-desc {
      text-align: center;
      font-size: 1.08rem;
      color: #435c8a;
      margin-bottom: 28px;
    }
    /* ...remaining styles unchanged... */
    footer {
      letter-spacing: .01em;
      font-size: 1.07rem;
      background: linear-gradient(90deg,#133a64 30%,#2d5177 100%);
      border-top: 2px solid #d8e5ef;
      box-shadow: 0 -2px 18px #133a6417;
      animation: footerBar 1.5s;
    }
    /* ...alert...*/
    .alert-card-new {
  background: #fff;
  border-radius: 1.2rem;
  box-shadow: 0 4px 24px #b6c6e51c;
  padding: 2rem 1.5rem 1.5rem 1.5rem;
  margin-bottom: 10px;
  border: none;
  transition: box-shadow 0.19s, transform 0.18s;
  position: relative;
  min-height: 160px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
.alert-card-new:hover {
  box-shadow: 0 10px 28px #1586fa17, 0 2px 10px #ffd90018;
  transform: translateY(-2px) scale(1.02);
}
.alert-time {
  background: #ffd900;
  color: #333;
  font-size: 1rem;
  font-weight: 500;
  border-radius: 0.21em;
  padding: 2px 9px;
  display: inline-block;
  margin-bottom: 1.2em;
  margin-right: 1em;
}
.alert-title {
  color: #002664;
  font-size: 1.43rem;
  font-weight: 700;
  line-height: 1.18;
  margin-bottom: 0.2em;
  display: flex;
  align-items: center;
}
.alert-arrow {
  color: #ffd900;
  font-size: 1.4rem;
  margin-left: 10px;
  font-weight: 500;
}
@media (max-width: 700px) {
  .alert-card-new {
    padding: 1.2rem 0.7rem 1rem 0.7rem;
    border-radius: 0.8rem;
    font-size: 1rem;
  }
  .alert-title { font-size: 1.07rem; }
}

  </style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow-sm">
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
            
          <a class="nav-link" href="https://www.police.nsw.gov.au/about_us" target="_blank" rel="noopener noreferrer">About Police</a>
          
          <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>


            <a href="contact.php" class="btn btn-primary">Contact Us</a>

            <li class="nav-item ms-3">
              <a class="btn btn-outline-light" href="login.php">
                <i class="fas fa-sign-in-alt"></i> Login
              </a>
            </li>
        </ul>
      </div>
    </div>
  </nav>
  

  <!-- PUBLIC HERO -->
  <header>
    <div class="container text-center">
      <h1 class="display-3 animate__animated animate__fadeInDown">
        Welcome to Police NSW CMS
      </h1>
      <p class="lead animate__animated animate__fadeInUp">
        Securely track, report, and manage crime data in NSW.
      </p>
      <a href="login.php" class="btn btn-light btn-lg mt-3 me-2">
        <i class="fas fa-sign-in-alt"></i> Login to View
      </a>
      <!-- Hotline Info Bar -->
      <div class="hotline-bar mt-4 d-flex flex-wrap justify-content-center align-items-center text-white fw-semibold fs-5">
        <div class="mx-3 border-end pe-3">
          EMERGENCIES: <span class="text-warning fw-bold">000</span>
        </div>
        <div class="mx-3 border-end pe-3">
          POLICE ASSISTANCE LINE: <span class="text-warning fw-bold">131 444</span>
        </div>
        <div class="mx-3 border-end pe-3">
          CRIME STOPPERS: <span class="text-warning fw-bold">1800 333 000</span>
        </div>
        <div class="mx-3">
          <a href="https://portal.police.nsw.gov.au/s/login/?ec=302&startURL=%2Fs%2F" class="text-white text-decoration-underline" target="_blank">Community Portal</a>
        </div>
      </div>


      <br>
      <span class="down-arrow" onclick="window.scrollTo({top: document.querySelector('#alerts-section').offsetTop-60, behavior:'smooth'});"><i class="fas fa-angle-double-down"></i></span>
    </div>
  </header>

  <!-- Alerts Section --><!-- Alerts Section: Modern Card Grid Style -->
<section id="alerts-section" style="background: linear-gradient(90deg, #f5faff 70%, #faf6e2 100%); border-bottom: 1.5px solid #f0e7ca; box-shadow: 0 3px 30px -14px #8c6e2a21; padding: 60px 0;">
  <div class="container">
    <h2 class="text-center mb-4" style="font-weight:800;color:#234;">
      <i class="fas fa-exclamation-circle me-2 text-warning"></i>
      Latest Police News
    </h2>
    <div class="row g-4">
      <!-- CARD 1 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzI4Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">21 minutes ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Appeal to locate man missing from Coffs Harbour</h5>
          </div>
        </a>
      </div>
      <!-- CARD 2 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzI3Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">an hour ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Fourth teen charged following Northbridge brawl</h5>
          </div>
        </a>
      </div>
      <!-- CARD 3 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzI2Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">2 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Man charged after Illawarra mother disappears 30 years ago - Strike Force Anthea</h5>
          </div>
        </a>
      </div>
      <!-- CARD 4 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzI0Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">2 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Man charged with DV, firearms, drug offences - Armidale</h5>
          </div>
        </a>
      </div>
      <!-- CARD 5 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzIxLmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">2 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Five charged, 27 infringed during Operation Rapina - Lismore</h5>
          </div>
        </a>
      </div>
      <!-- CARD 6 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzIwLmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">2 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Teens charged with property and traffic-offences - Operation Soteria</h5>
          </div>
        </a>
      </div>
      <!-- CARD 7 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzE1Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">3 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Man charged with alleged commercial drug supply - Central Coast</h5>
          </div>
        </a>
      </div>
      <!-- CARD 8 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzE5Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">3 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Wanted man charged following pursuit - Dubbo</h5>
          </div>
        </a>
      </div>
      <!-- CARD 9 -->
      <div class="col-md-4">
        <a href="https://www.police.nsw.gov.au/news/news?sq_content_src=%2BdXJsPWh0dHBzJTNBJTJGJTJGZWJpenByZC5wb2xpY2UubnN3Lmdvdi5hdSUyRm1lZGlhJTJGMTE4NzE3Lmh0bWwmYWxsPTE%3D" target="_blank" class="text-decoration-none">
          <div class="alert-card p-4 h-100 shadow-sm rounded-4 bg-white position-relative">
            <span class="badge bg-warning text-dark position-absolute top-0 start-0 m-3" style="font-size:.98em;">4 hours ago</span>
            <h5 class="mt-4 mb-2 text-primary" style="font-weight:600;">Cold-case arrest three decades after Illawarra mother disappears - Strike Force Anthea</h5>
          </div>
        </a>
      </div>
    </div>
  </div>
</section>

<!-- Alerts Card Styling -->
<style>
  .alert-card {
    transition: box-shadow .22s, transform .14s;
  }
  .alert-card:hover {
    box-shadow: 0 16px 40px #1586fa26, 0 3px 12px #ffd90022;
    transform: translateY(-2px) scale(1.03);
    background: linear-gradient(105deg, #f7fafd 60%, #fffbe8 100%);
  }
</style>



  <!-- News Section -->
  <!-- News Section - Carousel Style -->
<!-- News Section - Carousel Style with Soft Cards and Smoother Slide -->
<section class="news-section" id="news-section">
  <div class="container">
    <h2 class="text-center mb-4" style="font-weight:800;color:#234;">
      <i class="fas fa-newspaper me-2 text-primary"></i>
      Latest Police Alerts
    </h2>
    <div id="newsCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
      <div class="carousel-inner">
        <!-- Slide 1 -->
        <div class="carousel-item active">
          <div class="news-card-soft row justify-content-center align-items-center mx-auto">
            <div class="col-md-5 p-0">
              <img src="news1.jpg" alt="Operation" class="d-block w-100 rounded-start card-img" style="object-fit:cover;min-height:220px;">
            </div>
            <div class="col-md-7 p-4">
              <h4 style="font-weight:700;">$1,000,000 reward offered for information</h4>
              <div class="text-muted mb-2" style="font-size:1rem;">27 May 2025</div>
              <p style="color:#245;">Rewards are being offered for reporting on missing people.</p>
              <a href="https://www.police.nsw.gov.au/can_you_help_us/rewards/1000000_reward" class="btn btn-link px-0">Read more</a>
            </div>
          </div>
        </div>
        <!-- Slide 2 -->
        <div class="carousel-item">
          <div class="news-card-soft row justify-content-center align-items-center mx-auto">
            <div class="col-md-5 p-0">
              <img src="news2.jpg" alt="Cyber Security" class="d-block w-100 rounded-start card-img" style="object-fit:cover;min-height:220px;">
            </div>
            <div class="col-md-7 p-4">
              <h4 style="font-weight:700;">Cyber Safety Awareness</h4>
              <div class="text-muted mb-2" style="font-size:1rem;">24 May 2025</div>
              <p style="color:#245;">Promoting safe online practices as cyber threats continue to rise.</p>
              <a href="https://www.police.nsw.gov.au/safety_and_prevention/crime_prevention/online_safety" class="btn btn-link px-0">Learn more</a>
            </div>
          </div>
        </div>
        <!-- Slide 3 -->
        <div class="carousel-item">
          <div class="news-card-soft row justify-content-center align-items-center mx-auto">
            <div class="col-md-5 p-0">
              <img src="news3.jpg" alt="Community" class="d-block w-100 rounded-start card-img" style="object-fit:cover;min-height:220px;">
            </div>
            <div class="col-md-7 p-4">
              <h4 style="font-weight:700;">Community Engagement Success</h4>
              <div class="text-muted mb-2" style="font-size:1rem;">20 May 2025</div>
              <p style="color:#245;">Learn about public safety.</p>
              <a href="https://www.police.nsw.gov.au/safety_and_prevention/policing_in_the_community/community_engagement" class="btn btn-link px-0">See photos</a>
            </div>
          </div>
        </div>
        <!-- Slide 4 -->
        <div class="carousel-item">
          <div class="news-card-soft row justify-content-center align-items-center mx-auto">
            <div class="col-md-5 p-0">
              <img src="news4.jpg" alt="Recruitment" class="d-block w-100 rounded-start card-img" style="object-fit:cover;min-height:220px;">
            </div>
            <div class="col-md-7 p-4">
              <h4 style="font-weight:700;">Recruitment Drive for 2025</h4>
              <div class="text-muted mb-2" style="font-size:1rem;">18 May 2025</div>
              <p style="color:#245;">NSW Police is now accepting applications for new officers. Join a team making a difference!</p>
              <a href="https://www.police.nsw.gov.au/recruitment" class="btn btn-link px-0">Apply now</a>
            </div>
          </div>
        </div>
      </div>
      <!-- Controls -->
      <button class="carousel-control-prev" type="button" data-bs-target="#newsCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#newsCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
      </button>
      <div class="carousel-indicators mt-3">
        <button type="button" data-bs-target="#newsCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#newsCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#newsCarousel" data-bs-slide-to="2"></button>
        <button type="button" data-bs-target="#newsCarousel" data-bs-slide-to="3"></button>
      </div>
    </div>
  </div>
</section>

<!-- Add to your existing <style> in the head -->
<style>
.news-section {
  background: linear-gradient(120deg, #f0f6fa 70%, #eaf1ea 100%);
  border-radius: 24px;
  box-shadow: 0 4px 32px #b6c6e522;
  padding: 52px 0 52px 0;
}
.news-card-soft {
  max-width: 850px;
  background: linear-gradient(112deg, #ffffff 70%, #f4f7ff 100%);
  border-radius: 2.1rem;
  box-shadow: 0 6px 36px #b6c6e53c, 0 1px 9px #63a4f429;
  margin: 0 auto 16px auto;
  overflow: hidden;
  transition: box-shadow 0.2s;
}
.news-card-soft:hover {
  box-shadow: 0 16px 60px #1878fa33, 0 3px 16px #ffd90015;
}
.card-img {
  border-top-left-radius: 2.1rem !important;
  border-bottom-left-radius: 2.1rem !important;
  background: #e6eef8;
}
@media (max-width: 900px) {
  .news-card-soft { flex-direction: column; max-width: 97vw;}
  .card-img { border-top-left-radius: 2.1rem !important; border-bottom-left-radius: 0 !important; border-top-right-radius: 2.1rem !important;}
}
@media (max-width: 700px) {
  .news-card-soft .col-md-5, .news-card-soft .col-md-7 { flex: 0 0 100%; max-width: 100%;}
  .news-card-soft { border-radius: 1.3rem;}
}
.carousel-indicators [data-bs-target] {
  background-color: #1586fa !important;
  width: 14px; height: 14px; border-radius: 50%;
  border: none;
  margin: 0 6px;
}
</style>

  <!-- About Section -->
  <section id="about">
    <div class="container">
      <h2 class="text-center mb-5 animate__animated animate__fadeInDown">About the System</h2>
      <div class="row g-5 align-items-center justify-content-center">
        
        <!-- LEFT: GIF & badge -->
        <div class="col-lg-6 mb-4 mb-lg-0 animate__animated animate__fadeInLeft">
          <div class="about-video-card" style="background:rgba(255,255,255,0.85);box-shadow:0 8px 40px #0056a845;border-radius:1.5rem;padding:1.2rem;position:relative;min-height:320px;display:flex;align-items:center;justify-content:center;">
            <div class="about-badge" style="position:absolute;left:18px;top:18px;width:54px;height:54px;z-index:2;background:rgba(255,255,255,0.96);border-radius:50%;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 18px #2740b822;animation:pulseBadge 2.5s infinite;">
              <svg width="38" height="38" viewBox="0 0 40 40" fill="none">
                <circle cx="20" cy="20" r="18" stroke="#ffd900" stroke-width="4" fill="#fff"/>
                <path d="M20 8 L23 20 L37 20 L25 26 L28 38 L20 31 L12 38 L15 26 L3 20 L17 20 Z" fill="#1586fa" stroke="#194ba4" stroke-width="1.2"/>
                <circle cx="20" cy="20" r="3" fill="#ffd900" stroke="#194ba4" stroke-width="1.1"/>
              </svg>
            </div>
            <!-- Replace video with GIF -->
            <img class="about-gif"
                 src="mypolice.gif"
                 alt="Police Activity GIF"
                 style="border-radius:1.1rem;width:100%;max-width:360px;min-height:220px;object-fit:cover;box-shadow:0 4px 22px #1a53a229;">
            <svg class="video-waves" viewBox="0 0 400 60" preserveAspectRatio="none" style="pointer-events:none;position:absolute;left:0;right:0;bottom:0;width:100%;height:60px;z-index:3;opacity:0.38;">
              <path d="M0,30 C100,90 300,0 400,30 L400,60 L0,60 Z" fill="#1586fa"/>
              <path d="M0,40 C120,100 320,10 400,40 L400,60 L0,60 Z" fill="#ffd900" opacity="0.27"/>
            </svg>
          </div>
        </div>
        <!-- RIGHT: Features and action -->
        <div class="col-lg-6 animate__animated animate__fadeInRight">
          <div class="glass-card position-relative" style="background:rgba(255,255,255,0.77);border-radius:1.4rem;box-shadow:0 8px 48px #83b0ff29;padding:2.1rem 2rem;position:relative;overflow:hidden;min-height:320px;">
            <svg class="about-glow" viewBox="0 0 100 100" style="position:absolute;right:-24px;bottom:-32px;width:80px;height:80px;z-index:0;filter:blur(7px);opacity:0.15;animation:aboutGlow 3s infinite alternate;">
              <circle cx="50" cy="50" r="50" fill="#1586fa"/>
            </svg>
            <h3>
              <i class="fas fa-shield-alt text-primary me-2"></i>
              Police NSW CMS
            </h3>
            <div class="about-desc" style="font-size:1.11rem;margin-bottom:24px;color:#374b7c;">
              A modern, secure, and connected system that empowers NSW Police to serve and protect the community with digital efficiency and trust.
            </div>
            <ul class="about-feature-list mb-0" style="padding-left:0;margin-bottom:0;">
              <li class="animate__animated animate__fadeInUp"><i class="fas fa-bolt"></i> Real-time crime case updates</li>
              <li class="animate__animated animate__fadeInUp" style="animation-delay:.1s;"><i class="fas fa-user-shield"></i> Secure evidence management</li>
              <li class="animate__animated animate__fadeInUp" style="animation-delay:.2s;"><i class="fas fa-users"></i> Community engagement portal</li>
              <li class="animate__animated animate__fadeInUp" style="animation-delay:.3s;"><i class="fas fa-map-marked-alt"></i> Integrated location services</li>
              <li class="animate__animated animate__fadeInUp" style="animation-delay:.4s;"><i class="fas fa-mobile-alt"></i> Mobile responsive access</li>
            </ul>
            <button id="findStation" class="find-station-btn mt-3" style="margin-top:18px;padding:12px 32px;border-radius:2em;font-weight:700;font-size:1.14rem;background:linear-gradient(90deg,#1586fa 65%,#ffd900 120%);color:#fff;border:none;box-shadow:0 2px 12px #1586fa21;position:relative;overflow:hidden;z-index:2;">
              <i class="fas fa-map-marker-alt"></i> Find Nearby Station
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section id="features" class="py-5">
    <div class="container">
      <h2 class="text-center mb-4">Key Features</h2>
      <div class="row g-4">
        <!-- Crime Reporting -->
        <div class="col-md-3">
          <a href="report.php" class="text-decoration-none text-dark">
            <div class="card feature-card h-100 text-center hover-shadow" style="cursor:pointer;">
              <img src="report.jpg" class="card-img-top" alt="Crime Reporting">
              <div class="card-body">
                <h5 class="card-title">Crime Reporting</h5>
                <p class="card-text">Submit reports securely.</p>
              </div>
            </div>
          </a>
        </div>
        <!-- Public Services -->
        <div class="col-md-3">
          <a href="pay.php" class="text-decoration-none text-dark">
            <div class="card feature-card h-100 text-center hover-shadow" style="cursor:pointer;">
              <img src="public.jpg" class="card-img-top" alt="Public Services">
              <div class="card-body">
                <h5 class="card-title">Public Services</h5>
                <p class="card-text">Pay fines & apply permits.</p>
              </div>
            </div>
          </a>
        </div>
        <!-- Community -->
        <div class="col-md-3">
          <a href="missing.php" class="text-decoration-none text-dark">
            <div class="card feature-card h-100 text-center hover-shadow" style="cursor:pointer;">
              <img src="community.jpg" class="card-img-top" alt="Community">
              <div class="card-body">
                <h5 class="card-title">Community</h5>
                <p class="card-text">Missing persons & rewards.</p>
              </div>
            </div>
          </a>
        </div>
        <!-- Station Finder (JS link) -->
        <!-- Station Finder (opens stations.php page) -->
        <div class="col-md-3">
          <a href="stations.php" class="text-decoration-none text-dark">
            <div class="card feature-card h-100 text-center hover-shadow" style="cursor:pointer;">
              <img src="logo.jpg" class="card-img-top" alt="Station Finder">
              <div class="card-body">
                <h5 class="card-title">Station Finder</h5>
                <p class="card-text">Locate nearest station.</p>
              </div>
            </div>
          </a>
        </div>

  </section>

  <!-- Professional Connect Section -->
<section id="connect" class="py-5">
  <div class="container">
    <div class="connect-content">
      <div class="connect-details">
        <h3>Follow Us: NSW Police</h3>
        <p>Stay up to date with news, campaigns, and important alerts. Follow us, reach out directly, or send your enquiry.</p>

        <div class="connect-social mb-3 d-flex gap-3">
          <a href="https://www.facebook.com/nswpoliceforce/" target="_blank" aria-label="Facebook">
            <img src="fb.jpg" alt="Facebook" style="height: 36px; width: 36px;">
          </a>
          <a href="https://x.com/nswpolice" target="_blank" aria-label="X/Twitter">
            <img src="x.jpg" alt="X" style="height: 36px; width: 36px;">
          </a>
          <a href="https://www.instagram.com/nswpolice/" target="_blank" aria-label="Instagram">
            <img src="insta.jpg" alt="Instagram" style="height: 36px; width: 36px;">
          </a>
          <a href="https://www.linkedin.com/company/nsw-police-force" target="_blank" aria-label="LinkedIn">
            <img src="linkedin.jpg" alt="LinkedIn" style="height: 36px; width: 36px;">
          </a>
        </div>

        <div class="connect-contact">
          <i class="fas fa-envelope"></i>
          <a href="mailto:contact@policensw.gov.au" class="text-white text-decoration-underline">contact@policensw.gov.au</a>
        </div>
        <div class="connect-contact">
          <i class="fas fa-phone-alt"></i>
          <a href="tel:+61212345678" class="text-white text-decoration-underline">(02) 1234 5678</a>
        </div>
        <div class="connect-contact">
          <i class="fas fa-map-marker-alt"></i>
          HQ: 1 Police Plaza, Sydney NSW
        </div>
      </div>
    </div>
  </div>
</section>

  <!-- Social Icons in Connect Section -->


  <!-- Footer -->
  <footer class="text-center bg-dark text-white py-3 mt-5">
    <p class="mb-0">&copy; 2025 Police NSW CMS</p>
  </footer>
  <!-- Bootstrap JS & Geolocation -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  
</body>
</html>
