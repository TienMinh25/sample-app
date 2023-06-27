// Add toggle listeners to listen for clicks
document.addEventListener("turbo:load", () => {
    let hamburger = document.querySelector("#hamburger");
    hamburger.addEventListener("click", function(event) {
        event.preventDefault();
        let menu = document.querySelector("#navbar-menu");
        menu.classList.toggle("collapse");
    });
    let account = document.querySelector("#account")
    account.addEventListener("click", (e) => {
        e.preventDefault()
        let menu = document.querySelector("#dropdown-menu")
        menu.classList.toggle("active")
    })
})