// Reinitialize all event listeners after DOM content is loaded
const reinitializeUsersListeners = () => {
    initializeUserSearchBar();
    initializeEditUser();
    initializeAddUserModal();
    initializeBatchToggle(); // Add batch toggle initialization
    initializeDeleteUsers();
};

// ------------------------------------------------- Search Bar Process -------------------------------------------------
const initializeUserSearchBar = () => {
    const searchBar = document.getElementById('search-bar');
    if (searchBar) {
        searchBar.addEventListener('input', function () {
            const filter = this.value.toLowerCase();
            const rows = document.querySelectorAll('.teacher-details tr');

            rows.forEach(row => {
                const cells = Array.from(row.querySelectorAll('td'));
                const rowContent = cells.map(cell => cell.textContent.toLowerCase()).join(' ');

                if (rowContent.includes(filter)) {
                    row.style.display = ''; // Show the row
                } else {
                    row.style.display = 'none'; // Hide the row
                }
            });
        });
    } else {
        console.error('Element #search-bar not found');
    }
};
// ------------------------------------------------ End of Search Bar Process ------------------------------------------

// -------------------------------------------------- Edit User Process ---------------------------------------------
const initializeEditUser = () => {
    const editButtons = document.querySelectorAll('.edit'); // Edit buttons
    const popupOverlay = document.querySelector('.popup-overlay');
    const closeBtn = document.querySelector('.popup-close');
    const cancelBtn = document.querySelector('.cancel');
    const editForm = document.querySelector('#editForm');

    // Show popup when edit button is clicked
    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr'); // Find the row associated with the button
            const id = row.querySelector('td:nth-child(1)').textContent;
            const name = row.querySelector('td:nth-child(2)').textContent;
            const email = row.querySelector('td:nth-child(3)').textContent;
            const birthday = row.querySelector('td:nth-child(4)').textContent;
            const batch = row.querySelector('td:nth-child(5)').textContent;

            // Populate the form with existing data
            document.querySelector('#student-id').value = id;
            document.querySelector('#student-name').value = name;
            document.querySelector('#student-email').value = email;
            document.querySelector('#student-birthday').value = birthday;
            document.querySelector('#student-batch').value = batch;

            // Show the popup
            popupOverlay.style.display = 'flex';
            popupOverlay.style.opacity = '1';
        });
    });

    // Close the popup when the close icon is clicked
    closeBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });

    // Cancel button hides the popup
    cancelBtn.addEventListener('click', () => {
        popupOverlay.style.display = 'none';
        popupOverlay.style.opacity = '0';
    });
};
// ------------------------------------------------ End of Edit User Process ----------------------------------------

