<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();

if (!isset($_GET['id'])) {
    die('Shift ID missing.');
}

$id = intval($_GET['id']);

$stmt = $conn->prepare("DELETE FROM shifts WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();

header("Location: shift_management.php");
exit;
