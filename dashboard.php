<div class="container-fluid py-4">
  <!-- Officer Greeting -->
  <div class="row mb-4">
    <div class="col">
      <h3><i class="fas fa-gauge-high me-2"></i>Welcome, Officer <?= htmlspecialchars($_SESSION['username']) ?></h3>
    </div>
  </div>

  <!-- Top Cards -->
  <div class="row g-4">
    <!-- Shift Info -->
<!-- Shift Info -->
<div class="col-md-4">
  <a href="shift.php" class="text-decoration-none text-dark">
    <div class="card shadow-sm border-0 rounded-4">
      <div class="card-body d-flex align-items-center">
        <div class="me-3">
          <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
            <i class="fas fa-clock"></i>
          </div>
        </div>
        <div>
          <h5 class="mb-1">Shift Info</h5>
          <p class="text-muted mb-0">Today: 0800–1700 hrs</p>
        </div>
      </div>
    </div>
  </a>
</div>

<!-- Active Cases -->
<div class="col-md-4">
  <a href="view.php" class="text-decoration-none text-dark">
    <div class="card shadow-sm border-0 rounded-4">
      <div class="card-body d-flex align-items-center">
        <div class="me-3">
          <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
            <i class="fas fa-folder-open"></i>
          </div>
        </div>
        <div>
          <h5 class="mb-1">Active Cases</h5>
          <p class="text-muted mb-0">You are assigned to <strong>4</strong> open cases</p>
        </div>
      </div>
    </div>
  </a>
</div>

    <!-- Quick Actions -->
    <div class="col-md-4">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body d-flex align-items-center">
          <div class="me-3">
            <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
              <i class="fas fa-bolt"></i>
            </div>
          </div>
          <div>
            <h5 class="mb-1">Quick Actions</h5>
            <p class="mb-0">
              <a href="report.php">File Report</a> ·
              <a href="upload.php">Upload Evidence</a>
            </p>
          </div>
        </div>
      </div>
    </div>



  <!-- Case Status Chart -->
  <div class="row mt-4">
    <div class="col-md-6">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body">
          <h5 class="card-title mb-3"><i class="fas fa-chart-pie text-info me-2"></i>Case Status Overview</h5>
          <canvas id="caseStatusChart" height="180"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Alerts and Tasks -->
  <div class="row g-4 mt-2">
    <!-- Today's Alerts -->
    <div class="col-md-6">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body">
          <h5 class="card-title mb-3"><i class="fas fa-bell text-danger me-2"></i>Today's Alerts</h5>
          <ul class="list-group list-group-flush">
            <li class="list-group-item">🔔 Suspicious activity reported in Sydney CBD</li>
            <li class="list-group-item">🧍 Missing person update: Jane Doe (Case #12345)</li>
            <li class="list-group-item">📦 Evidence submission pending for Case #9987</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Pending Tasks -->
    <div class="col-md-6">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body">
          <h5 class="card-title mb-3"><i class="fas fa-tasks text-primary me-2"></i>Pending Tasks</h5>
          <ul class="list-group list-group-flush">
            <li class="list-group-item">✅ Submit shift report for 28 May</li>
            <li class="list-group-item">🔍 Follow up on stolen vehicle case #3210</li>
            <li class="list-group-item">📅 Schedule interview with witness (Case #8871)</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Chart.js Script -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const ctx = document.getElementById('caseStatusChart').getContext('2d');
new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Open', 'Closed', 'Pending Review'],
        datasets: [{
            label: 'Case Status',
            data: [12, 7, 4],
            backgroundColor: ['#0d6efd', '#198754', '#ffc107'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'bottom',
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        return `${context.label}: ${context.raw} cases`;
                    }
                }
            }
        }
    }
});
</script>
