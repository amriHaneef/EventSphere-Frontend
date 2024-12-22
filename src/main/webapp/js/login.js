function showLoginForm() {
    document.getElementById('login').style.left = "27px";
    document.getElementById('register').style.right = "-350px";
    document.getElementById('btn').style.left = "0px";
}

function showRegisterForm() {
    document.getElementById('login').style.left = "-350px";
    document.getElementById('register').style.right = "25px";
    document.getElementById('btn').style.left = "150px";
}

function togglePasswordVisibility(fieldId, eyeId, eyeSlashId) {
    const passwordField = document.getElementById(fieldId);
    const eye = document.getElementById(eyeId);
    const eyeSlash = document.getElementById(eyeSlashId);

    if (passwordField.type === "password") {
        passwordField.type = "text";
        eye.style.opacity = "0";
        eyeSlash.style.opacity = "1";
    } else {
        passwordField.type = "password";
        eye.style.opacity = "1";
        eyeSlash.style.opacity = "0";
    }
}
