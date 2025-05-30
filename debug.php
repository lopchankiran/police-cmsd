<?php
// debug.php
require_once 'config.php';

// 1. Show which DB we're actually talking to
echo '<strong>Connected to DB:</strong> ' . DB_NAME . '<br>';

// 2. Confirm the staff table exists and how many rows it has
$db = getDbConnection();
$res = $db->query("SHOW TABLES LIKE 'staff'");
echo '<strong>Staff table exists?</strong> ' . ($res && $res->num_rows ? 'Yes' : 'No') . '<br>';
$res = $db->query("SELECT COUNT(*) AS cnt FROM staff");
$row = $res ? $res->fetch_assoc() : ['cnt'=>'?'];
echo '<strong>Staff row count:</strong> ' . $row['cnt'] . '<br><br>';

// 3. List each user’s hash length, a hash preview, and whether PHP thinks it matches "123"
echo '<pre>';
$res = $db->query("SELECT username, password_hash FROM staff");
while ($r = $res->fetch_assoc()) {
    $u    = $r['username'];
    $h    = $r['password_hash'];
    $len  = strlen($h);
    $pref = substr($h, 0, 12) . '…';
    $ok   = password_verify('123', $h) ? 'OK' : 'FAIL';
    echo sprintf("%-10s | len %3d | %s | %s\n", $u, $len, $pref, $ok);
}
echo '</pre>';
