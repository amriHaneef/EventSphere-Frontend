
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












