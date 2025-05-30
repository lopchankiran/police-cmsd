<?php
session_start();
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/fpdf.php';       // the one-file library

// Only forensic officers may run this
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'forensic_officer') {
    header('Location: login.php');
    exit;
}

$db   = getDbConnection();
$type = $_POST['report_type'] ?? 'evidence_summary';

// Instantiate FPDF and add a page
$pdf = new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial','B',14);

// Header
$pdf->Cell(0,10, 'Forensic Report', 0,1,'C');
$pdf->SetFont('Arial','',10);
$pdf->Cell(0,6, 'Generated: '.date('Y-m-d H:i'), 0,1,'C');
$pdf->Ln(4);

// ════════════════════════════════════════════════
// Evidence Summary
// ════════════════════════════════════════════════
if ($type === 'evidence_summary') {
    $pdf->SetFont('Arial','B',12);
    $pdf->Cell(0,8,'Recent Evidence Summary',0,1);
    $pdf->Ln(2);

    // Table header
    $pdf->SetFont('Arial','B',10);
    $pdf->Cell(20,7,'ID',1);
    $pdf->Cell(60,7,'Title',1);
    $pdf->Cell(50,7,'Tags',1);
    $pdf->Cell(50,7,'Uploaded At',1);
    $pdf->Ln();

    // Table rows
    $pdf->SetFont('Arial','',9);
    $res = $db->query("
      SELECT evidence_id, title, tags, uploaded_at
        FROM evidence
       ORDER BY uploaded_at DESC
       LIMIT 50
    ");
    while ($r = $res->fetch_assoc()) {
        $pdf->Cell(20,6, $r['evidence_id'],1);
        $pdf->Cell(60,6, substr($r['title'], 0, 30),1);
        $pdf->Cell(50,6, substr($r['tags'], 0, 25),1);
        $pdf->Cell(50,6, $r['uploaded_at'],1);
        $pdf->Ln();
    }

// ════════════════════════════════════════════════
// Full Forensic Evidence
// ════════════════════════════════════════════════
} else {
    $pdf->SetFont('Arial','B',12);
    $pdf->Cell(0,8,'Full Forensic Evidence Details',0,1);
    $pdf->Ln(2);

    // Table header
    $pdf->SetFont('Arial','B',10);
    $pdf->Cell(15,7,'ID',1);
    $pdf->Cell(50,7,'Title',1);
    $pdf->Cell(60,7,'File Path',1);
    $pdf->Cell(20,7,'Words',1);
    $pdf->Cell(30,7,'Keywords',1);
    $pdf->Cell(30,7,'Uploaded',1);
    $pdf->Ln();

    // Table rows
    $pdf->SetFont('Arial','',9);
    $res = $db->query("
      SELECT id, title, file_path, metadata, uploaded_at
        FROM forensic_evidence
       ORDER BY uploaded_at DESC
       LIMIT 50
    ");
    while ($r = $res->fetch_assoc()) {
        $meta = json_decode($r['metadata'], true);
        $pdf->Cell(15,6, $r['id'],1);
        $pdf->Cell(50,6, substr($r['title'], 0, 25),1);
        $pdf->Cell(60,6, substr($r['file_path'], 0, 30),1);
        $pdf->Cell(20,6, number_format($meta['word_count'] ?? 0),1);
        $pdf->Cell(30,6, substr(implode(',',$meta['suspicious_keywords'] ?? []),0,20),1);
        $pdf->Cell(30,6, $r['uploaded_at'],1);
        $pdf->Ln();
    }
}

// Output as download
$pdf->Output('D', 'forensic_report_'.date('Ymd_His').'.pdf');
exit;
