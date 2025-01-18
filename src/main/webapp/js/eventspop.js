function eventsDetailsPopUp(eventId) {
    alert(eventId);

    document.getElementById("eventTable").style.display = "none";

    document.getElementById("eventData").style.display = "block";
}

function onloading() {
    alert("hi");
    document.getElementById("eventTable").style.display = "block";

    document.getElementById("eventData").style.display = "none";
}