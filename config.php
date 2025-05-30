<?php
function getDbConnection() {
    $host = 'localhost';
    $user = 'root';
    $pass = '';  // Default XAMPP password is empty
    $dbname = 'crime_db';  // Your actual database name

    $conn = new mysqli($host, $user, $pass, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}
?>
