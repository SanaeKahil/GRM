<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>gestion des appels d'offres</title>
    
    <!-- ======= Bootstrap ====== -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
  <style>
  
  #btnCreeAppel1 {
  cursor: not-allowed;
}
  
  </style>
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
			<div class="card" style="background-color: #fff;">
      <div class="card-header">
<c:choose>
  <c:when test="${empty listBesoins}">
    <!-- Afficher le message lorsque la liste est vide -->
    <div class="d-flex justify-content-center">
  <button data-bs-toggle="tooltip" title="Aucun besoin à traiter" id="btnCreeAppel1" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#creeAppel">Créer Appel d'Offre</button>
</div>

  </c:when>
  <c:otherwise>
    <!-- Afficher le bouton pour créer l'appel d'offre lorsque la liste n'est pas vide -->
    <div class="d-flex justify-content-center">
      <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#creeAppel">Créer Appel d'Offre</button>
    </div>
  </c:otherwise>
</c:choose>
        <div class="card-body">
          <table class="table mt-3">
            <thead>
              <tr>
                <th scope="col">Appel offre</th>
                <th scope="col">date Debut</th>
                <th scope="col">date livraison</th>
                <th scope="col">list des besoins</th>
              </tr>
            </thead>
            <tbody>
             <c:forEach items="${listAppelOffres}" var="a">
             
                  <tr>
                  		<td>${a.nom}</td>
                  		<td>${a.date_debut}</td>
                  		<td>${a.date_fin}</td>    
                  		<td>

                  		    <button type="submit" class="btn " data-bs-toggle="modal" data-bs-target="#${a.id_app_off}"> 
		                     <ion-icon name="list"></ion-icon>                                 
		                    </button>     
		                </td>     	
                  </tr>
             </c:forEach>
             
             
              <!-- End of React loop -->
            </tbody>
          </table>
           
        </div>
      </div>
    </div>
			<c:forEach items="${listAppelOffres}" var="a">
              <div class="modal fade" id="${a.id_app_off}" tabindex="-1" aria-labelledby="consulerAppelOffreLabel" aria-hidden="false">
			        <div class="modal-dialog modal-lg">
			          <div class="modal-content">
			            <div class="modal-header">
			              <h5 class="modal-title text-center" id="consulerAppelOffreLabel">${a.nom} </h5>
			              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
        
					<table class="table">
			                <thead>
			                  <tr>
			                    <th scope="col">Type</th>
			                    <th scope="col">Caracteristique</th>
			                   
			                  </tr>
			                </thead>
			                <tbody>		    
			                <c:forEach items="${a.listBesoins}" var="b">         
				                  <tr>
				                    <td>${b.type}</td>
				                    <td>	                   				                  	              
					                <c:choose>
			                            <c:when test="${b.type eq 'ordinateur'}">			                              
			                                CPU: ${b.cpu} GHz, Disque Dur: ${b.disque_dur} Go, Ecran: ${b.ecran} pouces, RAM: ${b.ram} Go
			                            </c:when>
			                            <c:when test="${b.type == 'imprimante'}">			                                <%-- b est une imprimante --%>
			                                Résolution: ${b.resolution} dpi, Vitesse: ${b.vitesse} ppm
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
     </div>
<!-- ========================= Fin Contenu ==================== -->          
        </div>
        
       <jsp:include page="modalCreeAppelOffre.jsp" flush="true"></jsp:include>
<!-- ========================= Fin Main ==================== -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- ======= Bootstrap JS ====== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>   
    
</body>
</html>