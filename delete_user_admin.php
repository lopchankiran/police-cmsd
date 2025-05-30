<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id'])) {
    $id = intval($_POST['id']);

    if ($_SESSION['user_id'] == $id) {
        $_SESSION['msg'] = 'You cannot delete your own account while logged in.';
    } else {
        $stmt = $conn->prepare("DELETE FROM staff WHERE id = ?");
        $stmt->bind_param('i', $id);
        if ($stmt->execute()) {
            $_SESSION['msg'] = 'User deleted successfully.';
        } else {
            $_SESSION['msg'] = 'Delete failed: ' . $stmt->error;
        }
        $stmt->close();
    }
}

$conn->close();
header('Location: register.php'); // ✅ No modal hash in the URL
exit;
