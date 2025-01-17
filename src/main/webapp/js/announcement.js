// Reinitialize the event listeners after DOM content is loaded
const reinitializeAnnouncementListeners = () => {
    initializeAnnouncementSearchBar();
    initializeAddAnnouncements();
    initializeAddStudentsForAnnouncements();
    initializeAddBatchesForAnnouncements();
};

// Initialize Search Bar functionality
const initializeAnnouncementSearchBar = () => {
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


// Initialize Add Announcements functionality
const initializeAddAnnouncements = () => {
    const reportButton = document.querySelector('.report');
    const announcementBackground = document.querySelector('.announcement-background');
    const closeButton = document.querySelector('.close-btn');
    const cancelButton = document.querySelector('.cancel');

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

};

// Initialize Delete Announcements functionality
const initializeAddStudentsForAnnouncements = () => {
    const deleteButtons = document.querySelectorAll(".studentAdd");
    const popupStudent = document.querySelector(".popup-student");
    const studentBackground = document.querySelector(".student-background");
    const closeButton = document.querySelector(".student-close-btn");
    const cancelButton = document.querySelector(".student-cancel-btn");
    const studentAnnouncementNameInput = document.querySelector("#studentAnnouncementName");
    const studentAnnouncementIDInput = document.querySelector("#studentAnnouncementID");


    // Function to open the popup
    const openPopup = (event) => {
        const announcementTitle = event.target.closest("tr").querySelector("td:nth-child(3)").textContent;
        studentAnnouncementNameInput.value = announcementTitle; // Set the Title in the input

        const announcementId = event.target.closest("tr").querySelector("td:nth-child(1)").textContent;
        studentAnnouncementIDInput.value = announcementId; // Set the Title in the input


        studentBackground.style.display = "block";
        studentBackground.style.opacity = '1';
    };

    // Function to close the popup
    const closePopup = () => {
        studentBackground.style.display = "none";
        studentBackground.style.opacity = '0';
    };

    deleteButtons.forEach((deleteButton) => {
        deleteButton.addEventListener("click", openPopup);
    });

    // Close popup when the close button (&times;) is clicked
    closeButton.addEventListener("click", closePopup);

    // Close popup when the cancel button is clicked
    cancelButton.addEventListener("click", (event) => {
        event.preventDefault(); // Prevent any default action (e.g., form submission)
        closePopup();
    });

    // Optional: Close popup when clicking outside the popup
    studentBackground.addEventListener("click", (event) => {
        if (event.target === studentBackground) {
            closePopup();
        }
    });
};



const initializeAddBatchesForAnnouncements = () => {
    const batchAddButtons = document.querySelectorAll(".BatchAdd");
    const popupBatch = document.querySelector(".popup-batch");
    const batchBackground = document.querySelector(".batch-background");
    const batchCloseButton = document.querySelector(".batch-close-btn");
    const batchCancelButton = document.querySelector(".batch-cancel-btn");
    const batchAnnouncementNameInput = document.querySelector("#batchAnnouncementName");
    const batchAnnouncementIDInput = document.querySelector("#batchAnnouncementID");


    // Function to open the popup
    const openPopup = (event) => {
        const announcementTitle = event.target.closest("tr").querySelector("td:nth-child(3)").textContent;
        batchAnnouncementNameInput.value = announcementTitle; // Set the Title in the input

        const announcementId = event.target.closest("tr").querySelector("td:nth-child(1)").textContent;
        batchAnnouncementIDInput.value = announcementId; // Set the Title in the input

        batchBackground.style.display = "block";
        batchBackground.style.opacity = '1';
    };

    // Function to close the popup
    const closePopup = () => {
        batchBackground.style.display = "none";
        batchBackground.style.opacity = '0';
    };

    batchAddButtons.forEach((batchAddButton) => {
        batchAddButton.addEventListener("click", openPopup);
    });

    // Close popup when the close button (&times;) is clicked
    batchCloseButton.addEventListener("click", closePopup);

    // Close popup when the cancel button is clicked
    batchCancelButton.addEventListener("click", (event) => {
        event.preventDefault(); // Prevent any default action (e.g., form submission)
        closePopup();
    });

    // Optional: Close popup when clicking outside the popup
    batchBackground.addEventListener("click", (event) => {
        if (event.target === batchBackground) {
            closePopup();
        }
    });
};
