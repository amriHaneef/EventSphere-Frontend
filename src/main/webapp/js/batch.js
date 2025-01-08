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
    const addBatchForm = document.querySelector('#addBatchForm');

    // Show the popup on button click
    if (addButton && addBatchPopup) {
        addButton.addEventListener('click', () => {
            addBatchPopup.style.display = 'flex'; // Display the popup
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

    // Handle form submission
    if (addBatchForm) {
        addBatchForm.addEventListener('submit', (e) => {
            e.preventDefault(); // Prevent default form submission
            console.log('Add Batch Form submitted!');
            closePopup();
        });
    }
};

document.addEventListener('DOMContentLoaded', initializeAddBatches);


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
const initializeEditBatches = () => {
    const editButtons = document.querySelectorAll('.edit');
    const editPopup = document.querySelector('.edit-batch');
    const closeBtn = document.querySelector('.batch-close');
    const cancelBtn = document.querySelector('.cancel');
    const editForm = document.querySelector('#editFormbatch');

    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr');
            if (!row) return;

            const batchId = row.querySelector('td:nth-child(1)').textContent;
            const batchName = row.querySelector('td:nth-child(2)').textContent;
            const startDate = row.querySelector('td:nth-child(3)').textContent;
            const endDate = row.querySelector('td:nth-child(4)').textContent;
            const lecturer = row.querySelector('td:nth-child(5)').textContent;

            document.querySelector('#batch-id').value = batchId;
            document.querySelector('#batch-name').value = batchName;
            document.querySelector('#start-date').value = startDate;
            document.querySelector('#end-date').value = endDate;
            document.querySelector('#lecture').value = lecturer;

            editPopup.style.display = 'flex';
        });
    });

    const closePopup = () => {
        editPopup.style.display = 'none';
    };

    if (closeBtn) {
        closeBtn.addEventListener('click', closePopup);
    }

    if (cancelBtn) {
        cancelBtn.addEventListener('click', closePopup);
    }

    if (editForm) {
        editForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const updatedBatch = {
                id: document.querySelector('#batch-id').value,
                name: document.querySelector('#batch-name').value,
                startDate: document.querySelector('#start-date').value,
                endDate: document.querySelector('#end-date').value,
                lecturer: document.querySelector('#lecture').value,
            };
            console.log('Batch updated:', updatedBatch);
            closePopup();
        });
    }
};

document.addEventListener('DOMContentLoaded', reinitializeBatchesListeners);
