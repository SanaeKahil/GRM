    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>gestion des ressources livres</title>
    
    <!-- ======= Bootstrap ====== -->
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
    <!-- Inclure le fichier JavaScript -->
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="/static/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script src="/static/js/gestionAppelOffre.js"></script>
     <script src="/static/js/gestionProsition.js"></script>
     <script src="/static/js/gestionRessourceLivres.js"></script>
</head>
<style>
     .vide {
    color: red; /* Couleur du texte */
}

</style>
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
    <!--  <div class="m-1">
			<div class="card " style="background-color: #fff;">
			
      <div class="card-header">
        <div class="card-body"> -->
    <div style="max-height: 400px; overflow-y: auto;  class="m-1">
         <div class="mb-3" style="position: sticky; top: 0;">
    <label for="selectAppelOffre1" class="form-label">Sélectionner un appel d'offre :</label>
    <select class="form-select" id="selectAppelOffre1" >
          <option value="all">All</option>
       <c:forEach items="${listAppel}" var="a">
          <option value="${a.id_app_off}">${a.nom}</option>
      </c:forEach>
      <!-- Ajoutez d'autres options selon vos besoins -->
    </select>
  </div >
          <table class="table mt-3">
            <thead style="position: sticky; top: 0; background-color: white; z-index: 1;">
              <tr>
                <th>Appel offre</th>
                <th scope="col">type</th>
                <th scope="col">marque</th>
                <th scope="col">prix</th>
                <th scope="col">numero inventaire</th>
                <th>Etat livraison</th> 
                <th>Etat affectation</th>
                <th></th>

              </tr>
            </thead>
          
            <tbody >
             <c:forEach items="${listRessource}" var="a">
             
                  <tr>
                  		<td>${a.besoin.appelOffre.nom }</td>
                  		<td>${a.besoin.type}
                  		<input value="${ a.idRes}" name="idRes" class="idRes" hidden="hidden">
                  		</td>
        <td>${a.marque}</td>
                  		<td>${a.prix}</td>    
			                   
		                  <td>  <input type="text" name="numero_inventaire" oninput="verfie(this,${a.idRes})" id="num${a.idRes}" class="form-control numInv"  value="${a.numero_inventaire}" >
		                     <div id="vide${a.idRes}" class="vide" style="display: none;"></div>
		                     </td>	
		                <td>
		                 <div class="d-flex justify-content-center">
					           <c:choose>
				                 <c:when test='${a.etat_recep eq "recue" }'>			                              
				              		<div class="form-check form-check-inline ml-5">
								        <input class="form-check-input"   onclick="modiferEtatRoussource('${a.idRes}')"  type="radio"  name="recue_${a.idRes}" id="oui_${a.idRes}" checked="checked">
								        <label class="form-check-label"  for="oui_${a.idRes}">Recue</label>
								    </div>		
				              		<div class="form-check form-check-inline">
								        <input class="form-check-input" onclick="modiferEtatRoussource('${a.idRes}')"  type="radio" name="recue_${a.idRes}" id="non_${a.idRes}" >
								        <label class="form-check-label"for="non_${a.idRes}">Non Recue</label>
								    </div> 	                 
							    </c:when>
				                 <c:otherwise>			                            
				              		<div class="form-check form-check-inline ml-5">
								        <input class="form-check-input"   onclick="modiferEtatRoussource('${a.idRes}')"  type="radio" name="nonrecue_${a.idRes}"  id="oui_${a.idRes}" >
								        <label class="form-check-label"  for="oui_${a.idRes}">Recue</label>
								    </div>		
				              		<div class="form-check form-check-inline">
								        <input class="form-check-input" onclick="modiferEtatRoussource('${a.idRes}')"  type="radio" name="nonrecue_${a.idRes}" id="non_${a.idRes}" checked="checked">
								        <label class="form-check-label"for="non_${a.idRes}">Non Recue</label>
								    </div> 	                
								 </c:otherwise>
				             </c:choose> 
				             </div> 
		                </td>
		                <td>

		                 <div class="d-flex justify-content-center">
					           <c:choose>
					           
				                 <c:when test='${a.etat_affect eq "Affectée à un département" or a.etat_affect eq "Affectée à une personne" }'>			                              
				              		<div class="form-check form-check-inline ml-5">
								        <input class="form-check-input" onclick="modiferEtatAffectation('${a.besoin.personnelAdministration.roles}','${a.idRes}','${a.besoin.personnelAdministration.nom}','${a.besoin.personnelAdministration.prenom}','${a.besoin.personnelAdministration.cin}','${a.besoin.personnelAdministration.departement.nom_depart}','${a.besoin.demander_par}')"   type="radio"  name="affecte_${a.idRes}" id="affecteoui_${a.idRes}" checked="checked">
								        <label class="form-check-label"  for="affecteoui_${a.idRes}">affecte</label>
								    </div>		
				              		<div class="form-check form-check-inline">
								        <input class="form-check-input" onclick="modiferEtatAffectation('${a.besoin.personnelAdministration.roles}','${a.idRes}','${a.besoin.personnelAdministration.nom}','${a.besoin.personnelAdministration.prenom}','${a.besoin.personnelAdministration.cin}','${a.besoin.personnelAdministration.departement.nom_depart}','${a.besoin.demander_par}')"   type="radio" name="affecte_${a.idRes}" id="affectenon_${a.idRes}" >
								        <label class="form-check-label"for="affectenon_${a.idRes}">Non affecte</label>
								    </div> 	                 
							    </c:when>
				                 <c:otherwise>			                            
				              		<div class="form-check form-check-inline ml-5">
								        <input class="form-check-input"  onclick="modiferEtatAffectation('${a.besoin.personnelAdministration.roles}','${a.idRes}','${a.besoin.personnelAdministration.nom}','${a.besoin.personnelAdministration.prenom}','${a.besoin.personnelAdministration.cin}','${a.besoin.personnelAdministration.departement.nom_depart}','${a.besoin.demander_par}')"    type="radio" name="nonaffecte_${a.idRes}"  id="affecteoui_${a.idRes}">
								        <label class="form-check-label"  for="affecteoui_${a.idRes}">affecte</label>
								    </div>		
				              		<div class="form-check form-check-inline">
								        <input class="form-check-input" onclick="modiferEtatAffectation('${a.besoin.personnelAdministration.roles}','${a.idRes}','${a.besoin.personnelAdministration.nom}','${a.besoin.personnelAdministration.prenom}','${a.besoin.personnelAdministration.cin}','${a.besoin.personnelAdministration.departement.nom_depart}','${a.besoin.demander_par}')"    type="radio" name="nonaffecte_${a.idRes}" id="affectenon_${a.idRes}" checked="checked">
								        <label class="form-check-label"for="affectenon_${a.idRes}">Non affecte</label>
								    </div> 	                
								 </c:otherwise>
				             </c:choose> 
				             </div> 
		                </td>
		                 <td><a data-bs-toggle="modal" data-bs-target="#d${a.idRes}" style="color: #000; cursor: pointer;text-decoration:underline;">Plus de détails</a></td>	
                  </tr>  
                  
             </c:forEach>
            </tbody>
          </table>
		</div>      
  
           <div class="d-flex justify-content-center">
            <button class="btn btn-primary" id="submit" onclick="submitModif()">Modifier</button>
          </div>
    <!--    </div>
    </div>-->
    <div class="modal fade" id="affectation" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Affectation de ressource</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
            <div class="m-3">
              <p>Sélectionner un enseignant si tu veut modifier </p>
              <div class="mb-3">
                <label for="enseignantSelect" class="form-label">CIN</label>
                <select class="form-select" id="cinS" onchange="modiferSelect(this)">
                  <c:forEach items="${listPersonnel}" var="p">
                    <option value="${p.cin}">${p.cin}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="mb-3">
                <label for="nomSelect" class="form-label">Nom</label>
                <select class="form-select" id="nomS"  onchange="modiferSelect(this)">
                  <c:forEach items="${listPersonnel}" var="p">
                    <option value="${p.cin}">${p.nom}</option>
                  </c:forEach>          
                </select>
              </div>

              <div class="mb-3">
                <label for="prenomSelect" class="form-label">Prénom</label>
                <select class="form-select" id="prenomS"  onchange="modiferSelect(this)">
                  <c:forEach items="${listPersonnel}" var="p">
                    <option value="${p.cin}">${p.prenom}</option>
                  </c:forEach>          
                </select>
              </div>
              <div class="mb-3">
 					<p id="role"></p>
 					<p id="depP">Département: <span id="departement"></span></p>
              </div>
              <div class="mb-3" style="display: none" id="affecDep">
                <label class="form-check-label">Affectation pour tous les départements :</label><br>
                <input type="radio" id="tousDepartementsOui" name="tousDepartements" value="oui">
                <label for="tousDepartementsOui">Oui</label><br>
                <input type="radio" id="tousDepartementsNon" name="tousDepartements" value="non" checked>
                <label for="tousDepartementsNon">Non</label>             
              </div>
            </div>
          </div>
                        <div class="modal-footer">
      
        <input  name="idResAff" id="idResAff" hidden="hidden">
        <input  name="etat" id="etatAff" hidden="hidden">
        <button type="button" class="btn btn-primary" onclick="confirmerAffectaion()" >Confirmer affectation</button>
    
  </div>
        </div>

      </div>

</div>

		<!-- ========================= Fin Contenu ==================== -->          
        
        <c:forEach items="${listRessource}" var="a">
<div class="modal fade" id="d${a.idRes}" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="detailsModalLabel">Détails de la Resource</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Informations du fournisseur -->
        <h6>Livreé par : ${a.fournisseurModel.nomSociete}</h6>
	

        <hr> <!-- Ligne de sï¿½paration -->         
       <c:choose>
                 <c:when test="${a.besoin.type eq 'ordinateur'}">			                              
                     <li>CPU: ${a.besoin.cpu} GHz </li>
                      <li>  Disque Dur: ${a.besoin.disque_dur} Go   </li>
                       <li> RAM: ${a.besoin.ram} Go </li>
                        <li>Ecran: ${a.besoin.ecran} pouces </li>
                        
                 </c:when>
                 <c:when test="${a.besoin.type == 'imprimante'}">	
                 <li>Résolution: ${a.besoin.resolution} dpi</li>		                                <%-- b est une imprimante --%>
                   <li>Vitesse: ${a.besoin.vitesse} ppm</li>
                 </c:when>
       </c:choose>
		                      
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