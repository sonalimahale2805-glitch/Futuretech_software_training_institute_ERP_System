function addStudent() {
  const name = document.getElementById("studentName").value;
  const course = document.getElementById("course").value;
  const totalFee = parseInt(document.getElementById("totalFee").value);
  const paidFee = parseInt(document.getElementById("paidFee").value);
  const installments = document.getElementById("installments").value;
  const nextDue = document.getElementById("nextDue").value;

  if (!name || !course || !totalFee || !paidFee) {
    alert("Please fill all required fields");
    return;
  }

  const balance = totalFee - paidFee;

  let status = "Partial";
  let statusClass = "partial";

  if (balance === 0) {
    status = "Paid";
    statusClass = "paid";
  }

  const table = document.getElementById("studentTable");

  const row = document.createElement("tr");

  row.innerHTML = `
    <td>${name}</td>
    <td>${course}</td>
    <td>₹${totalFee.toLocaleString()}</td>
    <td>₹${paidFee.toLocaleString()}</td>
    <td>₹${balance.toLocaleString()}</td>
    <td>${installments}</td>
    <td>${nextDue || "-"}</td>
    <td class="${statusClass}">${status}</td>
  `;

  table.appendChild(row);

  // Clear form
  document.getElementById("studentName").value = "";
  document.getElementById("course").value = "";
  document.getElementById("totalFee").value = "";
  document.getElementById("paidFee").value = "";
  document.getElementById("installments").value = "";
  document.getElementById("nextDue").value = "";

  alert("Student Added Successfully ✅");
}