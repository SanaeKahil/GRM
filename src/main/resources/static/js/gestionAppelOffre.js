 $(document).ready(function() {
        // Fonction pour vérifier si la date de fin est supérieure à la date de début
        function checkDates() {
            var dateDebut = new Date($("#dateDebut").val());
            var dateFin = new Date($("#dateFin").val());
            var errorMessage = "La date de laivraison doit être ultérieure à la date de début.";
            if (dateFin <= dateDebut) {
                $("#dateFinError").text(errorMessage).css("color", "red");
                 $("#submit").prop("disabled", true);
            } else {
                $("#dateFinError").empty(); // Effacer le texte d'erreur s'il n'y a pas d'erreur
                 $("#submit").prop("disabled", false);
            }
        }
        // Ajouter un gestionnaire d'événement onchange aux champs de date de début et de fin
        $("#dateDebut, #dateFin").on("change", checkDates);
    });

  