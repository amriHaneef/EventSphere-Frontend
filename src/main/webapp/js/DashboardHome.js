document.addEventListener('DOMContentLoaded', function() {

    // Example: Row click event handling
    // Assuming that the rows are clickable and call openEventDetails()
    const rows = document.querySelectorAll('table tr');  // Get all rows in the table
    rows.forEach(row => {
        row.addEventListener('click', function() {
            openEventDetails(row);  // Pass the clicked row to openEventDetails function
        });
    });

    // Function to open the modal and display event details
    function openEventDetails(row) {
        console.log('Row clicked:', row);

        const detailsPopup = document.querySelector('#eventDetails');
        console.log('Popup element:', detailsPopup); // Debugging log

        if (!detailsPopup) {
            console.error('Popup element not found!');
            return;
        }

        // Continue with populating and showing the popup
        const eventName = row.children[1].textContent;  // Assuming event name is in second column (index 1)
        const consultant = row.children[4].textContent;  // Assuming consultant is in the 5th column (index 4)
        const participatedBatch = row.children[3].textContent;  // Assuming batch is in the 4th column (index 3)

        detailsPopup.querySelector('.details .plan:nth-child(1) span').innerHTML = `<strong>Name: </strong> ${eventName}`;
        detailsPopup.querySelector('.details .plan:nth-child(2) span').innerHTML = `<strong>Consultant: </strong> ${consultant}`;
        detailsPopup.querySelector('.details .plan:nth-child(3) span').innerHTML = `<strong>Participated Batch: </strong> ${participatedBatch}`;
        detailsPopup.querySelector('.details .plan:nth-child(4) span').innerHTML = `<strong>Assigned Students: </strong> Students Placeholder`;

        // Add the 'show' class to make the popup visible
        detailsPopup.classList.add('show');
    }

    // Function to close the event details popup
    function closeEventDetails() {
        const detailsPopup = document.querySelector('#eventDetails');
        detailsPopup.classList.remove('show');
    }

    // Add event listener to the "Done" button to close the event details
    const closeButton = document.querySelector('#eventDetails button');
    if (closeButton) {
        closeButton.addEventListener('click', closeEventDetails);
    }
    // Other code for handling event details, etc.



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



});













// -------------------------Admin view event details form ---------------------------------

// -----------------Add User Popup Modal Form----------------------------------------

// Open Modal
document.getElementById('openModalBtn').addEventListener('click', function () {
    document.getElementById('userForm').classList.add('show');
    document.body.classList.add('no-scroll'); // Prevent body scroll
});

// Close Modal
document.getElementById('closeModalBtn').addEventListener('click', function () {
    document.getElementById('userForm').classList.remove('show');
    document.body.classList.remove('no-scroll'); // Enable body scroll
});

// Close Modal when clicking outside the modal content
document.getElementById('userForm').addEventListener('click', function (e) {
    if (e.target === this) {
        document.getElementById('userForm').classList.remove('show');
        document.body.classList.remove('no-scroll'); // Enable body scroll
    }
});

//------------------End of Add user popup--------------------------------------------------


// -------------------------------Teacher view event details form------------------------------------
// Function to open the modal
function openTeacherEventDetails() {
    const modal = document.getElementById('teacher_eventDetails');
    modal.classList.add('show');
}

// Function to close the modal
function closeTeacherEventDetails() {
    const modal = document.getElementById('teacher_eventDetails');
    modal.classList.remove('show');
}

// Close modal when clicking outside the modal content (on the overlay)
window.addEventListener('click', function (event) {
    const modal = document.getElementById('teacher_eventDetails');
    // Check if the modal is visible and the click is outside the modal content (overlay)
    if (modal.classList.contains('show') && !event.target.closest('.card')) {
        closeTeacherEventDetails();
    }
});

// ------------------------------------End of teachers event form---------------------------------------------




// -----------------------------------------Student event details form------------------------------------------
// Function to open the modal
function openStudentEventDetails() {
    const modal = document.getElementById('student_eventDetails');
    modal.classList.add('show');
}

// Function to close the modal
function closeStudentEventDetails() {
    const modal = document.getElementById('student_eventDetails');
    modal.classList.remove('show');
}

// Close modal when clicking outside the modal content (on the overlay)
window.addEventListener('click', function (event) {
    const modal = document.getElementById('student_eventDetails');
    // Check if the modal is visible and the click is outside the modal content (overlay)
    if (modal.classList.contains('show') && !event.target.closest('.card')) {
        closeStudentEventDetails();
    }
});












