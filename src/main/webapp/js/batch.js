
// Reinitialize the event listeners after DOM content is loaded
const reinitializeBatchesListeners = () => {
    initializeBatchSearchBar();
    initializeAddBatches();
    initializeDeleteBatches();
    initializeEditBatches();
};

// Initialize Search Bar functionality
const initializeBatchSearchBar = () => {
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


// Initialize Add batch functionality
const initializeAddBatches = () => {
    const reportButton = document.querySelector('.report');
    const eventBackground = document.querySelector('.event-background');
    const closeButton = document.querySelector('.close-btn');
    const cancelButton = document.querySelector('.cancel');
    const eventform = document.querySelector('#event-form');

    if (reportButton && eventBackground) {
        reportButton.addEventListener('click', () => {
            eventBackground.style.display = 'block';
        });
    }

    const closePopup = () => {
        if (eventBackground) {
            eventBackground.style.display = 'none';
        }
    };

    if (closeButton) {
        closeButton.addEventListener('click', closePopup);
    }

    if (cancelButton) {
        cancelButton.addEventListener('click', closePopup);
    }

    if (eventform) {
        eventform.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log('Form submitted!');
            closePopup();
        });
    }
};

// Initialize Delete batch functionality
const initializeDeleteBatches = () => {
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

// Initialize edite batch functionality
const initializeEditBatches = () => {
    const editButtons = document.querySelectorAll('.edit'); // Ensure this targets your edit buttons
    const popupOverlay = document.querySelector('.edit-batch');
    const closeBtn = document.querySelector('.batch-close');
    const cancelBtn = document.querySelector('.cancel');
    const editForm = document.querySelector('#editForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (batch) => {
            const row = batch.target.closest('tr'); // Find the row associated with the button
            const batchId = row.querySelector('td:nth-child(1)').textContent;
            const batchName = row.querySelector('td:nth-child(2)').textContent;
            const startDate = row.querySelector('td:nth-child(3)').textContent;
            const endDate = row.querySelector('td:nth-child(4)').textContent;
            const lecturer = row.querySelector('td:nth-child(5)').textContent;

            // Populate the form with existing data
            document.querySelector('#student-id').value = batchId;
            document.querySelector('#student-name').value = batchName;
            document.querySelector('#student-date').value = startDate;
            document.querySelector('#student-time').value = endDate;
            document.querySelector('#student-platform').value = lecturer;

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
            date: document.querySelector('#student-start-date').value,
            time: document.querySelector('#student-end-date').value,
            platform: document.querySelector('#lecturer').value
        };

        console.log('Event updated:', updatedEvent);

        // Add the code here to save the updated event (e.g., make an AJAX request to update the backend)

        // Close the popup after saving
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });
};



// Call this function to initialize all necessary functionalities
document.addEventListener('DOMContentLoaded', reinitializeBatchesListeners );
