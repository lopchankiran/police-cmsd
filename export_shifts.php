<?php
require_once 'config.php';
$conn = getDbConnection();

header('Content-Type: text/csv');
header('Content-Disposition: attachment;filename=shifts_export.csv');

$output = fopen('php://output', 'w');
fputcsv($output, ['ID', 'Officer ID', 'Shift Date', 'Start Time', 'End Time', 'Notes', 'Created At']);

$result = $conn->query("SELECT * FROM shifts");
while ($row = $result->fetch_assoc()) {
    fputcsv($output, $row);
}
fclose($output);
exit;
