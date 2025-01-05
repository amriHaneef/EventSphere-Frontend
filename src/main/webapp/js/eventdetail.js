// Show popup when button is clicked
document.getElementById('markAttendanceBtn').addEventListener('click', () => {
    document.getElementById('popupOverlay').style.display = 'flex';
});

// Close popup
document.getElementById('closePopupBtn').addEventListener('click', () => {
    document.getElementById('popupOverlay').style.display = 'none';
});

// Handle form submission
document.getElementById('attendanceForm').addEventListener('submit', (event) => {
    event.preventDefault();

    const batch = document.getElementById('batch').value;
    const student = document.getElementById('student').value;
    const mockDetails = document.getElementById('mockDetails').value;

    alert(`Attendance marked successfully:\nBatch: ${batch}\nStudent: ${student}\nDetails: ${mockDetails}`);
    document.getElementById('popupOverlay').style.display = 'none';
});

