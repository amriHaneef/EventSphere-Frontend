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


document.addEventListener("DOMContentLoaded", function () {
    const announcementsLink = document.getElementById("announcements-link");
    const mainContent = document.getElementById("main-content");

    announcementsLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the announcement page dynamically
        fetch(`${pageContextPath}/pages/announcement`)
            .then(response => response.text())
            .then(html => {
                mainContent.innerHTML = html; // Replace main content with the new HTML
                // Now, initialize or reinitialize the JavaScript related to announcements
                reinitializeAnnouncementListeners();  // This should contain the JS for handling dynamic actions
            })
            .catch(error => console.error("Error loading announcements:", error));
    });
});


