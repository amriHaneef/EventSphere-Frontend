// Reinitialize the event listeners after DOM content is loaded
const reinitializeEventContentListeners = () => {
    initializeEventSearchBar();
    initializeAddEvents();
    initializeDeleteEvents();
    initializeEditEvent();
};

// Initialize Search Bar functionality
const initializeEventSearchBar = () => {
    const searchBar = document.getElementById('search-bar');
    if (searchBar) {
        console.log("Search bar found and initializing...");
        searchBar.addEventListener('input', function () {
            const filter = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll('tbody tr');

            rows.forEach(row => {
                const cells = Array.from(row.querySelectorAll('td'));
                const rowContent = cells.map(cell => cell.textContent.toLowerCase().trim()).join(' ');

                if (rowContent.includes(filter)) {
                    row.style.display = ''; // Show the row
                } else {
                    row.style.display = 'none'; // Hide the row
                }
            });
        });
    } else {
        console.error('Search bar not found!');
    }
};

// Initialize Add Events functionality
const initializeAddEvents = () => {
    const addButton = document.querySelector('.report');
    const addEventPopup = document.querySelector('.add-event-popup');
    const closeAddPopupButton = document.querySelector('.popup-close');
    const cancelAddPopupButton = document.querySelector('.cancel-btn');
    const addEventForm = document.querySelector('#addeventForm');

    if (addButton && addEventPopup) {
        addButton.addEventListener('click', () => {
            addEventPopup.style.display = 'flex';
        });
    }

    const closePopup = () => {
        if (addEventPopup) {
            addEventPopup.style.display = 'none'; // Hide the popup
        }
    };

    if (closeAddPopupButton) {
        closeAddPopupButton.addEventListener('click', closePopup);
    }

    if (cancelAddPopupButton) {
        cancelAddPopupButton.addEventListener('click', closePopup);
    }

    if (addEventForm) {
        addEventForm.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log('Add Event Form submitted!');
            closePopup();
        });
    }
};

// Initialize Delete Events functionality
const initializeDeleteEvents = () => {
    const deleteButtons = document.querySelectorAll('.delete');
    const popupOverlay = document.querySelector('.popup-overlay');
    const closeBtn = document.querySelector('.delete-close');
    const cancelBtn = document.querySelector('.cancel-Btn');
    const okBtn = document.querySelector('.ok-btn');

    deleteButtons.forEach((deleteButton) => {
        deleteButton.addEventListener('click', () => {
            popupOverlay.style.display = 'flex';
            popupOverlay.style.opacity = '1';
        });
    });

    closeBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });

    cancelBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });

    okBtn.addEventListener('click', () => {
        console.log('Event Deleted');
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });
};

// Initialize Edit event functionality
const initializeEditEvent = () => {
    const editButtons = document.querySelectorAll('.edit');
    const popupOverlay = document.querySelector('.edit-Overlay');
    const closeBtn = document.querySelector('.edit-Close');
    const cancelBtn = document.querySelector('.Cancel-Btn');
    const editeventForm = document.querySelector('#editeventForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr'); // Find the row associated with the button
            const id = row.querySelector('td:nth-child(1)').textContent;
            const name = row.querySelector('td:nth-child(2)').textContent;
            const date = row.querySelector('td:nth-child(3)').textContent;
            const time = row.querySelector('td:nth-child(4)').textContent;
            const platform = row.querySelector('td:nth-child(5)').textContent;
            const lecturer = row.querySelector('td:nth-child(6)').textContent
            const status = row.querySelector('td:nth-child(7)').textContent;

            // Populate the form with existing data
            document.querySelector('#event-id').value = id;
            document.querySelector('#event-name').value = name;
            document.querySelector('#event-date').value = date;
            document.querySelector('#event-time').value = time;
            document.querySelector('#event-Platform').value = platform;
            document.querySelector('#lecturer-name').value = lecturer;
            document.querySelector('#event-status').value = status;

            // Show the popup
            popupOverlay.style.display = 'flex';
            popupOverlay.style.opacity = '1';
        });
    });

    // Close the popup when the close icon is clicked
    closeBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
    });

    // Cancel button hides the popup
    cancelBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
    });
};


function backToEvent(){
    document.getElementById("eventTable").style.display= "block";
    document.getElementById("eventDetails").style.display= "none";
}
function showEventDetails(eventId, eventName, eventDate, eventTime, platform, lecturer, status) {

    document.getElementById("eventTable").style.display= "none";
    document.getElementById("eventDetails").style.display= "block";
    // Example data retrieval logic (replace with actual server-side logic)
    const eventDetails = {
        eventId: eventId,
        eventName: eventName,
        eventDate: eventDate,
        eventTime: eventTime,
        platform: platform,
        lecturer: lecturer,
        status: status
    };

    // Populate the event details table
    document.getElementById("detail-event-id").innerText = eventDetails.eventId;
    document.getElementById("detail-event-name").innerText = eventDetails.eventName;
    document.getElementById("detail-event-date").innerText = eventDetails.eventDate;
    document.getElementById("detail-event-time").innerText = eventDetails.eventTime;
    document.getElementById("detail-event-platform").innerText = eventDetails.platform;
    document.getElementById("detail-event-lecturer").innerText = eventDetails.lecturer;
    document.getElementById("detail-event-status").innerText = eventDetails.status;

    // Show the event details container
    document.querySelector(".event-details-container").style.display = "block";
}

// Function to open the attendance popup
function showAttendancePopup(eventId) {
    fetchStudentsForEvent(eventId);
    document.querySelector('.attendance-popup').style.display = 'block';
}

// Function to close the attendance popup
document.querySelector('.attendance-close').addEventListener('click', function() {
    document.querySelector('.attendance-popup').style.display = 'none';
});

// Fetch the students list for the specific event
function fetchStudentsForEvent(eventId) {

    const students = [
        { id: 1, name: 'Student A' },
        { id: 2, name: 'Student B' },
        { id: 3, name: 'Student C' }
    ];

    // Generate the HTML for the student list with checkboxes
    let studentListHTML = '';
    students.forEach(student => {
        studentListHTML += `
            <div class="student-item">
                <input type="checkbox" id="student-${student.id}" name="attendance" value="${student.id}">
                <label for="student-${student.id}">${student.name}</label>
            </div>
        `;
    });

    // Add the generated list to the container
    document.getElementById('studentListContainer').innerHTML = studentListHTML;
}

// Handle the form submission
document.getElementById('attendanceForm').addEventListener('submit', function(event) {
    event.preventDefault();

    // Get the selected students (attendance marked as checked)
    const selectedStudents = [];
    document.querySelectorAll('input[name="attendance"]:checked').forEach(checkbox => {
        selectedStudents.push(checkbox.value);
    });

    // Log or process the selected students
    console.log('Attendance marked for students:', selectedStudents);

    // Optionally, send the data to the backend to save attendance
    // Example: submitAttendance(eventId, selectedStudents);

    // Close the popup after submitting
    document.querySelector('.attendance-popup').style.display = 'none';
});


// Initialize all functionalities on DOM content load
document.addEventListener('DOMContentLoaded', reinitializeEventContentListeners);
