/**
 * @author 박성우
 */
document.addEventListener("DOMContentLoaded", () => {
    const sideMenu = document.querySelector(".side-menu");
    const checkBtn = document.querySelector(".check-btn");

    checkBtn.addEventListener("click", () => {
        sideMenu.classList.toggle("open");
    });
});