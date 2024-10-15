<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page principale d'eniengant</title>
    
    <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
   <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
</head>

<body>

<!-- =============== Navigation ================ -->
<!-- Inclusion de la barre de navigation : Spring Boot Include JSP file inside another JSP File -->
<jsp:include page="SidebarEnseignant.jsp" flush="true"></jsp:include>
<!-- =============== fin Navigation ================ -->

<!-- ========================= Main ==================== -->
            <!-- #DCDCDC , F5F5F5 , FFFAF0 , F5F5DC , FFFAFA, F5FFFA , FAF0E6 , FDF5E6 -->
       <!--  <div class="mainCSS"> -->
        <div class="mainCSS" style="background-color: #F5F5F5;">
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
<!-- 1- Contenu des Ressources --------------------------------------------- -->
<div id="ressourcesContent" style="display: none;">		
	<%@ include file="ContenuRessources.jsp" %>
</div>

<!-- 2- Contenu des besoins --------------------------------------------- -->   
<div id="besoinsContent" style="display: none;">
	<%@ include file="ContenuBesoins.jsp" %>
</div>

<!-- 3- Contenu du Profil --------------------------------------------- -->   
<div id="profilContent" style="display: none;">
	<%@ include file="ContenuProfil.jsp" %>
</div>

<!-- 3- Contenu des messages (Le contenu par défaut lorsque l'application est lancée 'car ne contient pas : style="display: none;"') --------------------------------------------- -->  
<div id="messagesContent">
    <%@ include file="ContenuMessage.jsp" %>
</div>

<!-- ========================= Fin Contenu ==================== -->          
        </div>
<!-- ========================= Fin Main ==================== -->
    
</body>
</html>


<%-- <p>CIN: ${sessionScope.currentUser.cin}</p> --%>

