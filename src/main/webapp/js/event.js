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

// Initialize Add Batch functionality
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

    // Close the popup
    const closePopup = () => {
        if ( addEventPopup) {
            addEventPopup.style.display = 'none'; // Hide the popup
        }
    };

    if (closeAddPopupButton) {
        closeAddPopupButton.addEventListener('click', closePopup);
    }

    if (cancelAddPopupButton) {
        cancelAddPopupButton.addEventListener('click', closePopup);
    }

    // Handle form submission
    if ( addEventPopup) {
        addEventPopup.addEventListener('submit', (e) => {
            e.preventDefault(); // Prevent default form submission
            console.log('Add Event Form submitted!');
            closePopup();
        });
    }
};


// Initialize Delete event functionality
const initializeDeleteEvents = () => {
    const deleteButtons = document.querySelectorAll('.delete');
    const popupOverlay = document.querySelector('.popup-overlay');
    const closeBtn = document.querySelector('.popup-close');
    const cancelBtn = document.querySelector('.cancel-btn');
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

// Initialize edite event functionality
const initializeEditEvent = () => {
    const editButtons = document.querySelectorAll('.edit'); // Ensure this targets your edit buttons
    const popupOverlay = document.querySelector('.edit-event');
    const closeBtn = document.querySelector('.event-close');
    const cancelBtn = document.querySelector('.cancel');
    const editForm = document.querySelector('#editForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr'); // Find the row associated with the button
            const eventId = row.querySelector('td:nth-child(1)').textContent;
            const eventName = row.querySelector('td:nth-child(2)').textContent;
            const eventDate = row.querySelector('td:nth-child(3)').textContent;
            const eventTime = row.querySelector('td:nth-child(4)').textContent;
            const eventPlatform = row.querySelector('td:nth-child(5)').textContent;

            // Populate the form with existing data
            document.querySelector('#student-id').value = eventId;
            document.querySelector('#student-name').value = eventName;
            document.querySelector('#student-date').value = eventDate;
            document.querySelector('#student-time').value = eventTime;
            document.querySelector('#student-platform').value = eventPlatform;

            // Show the popup
            popupOverlay.style.display = 'flex';
            popupOverlay.style.opacity = '1';
        });
    });

    // Close the popup when the close icon is clicked
    closeBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });

    // Cancel button hides the popup
    cancelBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });

    // Handle form submission (Save the edited event)
    editForm.addEventListener('submit', (e) => {
        e.preventDefault();

        const updatedEvent = {
            id: document.querySelector('#student-id').value,
            name: document.querySelector('#student-name').value,
            date: document.querySelector('#student-date').value,
            time: document.querySelector('#student-time').value,
            platform: document.querySelector('#student-platform').value
        };

        console.log('Event updated:', updatedEvent);

        // Add the code here to save the updated event (e.g., make an AJAX request to update the backend)

        // Close the popup after saving
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });
};
// Show popup when button is clicked
document.getElementById('markAttendanceBtn').addEventListener('click', () => {
    document.getElementById('popupOverlay').style.display = 'flex';
});

// Close popup
document.getElementById('closePopupBtn').addEventListener('click', () => {
    document.getElementById('popupOverlay').style.display = 'none';
});

// Handle form submission
document.getElementById('attendanceForm').addEventListener('submit', (event) => {
    event.preventDefault();

    const batch = document.getElementById('batch').value;
    const student = document.getElementById('student').value;
    const mockDetails = document.getElementById('mockDetails').value;

    alert(`Attendance marked successfully:\nBatch: ${batch}\nStudent: ${student}\nDetails: ${mockDetails}`);
    document.getElementById('popupOverlay').style.display = 'none';
});

// Call this function to initialize all necessary functionalities
document.addEventListener('DOMContentLoaded', reinitializeEventContentListeners);