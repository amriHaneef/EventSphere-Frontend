
    document.querySelector('.logout').addEventListener('click', function (event) {
    event.preventDefault(); // Prevent default link behavior

    // Send POST request to logout endpoint
    fetch('/pages/logout', {
    method: 'POST',
    credentials: 'include' // Include cookies/session for the request
})
    .then(response => {
    if (response.ok) {
    console.log('Logout successful.');
    // Redirect to login page
    window.location.href = '/pages/login.jsp';
} else {
    console.error('Logout failed. Status:', response.status);
    alert('Logout failed. Please try again.');
}
})
    .catch(error => {
    console.error('Error during logout:', error);
    alert('An error occurred. Please try again.');
});
});
