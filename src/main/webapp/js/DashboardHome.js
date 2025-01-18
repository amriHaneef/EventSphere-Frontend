document.addEventListener('DOMContentLoaded', function() {
    // Get all rows in the table
    const rows = document.querySelectorAll('table tr');
    rows.forEach(row => {
        row.addEventListener('click', function() {
            openEventDetails(row);  // Pass clicked row to openEventDetails function
        });
    });

    // Function to open the event details popup
    function openEventDetails(row) {
        const detailsPopup = document.querySelector('#eventDetails');
        if (!detailsPopup) {
            console.error('Popup element not found!');
            return;
        }

        // Get event data from the clicked row
        const eventName = row.children[1].textContent;  // Assuming the event name is in the second column
        const eventDate = row.children[2].textContent; // Assuming consultant data (adjust according to your actual table)
        const platform = row.children[3].textContent;  // Assuming batch is in the 4th column
        const status = row.children[4].textContent;  // Assuming batch is in the 4th column

        // Populate the popup with event data
        detailsPopup.querySelector('.details .plan:nth-child(1) span').innerHTML = `<strong>Name: </strong> ${eventName}`;
        detailsPopup.querySelector('.details .plan:nth-child(2) span').innerHTML = `<strong>Date: </strong> ${eventDate}`;
        detailsPopup.querySelector('.details .plan:nth-child(3) span').innerHTML = `<strong>Platform: </strong> ${platform}`;
        detailsPopup.querySelector('.details .plan:nth-child(4) span').innerHTML = `<strong>Status: </strong>  ${status}`;

        console.log('Row children:', row.children);
        // Show the popup
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



// ---------------------------------------------------get data for api--------------------------------------------

// ---------------------------------------------------get data for api--------------------------------------------













