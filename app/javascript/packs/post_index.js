document.addEventListener('DOMContentLoaded', (event) => {
    var modal = document.getElementById("homeModal");
    var img = document.getElementById("homeImg");
    var modalImg = document.getElementById("modalImg");
    var captionText = document.getElementById("caption");
    var span = document.getElementById("close");
    img.onclick = function(){
        modal.style.display = "block";
        modalImg.src = this.src; // Get the source from the img tag
        captionText.innerHTML = this.alt;
    }
    // Get the span element that closes the modal
    modalImg.onclick = function(){
        modal.style.display = "none";
    }
})
