function login() {
  let email = document.getElementById("email").value;
  let password = document.getElementById("password").value;
  let msg = document.getElementById("msg");

  // Dummy Admin Credentials
  let adminEmail = "admin@college.edu";
  let adminPassword = "123456";

  if (email === "" || password === "") {
    msg.innerText = "Please fill all fields!";
    return;
  }

  if (email === adminEmail && password === adminPassword) {
    msg.style.color = "lightgreen";
    msg.innerText = "Login Successful!";
    
  } else {
    msg.style.color = "red";
    msg.innerText = "Invalid Email or Password!";
  }
}