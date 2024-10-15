<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/static/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</head>
<div class="containerCSS">
        <div class="navigationCSS">
            <ul>
                <li>
                    <div>
                        <span class="icon">
                            <ion-icon name="briefcase-outline"></ion-icon>
                        </span>
                        <span class="title">Besoins</span>
                    </div>
                </li>
                
                <li style="cursor: pointer;">
                    <div id="demanderBesoinButton">
                        <span class="icon">
                             <ion-icon name="create-outline"></ion-icon> 
                        </span>
                        <span class="title">Demande</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="consulterBesoinButton">
                        <span class="icon">
                            <ion-icon name="list-outline"></ion-icon>
                        </span>
                        <span class="title">Consultation</span>
                    </div>
                </li>
                
                <li style="cursor: pointer;">
                    <div id="ajouterBesoinDepartementButton">
                        <span class="icon">
                            <ion-icon name="add-circle-outline"></ion-icon>
                        </span>
                        <span class="title">Nouveau Besoin</span>
                    </div>
                </li>
                
                <li style="cursor: pointer;">
                    <div id="ConsulterRessourcesButton">
                        <span class="icon">
                            <ion-icon name="alert-circle-outline"></ion-icon>
                        </span>
                        <span class="title">Nouvelle Panne</span>
                    </div>
                </li>

                <li style="cursor: pointer;">
                    <div id="signOut">
                        <span class="icon">
                            <ion-icon name="log-out-outline"></ion-icon>
                        </span>
                        <span class="title">Log Out</span>
                    </div>
                </li>
                
                
            </ul>
        </div>
    </div>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    
    
   <script>
    document.addEventListener("DOMContentLoaded", function () {
        var demanderBesoinButton = document.getElementById("demanderBesoinButton");
        var consulterBesoinButton = document.getElementById("consulterBesoinButton");
        var consulterRessourcesButton=document.getElementById("ConsulterRessourcesButton");

        demanderBesoinButton.addEventListener("click", function () {
            document.getElementById("demandeBesoinsContent").style.display = "block";
            document.getElementById("consultationBesoinsContent").style.display = "none";
        	document.getElementById("ajouterBesoinDepartementContent").style.display = "none";
        	document.getElementById("consultationRessourcesContent").style.display="none";

        });

        consulterBesoinButton.addEventListener("click", function () {
            document.getElementById("consultationBesoinsContent").style.display = "block";
            document.getElementById("demandeBesoinsContent").style.display = "none";
        	document.getElementById("ajouterBesoinDepartementContent").style.display = "none";
        	document.getElementById("consultationRessourcesContent").style.display="none";
        });
        
        
        ajouterBesoinDepartementButton.addEventListener("click",function(){
        	document.getElementById("ajouterBesoinDepartementContent").style.display = "block";
            document.getElementById("consultationBesoinsContent").style.display = "none";
            document.getElementById("demandeBesoinsContent").style.display = "none";
        	document.getElementById("consultationRessourcesContent").style.display="none";
        });
        
        consulterRessourcesButton.addEventListener("click",function(){
        	document.getElementById("consultationRessourcesContent").style.display="block";
        	document.getElementById("ajouterBesoinDepartementContent").style.display = "none";
            document.getElementById("consultationBesoinsContent").style.display = "none";
            document.getElementById("demandeBesoinsContent").style.display = "none";
        });
    });
    
    document.getElementById('signOut').addEventListener('click', function() {
        Swal.fire({
            text: 'Voulez-vous vraiment quitter votre espace?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#007bff',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Oui, quitter',
            cancelButtonText: 'Annuler'
        }).then((result) => {
            if (result.isConfirmed) {
                fetch('/logout', {
                    method: 'POST' 
                })
                .then(response => {
                    Swal.fire({
                        title: 'Au revoir!',
                        icon: 'success',
                        timer: 1500, 
                        timerProgressBar: true 
                    });
                    setTimeout(() => {
                        window.location.replace('/login');
                    }, 1500); 
                })
                .catch(error => {
                    console.error('Erreur lors de la déconnexion :', error);
                });
            }
        });
    });    
</script>    
</body>
</html>