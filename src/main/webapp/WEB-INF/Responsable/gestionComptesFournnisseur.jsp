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
     <script src="/static/js/gestionComptesFournnisseur.js"></script>
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
     <div class="container">
			<div class="card" style="background-color: #fff;">
			
      <div class="card-header">
        <div class="card-body">
    
          <table class="table mt-3">
            <thead>
              <tr>
                <th scope="col">nomSociete</th>
                <th scope="col">gerant</th>
                <th scope="col">lieu</th>
                <th scope="col">adresse</th>
                 <th scope="col">site_internet</th>
                 <th></th>
                 <th></th>
              </tr>
            </thead>
            <tbody>
             <c:forEach items="${listComptes}" var="a">
             
                  <tr>
                  		<td>${a.nomSociete}
                  		<input value="${a.id_four}" name="idRes" class="idFour" hidden="hidden">
                  		</td>
                  		<td>${a.gerant}</td>
                  		<td>${a.lieu}</td>    
			                    <td>	                   				                  	              
									${a.adresse }
		                         </td>   
							<td>${a.site_internet}</td>
							<td><button class="btn btn-primary"  onclick="modfierInfoFournisseur('${a.id_four}','${a.nomSociete}','${a.motDePasse}', '${a.gerant}','${a. adresse}','${a. lieu}', '${a.site_internet}')">Modifier</button></td>
                  </tr>
                	
             </c:forEach>
             
             
              
            </tbody>
          </table> 
               
        </div>
         <div class="card-footer d-flex justify-content-center">
         <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ajouterFournisseurModal">
  Ajouter un nouveau fournisseur
</button>
      </div>
    </div>
		<!-- ========================= Fin Contenu ==================== -->          
        </div>
       <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="ajouterFournisseurModal" tabindex="-1" aria-labelledby="ajouterFournisseurModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ajouterFournisseurModalLabel">Ajouter un nouveau fournisseur</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
  
        <form method="POST" action="/modiferInfoFournnisseur">
          <div class="mb-3">
            <label for="nomSociete" class="form-label">Nom de la société</label>
            <input type="text" class="form-control" id="nomSociete" name="nomSociete" required>
          </div>
                    <div class="mb-3">
            <label for="motDePasse" class="form-label">Mot Pass</label>
            <input type="password" class="form-control" id="motDePasse" name="motDePasse" required>
          </div>
      <!--     <div class="mb-3">
            <label for="gerant" class="form-label">Gérant</label>
            <input type="text" class="form-control" id="gerant" name="gerant" required>
          </div>
          <div class="mb-3">
            <label for="adresse" class="form-label">Adresse</label>
            <input type="text" class="form-control" id="adresse" name="adresse" required>
          </div>
          <div class="mb-3">
            <label for="lieu" class="form-label">Lieu</label>
            <input type="text" class="form-control" id="lieu" name="lieu" required>
          </div>
          <div class="mb-3">
            <label for="siteInternet" class="form-label">Site Internet</label>
            <input type="text" class="form-control" id="siteInternet" name="siteInternet">
          </div> -->
           <div class=" d-flex justify-content-center">
          <button type="submit" class="btn btn-primary">Ajouter</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
      </div>
    </div>
  </div>
</div>
       
<!-- ========================= Fin Main ==================== -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- ======= Bootstrap JS ====== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>   
    
</body>
</html>