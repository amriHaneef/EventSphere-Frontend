function addEvent() {
    alert("Add Event functionality to be implemented.");
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
    const eventBatch = document.getElementById('eventType').value.trim();
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
    console.log({ eventName, eventDate, eventType, eventProgress });

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

// Sample student data for each batch
const students = {
    "DSE23.2f": [
        { id: 1, name: "Amri" },
        { id: 2, name: "Harindu" },
        { id: 3, name: "Shan" }
    ],
    "DSE23.3f": [
        { id: 4, name: "Adeesha" },
        { id: 5, name: "Niki" }
    ],
    "HDSE23.2f": [
        { id: 6, name: "Nadeesha" },
        { id: 7, name: "Dilani" }
    ],
    "HDSE24.2f": [
        { id: 8, name: "Tharindu" },
        { id: 9, name: "Tharu" }
    ]
};

// Function to load attendance based on selected batch
function loadAttendance() {
    const selectedBatch = document.getElementById("eventBatch_attendence").value;
    const attendanceList = document.getElementById("attendanceList");

    // Clear the existing list
    attendanceList.innerHTML = "";

    // Check if a batch is selected
    if (selectedBatch) {
        const batchStudents = students[selectedBatch];
        if (batchStudents) {
            batchStudents.forEach(student => {
                const listItem = `
                    <li>
                        <input type="checkbox" id="attendee_${student.id}">
                        <label for="attendee_${student.id}">${student.name}</label>
                    </li>`;
                attendanceList.innerHTML += listItem;
            });
        }
    }
}

// Function to submit attendance
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
// Open the popup for Add or Edit actions
function openPopup(action, eventData = null) {
    const popupTitle = document.getElementById("popupTitle");
    const submitButton = document.getElementById("popupSubmitButton");
    const eventForm = document.getElementById("eventForm");

    // Set the popup title and button text based on the action
    if (action === "add") {
        popupTitle.innerText = "Add Event";
        submitButton.innerText = "Add Event";
        eventForm.reset(); // Clear the form
        document.getElementById("eventId").value = ""; // Clear hidden event ID
    } else if (action === "edit") {
        popupTitle.innerText = "Edit Event";
        submitButton.innerText = "Save Changes";

        // Populate the form with existing event data
        document.getElementById("eventId").value = eventData.eventId;
        document.getElementById("eventName").value = eventData.eventName;
        document.getElementById("eventType").value = eventData.eventType;
        document.getElementById("eventDate").value = eventData.eventDate;

    }

    // Show the popup
    document.getElementById("popupForm").style.display = "block";
}



// Close the popup
function closePopup() {
    document.getElementById("popupForm").style.display = "none";
}

// Example: Trigger the popup for adding an event
function addEvent() {
    openPopup("add");
}

// Example: Trigger the popup for editing an event
function editEvent(eventId) {
    // Fetch event data from the table or backend (dummy data for example)
    const eventData = {
        eventId: eventId,
        eventType: "Session-Workshop",
        eventBatch: "DSE23.2f",
        eventDate: "2024-12-25",
        eventName: "Java Workshop"

    };

    openPopup("edit", eventData);
}

// Event listener for form submission
document.getElementById("eventForm").addEventListener("submit", function (e) {
    e.preventDefault(); // Prevent default form submission
    const eventId = document.getElementById("eventId").value;

    if (eventId) {
        // Call the backend to update the event (Edit)
        console.log("Editing event:", eventId);
    } else {
        // Call the backend to add a new event (Add)
        console.log("Adding new event");
    }

    closePopup(); // Close the popup after submission
});


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