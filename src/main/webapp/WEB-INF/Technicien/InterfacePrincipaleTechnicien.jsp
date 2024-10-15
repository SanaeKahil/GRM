<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page principale du technicien</title>
    
    <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
   <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/technicien.js"></script>
</head>

<body>

<!-- =============== Navigation ================ -->
<jsp:include page="SidebarTechnicien.jsp" flush="true"></jsp:include>
<!-- =============== fin Navigation ================ -->

<!-- ========================= Main ==================== -->
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
<!-- 1- Contenu des Pannes --------------------------------------------- -->
<div id="pannesContent" style="display: none;">		
	<%@ include file="ConsulterPannes.jsp" %>
</div>

<!-- 2- Contenu des messages (Le contenu par défaut lorsque l'application est lancée 'car ne contient pas : style="display: none;"') --------------------------------------------- -->  
<div id="signalementsContent">
    <%@ include file="SignalementsNotification.jsp" %>
</div>

<!-- ========================= Fin Contenu ==================== -->          
        </div>
<!-- ========================= Fin Main ==================== -->
    
</body>
</html>




