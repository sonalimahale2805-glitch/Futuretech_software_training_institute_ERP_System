const table = document.getElementById("tableBody");
const titleInput = document.getElementById("title");
const dateInput = document.getElementById("date");
const fileInput = document.getElementById("file");

/* Load saved data */
window.onload = () => {
  const data = JSON.parse(localStorage.getItem("rows")) || [];
  data.forEach(addRow);
};

/* Create Assignment */
document.getElementById("createBtn").onclick = () => {
  const title = titleInput.value;
  const date = dateInput.value;
  const file = fileInput.files[0];

  if (!title || !date) {
    alert("Title and Date are required!");
    return;
  }

  // 🔥 MAIN LOGIC
  let status = "Pending";
  if (file) {
    status = "Submitted";
  }

  const rowData = {
    student: "Sonali",
    assignment: title,
    date: date,
    status: status
  };

  addRow(rowData);
  save(rowData);

  titleInput.value = "";
  dateInput.value = "";
  fileInput.value = "";
};

/* Add row to table */
function addRow(d) {
  const tr = document.createElement("tr");

  tr.innerHTML = `
    <td>${d.student}</td>
    <td>${d.assignment}</td>
    <td>${d.date}</td>
    <td><span class="status ${d.status.toLowerCase()}">${d.status}</span></td>
    <td>
      <button class="reviewBtn">Review</button>
    </td>
  `;

  const btn = tr.querySelector(".reviewBtn");
  const statusSpan = tr.querySelector(".status");

  btn.onclick = () => {
    statusSpan.innerText = "Reviewed";
    statusSpan.className = "status reviewed";
    btn.disabled = true;
  };

  table.appendChild(tr);
}

/* Save in localStorage */
function save(d) {
  const old = JSON.parse(localStorage.getItem("rows")) || [];
  old.push(d);
  localStorage.setItem("rows", JSON.stringify(old));
}
