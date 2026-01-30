const selected = document.querySelector(".selected");
const optionsBox = document.querySelector(".options");
const options = document.querySelectorAll(".options li");

selected.onclick = () => {
  optionsBox.style.display =
    optionsBox.style.display === "block" ? "none" : "block";
};

options.forEach(option => {
  option.onclick = () => {
    selected.innerText = option.innerText;
    optionsBox.style.display = "none";
  };
});

document.onclick = (e) => {
  if (!e.target.closest(".dropdown")) {
    optionsBox.style.display = "none";
  }
};