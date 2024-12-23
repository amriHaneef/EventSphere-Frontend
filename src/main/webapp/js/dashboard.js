const sideLinks  = document.querySelectorAll('.sidebar .side-menu li a:not(.logout)');

sideLinks.forEach(item =>{
    const li = item.parentElement;
    item.addEventListener('click', () =>{
        sideLinks.forEach(i =>{
            i.parentElement.classList.remove('active');
        })
        li.classList.add('active');
    })
});


const menuBar = document.querySelector('.content nav .bx.bx-menu');

const sideBar = document.querySelector('.sidebar');

menuBar.addEventListener('click', () =>{
    sideBar.classList.toggle('close');
});


const toggler = document.getElementById('theme-toggle');

toggler.addEventListener('change', function() {
    if (this.checked) {
        document.body.classList.add('dark'); // Apply dark theme when checked
    } else {
        document.body.classList.remove('dark'); // Remove dark theme when unchecked
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




// Function to open the modal
function openEventDetails() {
    const modal = document.getElementById('eventDetails');
    modal.classList.add('show');
}

// Function to close the modal
function closeEventDetails() {
    const modal = document.getElementById('eventDetails');
    modal.classList.remove('show');
}

// Close modal when clicking outside the modal content (on the overlay)
window.addEventListener('click', function (event) {
    const modal = document.getElementById('eventDetails');
    // Check if the modal is visible and the click is outside the modal content (overlay)
    if (modal.classList.contains('show') && !event.target.closest('.card')) {
        closeEventDetails();
    }
});
// -------------------------End of Admin view event details form ---------------------------------


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












