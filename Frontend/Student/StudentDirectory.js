console.log("Student Directory Loaded");


document.querySelector(".add_btn").onclick = function() {
    document.getElementById('addStudentModal').style.display = 'block';
}


window.onclick = function(event) {
    let modal = document.getElementById('addStudentModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
}/**
 * 
 */