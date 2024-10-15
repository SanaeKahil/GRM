
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>gestion des appels d'offres</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script src="/static/js/gestionAppelOffre.js"></script>
     <script src="/static/js/gestionProsition.js"></script>
     <style >
     #vide {
    padding: 20px;
    background-color: #f8d7da; /* Couleur de fond */
    color: #721c24; /* Couleur du texte */
    border: 1px solid #f5c6cb; /* Bordure */
    border-radius: 5px; /* Coins arrondis */
    margin-top: 20px; /* Espacement en haut */
}

</style>
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
     <div class="container ">
     <div class="mb-3">
    <label for="selectAppelOffre" class="form-label">Sélectionner un appel d'offre :</label>
    <select class="form-select" id="selectAppelOffre">
          <option value="all">All</option>
       <c:forEach items="${listAppel}" var="a">
          <option value="${a.id_app_off}">${a.nom}</option>
      </c:forEach>
      <!-- Ajoutez d'autres options selon vos besoins -->
    </select>
  </div >
		<table class="table table-striped " id="tab">
    <thead>
        <tr>
            <th>Appel Offre</th>
            <th>Fournisseur</th>
            <th>Date de Livraison</th>
            <th>Total</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody id="body">
        <c:forEach items="${listProposition}" var="pr">
           
				<c:choose>
					<c:when test='${pr.etat eq "refuse" or pr.etat eq "" or pr.etat eq  NULL  }'>
					 <tr>
                <td>${pr.appelOffre.nom}</td>
                <td>${pr.fournisseur.nomSociete}</td>
                <td>${pr.date_livraison}</td>
                <td>${pr.total}</td>		
                
                <td><a data-bs-toggle="modal" data-bs-target="#d${pr.id_prop}" style="color: #000; cursor: pointer;text-decoration:underline;">Plus de détails</a></td>	                              
							<td>
							    <div class="form-check form-check-inline">
							        <input id="${pr.id_prop}" value="${pr.id_prop}" hidden="hidden">
							        <input id="${pr.id_prop}_four" value="${pr.fournisseur.id_four}" hidden="hidden">
							        <input class="form-check-input" type="radio" name="choix_${pr.id_prop}" id="accepter_${pr.id_prop}" >
							        <label class="form-check-label" for="accepter_${pr.id_prop}">Accepter</label>
							    </div>
							</td>
							<td>
							    <div class="form-check form-check-inline">
							        <input class="form-check-input" type="radio" name="choix_${pr.id_prop}" id="refuser_${pr.id_prop}" checked="checked">
							        <label class="form-check-label" for="refuser_${pr.id_prop}">Refuser</label>
							    </div>
							</td> 	    
							</tr>             
				    </c:when>
	                 <c:when test='${pr.etat eq "accepter" }'>	
	                  <tr>
                <td>${pr.appelOffre.nom}</td>
                <td>${pr.fournisseur.nomSociete}</td>
                <td>${pr.date_livraison}</td>
                <td>${pr.total}</td>	
                
                <td><a data-bs-toggle="modal" data-bs-target="#d${pr.id_prop}" style="color: #000; cursor: pointer;text-decoration:underline;">Plus de dï¿½tails</a></td>
	                    <td>	                            
							    <div class="form-check form-check-inline">
									<input id="${pr.id_prop}" value="${pr.id_prop}" hidden="hidden">
							        <input id="${pr.id_prop}_four" value="${pr.fournisseur.id_four}" hidden="hidden">
							        <input class="form-check-input" type="radio" name="choix_${pr.id_prop}" id="accepter_${pr.id_prop}"  checked="checked">
							        <label class="form-check-label" for="accepter_${pr.id_prop}">Accepter</label>
							    </div>
							</td>
							<td>
							    <div class="form-check form-check-inline">
							        <input class="form-check-input" type="radio" name="choix_${pr.id_prop}" id="refuser_${pr.id_prop}">
							        <label class="form-check-label" for="refuser_${pr.id_prop}">Refuser</label>
							    </div>
							</td> 
					  </tr> 	                 
					 </c:when>
	                </c:choose>   
             
        </c:forEach>
    </tbody>
</table>
			<div class="d-flex justify-content-center m-5" > <button id="btnValide" class="btn btn-primary ml-3"  data-bs-toggle="modal" data-bs-target="#confirmationModal">Valider</button></div>

     </div>
    <div id="vide" style="display: none;">Aucune proposition correspond à cet appel d'offre</div>
     
   
     
   
<!-- ========================= Fin Contenu ==================== -->     


<!-- modal de confirmation modification  -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmationModalLabel">Confirmation de modification</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" >
        Vous étes-vous sur de vouloir modifier ?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
        <button type="button" class="btn btn-primary" onclick="accepterRefuserProposition()"  data-bs-dismiss="modal" >Confirmer</button>
      </div>
    </div>
  </div>
</div>
      
      
      
  <!-- modal de confirmation modification etat fournisseur   -->
       <div class="modal fade" id="confirmationFour" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmationModalLabel">Confirmation de modification</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="fourn" >
        Vous étes-vous sur de vouloir modifier ?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
        <button type="button" class="btn btn-primary" id="modifEtat"  data-bs-dismiss="modal" >Confirmer</button>
      </div>
    </div>
  </div>
</div>
      
<!-- fin modal confirmation -->     
        <c:forEach items="${listProposition}" var="pr">
