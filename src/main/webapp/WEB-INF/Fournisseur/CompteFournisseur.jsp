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
     <div class="card">
        <div class="card-header text-white" style="background:#116680;">
           Mon Compte
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <strong>Nom de la société :</strong>
                </div>
                <div class="col-md-6">
                    ${sessionScope['Fournisseur'].nomSociete}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <strong>Gérant :</strong>
                </div>
                <div class="col-md-6">
                    ${sessionScope['Fournisseur'].gerant}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <strong>Site Web :</strong>
                </div>
                <div class="col-md-6">
                    ${sessionScope['Fournisseur'].site_internet}
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <strong>Addresse:</strong>
                </div>
                <div class="col-md-6">
                    ${sessionScope['Fournisseur'].adresse}
                </div>
            </div>
        </div>
    </div>
	
 </div>
</div>

</body>

  <!-- La fin de class="main-login"  -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
