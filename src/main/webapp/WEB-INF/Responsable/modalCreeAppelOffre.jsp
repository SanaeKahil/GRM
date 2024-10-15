<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	   <div class="modal fade" id="creeAppel" tabindex="-1" aria-labelledby="modalAppelOffreLabel" >
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalAppelOffreLabel">Creer Appel d'Offre</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Formulaire pour ajouter un appel d'offre -->
        <form action="/ajouterAppelOffre" method="POST" >
        <input type="text" class="form-control" value="${lastIdAppelOffre+1}" name="id"  hidden>
          <div class="mb-3">
            <label for="titre" class="form-label">Titre </label>
            <input type="text" class="form-control" name="titre" >
          </div>
          <div class="mb-3">
            <label for="titre" class="form-label">date debut</label>
            <input type="date" class="form-control" id="dateDebut" placeholder="Titre" name="dateDebut">
          </div>
          <div class="mb-3">
            <label for="titre" class="form-label">date laivraison</label>
            <input type="date" class="form-control" id="dateFin" placeholder="Titre" name="dateFin">
            <div id="dateFinError" style="color: red;"></div>
          </div>
          <!-- Ajoutez d'autres champs de formulaire selon vos bs -->
          <div class="d-flex justify-content-center">
          <button type="submit" class="btn btn-primary" id="submit">Ajouter Appel d'Offre</button>
          </div>
        </form>
        
        <hr>
        <!-- Table pour lister les bs -->
        <h5>Liste des besoins</h5>
        <table class="table">
          <thead>
            <tr>
              <th scope="col">type</th>
              <th scope="col">caracterstique</th>
        
              
              <!-- Ajoutez d'autres colonnes au b -->
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${listBesoins}" var="b">   
            	 <c:if test="${b.appelOffre == null}">  <!-- just les besoins n'affect aucun appelOffre -->
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
