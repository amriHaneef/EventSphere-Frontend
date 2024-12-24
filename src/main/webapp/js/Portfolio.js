window.aboutEditing = function() {
    const paragraph = document.querySelector('.about');
    const isEditable = paragraph.getAttribute('contenteditable') === 'true';

    if (!isEditable) {
        paragraph.setAttribute('contenteditable', 'true');
        paragraph.focus();
    } else {
        paragraph.removeAttribute('contenteditable');
    }
};

function educationEditing() {
    // Select all p2 and p3 elements in the education section
    const educationParagraphs = document.querySelectorAll('.education-section .p2, .education-section .p3');

    // Check the current state of the first paragraph
    const isEditable = educationParagraphs[0]?.getAttribute('contenteditable') === 'true';

    educationParagraphs.forEach((paragraph) => {
        if (!isEditable) {
            paragraph.setAttribute('contenteditable', 'true'); // Enable editing
            paragraph.style.border = '1px dashed #ccc'; // Optional: Add visual cue
        } else {
            paragraph.removeAttribute('contenteditable'); // Disable editing
            paragraph.style.border = ''; // Remove visual cue
        }
    });

    // Optional: Scroll to focus the first editable element
    if (!isEditable && educationParagraphs.length > 0) {
        educationParagraphs[0].focus();
    }
}


function experienceEditing() {
    // Select all p2 and p3 elements in the education section
    const experienceParagraphs = document.querySelectorAll('.experience-section .p2, .experience-section .p3');

    // Check the current state of the first paragraph
    const isEditable = experienceParagraphs[0]?.getAttribute('contenteditable') === 'true';

    experienceParagraphs.forEach((paragraph) => {
        if (!isEditable) {
            paragraph.setAttribute('contenteditable', 'true'); // Enable editing
            paragraph.style.border = '1px dashed #ccc'; // Optional: Add visual cue
        } else {
            paragraph.removeAttribute('contenteditable'); // Disable editing
            paragraph.style.border = ''; // Remove visual cue
        }
    });

    // Optional: Scroll to focus the first editable element
    if (!isEditable && experienceParagraphs.length > 0) {
        experienceParagraphs[0].focus();
    }
}

