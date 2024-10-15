<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toast Notification</title>
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
            width: 96.5%; /* 50% de largeur avec un espacement de 25px */
            height: 105px;
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
            margin-bottom: 25px; margin-left:-10px; /* .... */
        }

        .container-2 p:first-child {
            color: #101020;
            font-weight: 600;
            font-size: 16px;
            margin-top: -10px; margin-left:-110px;
        }

        .container-2 p:last-child {
            font-size: 15px;
            font-weight: 400;
            color: #656565;
            margin-top: -10px; margin-left:-110px;
            width: 125%;  /* pour forcer la rupture des mots */
            
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
<div class="wrapper">
    <c:forEach items="${myListNotifications}" var="notification" varStatus="loop">
      <c:if test="${notification.user_dest.cin == sessionScope.Enseignant.cin}"> <!-- Cette condition affiche uniquement les notifications destinées à l'enseignant actuellement authentifié -->
        <div class="toast ${notification.etat==1 ? 'success' : 'info'} ${notification.etat==0 ? 'unread' : ''}" style="display: grid;" onclick="markAsRead(this)" data-notification-id="${notification.id_notif}">
            <div class="container-1">
                <i class="fas fa-${notification.etat==1 ? 'check-square' : 'info-circle'}"></i>
            </div>
            <div class="container-2">
                <p>Envoyé par ${notification.user_sour.nom} ${notification.user_sour.prenom}</p>
                <%-- <p>Send By ${notification.user_sour.nom} ${notification.user_sour.prenom} (${notification.user_sour.roles})</p> --%>
                <p>${notification.message}</p>
            </div>
            <button><i class="fas fa-eye" style="margin-top:-10px; margin-right:-25px;"></i></button>
        </div>
        <!-- Ajoute une ligne après chaque deux notifications -->
        <%-- <c:if test="${loop.index % 2 == 1 && !loop.last}">
            <div style="width: 100%; margin-bottom: 20px;"></div>
        </c:if> --%>
	   </c:if>
	</c:forEach>
	
	<!-- Vérifier si la liste des notifications est vide -->
    <c:if test="${empty myListNotifications  || not myListNotifications.stream().anyMatch(n -> n.user_dest.cin eq sessionScope.Enseignant.cin) }">
        <div class="toast info unread" style="display: grid;">
            <div class="container-1">
                <i class="fas fa-info-circle"></i>
            </div>
            <div class="container-2">
                <p>Aucune notification disponible</p>
                <p>Il n'y a actuellement aucune notification envoyée.</p>
            </div>
        </div>
    </c:if>

    
     <!-- ajouter de l'espace après vos notifications -->
    <div style="width: 100%; margin-bottom: 20px;"></div>
</div>

<!--Script-->
<script>
    function markAsRead(element) {
        // Récupérer l'ID de la notification à partir de l'élément parent
        var notificationId = element.getAttribute("data-notification-id");
       // var notificationId = element.dataset.data-notification-id;
        
        // Effectuer une requête AJAX pour mettre à jour l'état de la notification dans la base de données
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
</body>

</html>