<div class="modal fade" id="d${pr.id_prop}" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="detailsModalLabel">Détails de la Proposition</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Informations du fournisseur -->
        <h6>Informations du Fournisseur:</h6>
		<c:choose>
    <c:when test="${empty pr.fournisseur.gerant || empty pr.fournisseur.adresse || empty pr.fournisseur.lieu}">
            <ul>
          <li><strong>Nom de la Societe:</strong> ${pr.fournisseur.nomSociete}</li>
    </ul>
        <div class="alert alert-info" role="alert">
            Le fournisseur est nouveau. Veuillez ajouter les informations manquantes :
        </div>
      <input value="${pr.fournisseur.id_four}" id="idFour" hidden="hidden">
          
            <div class="mb-3">
                <label for="gerant" class="form-label">Gérant</label>
                <input type="text" class="form-control" value="${pr.fournisseur.gerant}" id="gerant" name="gerant">
            </div>
           
            <div class="mb-3">
                <label for="adresse" class="form-label">Adresse</label>
                <input type="text" class="form-control" value="${pr.fournisseur.adresse}" id="adresse" name="adresse">
            </div>
            
            <div class="mb-3">
                <label for="lieu" class="form-label">Lieu</label>
                <input type="text" class="form-control" id="lieu" value=" ${pr.fournisseur.lieu}"  name="lieu" >
            </div>
           <div class="mb-3">
                <label for="lieu" class="form-label">Site internet (optionnel)</label>
                <input type="text" class="form-control" id="site_internet" value=" ${pr.fournisseur.site_internet}"  name="site_internet" >
            </div>
           
            <button type="submit" class="btn btn-primary" onclick="ajouterInfoFournisseur()" >Ajouter</button>
        
        
    </c:when>
     <c:otherwise>
             <ul>
          <li><strong>Nom de la Societe:</strong> ${pr.fournisseur.nomSociete}</li>
     
     		    <li><strong>Gérant:</strong> ${pr.fournisseur.gerant}</li>
    <li><strong>Adresse:</strong> ${pr.fournisseur.adresse}</li>
    <li><strong>Lieu:</strong> ${pr.fournisseur.lieu}</li>
    <li><strong>Site Internet:</strong> <a href="${pr.fournisseur.site_internet}" target="_blank">${pr.fournisseur.site_internet}</a></li>
     	</ul>	
     	           <div class="d-flex justify-content-center">
             <p class="mx-5"> list noire </p>
              	   <c:choose>
	                 <c:when test="${pr.fournisseur.etat eq 0}">			                              
	              		<div class="form-check form-check-inline ml-5">
					        <input class="form-check-input"   onclick="modiferEtatFournisseur('${pr.fournisseur.nomSociete}','${pr.id_prop}','${pr.fournisseur.id_four}')"  type="radio" name="listNoire_${pr.id_prop}" id="oui_${pr.id_prop}" >
					        <label class="form-check-label"  for="oui_${pr.id_prop}">Oui</label>
					    </div>		
	              		<div class="form-check form-check-inline">
					        <input class="form-check-input" onclick="modiferEtatFournisseur('${pr.fournisseur.nomSociete}','${pr.id_prop}','${pr.fournisseur.id_four}')" type="radio" name="listNoire_${pr.id_prop}" id="non_${pr.id_prop}" checked="checked">
					        <label class="form-check-label"for="non_${pr.id_prop}">Non</label>
					    </div> 	                 
				    </c:when>
	                 <c:when test="${pr.fournisseur.etat eq 1}">			                            
	              		<div class="form-check form-check-inline ml-5">
					        <input class="form-check-input" onclick="modiferEtatFournisseur('${pr.fournisseur.nomSociete}','${pr.id_prop}','${pr.fournisseur.id_four}')" type="radio" name="listNoire_${pr.id_prop}" id="oui_${pr.id_prop}" checked="checked">
					        <label class="form-check-label" for="oui_${pr.id_prop}">Oui</label>
					    </div>		
	              		<div class="form-check form-check-inline">
					        <input class="form-check-input" onclick="modiferEtatFournisseur('${pr.fournisseur.nomSociete}','${pr.id_prop}','${pr.fournisseur.id_four}')" type="radio" name="listNoire_${pr.id_prop}" id="non_${pr.id_prop}" >
					        <label class="form-check-label" for="non_${pr.id_prop}">Non</label>
					    </div> 	                 
					 </c:when>
	                </c:choose>          
           </div>
     </c:otherwise>
</c:choose>

        <hr> <!-- Ligne de sï¿½paration -->
 
        <!-- Tableau des dï¿½tails de la proposition -->
        <h6>Détails de la Proposition:</h6>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Type</th>
              <th>Marque</th>
              <th>Prix</th>
              <th>Caractéristiques</th>
            </tr>
          </thead>
          <tbody>
           <c:forEach items="${pr.details}" var="d">
            <tr>
              <td>${d.besoin.type}</td>
              <td>${d.marque}</td>
              <td>${d.prix}</td>
			  <td>	                   				                  	              
	              <c:choose>
	                 <c:when test="${d.besoin.type eq 'ordinateur'}">			                              
	                     CPU: ${d.besoin.cpu} GHz, Disque Dur: ${d.besoin.disque_dur} Go, Ecran: ${d.besoin.ecran} pouces, RAM: ${d.besoin.ram} Go
	                 </c:when>
	                 <c:when test="${d.besoin.type == 'imprimante'}">			                                <%-- b est une imprimante --%>
	                     Resolution: ${d.besoin.resolution} dpi, Vitesse: ${d.besoin.vitesse} ppm
	                 </c:when>
	              </c:choose>
             </td>
            </tr>
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
      
<!-- ========================= Fin Main ==================== -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- ======= Bootstrap JS ====== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>   
    
</body>
</html>