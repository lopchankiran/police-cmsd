<?php
session_start();
require_once __DIR__ . '/config.php';      // your getDbConnection()
$db = getDbConnection();

// only allow logged-in users
if (!isset($_SESSION['user_id'], $_SESSION['role'])) {
    header('Location: login.php');
    exit;
}

$errors = [];
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $toUsername = trim($_POST['to']);
    $message    = trim($_POST['message']);
    $sender_id  = $_SESSION['user_id'];     // this is staff.id

    if ($toUsername === '' || $message === '') {
        $errors[] = 'Please select a recipient and enter a message.';
    } else {
        // 1) look up recipient’s staff.id
        $stmt = $db->prepare("SELECT `id` FROM `staff` WHERE `username` = ?");
        $stmt->bind_param('s', $toUsername);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows === 0) {
            $errors[] = "User “{$toUsername}” not found in staff.";
        } else {
            $row = $res->fetch_assoc();
            $recipient_id = $row['id'];
            $stmt->close();

            // 2) insert the message
            $ins = $db->prepare("
                INSERT INTO `messages` 
                  (`sender_id`, `recipient_id`, `message`) 
                VALUES (?,?,?)
            ");
            $ins->bind_param('iis', $sender_id, $recipient_id, $message);
            if ($ins->execute()) {
                $success = "Message sent to “{$toUsername}”.";
            } else {
                $errors[] = "Failed to send message. Please try again.";
            }
            $ins->close();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Secure Messaging</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container py-5">
    <h3>Secure Messaging</h3>

    <?php if ($success): ?>
      <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
    <?php endif; ?>

    <?php if ($errors): ?>
      <?php foreach ($errors as $e): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($e) ?></div>
      <?php endforeach; ?>
    <?php endif; ?>

    <form method="POST" class="bg-white p-4 rounded shadow-sm">
      <div class="mb-3">
        <label for="to" class="form-label">To</label>
        <select name="to" id="to" class="form-control" required>
          <option value="">-- select recipient --</option>
          <option value="ravin" <?= (isset($_POST['to']) && $_POST['to']==='ravin') ? 'selected' : '' ?>>ravin</option>
          <option value="kiran" <?= (isset($_POST['to']) && $_POST['to']==='kiran') ? 'selected' : '' ?>>kiran</option>
          <option value="sudip" <?= (isset($_POST['to']) && $_POST['to']==='sudip') ? 'selected' : '' ?>>sudip</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="message" class="form-label">Message</label>
        <textarea name="message" id="message" class="form-control" rows="4" required><?= htmlspecialchars($_POST['message'] ?? '') ?></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Send Message</button>
    </form>
  </div>
</body>
</html>
