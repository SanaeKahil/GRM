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
            left: 1.8%; /* left: 50%; */
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

        .info i {
            color: #2F86EB;
        }

        .container-1,
        .container-2 {
            align-self: center;
        }

        .container-1 i {
            font-size: 45px;
            margin-bottom: 30px; margin-left:-10px; /* .... */
        }

        .container-2 p:first-child {
            color: #101020;
            font-weight: 600;
            font-size: 16px;
            margin-top: -15px; margin-left:-110px;
        }

        .container-2 p:last-child {
            font-size: 15px;
            font-weight: 400;
            color: #656565;
            margin-top: -15px; margin-left:-110px;
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
         
        /* Ajout de style pour les notifications non lues */
        .unread {
            background-color: #f0f0f0;
        }

    </style>
</head>
<body>
<div class="wrapper">
    <c:forEach items="${myListPannes}" var="panne" varStatus="loop">
        <c:if test="${panne.etat_panne == 'Non réparée'}">
            <div class="toast info unread" style="display: grid;">
                <div class="container-1">
                    <i class="fas fa-info-circle"></i>
                </div>
                <div class="container-2">
                    <p>Chers Techniciens,</p>
                    <p>Nous souhaitons vous informer qu'une <b style="color:#FF0000;">panne</b> a été détectée dans une ressource de type <b style="color:#008080;">${panne.ressource.besoin.type}</b> portant le numéro d'inventaire <b style="color:#008080;">${panne.ressource.numero_inventaire}</b>.
                        Cette ressource appartient au <b style="color:#008080;">${panne.ressource.besoin.personnelAdministration.departement.nom_depart}</b>.
                        Nous vous prions de bien vouloir intervenir pour résoudre ce problème dans les plus brefs délais.</p>
                </div>
                <button><i class="fas fa-eye" style="margin-top:-10px; margin-right:-25px;"></i></button>
            </div>
        </c:if>
    </c:forEach>
    
    <!-- Vérifier si la liste des pannes est vide ou si aucune panne non réparée n'existe -->
    <c:if test="${empty myListPannes || not myListPannes.stream().anyMatch(p -> p.etat_panne == 'Non réparée')}">
        <div class="toast info unread" style="display: grid;">
            <div class="container-1">
                <i class="fas fa-info-circle"></i>
            </div>
            <div class="container-2">
                <p>Aucune notification de panne disponible</p>
                <p>Il n'y a actuellement aucune panne enregistrée.</p>
            </div>
        </div>
    </c:if>
    
    <!-- ajouter de l'espace après vos notifications -->
    <div style="width: 100%; margin-bottom: 20px;"></div>
</div>


</body>

</html>