// ------------------------ Add User Popup Modal Form ------------------------------------------------
const initializeAddUserModal = () => {
    // Show the image preview when an image is selected
    document.getElementById('imgInput').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                // Set the src of the image preview to the selected image
                document.getElementById('imagePreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Open the modal on button click
    document.querySelector('.report').addEventListener('click', openModal);

    // Close the modal
    document.querySelector('.close').addEventListener('click', closeModal);

    // Optional: Close modal when clicking outside the modal content
    window.addEventListener('click', (event) => {
        const modal = document.getElementById('userForm');
        if (event.target === modal) {
            closeModal();
        }
    });

    // Show or hide the batch field based on the user type
    // Toggle visibility of the batch field based on user type
    document.getElementById("userType").addEventListener("change", function () {
        const batchField = document.getElementById("batchField");
        if (this.value === "STUDENT") {
            batchField.style.display = "block"; // Show the batch field
        } else {
            batchField.style.display = "none"; // Hide the batch field
        }
    });
};

// Open the modal
function openModal(event) {
    event.preventDefault(); // Prevent default anchor behavior
    const modal = document.getElementById('userForm');
    modal.style.display = 'flex'; // Set to 'flex' for flexbox alignment
}

// Close the modal
function closeModal() {
    const modal = document.getElementById('userForm');
    modal.style.display = 'none';
}

// ---------------------- End of Add User Popup Modal Form -------------------------------------------




// --------------------------- Batch Toggle Process --------------------------------------------------
function initializeBatchToggle() {
    const batchHeaders = document.querySelectorAll(".student-head");
    batchHeaders.forEach((header) => {
        const batchId = header.dataset.batchId; // Use dataset for cleaner code

        if (!batchId) {
            console.error("Missing data-batch-id attribute on header:", header);
            return; // Skip this header if no batch ID is found
        }

        header.addEventListener("click", () => {
            toggleBatchDetails(batchId);
        });
    });
}

function toggleBatchDetails(batchId) {
    const batchDetails = document.getElementById(batchId);
    if (batchDetails) {
        batchDetails.classList.toggle("hidden");
        // Check computed styles
        const computedStyle = window.getComputedStyle(batchDetails);
        console.log("Computed display property:", computedStyle.display);
    } else {
        console.error(`Element with ID ${batchId} not found.`);
    }
}


//delete Icon
const initializeDeleteUsers = () => {
    const deleteButtons = document.querySelectorAll('.delete');
    const deleteOverlay = document.querySelector('.delete-overlay');
    const closeBtn = document.querySelector('.delete-close');
    const cancelBtn = document.querySelector('.cancel-btn-delete');

    deleteButtons.forEach((deleteButton) => {
        deleteButton.addEventListener('click', () => {
            deleteOverlay.style.display = 'block';
            deleteOverlay.style.opacity = '1';
        });
    });

    closeBtn.addEventListener('click', () => {
        deleteOverlay.style.display = 'none';
        deleteOverlay.style.opacity = '0';
    });

    cancelBtn.addEventListener('click', () => {
        deleteOverlay.style.display = 'none';
        deleteOverlay.style.opacity = '0';
    });

};




// ------------------------ End of Batch Toggle Process ----------------------------------------------

document.addEventListener('DOMContentLoaded', reinitializeUsersListeners);

document.addEventListener("DOMContentLoaded", function () {
    const studentHeads = document.querySelectorAll(".student-head");

    studentHeads.forEach(head => {
        head.addEventListener("click", function () {
            // Safely extract the batch ID from the element's attribute
            const batchId = this.getAttribute("data-batch-id")?.split("-")[1];
            const jwtToken = sessionStorage.getItem("jwtToken");

            // Log batch ID and JWT token for debugging
            console.log(`Extracted batchId: ${batchId}`);
            console.log(`JWT Token in sessionStorage: ${jwtToken ? jwtToken.substring(0, 10) + "..." : "null"}`);

            // Validate batch ID
            if (!batchId) {
                console.error("Batch ID is null or undefined.");
                alert("Error: Invalid Batch ID. Please try again.");
                return;
            }

            // Validate JWT token
            if (!jwtToken) {
                console.error("JWT Token is null or undefined.");
                alert("Error: Authorization token is missing. Please log in again.");
                return;
            }

            // Construct the URL for the API request
            const url = `/pages/users?batchId=${batchId}`;
            console.log(`Making a GET request to: ${url}`);

            // Perform the fetch request
            fetch(url, {
                method: "GET",
                headers: {
                    "Authorization": `Bearer ${jwtToken}`,
                },
            })
                .then(response => {
                    console.log(`Response status: ${response.status}`);
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Response data:", data);

                    // Dynamically update the DOM based on the fetched data
                    const studentTable = document.querySelector(`#batch-${batchId} tbody`);
                    studentTable.innerHTML = ""; // Clear existing rows
                    data.forEach(student => {
                        const row = document.createElement("tr");
                        row.innerHTML = `
                            <td>${student.id}</td>
                            <td>${student.name}</td>
                            <td>${student.email}</td>
                            <td>${student.dob ? student.dob.substring(0, 10) : "N/A"}</td>
                        `;
                        studentTable.appendChild(row);
                    });

                    // Show the table
                    const tableContainer = document.querySelector(`#batch-${batchId}`);
                    tableContainer.classList.remove("hidden");
                })
                .catch(err => {
                    console.error("An error occurred:", err);
                    alert("Failed to fetch students. Please try again later.");
                });
        });
    });



    document.querySelectorAll('.delete').forEach(button => {
        button.addEventListener('click', function () {
            const userId = this.getAttribute('data-user-id');
            if (confirm('Are you sure you want to delete this user?')) {
                deleteUser(userId);
            }
        });
    });

    function deleteUser(userId) {
        fetch(`http://13.60.250.63:8081/user/remove/${userId}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${sessionStorage.getItem('jwtToken')}`, // Replace with your method of storing the JWT token
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    alert('User deleted successfully!');
                    window.location.reload(); // Refresh the page to show updated user list
                } else {
                    response.text().then(error => {
                        console.error('Failed to delete user:', error);
                        alert('Failed to delete user.');
                    });
                }
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                alert('An error occurred while deleting the user.');
            });
    }

});
