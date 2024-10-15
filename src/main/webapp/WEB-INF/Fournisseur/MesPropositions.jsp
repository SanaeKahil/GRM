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
 <h4 class="mb-4 mt-4">Mes propositions </h4>
     <table class="table mt-3">
            <thead>
              <tr>
                <th scope="col">Appel offre</th>
                <th scope="col">Nom societe</th>
                <th scope="col">date livraison</th>
                <th scope="col">Etat</th>
                <th scope="col">Total</th>
                 <th scope="col">Détails</th>
              </tr>
            </thead>
            <tbody>
             <c:forEach items="${listPropositions}" var="proposition">
             
                  <tr>
                  		<td>${proposition.appelOffre.nom}</td>
                  		<td>${proposition.fournisseur.nomSociete}</td>
                  		<td>${proposition.date_livraison}</td>    
					      <td >
					       <c:choose>
					     
					    <c:when test="${proposition.etat eq 'accepter'}">
					      <span class="badge badge-pill bg-success"> accepter </span>
					    </c:when>
					    <c:when test="${proposition.etat eq 'refuser'}">
					      <span class="badge badge-pill bg-danger"> refuser </span>
					    </c:when>
					    <c:when test="${empty proposition.etat}">
					        <span class="badge badge-pill bg-warning"> En cours de traitement </span>
					    </c:when>
					    <c:otherwise>
					       
					    </c:otherwise>
					</c:choose>
					 </td>
                  		<td> <b> ${proposition.total} DH </b></td> 
                  		<td>

                  		    <button type="submit" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#${proposition.id_prop}"> 
		                      Consulter                                    
		                    </button>     
		                </td>     	
                  </tr>
             </c:forEach>
             
             
              <!-- End of React loop -->
            </tbody>
          </table>
         </div>
    </div>
    <!-- Modal -->
    <c:forEach items="${listPropositions}" var="proposition">
        <div class="modal fade" id="${proposition.id_prop}" tabindex="-1" aria-labelledby="consulerAppelOffreLabel" aria-hidden="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center" id="consulerAppelOffreLabel">${proposition.appelOffre.nom} </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Besoin</th>
                                    <th scope="col">Prix</th>
                                    <th scope="col">Marque</th>
                                </tr>
                            </thead>
                            <tbody>		    
                             <c:forEach items="${listDetailsProp}" var="DetailsProp">
							    <!-- Tester si DetailsProp.proposition est égal à proposition.id_prop -->
							    <c:if test="${DetailsProp.proposition.id_prop eq proposition.id_prop}">
							        <tr>
							            <td>${DetailsProp.besoin.type}</td>
							            <td> <b>${DetailsProp.prix} DH </b></td>
							            <td>${DetailsProp.marque}</td>
							        </tr>
							    </c:if>
							</c:forEach>

					       </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    
    <!-- ======= Bootstrap JS ====== -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <!-- La fin de class="main-login"  -->
  
</body>
<!--Script-->
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
