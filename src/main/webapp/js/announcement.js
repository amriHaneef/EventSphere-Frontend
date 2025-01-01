
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



// --------------------------------------Add Announcements--------------------------------------------------
const reportButton = document.querySelector('.report');
const announcementBackground = document.querySelector('.announcement-background');
const closeButton = document.querySelector('.close-btn');
const cancelButton = document.querySelector('.cancel');

// Show popup
reportButton.addEventListener('click', () => {
    announcementBackground.style.display = 'block';
});

// Close popup
const closePopup = () => {
    announcementBackground.style.display = 'none';
};

closeButton.addEventListener('click', closePopup);
cancelButton.addEventListener('click', closePopup);

// Submit form
const form = document.querySelector('#announcementForm');
form.addEventListener('submit', (e) => {
    e.preventDefault();
    // Process form data here
    console.log('Form submitted!');
    closePopup();
});
// -------------------------------------------End of Add Announcements------------------------------




// Get the elements
const deleteButton = document.querySelector('.delete');
const popupOverlay = document.querySelector('.popup-overlay');
const closeBtn = document.querySelector('.popup-close');
const cancelBtn = document.querySelector('.cancel-btn');
const okBtn = document.querySelector('.ok-btn');

// Show popup when delete button is clicked
deleteButton.addEventListener('click', () => {
    popupOverlay.style.display = 'flex';
    popupOverlay.style.opacity = '1';
});

// Close the popup when close icon is clicked
closeBtn.addEventListener('click', () => {
    popupOverlay.style.display = 'none';
    popupOverlay.style.opacity = '0';
});

// Cancel button hides the popup
cancelBtn.addEventListener('click', () => {
    popupOverlay.style.display = 'none';
    popupOverlay.style.opacity = '0';
});

// OK button for confirmation action (add the delete logic here)
okBtn.addEventListener('click', () => {
    // Your delete logic goes here
    console.log('Announcement Deleted');
    popupOverlay.style.display = 'none';
    popupOverlay.style.opacity = '0';
});





