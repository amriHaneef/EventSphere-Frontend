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





    async function saveAsPDF() {
    const { jsPDF } = window.jspdf;

    // Select the main content to save
    const element = document.querySelector('.main');

    // Render the HTML content as a canvas using html2canvas
    const canvas = await html2canvas(element);
    const imgData = canvas.toDataURL('image/png');

    // Create a new PDF document
    const doc = new jsPDF();

    // Add the image to the PDF
    const pdfWidth = doc.internal.pageSize.getWidth();
    const pdfHeight = (canvas.height * pdfWidth) / canvas.width;

    doc.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);

    // Save the PDF
    doc.save('portfolio.pdf');
}



