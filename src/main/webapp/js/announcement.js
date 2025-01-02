// Reinitialize the event listeners after DOM content is loaded
const reinitializeAnnouncementListeners = () => {
    initializeSearchBar();
    initializeAddAnnouncements();
    initializeDeleteAnnouncements();
};

// Initialize Search Bar functionality
const initializeSearchBar = () => {
    const searchBar = document.getElementById('search-bar');
    if (searchBar) {
        searchBar.addEventListener('input', function () {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                const rowContent = row.textContent.toLowerCase();
                row.style.display = rowContent.includes(filter) ? '' : 'none';
            });
        });
    }
};

// Initialize Add Announcements functionality
const initializeAddAnnouncements = () => {
    const reportButton = document.querySelector('.report');
    const announcementBackground = document.querySelector('.announcement-background');
    const closeButton = document.querySelector('.close-btn');
    const cancelButton = document.querySelector('.cancel');
    const form = document.querySelector('#announcementForm');

    if (reportButton && announcementBackground) {
        reportButton.addEventListener('click', () => {
            announcementBackground.style.display = 'block';
        });
    }

    const closePopup = () => {
        if (announcementBackground) {
            announcementBackground.style.display = 'none';
        }
    };

    if (closeButton) {
        closeButton.addEventListener('click', closePopup);
    }

    if (cancelButton) {
        cancelButton.addEventListener('click', closePopup);
    }

    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log('Form submitted!');
            closePopup();
        });
    }
};

// Initialize Delete Announcements functionality
const initializeDeleteAnnouncements = () => {
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
        console.log('Announcement Deleted');
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });
};

// Call this function to initialize all necessary functionalities
document.addEventListener('DOMContentLoaded', reinitializeAnnouncementListeners);
