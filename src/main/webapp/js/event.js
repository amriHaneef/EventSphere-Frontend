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

function addEvent() {
    document.getElementById('popupForm').style.display = 'block';
}

function closePopup() {
    document.getElementById('popupForm').style.display = 'none';
}

// Add form submission functionality
document.getElementById('addEventForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevent form from reloading the page

    // Get form data
    const eventName = document.getElementById('eventName').value.trim();
    const eventDate = document.getElementById('eventDate').value.trim();
    const eventBatch = document.getElementById('eventBatch').value.trim();
    const eventProgress = document.getElementById('eventProgress').value.trim();

    // Validation logic
    let errorMessage = '';
    if (!eventName) {
        errorMessage += 'Event name is required.\n';
    }
    if (!eventDate) {
        errorMessage += 'Event date is required.\n';
    }
    if (!eventBatch) {
        errorMessage += 'Event batch is required.\n';
    }
    if (!eventProgress || isNaN(eventProgress) || eventProgress < 0 || eventProgress > 100) {
        errorMessage += 'Event progress must be a number between 0 and 100.\n';
    }

    // Check if validation failed
    if (errorMessage) {
        alert(errorMessage); // Display error message to the user
        return; // Stop further execution
    }

    // Log or handle the form data (e.g., send it to the server or add to the table)
    console.log({ eventName, eventDate, eventBatch, eventProgress });

    // Close the popup after submission
    closePopup();

    // Optionally clear the form fields
    document.getElementById('addEventForm').reset();
});

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

// Load attendance list dynamically
function loadAttendance() {
    const attendanceList = document.getElementById("attendanceList");
    const attendees = [
        { id: 1, name: "Amri" },
        { id: 2, name: "Harindu" },
        { id: 3, name: "Shan" },
        { id: 4, name: "Adeesha" }
    ];

    attendees.forEach(attendee => {
        const listItem = `<li>
            <input type="checkbox" id="attendee_${attendee.id}">
            <label for="attendee_${attendee.id}">${attendee.name}</label>
        </li>`;
        attendanceList.innerHTML += listItem;
    });
}

// Submit attendance
function submitAttendance() {
    const selectedAttendees = [];
    const checkboxes = document.querySelectorAll("#attendanceList input[type='checkbox']");
    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            const label = checkbox.nextElementSibling;
            selectedAttendees.push(label.textContent);
        }
    });

    if (selectedAttendees.length > 0) {
        alert(`Attendance submitted for: ${selectedAttendees.join(", ")}`);
    } else {
        alert("Please select at least one attendee before submitting attendance.");
    }
}

// Submit feedback
function submitFeedback() {
    const feedbackBox = document.getElementById("feedbackBox");
    const feedback = feedbackBox.value.trim();

    if (feedback) {
        alert(`Feedback submitted: ${feedback}`);
        feedbackBox.value = ""; // Clear the input field
    } else {
        alert("Please enter feedback before submitting.");
    }
}

// Initialize components on page load
window.onload = () => {
    loadAttendance();

    // Example progress value
    const progressValue = 70; // Example: 70% progress

    // Part 2: Update Circular Progress Bar
    const progressPath = document.getElementById('progressPath');
    const progressText = document.getElementById('progressText');
    const dashoffset = 100 - progressValue;
    progressPath.style.strokeDashoffset = dashoffset;
    progressText.textContent = progressValue + "%";
};

