<!DOCTYPE html>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page principale responsable de resources</title>
    
    <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script src="/static/js/gestionAppelOffre.js"></script>
     <script src="/static/js/gestionProsition.js"></script>
</head>

<body>

<!-- =============== Navigation ================ -->
<!-- Inclusion de la barre de navigation : Spring Boot Include JSP file inside another JSP File -->
<jsp:include page="sideBareResponsable.jsp" flush="true"></jsp:include>
<!-- =============== fin Navigation ================ -->

<!-- ========================= Main ==================== -->
        <div class="mainCSS">
            <div class="topbarCSS">
                <div class="toggleCSS">
                    <ion-icon name="menu-outline"></ion-icon>
                </div>

                <div class="searchCSS">
                    <label>
                        <input type="text" placeholder="Search here">
                        <ion-icon name="search-outline"></ion-icon>
                    </label>
                </div>

                <div class="userCSS">
                    <ion-icon name="person-circle-outline" size="large"></ion-icon>
                </div>              
            </div>

<!-- ========================= le contenu ==================== -->
<br />		
     <div class="container">
        <div>
            <p>CIN: ${sessionScope.Responsable.cin}</p>
            <p>Nom: ${sessionScope.Responsable.nom}</p>
            <p>Prénom: ${sessionScope.Responsable.prenom}</p>
            <p>Date de naissance: ${sessionScope.Responsable.date_naissance}</p>
            <p>Email: ${sessionScope.Responsable.email}</p>
            <p>Rôles: ${sessionScope.Responsable.roles}</p>
        </div>
     </div>
<!-- ========================= Fin Contenu ==================== -->          
        </div>
<!-- ========================= Fin Main ==================== -->
            <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- ======= Bootstrap JS ====== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>   
</body>
</html>