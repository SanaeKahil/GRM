<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>les pannes sevres</title>
    
    <!-- ======= Bootstrap ====== -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
    <!-- Inclure le fichier JavaScript -->
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="/static/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <link rel="stylesheet" href="/static/css/style.css">
  <link rel="stylesheet" href="/static/css/styleRespo.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.3/jspdf.umd.min.js"></script>
  

    <!-- Inclure le fichier JavaScript -->
    <script src="/static/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script src="/static/js/gestionAppelOffre.js"></script>
     <script src="/static/js/gestionProsition.js"></script>
    <script src="/static/js/gestionRessourcesEnPannes.js"></script>
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



<!-- Button to trigger modal -->

 <table class="table table-striped">
          <thead>
            <tr>
              <th>Type</th>
              <th>Marque</th>
              <th>Prix</th>
               <th>Date garenti</th>
              <th>Détails de la Panne</th>
            </tr>
          </thead>
          <tbody>
           <c:forEach items="${list}" var="d">
            <tr>
              <td>${d.ressourece.besoin.type}</td>
              <td>${d.ressourece.marque}</td>
              <td>${d.ressourece.prix}</td>
               <td>${d.ressourece.date_garenti}</td>
			  <td>	                   				                  	              
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#panneModal${d.ressourece.idRes}">
						 Détails de la Panne
					</button>
             </td>
            </tr>
           </c:forEach>
          </tbody>
        </table>


<!-- Modal -->
 <c:forEach items="${list}" var="d">
<div class="modal fade" id="panneModal${d.ressourece.idRes}" tabindex="-1" role="dialog" aria-labelledby="panneModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="panneModalLabel">Détails de la Panne</h5>
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul>
          <li><strong>Date de la Panne:</strong> <span >${d.infoPanne.date_panne}</span></li>
          <li><strong>Fréquence:</strong> <span>${d.infoPanne.frequence}</span></li>
          <li><strong>Ordre:</strong> <span>${d.infoPanne.ordre}</span></li>
          <li><strong>Constat:</strong> <span>${d.infoPanne.constat}</span></li>
          <li><strong>Technicien Assigné:</strong> <span>${d.infoPanne.technicien.nom}  ${d.infoPanne.technicien.prenom}</span></li>
        </ul>
		<p id="garantieMessage${d.ressourece.idRes}"></p>
        <label for="reparer${d.ressourece.idRes}" id="reparerlabel${d.ressourece.idRes}" >
            <input type="radio" id="reparer${d.ressourece.idRes}" name="action${d.ressourece.idRes}" value="reparer"> Réparer
        </label>
        <label for="changer${d.ressourece.idRes}" id="changerlabel${d.ressourece.idRes}">
            <input type="radio" id="changer${d.ressourece.idRes}" name="action${d.ressourece.idRes}" value="changer"> Changer
        </label>
      </div>
      
      <div class="modal-footer d-flex justify-content-center" >
         <button class="btn btn-primary" data-bs-dismiss="modal" id="btnEnvoi${d.ressourece.idRes}"  onclick="envoyerDemande('${d.ressourece.idRes}','${d.ressourece.fournisseurModel.id_four}')">Envoyer la Demande</button>     
      </div>
    </div>
  </div>
</div>
  <script>
        $(document).ready(function() {
            var date_garenti = new Date("${d.ressourece.date_garenti}");
            $("#reparer${d.ressourece.idRes}").hide()
            $("#changer${d.ressourece.idRes}").hide()
            $("#reparerlabel${d.ressourece.idRes}").hide()
            $("#changerlabel${d.ressourece.idRes}").hide()
            $("#btnEnvoi${d.ressourece.idRes}").hide()
            if ( new Date() > date_garenti)
                $('#garantieMessage${d.ressourece.idRes}').text("La garantie est expirée.");
            else{
            	$('#garantieMessage${d.ressourece.idRes}').text("La garantie n'est pas encore expirée,vous pouvez envoyer un constat avec ressource  au fournisseur ${d.ressourece.fournisseurModel.nomSociete} .");
                $("#reparer${d.ressourece.idRes}").show()
                $("#changer${d.ressourece.idRes}").show()
                $("#reparerlabel${d.ressourece.idRes}").show()
                $("#changerlabel${d.ressourece.idRes}").show()
                 $("#btnEnvoi${d.ressourece.idRes}").show()
            }
            	
            

          
              
            
           
            // Gérer la sélection de l'action
            $('#actionSelect${d.ressourece.idRes}').change(function() {
                var selectedAction = $(this).val();
                // Faire quelque chose en fonction de l'action sélectionnée (par exemple, afficher un message)
                console.log("Action sélectionnée :", selectedAction);
            });
        });
    </script>
</c:forEach>
    
<!-- ========================= Fin Contenu ==================== -->          
        </div>
        
      
<!-- ========================= Fin Main ==================== -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <!-- ======= Bootstrap JS ====== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>   
    
</body>
</html>