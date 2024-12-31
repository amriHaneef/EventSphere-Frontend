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
