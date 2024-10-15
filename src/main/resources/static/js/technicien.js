document.addEventListener("DOMContentLoaded", function() {
    // add hovered class to selected list item
    let list = document.querySelectorAll(".navigationCSS li");

    function activeLink() {
        list.forEach((item) => {
            item.classList.remove("hovered");
        });
        this.classList.add("hovered");
    }

    list.forEach((item) => item.addEventListener("mouseover", activeLink));

    // Menu Toggle
    let navigation = document.querySelector(".navigationCSS");
    let main = document.querySelector(".mainCSS");
    let toggle = document.querySelector(".toggleCSS");

    toggle.onclick = function () {
        navigation.classList.toggle("active");
        main.classList.toggle("active");
    };
//------------------------------------------------------------------------------------------
    let pannesButton = document.getElementById("pannesButton");
    let signalementsButton = document.getElementById("signalementsButton");
    
    let pannesContent = document.getElementById("pannesContent");
    let signalementsContent = document.getElementById("signalementsContent");
    
	pannesButton.addEventListener("click", function() {
		    // Afficher le contenu 
	        pannesContent.style.display = "block";
	        
	        // Masquer le contenu
	        signalementsContent.style.display = "none";
	});
    
    signalementsButton.addEventListener("click", function() {
		// Afficher le contenu
        signalementsContent.style.display = "block";

        // Masquer les autres contenu
        pannesContent.style.display = "none";
	    
	 });

});










