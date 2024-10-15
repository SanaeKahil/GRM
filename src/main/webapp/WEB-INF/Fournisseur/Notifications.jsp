<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Notification</title>
     <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    
    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!--Font Awesome-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!--Stylesheet-->
    <style type="text/css">
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            border: none;
            font-family: "Poppins", sans-serif;
            /* font-size: 14px; */
        }

        body {
            background-color: #f9f9f9;
        }

        .wrapper {
            width: 100%;
            display: flex;
            flex-wrap: wrap; /* Permettre le passage à la ligne */
            /* justify-content: space-between; */
            position: absolute;
            /* transform: translate(-50%, -50%); */
            top: 90px; /* top: 50%; */
            left: 2%; /* left: 50%; */
            display: flex; /* Changed display to flex */
            /*justify-content: space-between;  Added to space the toasts */
        }

        .toast {
            width: calc(47% - 0.0px); /* 50% de largeur avec un espacement de 25px */
            height: 95px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 7px;
            display: grid;
            grid-template-columns: 1.3fr 6fr 0.5fr;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 10px; /* Espacement verticale entre les toasts */
            margin-right: 25px; /* Espacement horizontale entre les toasts */
        }
        
        .info {
            border-left: 8px solid #2F86EB;
        }

        .success {
            border-left: 8px solid #47D764;
        }

        .info i {
            color: #2F86EB;
        }
        
       .success i {
            color: #47D764;
        }

        .container-1,
        .container-2 {
            align-self: center;
        }

        .container-1 i {
            font-size: 45px;
            margin-bottom: 10px; margin-left:-10px; /* .... */
        }

        .container-2 p:first-child {
            color: #101020;
            font-weight: 600;
            font-size: 16px;
            margin-top: -10px; margin-left:-25px;
        }

        .container-2 p:last-child {
            font-size: 15px;
            font-weight: 400;
            color: #656565;
            margin-top: -10px; margin-left:-25px;
            width: 117%;  /* pour forcer la rupture des mots */
            
        }

        .toast button {
            align-self: flex-start;
            background-color: transparent;
            font-size: 25px;
            color: #656565;
            line-height: 0;
            cursor: pointer;
        }
         
        /* Ajout de style pour survol */
        /* .toast:hover {
            background-color: #f0f0f0;
        } */
        
        /* Ajout de style pour les notifications non lues */
        .unread {
            background-color: #f0f0f0;
        }

    </style>
</head>
<body>
 <!-- ========================= Navbar ==================== -->
  <nav class="navbar navbar-expand-lg navbar-dark mb-4" style="background-color: rgb(25, 75, 132) !important;">
    <div class="container-fluid">
        <a class="navbar-brand" href="/PagePublique">Fst Apples D'offres</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
              <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <c:if test="${not empty sessionScope['Fournisseur']}">
                    <li class="nav-item">
                        <a class="nav-link" href="/Compte">
                            <i class="fas fa-user mx-2"></i>   ${sessionScope['Fournisseur'].nomSociete}
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/MesPropositions">
                            | <i class="fa fa-tags mx-2" ></i> Mes propositions
                        </a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="/notifications">
                            | <i class="fas fa-bell mx-2"> </i>  Notifications
                        </a>
                    </li>
                    <li class="nav-item">
                      <a id="logout-link" class="nav-link" href="/logoutFournisseur">
                        | <i class="fa fa-sign-out mx-1" aria-hidden="true"></i>
                         </a>
                    </li>
                    
                  
                </c:if>
                <c:if test="${empty sessionScope['Fournisseur']}">
                   <li class="nav-item">
                     <a class="nav-link" href="/loginFournisseur">Connexion</a>
                    </li>
               </c:if>

            </ul>
        </div>
    </div>
</nav>
  
    <!-- ========================= Fin Navbar ==================== -->
<div class="container ">
 <div style="background-color: #fff;">
  <c:choose>
    <c:when test="${empty listNotifs}">
       <div class="alert alert-danger" role="alert">
         Aucune notification à consulter pour le moment.
       </div>
    </c:when>
    <c:otherwise>
   <div class="wrapper">
     <c:forEach items="${listNotifs}" var="notification" varStatus="loop">
         <div class="toast ${notification.etat==1 ? 'success' : 'info'} ${notification.etat==0 ? 'unread' : ''}" style="display: grid;min-height: 128px ;height:auto" onclick="markAsRead(this)" data-notification-id="${notification.id_notif}">
            <div class="container-1">
                <i class="fas fa-${notification.etat==1 ? 'check-square' : 'info-circle'}"></i>
            </div>
            <div class="container-2">
                <p>Envoyé par  ${notification.user_sour.nom} ${notification.user_sour.prenom}</p>
            <div >
                <p class="mt-3 " >${notification.message}</p>
            </div>
            </div>
            <button style="font-size: 17px;"><i class="fa-solid fa-eye"></i></button>
        </div>
        <!-- Ajoute une ligne après chaque deux notifications -->
       <c:if test="${loop.index % 2 == 1 && !loop.last}">
            <div style="width: 100%; margin-bottom: 20px;"></div>
        </c:if>
	
	 </c:forEach>

    
     <!-- ajouter de l'espace après vos notifications -->
    <div style="width: 100%; margin-bottom: 20px;"></div>
    </div>
     
    </c:otherwise>
  </c:choose>  
 </div>
</div>

</body>
<!--Script-->
<script>
    function markAsRead(element) {
        // Récupérer l'ID de la notification à partir de l'élément parent
        var notificationId = element.getAttribute("data-notification-id");
       // var notificationId = element.dataset.data-notification-id;
        
       
        var xhr = new XMLHttpRequest();
        xhr.open("PUT", "updateEtatNotificationById", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // Mettre à jour l'apparence de la notification et marquer comme lue
                    element.classList.remove('unread');
                    element.classList.remove('info');
                    element.classList.add('success');
                    element.querySelector('i').classList.remove('fa-info-circle');
                    element.querySelector('i').classList.add('fa-check-square');
                } else {
                    // Gérer les erreurs
                    console.error('Erreur lors de la mise à jour de la notification');
                   // alert("Erreur lors de la mise à jour de la notification");
                }
            }
        };
        // Envoyer l'ID de la notification à mettre à jour
        xhr.send("notificationId=" + notificationId);
    }
</script>
  <!-- La fin de class="main-login"  --><script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <script>
  
    document.getElementById("logout-link").addEventListener("click", function(event) {
        event.preventDefault(); 

        // Afficher la Sweet Alert
        Swal.fire({
            title: "Êtes-vous sûr de vouloir vous déconnecter ?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Oui, déconnectez-moi",
            cancelButtonText: "Annuler",
        }).then((result) => {
            if (result.isConfirmed) {
                // Si l'utilisateur confirme, rediriger vers l'URL de déconnexion
            	window.location.href = '/logoutFournisseur';
            }
        });
    });
</script>
</html>
