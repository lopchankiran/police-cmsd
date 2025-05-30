<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header('Location: login.php');
    exit;
}

$conn = getDbConnection();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $officer_id = intval($_POST['officer_id']);
    $shift_date = $_POST['shift_date'];
    $start_time = $_POST['start_time'];
    $end_time   = $_POST['end_time'];
    $notes      = trim($_POST['notes']);

    $stmt = $conn->prepare("INSERT INTO shifts (officer_id, shift_date, start_time, end_time, notes, created_at)
                            VALUES (?, ?, ?, ?, ?, NOW())");
    $stmt->bind_param("issss", $officer_id, $shift_date, $start_time, $end_time, $notes);
    $stmt->execute();
}

header("Location: shift_management.php");
exit;
