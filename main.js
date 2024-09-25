const downloadButtons = document.querySelectorAll('.download-btn');

// Add click event listener to each button
downloadButtons.forEach(button => {
  button.addEventListener('click', function() {
    const fileName = this.getAttribute('data-file'); // Get file name from data-file attribute
    const filePath = `download/${fileName}`; // Construct the file path
    const link = document.createElement('a');
    link.href = filePath;
    link.download = fileName;
    link.click();
  });
});
