<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ajouter proposition</title>
 <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="/static/css/CardAppelOffre.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
    .page_proposition .titlePage{
	    margin-top:20px;
	    margin-bottom:25px
	}
    
    .page_proposition table.table td, th {
	    background: #eaf7fe;
	}
	
	.page_proposition table th {
	    background: #eaf7fe !important;
	    padding-top: 22px !important;
	    padding-bottom: 22px !important;
	    /* text-align: center; */
	}
	
	.page_proposition .bgBlue{
	   background: #eaf7fe;
	}
	
	.page_proposition .row_footer_proposition {
		margin-top:15px;
		background: #d9f2ff;
		padding: 25px;
		border-radius:8px;
		box-shadow: 3px 4px 5px #cccccc4a;
	}
	
	.page_proposition .btnSubmit {
		margin-bottom:30px
	}

    
    </style>
    
    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
      <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
    
      <!-- ========================= Main ==================== -->
     <div class="container page_proposition">
        <div style="background-color: #fff;">
         <!-- Titre appel offre nom -->
         <h5 class="titlePage">  ${appelOffre.nom}</h5>
         <div class="row bgBlue">
          <div class="col-md-12 mx-auto bgBlue">
            <form action="/AjouterProposition" method="post">
            
                <table class="table ">
                    <thead>
                        <tr>
                            <th>Materiel</th>
                            <th>Détails</th>
                            <th>Prix</th>
                            <th>Marque</th>
                            <th>Date garantie</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listBesoinsAppelOffre}" var="b">
                            <tr>
                                <td>${b.type}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.type eq 'ordinateur'}">
                                            <li>CPU: ${b.cpu} GHz</li>
                                            <li>Disque Dur: ${b.disque_dur} Go</li>
                                            <li>Ecran: ${b.ecran} pouces</li>
                                            <li>RAM: ${b.ram} Go</li>
                                        </c:when>
                                        <c:when test="${b.type eq 'imprimante'}">
                                            <li>Resolution: ${b.resolution} dpi</li>
                                            <li>Vitesse: ${b.vitesse} ppm</li>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Champ de formulaire pour le prix -->
                                    <input type="number" name="prix_${b.id_bes}" id="prix_${b.id_bes}" class="form-control prix" placeholder="Prix" min="0" required >
                                    <div class="invalid-feedback">Veuillez entrer un prix valide.</div>
                                </td>
                                <td>
                                    <!-- Champ de formulaire pour la marque -->
                                    <input type="text" name="marque_${b.id_bes}" id="marque_${b.id_bes}" class="form-control" placeholder="Marque" required>
                                    <div class="invalid-feedback">Veuillez entrer la marque.</div>
                                </td>
                                 <td>
                                    <!-- Champ de formulaire pour la marque -->
                                    <input type="date" name="Dgarantie_${b.id_bes}" id="Dgarantie_${b.id_bes}" class="form-control" placeholder="date" required>
                                    <div class="invalid-feedback">Veuillez entrer la date.</div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                    </tbody>
                </table>
              </div>
             
              <div class="col-md-10  mx-auto row_footer_proposition" >
                 <div class="row">
	           		<div class="col-md-4">
		           		 <div>
			                Date de livraison: 
			                <input type="date" id="dateLivraison" name="dateLivraison" class="form-control" required>
			            </div>
		            </div>
		            <div class="col-md-8">
		           		<div class="float-md-end" style="margin-top:15px"> <!-- Utilisation de la classe float-end pour placer les éléments à droite -->
		                   <input type="hidden" name="total" id="totalInput" value="0">
		                   TOTAL : <b id="total">0 DH</b>
                   		</div>
		            </div>
	             </div>
	           </div>
	           
	           <div style="margin-top:30px"></div>
              
             <div class="col-md-11">
            
               <div class="float-md-end"> <!-- Utilisation de la classe float-end pour placer les éléments à droite -->
                   <!-- <input type="hidden" name="total" id="totalInput" value="0">
                   Total: <span id="total">0 DH</span>
                   <br> -->
                   <!-- tester si le fournisseur est bloque  -->
                   
                  <c:choose>
                    <c:when test="${sessionScope['Fournisseur'].etat == 1}">
                      <button type="button" class="btn btn-primary mt-2 btnSubmit" onclick="showSweetAlert()">Soumettre</button>
                    </c:when>
                 <c:otherwise>
                     <button type="submit" class="btn btn-primary mt-2 btnSubmit">Soumettre</button>
                 </c:otherwise>
               </c:choose>
                 <!--  <button type="submit" class="btn btn-primary mt-2">Soumettre</button> -->
               </div>
            </div>
            </form>
       </div> 
       </div>
    </div>

<script>
    // Sélectionnez tous les champs de prix
    const prixInputs = document.querySelectorAll('.prix');
    // Sélectionnez l'élément où afficher le total
    const totalElement = document.getElementById('total');
    // Sélectionnez le champ caché pour le total
    const totalInput = document.getElementById('totalInput');
    // Fonction pour calculer le total
    function calculerTotal() {
        let total = 0;
        // Bouclez à travers chaque champ de prix et ajoutez la valeur à total
        prixInputs.forEach(input => {
            
            if (!isNaN(parseFloat(input.value))) {
                total += parseFloat(input.value);
            }
        });
        // Mettez à jour le contenu de l'élément total
        totalElement.textContent = total.toFixed(2); // Arrondi à 2 décimales
        // Mettez à jour la valeur du champ caché
        totalInput.value = total.toFixed(2);
    }

    
    prixInputs.forEach(input => {
        input.addEventListener('input', calculerTotal);
    });
</script>
<script>
function showSweetAlert() {
           Swal.fire({
               title: 'Vous êtes bloqué !',
               text: 'Pour des raisons administratives ,vous ne pouvez pas ajouter une proposition',
               icon: 'error',
               confirmButtonText: 'OK'
           }).then((result) => {
               if (result.isConfirmed) {
                   window.location.href = '/PagePublique';
               }
           });
  
}
</script>    
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
            	window.location.href = '/logoutFournisseur';            }
        });
    });
</script>  
</body>
</html>