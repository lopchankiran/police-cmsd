-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2025 at 05:36 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crime_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `id` int(11) NOT NULL,
  `case_number` varchar(50) NOT NULL,
  `reported_by` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `reporter_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('open','investigating','closed','archived') DEFAULT 'open',
  `date_reported` datetime DEFAULT current_timestamp(),
  `last_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `assigned_officer` int(11) DEFAULT NULL,
  `report_type` varchar(50) DEFAULT 'general'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`id`, `case_number`, `reported_by`, `title`, `description`, `reporter_id`, `status`, `date_reported`, `last_updated`, `assigned_officer`, `report_type`) VALUES
(3, '', NULL, 'tall', NULL, NULL, 'open', '2000-02-12 12:00:00', '2025-05-15 13:06:42', NULL, 'Incident'),
(5, 'CASE-68255AAF5D1AA', NULL, 'tall', NULL, NULL, 'open', '2000-02-12 12:00:00', '2025-05-15 13:08:31', NULL, 'Incident'),
(6, 'CASE-68255ACFEE0BD', NULL, 'tall', NULL, NULL, 'open', '2000-02-12 12:00:00', '2025-05-15 13:09:03', NULL, 'Incident'),
(7, 'CASE-6825840D588D1', NULL, 'tall', NULL, NULL, 'open', '2025-02-12 00:11:00', '2025-05-15 16:05:01', NULL, 'Incident'),
(8, 'CASE-6825848B97A79', NULL, 'hii', NULL, NULL, 'open', '2000-12-12 00:12:00', '2025-05-15 16:07:07', NULL, 'Incident'),
(9, 'CASE-68258591955F0', NULL, 'hiii', NULL, NULL, 'open', '2025-12-12 00:11:00', '2025-05-15 16:11:29', NULL, 'Incident'),
(10, 'CASE-68391D81E0E24', NULL, 'fd', NULL, NULL, 'open', '2025-05-30 12:55:00', '2025-05-30 12:52:49', NULL, 'Incident');

-- --------------------------------------------------------

--
-- Table structure for table `case_details`
--

