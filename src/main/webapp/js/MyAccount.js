// Reinitialize all event listeners after DOM content is loaded
const reinitializeAccountListeners = () => {
    initializeEditUserPassword();
};


// -------------------------------------------------- Edit User Process ---------------------------------------------
const initializeEditUserPassword = () => {
    const changeButtons = document.querySelectorAll('.change'); // Edit buttons
    const changeOverlay = document.querySelector('.change-overlay');
    const closeBtn = document.querySelector('.change-close');
    const cancelBtn = document.querySelector('.change-cancel');
    const editForm = document.querySelector('#changeForm');

    // Show popup when edit button is clicked
    changeButtons.forEach((changeButton) => {
        changeButton.addEventListener('click', (event) => {

            // Show the popup
            changeOverlay.style.display = 'flex';
            changeOverlay.style.opacity = '1';
        });
    });

    // Close the popup when the close icon is clicked
    closeBtn.addEventListener('click', () => {
        changeOverlay.style.display = 'none';
        changeOverlay.style.opacity = '0';
    });

    // Cancel button hides the popup
    cancelBtn.addEventListener('click', () => {
        changeOverlay.style.display = 'none';
        changeOverlay.style.opacity = '0';
    });
};
// ------------------------------------------------ End of Edit User Process ----------------------------------------


document.addEventListener('DOMContentLoaded', reinitializeAccountListeners);
