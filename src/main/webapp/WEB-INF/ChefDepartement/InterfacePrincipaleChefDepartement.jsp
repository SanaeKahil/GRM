<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>La principale du chef</title>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <script src="/static/js/main.js"></script>
</head>
<body>
    <jsp:include page="SideBarChefDepartement.jsp" />
    <div class="mainCSS">
            <div class="topbarCSS">
                <div class="toggleCSS">
                    <ion-icon name="menu-outline"></ion-icon>
                </div>

                

                <div class="userCSS">
                    <ion-icon name="person-circle-outline" size="large"></ion-icon>
                </div>              
            </div>
      
    <div id="demandeBesoinsContent" style="display: none;">
    <%@ include file="ContenuDemandeBesoins.jsp" %>
    </div>
    
    <div id="consultationBesoinsContent" style="display: ${param.visibility == 'true' ? 'block' : 'none'};">
    <%@ include file="ContenuConsultationBesoins.jsp" %>
    </div>
    
    <div id="consultationRessourcesContent" style="display: none;">
    <%@ include file="ContenuConsultationRessources.jsp" %>
    </div>
    
    <div id="ajouterBesoinDepartementContent" style="display: none;">
    <%@ include file="ConsulterBesoinDepartement.jsp" %>
    </div>
 
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var successMessage = "<c:out value='${successMessage}'/>";
        if (successMessage) {
            Swal.fire({
                icon: 'success',
                title: successMessage,
                showConfirmButton: false,
                timer: 1500      
            });
        }
    });
    </script>   
</body>
</html>