CREATE TABLE `case_details` (
  `detail_id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `latitude` decimal(10,6) NOT NULL,
  `longitude` decimal(10,6) NOT NULL,
  `suspect_description` varchar(255) DEFAULT NULL,
  `vehicle_info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_details`
--

INSERT INTO `case_details` (`detail_id`, `case_id`, `latitude`, `longitude`, `suspect_description`, `vehicle_info`) VALUES
(1, 5, -33.869222, 151.109905, 'rr,5,6,', 'mazda'),
(2, 6, -33.883501, 151.155996, 'rr,5,6,', 'mazda'),
(3, 7, -33.866086, 151.150074, 'rr,5,6,', 'mazda'),
(4, 8, -33.882619, 151.105442, 'rr,5,6,', 'mazda'),
(5, 9, -33.840087, 151.220284, 'rr,5,6,', 'mazda'),
(6, 10, -33.872548, 151.210556, 'd', 'd');

-- --------------------------------------------------------

--
-- Table structure for table `chain_of_custody`
--

CREATE TABLE `chain_of_custody` (
  `id` int(11) NOT NULL,
  `evidence_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `action_time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(150) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `created_at`) VALUES
(1, 'ravin', 'ravin@gmail.com', NULL, 'rrtt', '2025-05-15 04:59:33');

-- --------------------------------------------------------

--
-- Table structure for table `custody_log`
--

CREATE TABLE `custody_log` (
  `id` int(11) NOT NULL,
  `evidence_id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `custody_log`
--

INSERT INTO `custody_log` (`id`, `evidence_id`, `officer_id`, `action`, `timestamp`, `notes`) VALUES
(1, 8, 9, 'Uploaded evidence', '2025-05-30 13:05:52', NULL),
(2, 9, 9, 'Uploaded evidence', '2025-05-30 13:06:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--

CREATE TABLE `evidence` (
  `evidence_id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp(),
  `tags` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evidence`
--

INSERT INTO `evidence` (`evidence_id`, `officer_id`, `title`, `description`, `file_path`, `uploaded_at`, `tags`) VALUES
(1, 8, 'rrr', '2w4', 'uploads/evi_68255b99c0507.jpg', '2025-05-15 13:12:25', NULL),
(2, 9, 'm', 'jnk', 'uploads/evi_6839117d08e6e.jpg', '2025-05-30 12:01:33', ''),
(3, 9, 's', 's', 'uploads/evi_683919620659a.jpg', '2025-05-30 12:35:14', 's'),
(4, 9, 's', '', 'uploads/evi_68391d052c049.jpg', '2025-05-30 12:50:45', ''),
(5, 8, 'd', 'd', 'uploads/evi_68391d95eff88.jpg', '2025-05-30 12:53:09', NULL),
(6, 9, 'kkkkkk', '123', 'uploads/evi_68391f466d2af.jpg', '2025-05-30 13:00:22', ''),
(7, 9, 'kkkkkk', '123', 'uploads/evi_68391f5283fef.jpg', '2025-05-30 13:00:34', ''),
(8, 9, 'kkkkkk', '123', 'uploads/evi_68392090232ec.jpg', '2025-05-30 13:05:52', ''),
(9, 9, 'r', 'tall', 'uploads/evi_683920a1198ce.jpg', '2025-05-30 13:06:09', 'phone');

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `fine_id` int(11) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `offender_name` varchar(100) DEFAULT NULL,
  `offender_license` varchar(30) DEFAULT NULL,
  `fine_amount` decimal(10,2) NOT NULL,
  `fine_reason` varchar(255) DEFAULT NULL,
  `status` enum('unpaid','paid','appealed') DEFAULT 'unpaid',
  `issued_by` int(11) DEFAULT NULL,
  `issued_date` datetime DEFAULT current_timestamp(),
  `paid_date` datetime DEFAULT NULL,
  `payment_method` varchar(30) DEFAULT NULL,
  `license` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fine_payments`
--

CREATE TABLE `fine_payments` (
  `id` int(11) NOT NULL,
  `license_no` varchar(50) NOT NULL,
  `fine_id` int(11) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `paid_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fine_payments`
--

INSERT INTO `fine_payments` (`id`, `license_no`, `fine_id`, `amount_paid`, `paid_at`) VALUES
(1, '123', 345, 1233.00, '2025-05-15 13:27:20'),
(2, '123`', 123, 11.00, '2025-05-30 11:14:45');

-- --------------------------------------------------------

--
-- Table structure for table `forensic_evidence`
--

CREATE TABLE `forensic_evidence` (
  `id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `content` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forensic_evidence`
--

INSERT INTO `forensic_evidence` (`id`, `officer_id`, `title`, `description`, `file_path`, `uploaded_at`, `metadata`, `content`) VALUES
(1, 9, 'sss', 's', 'uploads/forensic_analysis/fanal_683911bbaf2e6.txt', '2025-05-30 12:02:35', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n'),
(2, 9, 'sss', 's', 'uploads/forensic_analysis/fanal_6839120579108.txt', '2025-05-30 12:03:49', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n'),
(3, 9, 'sss', 's', 'uploads/forensic_analysis/fanal_683912facb576.txt', '2025-05-30 12:07:54', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n');
INSERT INTO `forensic_evidence` (`id`, `officer_id`, `title`, `description`, `file_path`, `uploaded_at`, `metadata`, `content`) VALUES
(4, 9, 'sss', 's', 'uploads/forensic_analysis/fanal_68391307a49ba.txt', '2025-05-30 12:08:07', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n'),
(5, 9, 'sss', 's', 'uploads/forensic_analysis/fanal_68391421c32cf.txt', '2025-05-30 12:12:49', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n'),
(6, 9, 's', 's', 'uploads/forensic_analysis/fanal_68391d15ee0ae.txt', '2025-05-30 12:51:02', '{\"file_size\":13420,\"word_count\":1629,\"timestamps_found\":0,\"sample_timestamps\":[],\"gps_coords\":[],\"device_info\":[],\"suspicious_keywords\":[\"weapon\"]}', '**Police Service Online Portal**\r\n\r\nThis portal allows citizens to:\r\n\r\n1. Pay fines online (e.g., traffic fine).\r\n2. Apply for permits (e.g., event permit, weapon permit).\r\n\r\n**File Structure**\r\n\r\n```\r\n/                    -- Document root\r\n  config.php             -> Database connection\r\n  index.php              -> Home page\r\n  pay_fine.php           -> Fine payment form & processing\r\n  apply_permit.php       -> Permit application form & processing\r\n  db_schema.sql          -> Database schema for crime_db\r\n/css\r\n  style.css              -> Custom styles\r\n/js\r\n  main.js                -> Optional JavaScript (currently unused)\r\n/uploads                -> Uploaded documents\r\n```\r\n\r\n---\r\n\r\n### config.php\r\n\r\n```php\r\n<?php\r\n// config.php\r\n// Database credentials for crime_db\r\ndefine(\'DB_HOST\', \'localhost\');\r\ndefine(\'DB_USER\', \'your_db_user\');\r\ndefine(\'DB_PASSWORD\', \'your_db_pass\');\r\ndefine(\'DB_NAME\', \'crime_db\');\r\n\r\n/**\r\n * Returns a mysqli connection to the crime_db database.\r\n * Dies with an error message if the connection fails.\r\n */\r\nfunction getDbConnection() {\r\n    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);\r\n    if ($conn->connect_error) {\r\n        die(\'Database connection failed: \' . $conn->connect_error);\r\n    }\r\n    $conn->set_charset(\'utf8mb4\');\r\n    return $conn;\r\n}\r\n```\r\n\r\n---\r\n\r\n### index.php\r\n\r\n````php\r\n<?php\r\n// index.php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n\r\n// Fetch summary stats\r\n$conn = getDbConnection();\r\n// Count total fine payments\r\n\\$res1 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM fine_payments\");\r\n\\$paymentCount = \\$res1->fetch_assoc()[\'cnt\'] ?? 0;\r\n// Count total permit applications\r\n\\$res2 = \\$conn->query(\"SELECT COUNT(*) AS cnt FROM permits\");\r\n\\$permitCount = \\$res2->fetch_assoc()[\'cnt\'] ?? 0;\r\n$conn->close();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <div class=\"row mt-4\">\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Total Fines Paid</h5>\r\n          <p class=\"card-text display-4\"><?= \\$paymentCount ?></p>\r\n          <a href=\"pay_fine.php\" class=\"btn btn-success\">Pay More Fines</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"col-md-6\">\r\n      <div class=\"card shadow-sm\">\r\n        <div class=\"card-body\">\r\n          <h5 class=\"card-title\">Permit Applications</h5>\r\n          <p class=\"card-text display-4\"><?= \\$permitCount ?></p>\r\n          <a href=\"apply_permit.php\" class=\"btn btn-warning\">New Permit</a>\r\n        </div>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n```php\r\n<?php\r\n// index.php\r\nsession_start();\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Police Service Portal</title>\r\n  <!-- Bootstrap CSS -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Custom Styles -->\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\"><i class=\"fas fa-shield-alt\"></i> Police Portal</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navMenu\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navMenu\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"pay_fine.php\">Pay Fine</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"apply_permit.php\">Apply Permit</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<div class=\"container my-5 text-center\">\r\n  <h1>Welcome to the Police Service Portal</h1>\r\n  <p class=\"lead\">Pay fines and apply for permits quickly and securely.</p>\r\n  <a href=\"pay_fine.php\" class=\"btn btn-success me-2\">Pay Fine</a>\r\n  <a href=\"apply_permit.php\" class=\"btn btn-warning\">Apply for Permit</a>\r\n</div>\r\n\r\n<!-- Bootstrap Bundle JS -->\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n<!-- FontAwesome -->\r\n<script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n</body>\r\n</html>\r\n````\r\n\r\n---\r\n\r\n### pay\\_fine.php\r\n\r\n```php\r\n<?php\\session_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$license = trim(\\$_POST[\'license\'] ?? \'\');\r\n    \\$fine_id = intval(\\$_POST[\'fine_id\'] ?? 0);\r\n    \\$amount  = floatval(\\$_POST[\'amount\'] ?? 0);\r\n    if (empty(\\$license) || \\$fine_id <= 0 || \\$amount <= 0) {\r\n        \\$errors[] = \'All fields are required and must be valid.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO fine_payments (license_no, fine_id, amount_paid) VALUES (?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'sid\', \\$license, \\$fine_id, \\$amount);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Payment successful. Transaction ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Payment failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Pay Fine | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Pay Fine</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n    </ul></div>\r\n  <?php endif; ?>\r\n  <?php if (\\$success): ?>\r\n    <div class=\"alert alert-success\"><?=htmlspecialchars(\\$success)?></div>\r\n  <?php endif; ?>\r\n  <form method=\"POST\">\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">License No.</label>\r\n      <input type=\"text\" name=\"license\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'license\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Fine ID</label>\r\n      <input type=\"number\" name=\"fine_id\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'fine_id\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label class=\"form-label\">Amount ($)</label>\r\n      <input type=\"number\" step=\"0.01\" name=\"amount\" class=\"form-control\" value=\"<?=htmlspecialchars(\\$_POST[\'amount\'] ?? \'\')?>\" required>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-success\">Submit Payment</button>\r\n    <a href=\"index.php\" class=\"btn btn-secondary ms-2\">Back</a>\r\n  </form>\r\n</div>\r\n<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>\r\n</body>\r\n</html>\r\n```\r\n\r\n---\r\n\r\n### apply\\_permit.php\r\n\r\n````php\r\n<?php\r\nsession_start();\r\nrequire_once \'config.php\';\r\n$errors = [];\\$success = \'\';\r\nif (\\$_SERVER[\'REQUEST_METHOD\'] === \'POST\') {\r\n    \\$name = trim(\\$_POST[\'name\'] ?? \'\');\r\n    \\$permit_type = trim(\\$_POST[\'permit_type\'] ?? \'\');\r\n    \\$details = trim(\\$_POST[\'details\'] ?? \'\');\r\n    // optional file upload\r\n    \\$support_doc_path = \'\';\r\n    if (!empty(\\$_FILES[\'support_doc\'][\'tmp_name\'])) {\r\n        \\$uploadDir = __DIR__ . \'/uploads/\';\r\n        if (!is_dir(\\$uploadDir)) mkdir(\\$uploadDir, 0755, true);\r\n        \\$orig = basename(\\$_FILES[\'support_doc\'][\'name\']);\r\n        \\$new  = time() . \'_\' . mt_rand() . \'_\' . \\$orig;\r\n        if (move_uploaded_file(\\$_FILES[\'support_doc\'][\'tmp_name\'], \\$uploadDir . \\$new)) {\r\n            \\$support_doc_path = \'uploads/\' . \\$new;\r\n        }\r\n    }\r\n    if (!\\$name || !\\$permit_type) {\r\n        \\$errors[] = \'Name and permit type are required.\';\r\n    }\r\n    if (empty(\\$errors)) {\r\n        \\$conn = getDbConnection();\r\n        \\$stmt = \\$conn->prepare(\r\n            \"INSERT INTO permits (applicant_name, permit_type, details, support_doc) VALUES (?, ?, ?, ?)\"\r\n        );\r\n        \\$stmt->bind_param(\'ssss\', \\$name, \\$permit_type, \\$details, \\$support_doc_path);\r\n        if (\\$stmt->execute()) {\r\n            \\$success = \'Application received. Reference ID: \' . \\$stmt->insert_id;\r\n        } else {\r\n            \\$errors[] = \'Submission failed: \' . \\$stmt->error;\r\n        }\r\n        \\$stmt->close();\r\n        \\$conn->close();\r\n    }\r\n}\r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <title>Apply Permit | Police Portal</title>\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-primary\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.php\">Police Portal</a>\r\n  </div>\r\n</nav>\r\n<div class=\"container my-5\">\r\n  <h2>Apply for a Permit</h2>\r\n  <?php if (!empty(\\$errors)): ?>\r\n    <div class=\"alert alert-danger\"><ul>\r\n      <?php foreach (\\$errors as \\$e): ?><li><?=htmlspecialchars(\\$e)?></li><?php endforeach; ?>\r\n\r\n---\r\n\r\n### index.html\r\n```html\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <meta charset=\"UTF-8\">\r\n  <title>Police NSW CMS</title>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <!-- Bootstrap 5 -->\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <!-- Font Awesome for icons -->\r\n  <script src=\"https://kit.fontawesome.com/a076d05399.js\" crossorigin=\"anonymous\"></script>\r\n  <!-- Animate.css for simple animations -->\r\n  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css\" />\r\n  <link rel=\"stylesheet\" href=\"css/style.css\">\r\n</head>\r\n<body>\r\n\r\n<!-- Navbar -->\r\n<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark sticky-top\">\r\n  <div class=\"container\">\r\n    <a class=\"navbar-brand\" href=\"index.html\">Police NSW CMS</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarNav\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n      <ul class=\"navbar-nav ms-auto\">\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"index.php\">Portal Home</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#about\">About</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#alerts\">Alerts</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#features\">Features</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#connect\">Connect</a></li>\r\n        <li class=\"nav-item\"><a class=\"nav-link\" href=\"#contact\">Contact</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light me-2\" href=\"register.php\">Register</a></li>\r\n        <li class=\"nav-item\"><a class=\"btn btn-outline-light\" href=\"login.php\">Login</a></li>\r\n      </ul>\r\n    </div>\r\n  </div>\r\n</nav>\r\n\r\n<!-- Hero Section -->\r\n<header>\r\n  <div class=\"container text-center\">\r\n    <h1 class=\"display-3 animate__animated animate__fadeInDown\">Welcome to Police NSW CMS</h1>\r\n    <p class=\"lead animate__animated animate__fadeInUp\">Securely track, report, and manage crime data in NSW.</p>\r\n    <a href=\"login.php\" class=\"btn btn-light btn-lg mt-3 me-2\">Login</a>\r\n    <a href=\"report.php\" class=\"btn btn-outline-light btn-lg mt-3 me-2\">View Reports</a>\r\n    <a href=\"index.php\" class=\"btn btn-success btn-lg mt-3\">Go to Portal</a>\r\n  </div>\r\n</header>\r\n\r\n<!-- Rest of sections unchanged -->\r\n...\r\n````\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `forensic_notes`
--

CREATE TABLE `forensic_notes` (
  `id` int(11) NOT NULL,
  `evidence_id` int(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `note_text` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forensic_notes`
--

INSERT INTO `forensic_notes` (`id`, `evidence_id`, `author`, `note_text`, `created_at`) VALUES
(1, 4, 'sudip', 'a', '2025-05-30 12:51:26');

-- --------------------------------------------------------

--
-- Table structure for table `forensic_tasks`
--

CREATE TABLE `forensic_tasks` (
  `id` int(11) NOT NULL,
  `evidence_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `task_description` text NOT NULL,
  `status` enum('pending','in_progress','completed') NOT NULL DEFAULT 'pending',
  `due_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `assigned_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forensic_tasks`
--

INSERT INTO `forensic_tasks` (`id`, `evidence_id`, `assigned_to`, `task_description`, `status`, `due_date`, `created_at`, `updated_at`, `assigned_at`) VALUES
(1, 1, 9, '', 'pending', NULL, '2025-05-15 14:46:15', '2025-05-15 14:46:15', '2025-05-15 14:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `incidents`
--

CREATE TABLE `incidents` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `reported_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `officer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `incidents`
--

INSERT INTO `incidents` (`id`, `title`, `description`, `status`, `reported_date`, `officer_id`) VALUES
(10, 'Burglary on Elm St', 'Reported by resident. Suspect unknown.', 'open', '2025-05-30 00:25:40', 8),
(11, 'Traffic Violation', 'Speeding vehicle ran red light.', 'closed', '2025-05-30 00:25:40', 9),
(12, 'Vandalism', 'Graffiti found on public building.', 'open', '2025-05-30 00:25:40', 10);

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_time` datetime NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `login_time`, `ip_address`) VALUES
(2, 14, '2025-05-15 12:47:13', '::1'),
(3, 14, '2025-05-15 12:58:38', '::1'),
(4, 8, '2025-05-15 13:05:06', '::1'),
(5, 9, '2025-05-15 13:30:57', '::1'),
(6, 9, '2025-05-15 13:36:12', '::1'),
(7, 9, '2025-05-15 13:39:31', '::1'),
(8, 9, '2025-05-15 13:39:43', '::1'),
(9, 9, '2025-05-15 13:43:19', '::1'),
(10, 9, '2025-05-15 13:45:59', '::1'),
(11, 9, '2025-05-15 13:46:04', '::1'),
(12, 14, '2025-05-15 13:49:00', '::1'),
(13, 8, '2025-05-15 13:49:05', '::1'),
(14, 9, '2025-05-15 13:49:13', '::1'),
(15, 9, '2025-05-15 13:52:02', '::1'),
(16, 9, '2025-05-15 14:30:19', '::1'),
(17, 9, '2025-05-15 14:32:27', '::1'),
(18, 14, '2025-05-15 14:35:37', '::1'),
(19, 8, '2025-05-15 14:36:25', '::1'),
(20, 9, '2025-05-15 14:38:10', '::1'),
(21, 9, '2025-05-15 14:59:43', '::1'),
(22, 9, '2025-05-15 15:03:19', '::1'),
(23, 14, '2025-05-15 15:28:52', '::1'),
(24, 14, '2025-05-15 15:34:44', '::1'),
(25, 14, '2025-05-15 15:50:35', '::1'),
(26, 8, '2025-05-15 15:50:42', '::1'),
(27, 9, '2025-05-15 15:50:52', '::1'),
(28, 14, '2025-05-15 15:53:52', '::1'),
(29, 9, '2025-05-15 15:54:06', '::1'),
(30, 8, '2025-05-15 15:54:25', '::1'),
(31, 14, '2025-05-15 16:16:06', '::1'),
(32, 14, '2025-05-19 16:34:30', '::1'),
(33, 8, '2025-05-19 16:35:28', '::1'),
(34, 8, '2025-05-19 16:51:17', '::1'),
(35, 8, '2025-05-19 16:58:29', '::1'),
(36, 14, '2025-05-19 18:29:50', '::1'),
(37, 8, '2025-05-19 21:08:40', '::1'),
(38, 14, '2025-05-19 21:19:41', '::1'),
(39, 8, '2025-05-23 12:08:16', '::1'),
(40, 14, '2025-05-23 12:21:13', '::1'),
(41, 8, '2025-05-23 12:23:47', '::1'),
(42, 8, '2025-05-28 10:37:24', '::1'),
(43, 8, '2025-05-29 17:41:11', '::1'),
(44, 14, '2025-05-29 17:43:01', '::1'),
(45, 8, '2025-05-29 18:50:08', '::1'),
(46, 8, '2025-05-29 20:37:53', '::1'),
(47, 8, '2025-05-29 21:23:35', '::1'),
(48, 8, '2025-05-29 21:24:49', '::1'),
(49, 8, '2025-05-29 22:28:37', '::1'),
(50, 14, '2025-05-29 22:28:57', '::1'),
(51, 8, '2025-05-29 22:35:30', '::1'),
(52, 14, '2025-05-29 22:35:48', '::1'),
(53, 8, '2025-05-29 22:37:42', '::1'),
(54, 14, '2025-05-29 22:38:01', '::1'),
(55, 8, '2025-05-30 09:44:38', '::1'),
(56, 14, '2025-05-30 09:44:56', '::1'),
(57, 8, '2025-05-30 09:47:23', '::1'),
(58, 14, '2025-05-30 09:47:32', '::1'),
(59, 8, '2025-05-30 09:51:48', '::1'),
(60, 14, '2025-05-30 09:53:10', '::1'),
(61, 14, '2025-05-30 10:53:05', '::1'),
(62, 8, '2025-05-30 10:56:07', '::1'),
(63, 9, '2025-05-30 10:56:22', '::1'),
(64, 14, '2025-05-30 11:13:20', '::1'),
(65, 14, '2025-05-30 11:15:09', '::1'),
(66, 14, '2025-05-30 11:16:25', '::1'),
(67, 8, '2025-05-30 11:23:42', '::1'),
(68, 14, '2025-05-30 11:29:32', '::1'),
(69, 9, '2025-05-30 11:40:02', '::1'),
(70, 9, '2025-05-30 11:51:05', '::1'),
(71, 9, '2025-05-30 11:56:27', '::1'),
(72, 9, '2025-05-30 12:40:12', '::1'),
(73, 8, '2025-05-30 12:51:42', '::1'),
(74, 14, '2025-05-30 12:54:18', '::1'),
(75, 14, '2025-05-30 12:54:18', '::1'),
(76, 9, '2025-05-30 12:54:59', '::1'),
(77, 9, '2025-05-30 13:00:06', '::1'),
(78, 8, '2025-05-30 13:06:28', '::1'),
(79, 8, '2025-05-30 13:22:33', '::1'),
(80, 14, '2025-05-30 13:24:13', '::1'),
(81, 8, '2025-05-30 13:25:10', '::1'),
(82, 14, '2025-05-30 13:28:19', '::1'),
(83, 9, '2025-05-30 13:28:46', '::1'),
(84, 8, '2025-05-30 13:28:57', '::1'),
(85, 14, '2025-05-30 13:30:21', '::1'),
(86, 8, '2025-05-30 13:31:35', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `msg_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`msg_id`, `sender_id`, `recipient_id`, `message`, `sent_at`) VALUES
(1, 8, 14, '123', '2025-05-30 13:21:48'),
(2, 8, 8, '123', '2025-05-30 13:22:07');

-- --------------------------------------------------------

--
-- Table structure for table `missing_persons`
--

CREATE TABLE `missing_persons` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `last_seen_datetime` datetime DEFAULT NULL,
  `last_seen_location` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `reward_amount` decimal(10,2) DEFAULT 0.00,
  `reported_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `missing_persons`
--

INSERT INTO `missing_persons` (`id`, `name`, `age`, `gender`, `last_seen_datetime`, `last_seen_location`, `description`, `photo_path`, `reward_amount`, `reported_at`) VALUES
(1, 'Ravin', 24, 'Male', '2000-03-12 12:12:00', 'hurstville', 'he was', '', 123.00, '2025-05-15 13:18:15');

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `officer_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `badge_number` varchar(30) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `station` varchar(100) DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`officer_id`, `full_name`, `rank`, `badge_number`, `contact_number`, `email`, `photo`, `station`, `date_joined`, `status`) VALUES
(8, 'kiran', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active'),
(9, 'John Smith', 'Sergeant', '1234', '0412345678', 'john.smith@police.gov.au', 'john.jpg', 'Sydney Central', '2020-05-10', 'active'),
(10, 'Emma Davis', 'Inspector', '5678', '0498765432', 'emma.davis@police.gov.au', 'emma.jpg', 'Parramatta Station', '2019-11-21', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `permits`
--

CREATE TABLE `permits` (
  `permit_id` int(11) NOT NULL,
  `applicant_name` varchar(100) NOT NULL,
  `permit_type` varchar(50) NOT NULL,
  `details` text DEFAULT NULL,
  `support_doc` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `submitted_at` datetime DEFAULT current_timestamp(),
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permits`
--

INSERT INTO `permits` (`permit_id`, `applicant_name`, `permit_type`, `details`, `support_doc`, `status`, `submitted_at`, `approved_by`, `approved_at`) VALUES
(1, 'rr', 'Event', 'rerr', '', 'approved', '2025-05-15 13:20:39', 14, '2025-05-15 14:36:04'),
(2, 'rrr', 'Event', 'music', 'uploads/1748567773_8329_665558.jpg', 'rejected', '2025-05-30 11:16:13', 14, '2025-05-30 12:54:23');

-- --------------------------------------------------------

--
-- Table structure for table `police_reports`
--

CREATE TABLE `police_reports` (
  `report_id` int(11) NOT NULL,
  `case_id` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `report_title` varchar(150) NOT NULL,
  `report_text` text DEFAULT NULL,
  `file_attachment` varchar(255) DEFAULT NULL,
  `submitted_at` datetime DEFAULT current_timestamp(),
  `status` enum('pending','reviewed','closed') DEFAULT 'pending',
  `incident_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('k', 's'),
('maintenance_mode', 'off'),
('max_login_attempts', '5');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `officer_id`, `shift_date`, `start_time`, `end_time`, `notes`, `created_at`) VALUES
(1, 1, '2025-05-15', '09:00:00', '17:00:00', 'Morning shift', '2025-05-15 13:29:57'),
(2, 1, '2025-05-15', '18:00:00', '22:00:00', 'Evening shift', '2025-05-15 13:29:57'),
(4, 8, '2025-02-12', '12:10:00', '02:00:00', NULL, '2025-05-15 13:30:20'),
(5, 8, '2025-05-22', '12:12:00', '12:13:00', NULL, '2025-05-29 21:10:04'),
(7, 1, '2025-06-07', '10:58:00', '10:58:00', 'k', '2025-05-30 10:54:56'),
(8, 8, '2025-05-09', '12:51:00', '12:51:00', NULL, '2025-05-30 12:51:55'),
(9, 8, '2025-06-01', '13:33:00', '19:30:00', '', '2025-05-30 13:30:49');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','police_officer','forensic_officer') NOT NULL DEFAULT 'police_officer',
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `username`, `password_hash`, `role`, `full_name`, `email`, `created_at`) VALUES
(8, 'kiran', '$2y$10$rcJey13NKICGS0v/N3bU7.wyOihTbwXS0bobbpxcnITTbazmpwpbG', 'police_officer', 'Kiran User', 'kiran@example.com', '2025-05-15 02:33:14'),
(9, 'sudip', '$2y$10$7w6JxCGVZscE0n24W7Ecc.7.QEA60i.XLkV36GR3UjfxsJ2VKXquO', 'forensic_officer', 'Sudip User', 'sudip@example.com', '2025-05-15 02:33:14'),
(14, 'ravin', '$2y$10$CSs.cFtOIJa2Hoe8TSnMVeBsp3WD0njItC/mw81OAWyCy7rqFVb4q', 'admin', 'Ravin Admin', 'ravin@example.com', '2025-05-15 02:47:08');

-- --------------------------------------------------------

--
-- Table structure for table `tow_requests`
--

CREATE TABLE `tow_requests` (
  `id` int(11) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `vehicle_plate` varchar(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `reason` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `request_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tow_requests`
--

INSERT INTO `tow_requests` (`id`, `officer_id`, `vehicle_plate`, `location`, `reason`, `status`, `request_date`) VALUES
(1, 8, 's', 's', 's', 'Pending', '2025-05-30 03:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','police_officer','forensic_officer') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('public','officer','analyst','admin','dispatcher') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `case_number` (`case_number`),
  ADD KEY `reported_by` (`reported_by`),
  ADD KEY `assigned_officer` (`assigned_officer`),
  ADD KEY `idx_cases_reporter_id` (`reporter_id`);

--
-- Indexes for table `case_details`
--
ALTER TABLE `case_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `chain_of_custody`
--
ALTER TABLE `chain_of_custody`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custody_log`
--
ALTER TABLE `custody_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evidence_id` (`evidence_id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `evidence`
--
ALTER TABLE `evidence`
  ADD PRIMARY KEY (`evidence_id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fine_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `issued_by` (`issued_by`);

--
-- Indexes for table `fine_payments`
--
ALTER TABLE `fine_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forensic_evidence`
--
ALTER TABLE `forensic_evidence`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forensic_notes`
--
ALTER TABLE `forensic_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evidence_id` (`evidence_id`);

--
-- Indexes for table `forensic_tasks`
--
ALTER TABLE `forensic_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evidence_id` (`evidence_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `incidents`
--
ALTER TABLE `incidents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`msg_id`),
  ADD KEY `idx_sender` (`sender_id`),
  ADD KEY `idx_recipient` (`recipient_id`);

--
-- Indexes for table `missing_persons`
--
ALTER TABLE `missing_persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`officer_id`),
  ADD UNIQUE KEY `badge_number` (`badge_number`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `permits`
--
ALTER TABLE `permits`
  ADD PRIMARY KEY (`permit_id`);

--
-- Indexes for table `police_reports`
--
ALTER TABLE `police_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `tow_requests`
--
ALTER TABLE `tow_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `case_details`
--
ALTER TABLE `case_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `chain_of_custody`
--
ALTER TABLE `chain_of_custody`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custody_log`
--
ALTER TABLE `custody_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `evidence`
--
ALTER TABLE `evidence`
  MODIFY `evidence_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fine_payments`
--
ALTER TABLE `fine_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `forensic_evidence`
--
ALTER TABLE `forensic_evidence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forensic_notes`
--
ALTER TABLE `forensic_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `forensic_tasks`
--
ALTER TABLE `forensic_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `incidents`
--
ALTER TABLE `incidents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `missing_persons`
--
ALTER TABLE `missing_persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `officers`
--
ALTER TABLE `officers`
  MODIFY `officer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `permits`
--
ALTER TABLE `permits`
  MODIFY `permit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `police_reports`
--
ALTER TABLE `police_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tow_requests`
--
ALTER TABLE `tow_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`reported_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`assigned_officer`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cases_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `case_details`
--
ALTER TABLE `case_details`
  ADD CONSTRAINT `case_details_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `custody_log`
--
ALTER TABLE `custody_log`
  ADD CONSTRAINT `custody_log_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`evidence_id`),
  ADD CONSTRAINT `custody_log_ibfk_2` FOREIGN KEY (`officer_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `evidence`
--
ALTER TABLE `evidence`
  ADD CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE CASCADE;

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`issued_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `forensic_notes`
--
ALTER TABLE `forensic_notes`
  ADD CONSTRAINT `forensic_notes_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`evidence_id`);

--
-- Constraints for table `forensic_tasks`
--
ALTER TABLE `forensic_tasks`
  ADD CONSTRAINT `forensic_tasks_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`evidence_id`),
  ADD CONSTRAINT `forensic_tasks_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `staff` (`id`);

--
-- Constraints for table `incidents`
--
ALTER TABLE `incidents`
  ADD CONSTRAINT `incidents_ibfk_1` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE SET NULL;

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_msgs_recipient` FOREIGN KEY (`recipient_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_msgs_sender` FOREIGN KEY (`sender_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `police_reports`
--
ALTER TABLE `police_reports`
  ADD CONSTRAINT `police_reports_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `police_reports_ibfk_2` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE SET NULL;

--
-- Constraints for table `tow_requests`
--
ALTER TABLE `tow_requests`
  ADD CONSTRAINT `tow_requests_ibfk_1` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
