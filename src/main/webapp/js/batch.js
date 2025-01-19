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
const initializeAddBatches = () => {
    const addButton = document.querySelector('.report');
    const addBatchPopup = document.querySelector('.add-batch-popup');
    const closeAddPopupButton = document.querySelector('.popup-close');
    const cancelAddPopupButton = document.querySelector('.cancel-btn');

    if (addButton && addBatchPopup) {
        addButton.addEventListener('click', () => {
            addBatchPopup.style.display = 'flex';
        });
    }

    // Close the popup
    const closePopup = () => {
        if (addBatchPopup) {
            addBatchPopup.style.display = 'none'; // Hide the popup
        }
    };

    if (closeAddPopupButton) {
        closeAddPopupButton.addEventListener('click', closePopup);
    }

    if (cancelAddPopupButton) {
        cancelAddPopupButton.addEventListener('click', closePopup);
    }

};


// Initialize Delete Batch functionality
const initializeDeleteBatches = () => {
    const deleteButtons = document.querySelectorAll('.delete');
    const popupOverlay = document.querySelector('.popup-overlay');
    const closeBtn = document.querySelector('.popup-close-delete');
    const cancelBtn = document.querySelector('.cancel-btn-delete');
    const okBtn = document.querySelector('.ok-btn');

    deleteButtons.forEach((deleteButton) => {
        deleteButton.addEventListener('click', () => {
            popupOverlay.style.display = 'flex';
        });
    });

    const closePopup = () => {
        popupOverlay.style.display = 'none';
    };

    if (closeBtn) {
        closeBtn.addEventListener('click', closePopup);
    }

    if (cancelBtn) {
        cancelBtn.addEventListener('click', closePopup);
    }

    if (okBtn) {
        okBtn.addEventListener('click', () => {
            console.log('Batch deleted!');
            closePopup();
        });
    }
};

// Initialize Edit Batch functionality
// -------------------------------------------------- Edit User Process ---------------------------------------------
const initializeEditBatches = () => {
    const editButtons = document.querySelectorAll('.edit'); // Edit buttons
    const popupOverlay = document.querySelector('.edit-overlay');
    const closeBtn = document.querySelector('.edit-close');
    const cancelBtn = document.querySelector('.edit-cancel');
    const editForm = document.querySelector('#editForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr'); // Find the row associated with the button
            const id = row.querySelector('td:nth-child(1)').textContent;
            const name = row.querySelector('td:nth-child(2)').textContent;
            const start_date = row.querySelector('td:nth-child(3)').textContent;
            const end_date = row.querySelector('td:nth-child(4)').textContent;
            const assigned_students = row.querySelector('td:nth-child(5)').textContent;
            const lecturer = row.querySelector('td:nth-child(6)').textContent;

            // Populate the form with existing data
            document.querySelector('#batch-id').value = id;
            document.querySelector('#batch-name').value = name;
            document.querySelector('#start-date').value = start_date;
            document.querySelector('#end-date').value = end_date;
            document.querySelector('#students').value = assigned_students;
            document.querySelector('#lecturers').value = lecturer;

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
};
// ------------------------------------------------ End of Edit User Process ----------------------------------------

document.addEventListener('DOMContentLoaded', reinitializeBatchesListeners);
