// Reinitialize all event listeners after DOM content is loaded
const reinitializeUsersListeners = () => {
    initializeUserSearchBar();
    initializeEditUser();
    initializeAddUserModal();
    initializeBatchToggle(); // Add batch toggle initialization
};

// ------------------------------------------------- Search Bar Process -------------------------------------------------
const initializeUserSearchBar = () => {
    const searchBar = document.getElementById('search-bar');
    if (searchBar) {
        searchBar.addEventListener('input', function () {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');

            rows.forEach(row => {
                const cells = Array.from(row.querySelectorAll('td'));
                const rowContent = cells.map(cell => cell.textContent.toLowerCase()).join(' ');

                if (rowContent.includes(filter)) {
                    row.style.display = ''; // Show the row
                } else {
                    row.style.display = 'none'; // Hide the row
                }
            });
        });
    } else {
        console.error('Element #search-bar not found');
    }
};
// ------------------------------------------------ End of Search Bar Process ------------------------------------------

// -------------------------------------------------- Edit Student Process ---------------------------------------------
const initializeEditUser = () => {
    const editButtons = document.querySelectorAll('.edit'); // Replace delete with edit button
    const popupOverlay = document.querySelector('.popup-overlay');
    const closeBtn = document.querySelector('.popup-close');
    const cancelBtn = document.querySelector('.cancel');
    const editForm = document.querySelector('#editForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr'); // Find the row associated with the button
            const id = row.querySelector('td:nth-child(1)').textContent;
            const name = row.querySelector('td:nth-child(2)').textContent;
            const email = row.querySelector('td:nth-child(3)').textContent;
            const birthday = row.querySelector('td:nth-child(4)').textContent;
            const batch = row.querySelector('td:nth-child(5)').textContent;

            // Populate the form with existing data
            document.querySelector('#student-id').value = id;
            document.querySelector('#student-name').value = name;
            document.querySelector('#student-email').value = email;
            document.querySelector('#student-birthday').value = birthday;
            document.querySelector('#student-batch').value = batch;

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
// ------------------------------------------------ End of Edit Student Process ----------------------------------------

// ------------------------ Add User Popup Modal Form ------------------------------------------------
const initializeAddUserModal = () => {
    // Show the image preview when an image is selected
    document.getElementById('imgInput').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                // Set the src of the image preview to the selected image
                document.getElementById('imagePreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Open the modal on button click
    document.querySelector('.report').addEventListener('click', openModal);

    // Close the modal
    document.querySelector('.close').addEventListener('click', closeModal);

    // Optional: Close modal when clicking outside the modal content
    window.addEventListener('click', (event) => {
        const modal = document.getElementById('userForm');
        if (event.target === modal) {
            closeModal();
        }
    });

    // Show or hide the batch field based on the user type
    document.getElementById("userType").addEventListener("change", function () {
        const batchField = document.getElementById("batchField");
        if (this.value === "student") {
            batchField.style.display = "block"; // Show the batch field
        } else {
            batchField.style.display = "none"; // Hide the batch field
        }
    });
};

// Open the modal
function openModal(event) {
    event.preventDefault(); // Prevent default anchor behavior
    const modal = document.getElementById('userForm');
    modal.style.display = 'flex'; // Set to 'flex' for flexbox alignment
}

// Close the modal
function closeModal() {
    const modal = document.getElementById('userForm');
    modal.style.display = 'none';
}

// ---------------------- End of Add User Popup Modal Form -------------------------------------------

// --------------------------- Batch Toggle Process --------------------------------------------------
const initializeBatchToggle = () => {
    const batchButton = document.getElementById("batch1");
    if (batchButton) {
        batchButton.addEventListener("click", () => {
            toggleBatchDetails('batchDetails1');
        });
    } else {
        console.error('Element #batch1 not found.');
    }
};

function toggleBatchDetails(batchId) {
    const batchDetails = document.getElementById(batchId);
    if (batchDetails) {
        if (batchDetails.style.display === "none" || batchDetails.style.display === "") {
            batchDetails.style.display = "block";
        } else {
            batchDetails.style.display = "none";
        }
    } else {
        console.error(`Element with ID ${batchId} not found.`);
    }
}
// ------------------------ End of Batch Toggle Process ----------------------------------------------

document.addEventListener('DOMContentLoaded', reinitializeUsersListeners);
