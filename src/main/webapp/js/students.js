// Function to reinitialize event listeners related to students
const reinitializeStudentListeners = () => {
    initializeSearchBar();
    initializeEditStudent();
};

// Initialize Search Bar functionality
const initializeSearchBar = () => {
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

// Initialize Edit Student functionality
const initializeEditStudent = () => {
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

// Reinitialize the event listeners after DOM content is loaded
document.addEventListener('DOMContentLoaded', reinitializeStudentListeners);
