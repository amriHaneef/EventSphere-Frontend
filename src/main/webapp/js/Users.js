
// -------------------------------------------------search bar process-----------------------------------------------

document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM fully loaded and parsed");  // Debugging line
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
});
// ----------------------------------------------------------- end of search bar process-------------------------------------------------



// Get the elements
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


// -----------------Add User Popup Modal Form----------------------------------------

//------------------------Showing the image immidiately------------------------------------
document.getElementById('imgInput').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            // Set the src of the image preview to the selected image
            document.getElementById('imagePreview').src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
});

// -----------------------------------------------------------------------------

function openModal(event) {
    event.preventDefault(); // Prevent default anchor behavior
    const modal = document.getElementById('userForm');
    modal.style.display = 'flex'; // Set to 'flex' for flexbox alignment
}

function closeModal() {
    const modal = document.getElementById('userForm');
    modal.style.display = 'none';
}

// Optional: Close modal when clicking outside the modal content
window.addEventListener('click', (event) => {
    const modal = document.getElementById('userForm');
    if (event.target === modal) {
        closeModal();
    }
});

document.getElementById("userType").addEventListener("change", function () {
    const batchField = document.getElementById("batchField");
    if (this.value === "student") {
        batchField.style.display = "block"; // Show the batch field
    } else {
        batchField.style.display = "none"; // Hide the batch field
    }
});




//------------------End of Add user popup--------------------------------------------------