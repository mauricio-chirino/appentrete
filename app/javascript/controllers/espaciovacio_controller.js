document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.card-text').forEach(function(cardText) {
        if (cardText.textContent.trim() === "") {
            cardText.textContent = "No hay descripción disponible.";
        }
    });
});