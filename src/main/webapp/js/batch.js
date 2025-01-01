// Show modal for adding a new batch
function addBatch() {
    // Reset form and set the modal title for 'Add Batch'
    document.getElementById("createBatchModal").style.display = "block";
    document.getElementById("modalTitle").textContent = "Create a New Batch";
    document.getElementById("createBatch").textContent = "Create Batch"; // Set button text to 'Create'
    document.getElementById("batchForm").reset(); // Reset form fields
}

// Show modal for editing an existing batch
function editBatch(batchId) {
    // Simulate loading batch data (In real scenario, fetch batch data from the server)
    const batch = {
        batchId: batchId,
        name: "Batch A",
        startDate: "2024-01-01",
        endDate: "2024-06-01",
        teacher: "Mrs.Sandaruwant",
        students: ["Student 1", "Student 2", "Student 3"],
    };

    // Populate the form fields with the existing batch data
    document.getElementById("createBatchModal").style.display = "block";
    document.getElementById("modalTitle").textContent = "Edit Batch"; // Change title to "Edit"
    document.getElementById("createBatch").textContent = "Update Batch"; // Set button text to 'Update'
    document.getElementById("batchName").value = batch.name;
    document.getElementById("startDate").value = batch.startDate;
    document.getElementById("endDate").value = batch.endDate;
    document.getElementById("teacher").value = batch.teacher;

    // Populate the students list (assuming you're managing it here; adapt as necessary)
    const studentsSelect = document.getElementById("students");
    studentsSelect.innerHTML = ""; // Clear the existing options
    batch.students.forEach(student => {
        const option = document.createElement("option");
        option.value = student;
        option.textContent = student;
        studentsSelect.appendChild(option);
    });

    // You can add logic to pre-select students or allow modifications based on your needs
}

// Close modal
function closeModal() {
    document.getElementById("createBatchModal").style.display = "none";
}

// Close modal if clicking outside the modal content
window.onclick = function (event) {
    const modal = document.getElementById("createBatchModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
};

// Form Submission Event Listener for Create/Edit
document.getElementById("batchForm").addEventListener("submit", function (event) {
    event.preventDefault();

    const batchName = document.getElementById("batchName").value;
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;
    const teacher = document.getElementById("teacher").value;
    const students = Array.from(document.getElementById("students").selectedOptions).map(option => option.value);

    if (!batchName || !startDate || !endDate || !teacher || students.length === 0) {
        alert("Please fill in all fields.");
        return;
    }

    // Simulate saving the batch to the server (Create or Edit)
    const isEditMode = document.getElementById("modalTitle").textContent === "Edit Batch";
    if (isEditMode) {
        console.log(`Batch Updated:`, {batchName, startDate, endDate, teacher, students});
    } else {
        console.log(`Batch Created:`, {batchName, startDate, endDate, teacher, students});
    }

    // Close modal after submitting
    closeModal();

    // Reset form fields
    document.getElementById("batchForm").reset();

    alert(isEditMode ? "Batch Updated Successfully!" : "Batch Created Successfully!");
});

// Show modal for viewing batch details (Simulated with batchId)
function viewBatchDetails(batchId) {
    // Simulate loading batch data for viewing details
    const batch = {
        name: "Batch A",
        startDate: "2024-01-01",
        endDate: "2024-06-01",
        teacher: "Mrs.sandaruwani",
        students: ["Student 1", "Student 2", "Student 3"],
        events: ["Event 1", "Event 2"]
    };

}

// Function to delete the batch row
function deleteBatch(batchId) {
    // Get the table and the specific row to be deleted
    const table = document.getElementById("Admin_batch_tab_table");
    const rows = table.getElementsByTagName("tr");

    // Loop through the rows and find the row with the matching batchId
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cell = row.getElementsByTagName("td")[0]; // Batch ID is in the first column
        if (cell && cell.textContent == batchId) {
            // Confirm before deletion
            const confirmation = confirm("Are you sure you want to delete this batch?");
            if (confirmation) {
                row.remove(); // Remove the row from the table
            }
            break;
        }
    }
}

        function searchBatch() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById('batchSearch');
        filter = input.value.toUpperCase();
        table = document.getElementById('Admin_batch_tab_table');
        tr = table.getElementsByTagName('tr');

        for (i = 1; i < tr.length; i++) { // Skip the header row
        td = tr[i].getElementsByTagName('td');
        if (td) {
        txtValue = td[0].textContent || td[0].innerText; // Search in Batch ID column
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
    } else {
        tr[i].style.display = "none";
    }
    }
    }
    }



// Close batch details modal
function closeBatchDetailsModal() {
    document.getElementById("batchDetailsModal").style.display = "none";
}

// Search and filter batches based on user input
document.getElementById("searchButton").addEventListener("click", function () {
    const searchQuery = document.getElementById("searchInput").value.toLowerCase();
    const teacherFilter = document.getElementById("filterTeacher").value;
    const statusFilter = document.getElementById("filterStatus").value;

    // Simulate fetching and filtering the batch list (In a real scenario, this would be an Ajax request)
    console.log(`Searching for: ${searchQuery}, Teacher: ${teacherFilter}, Status: ${statusFilter}`);

    // Update UI with filtered results (This is a simulation, in real-world, this data would come from the server)
    const filteredBatches = [
        {name: "Batch A", teacher: "John Doe", status: "active"},
        {name: "Batch B", teacher: "Jane Smith", status: "completed"}
    ];

    const batchList = document.getElementById("batchList");
    batchList.innerHTML = ""; // Clear previous results

    filteredBatches.forEach(batch => {
        if (batch.name.toLowerCase().includes(searchQuery) &&
            (teacherFilter === "" || batch.teacher === teacherFilter) &&
            (statusFilter === "" || batch.status === statusFilter)) {

            const batchItem = document.createElement("div");
            batchItem.classList.add("batchItem");
            batchItem.innerHTML = `
                <h3>${batch.name}</h3>
                <p><strong>Teacher:</strong> ${batch.teacher}</p>
                <p><strong>Status:</strong> ${batch.status}</p>
                <button onclick="viewBatchDetails('${batch.name}')">View Details</button>
                <button onclick="editBatch('${batch.name}')">Edit</button> <!-- Edit button -->
            `;
            batchList.appendChild(batchItem);
        }
    });
});

