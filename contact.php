<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Us - Police NSW CMS</title>
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
      min-height: 100vh;
    }
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
    .contact-card form .form-label {
      font-weight: 500;
      color: #133a64;
      margin-bottom: 4px;
    }
    .contact-card form .form-control {
      border-radius: 10px;
      border: 2px solid #e1ecfb;
      box-shadow: none;
      padding: .70rem .95rem;
      font-size: 1.07rem;
      margin-bottom: 16px;
      transition: border-color .23s, box-shadow .17s, background .17s;
      background: #f4f7fa;
    }
    .contact-card form .form-control:focus {
      border-color: #1586fa;
      background: #fff;
      box-shadow: 0 2px 14px #1586fa16;
    }
    .contact-card form textarea.form-control {
      min-height: 90px;
      resize: vertical;
    }
    .contact-card .btn {
      border-radius: 9px;
      padding: .62rem 0;
      font-weight: 700;
      letter-spacing: .02em;
      background: linear-gradient(90deg,#1586fa 65%,#ffd900 120%);
      border: none;
      color: #fff;
      font-size: 1.14rem;
      transition: background .19s, color .14s;
      box-shadow: 0 2px 8px #1586fa19;
    }
    .contact-card .btn:hover {
      background: #ffd900;
      color: #22395d;
    }
    @media (max-width: 600px) {
      .contact-card {
        padding: 32px 7vw 25px 7vw;
        max-width: 97vw;
      }
    }
    footer {
      letter-spacing: .01em;
      font-size: 1.07rem;
      background: linear-gradient(90deg,#133a64 30%,#2d5177 100%);
      border-top: 2px solid #d8e5ef;
      box-shadow: 0 -2px 18px #133a6417;
      margin-top: 70px;
    }
  </style>
</head>
<body>
  <!-- Navbar (optional, can be copied from index.php) -->
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow-sm" style="background: linear-gradient(90deg, #112d55 0%, #304c73 80%);">
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
            <li class="nav-item"><a class="nav-link" href="index.php#connect">Connect</a></li>
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

  <!-- Contact Card -->
  <section class="bg-light py-5" style="min-height:60vh;">
    <div class="container">
      <div class="contact-card animate__animated animate__fadeInUp">
        <div class="contact-icon animate__animated animate__zoomIn">
          <i class="fas fa-envelope-open-text"></i>
        </div>
        <h2>Contact Us</h2>
        <div class="contact-desc">
          Have a question, feedback, or want to get in touch with NSW Police? Please use the form below and our team will get back to you as soon as possible.
        </div>
        <!-- Handle the form submission in PHP below -->
        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
          // You can replace this with actual emailing or DB saving logic
          $name = htmlspecialchars($_POST['name']);
          $email = htmlspecialchars($_POST['email']);
          $message = htmlspecialchars($_POST['message']);
          echo '<div class="alert alert-success">Thank you, ' . $name . '. Your message has been received!</div>';
          // To send email, use mail() function here (set up mail server)
        }
        ?>
        <form action="contact.php" method="POST" autocomplete="off">
          <label class="form-label" for="contactName">Name</label>
          <input type="text" class="form-control" id="contactName" name="name" required>
          <label class="form-label" for="contactEmail">Email</label>
          <input type="email" class="form-control" id="contactEmail" name="email" required>
          <label class="form-label" for="contactMsg">Message</label>
          <textarea class="form-control" id="contactMsg" name="message" required></textarea>
          <button type="submit" class="btn w-100 mt-2">Send Message</button>
        </form>
      </div>
    </div>
  </section>
  <!-- Footer -->
  <footer class="text-center text-white py-3">
    <p class="mb-0">&copy; 2025 Police NSW CMS</p>
  </footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
