const tableBody = document.getElementById("studentTable");
const titleInput = document.getElementById("title");
const dateInput = document.getElementById("date");
const fileInput = document.getElementById("fileInput");

// Refresh kelya var data dakhva
window.onload = () => {
    const savedData = JSON.parse(localStorage.getItem("myAssignments")) || [];
    savedData.forEach(item => createRow(item));
};

document.getElementById("publishBtn").onclick = () => {
    const title = titleInput.value;
    const date = dateInput.value;

    if (!title || !date) {
        alert("Please enter title and date!");
        return;
    }

    // 🔥 MAIN LOGIC: Check if file exists
    let statusText = "PENDING"; 
    let statusClass = "pending";

    if (fileInput.files.length > 0) {
        statusText = "SUBMITTED";
        statusClass = "submitted";
    }

    const newData = {
        student: "Rahul Kumar", // Hardcoded for UI demo
        assignment: title,
        date: date,
        status: statusText,
        cssClass: statusClass
    };

    createRow(newData);
    saveData(newData);

    // Form clear kara
    titleInput.value = "";
    dateInput.value = "";
    fileInput.value = "";
};

function createRow(data) {
    const tr = document.createElement("tr");
    tr.innerHTML = `
        <td>${data.student}</td>
        <td>${data.assignment}</td>
        <td>${data.date}</td>
        <td><span class="badge ${data.cssClass}">${data.status}</span></td>
        <td><button class="action-btn">Review and grade</button></td>
    `;

    // Review Button Logic
    tr.querySelector(".action-btn").onclick = function() {
        const badge = tr.querySelector(".badge");
        badge.innerText = "REVIEWED";
        badge.className = "badge reviewed";
    };

    tableBody.appendChild(tr);
}

function saveData(obj) {
    const list = JSON.parse(localStorage.getItem("myAssignments")) || [];
    list.push(obj);
    localStorage.setItem("myAssignments", JSON.stringify(list));
}