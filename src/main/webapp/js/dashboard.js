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

document.querySelector('.notif').addEventListener('click', function (e) {
    e.preventDefault();
    const miniCart = document.querySelector('.mini-cart');
    miniCart.style.opacity = miniCart.style.opacity === '1' ? '0' : '1';
    miniCart.style.visibility = miniCart.style.visibility === 'visible' ? 'hidden' : 'visible';
});




document.addEventListener("DOMContentLoaded", function () {


    const eventsLink = document.getElementById("events-link");
    const eventContent = document.getElementById("main-content");

    eventsLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the announcement page dynamically
        fetch(`${pageContextPath}/pages/events`)
            .then(response => response.text())
            .then(html => {
                eventContent.innerHTML = html; // Replace main content with the new HTML
                // Now, initialize or reinitialize the JavaScript related to announcements
                reinitializeEventContentListeners();  // This should contain the JS for handling dynamic actions
            })
            .catch(error => console.error("Error loading events:", error));
    });


    const announcementsLink = document.getElementById("announcements-link");
    const announcementsContent = document.getElementById("main-content");

    announcementsLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the announcement page dynamically
        fetch(`${pageContextPath}/pages/announcement`)
            .then(response => response.text())
            .then(html => {
                announcementsContent.innerHTML = html; // Replace main content with the new HTML
                // Now, initialize or reinitialize the JavaScript related to announcements
                reinitializeAnnouncementListeners();  // This should contain the JS for handling dynamic actions
            })
            .catch(error => console.error("Error loading announcements:", error));
    });


    const batchesLink = document.getElementById("batches-link");
    const batchesContent = document.getElementById("main-content");

    batchesLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the announcement page dynamically
        fetch(`${pageContextPath}/pages/batches`)
            .then(response => response.text())
            .then(html => {
                batchesContent.innerHTML = html; // Replace main content with the new HTML
                // Now, initialize or reinitialize the JavaScript related to announcements
                reinitializeBatchesListeners();  // This should contain the JS for handling dynamic actions
            })
            .catch(error => console.error("Error loading Batches:", error));
    });


    const usersLink = document.getElementById("users-link");
    const usersContent = document.getElementById("main-content");

    usersLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the announcement page dynamically
        fetch(`${pageContextPath}/pages/users`)
            .then(response => response.text())
            .then(html => {
                usersContent.innerHTML = html; // Replace main content with the new HTML
                // Now, initialize or reinitialize the JavaScript related to announcements
                reinitializeUsersListeners();  // This should contain the JS for handling dynamic actions
            })
            .catch(error => console.error("Error loading Users:", error));
    });


    const studentsLink = document.getElementById("students-link");
    const studentsContent = document.getElementById("main-content");

    studentsLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the student page dynamically
        fetch(`${pageContextPath}/pages/students`)
            .then(response => response.text())
            .then(html => {
                studentsContent.innerHTML = html; // Replace main content with the new HTML
                // Reinitialize the JavaScript related to students
                reinitializeStudentListeners(); // Ensure this function is properly defined in student.js
            })
            .catch(error => console.error("Error loading students:", error));
    });


    const accountsLink = document.getElementById("accounts-link");
    const accountsContent = document.getElementById("main-content");

    accountsLink.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior of the link

        // Load the student page dynamically
        fetch(`${pageContextPath}/pages/accounts`)
            .then(response => response.text())
            .then(html => {
                accountsContent.innerHTML = html; // Replace main content with the new HTML
                // Reinitialize the JavaScript related to students
                reinitializeAccountListeners(); // Ensure this function is properly defined in student.js
            })
            .catch(error => console.error("Error loading accounts:", error));
    });



});