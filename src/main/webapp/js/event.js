function addEvent() {
    alert("Add Event functionality to be implemented.");
}

function editEvent() {
    alert("Edit Event functionality to be implemented.");
}

function deleteEvent() {
    alert("Delete Event functionality to be implemented.");
}

function searchEvent() {
    const searchInput = document.getElementById("searchInput").value.toLowerCase();
    const table = document.getElementById("eventTable");
    const rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let cells = rows[i].getElementsByTagName("td");
        let match = false;

        for (let j = 0; j < cells.length; j++) {
            if (cells[j].innerHTML.toLowerCase().includes(searchInput)) {
                match = true;
                break;
            }
        }

        rows[i].style.display = match ? "" : "none";
    }
}
// Data for the progress of events
const progressData = [75, 85, 80]; // Replace with actual progress values

// Calculate average progress
const calculateAverageProgress = (data) => {
    const totalProgress = data.reduce((acc, curr) => acc + curr, 0);
    return totalProgress / data.length;
};

// Render the pie chart
const renderPieChart = (averageProgress) => {
    const ctx = document.getElementById('progressPieChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Completed', 'Remaining'],
            datasets: [{
                data: [averageProgress, 100 - averageProgress],
                backgroundColor: ['#4caf50', '#f44336'], // Green and red colors
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: (tooltipItem) => {
                            return tooltipItem.label + ': ' + tooltipItem.raw + '%';
                        }
                    }
                }
            }
        }
    });
};

// Initialize the pie chart
document.addEventListener('DOMContentLoaded', () => {
    const averageProgress = calculateAverageProgress(progressData);
    renderPieChart(averageProgress);
});
