<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<div class='container'>
    <!-- <h3 class="mb-4"><i class="fas fa-cogs text-primary"></i> <span class="text-primary">Liste des Ressources :</span></h3> -->
    <h3 class="mb-4" style="color:#008080;"><i class="fas fa-cogs"></i> <span >Liste des Ressources :</span></h3>
    <table class='table table-striped table-bordered'>
        <thead>
            <th>ID</th>
            <th>Num Inventaire</th>
            <th>Type Ressource</th>
            <th>Etat Reception</th>
            <th>Etat Affectation</th>
            <th>Personnel</th>
            <th>Role</th>
            <th style="width:13%">Action</th>
        </thead>
        <tbody>
            <!-- Vérifier si la liste des ressources est vide -->
            <c:if test="${empty myListRessources}">
                <tr>
                  <td colspan="7" class="text-center"><b style="color:#008080;">Aucune Ressource Disponible</b></td>
                </tr>
            </c:if>
            <!-- Si la liste des ressources n'est pas vide, afficher les ressources -->
            <c:forEach items="${myListRessources}" var="ressource">
                <tr>
                    <td>${ressource.idRes}</td>
                    <td>${ressource.numero_inventaire}</td>
                    <td>${ressource.besoin.type}</td>
                    <td>${ressource.etat_recep}</td>
                    <td>${ressource.etat_affect}</td>
                    <td>${ressource.besoin.personnelAdministration.nom} ${ressource.besoin.personnelAdministration.prenom}</td>
                    <td>${ressource.besoin.personnelAdministration.roles}</td>
                    <td>
                        <!-- Bouton pour signaler une panne -->
                        <div class="signalPanneBtn" style="color: red; cursor: pointer; margin-left: 40px; font-size: 22px;" title="Signaler Panne">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
         
              <!-- <div class="form-group row">
                  <div class="col-sm-5 offset-sm-10" >
                    <div onClick="Retour();">
                      <button style="width:30%; font-size:110%; background-color:#B0C4DE;" class="btn btn-info">Retour</button>
                    </div>                          
                  </div>
              </div> -->                      
   </div>

<!----------------------------------------  -->  
<%@ include file="SignalerPanne.jsp" %>     
<!----------------------------------------  -->

<script>
    $(document).ready(function() {
        // Lorsque vous cliquez sur le bouton "Signaler Panne"
        $('.signalPanneBtn').click(function() {
            // Afficher un message de confirmation
            if (confirm('Voulez-vous vraiment signaler une panne pour cette ressource ?')) {
                // Récupérer le numéro d'inventaire de la ressource de la ligne sélectionnée
                var numeroInventaire = $(this).closest('tr').find('td:first').text();
                // Pré-remplir le champ "Numéro Inventaire" dans la fenêtre modale avec la valeur récupérée
                $('#signalerPanneModal').find('input[name="ressource"]').val(numeroInventaire);
                // Afficher la fenêtre modale
                $('#signalerPanneModal').modal('show'); // existe dans le fichier : SignalerPanne.jsp
            }
        });
    });
</script>
       

<!-- ----------------------------------------------------------------------------------------------
<%-- Vérifier si l'utilisateur connecté est un enseignant et si son CIN correspond au CIN du personnel associé à la ressource --%>
  <c:if test="${sessionScope.Enseignant != null && sessionScope.Enseignant.cin == ressource.besoin.personnelAdministration.cin}">
      <tr>
          <td></td>
      </tr>
  </c:if>
 -->

<!-- --------------------- Liste des Pannes des Ressources ----------------- -->
<br/> 
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3 class="mb-4"><i class="fas fa-exclamation-triangle mr-2 text-danger"></i> <span class="text-danger">Liste des Pannes des Ressources :</span></h3>
            
			<table class="table table-striped table-bordered">
			    <thead class="thead-dark">
			        <tr>
			            <th scope="col">#</th>
			            <th scope="col">Numéro Inventaire</th>
			            <th scope="col">Type</th>
			            <th scope="col">Date Panne</th>
			            <th scope="col">État Panne</th>
			        </tr>
			    </thead>
			    <tbody>
			        <!-- Vérifier si la liste des pannes est vide -->
			        <c:choose>
			            <c:when test="${empty listePannes}">
			                <tr>
			                    <td colspan="5" class="text-center"><b style="color:#008080;">Aucune Panne Disponible</b></td>
			                </tr>
			            </c:when>
			            <c:otherwise>
			                <!-- Si la liste des pannes n'est pas vide -->
			                <c:set var="panneDisponible" value="false" />
			                <c:forEach items="${listePannes}" var="panne">
			                    <c:if test="${sessionScope.Enseignant != null && sessionScope.Enseignant.cin == panne.ressource.besoin.personnelAdministration.cin}">
			                        <tr>
			                            <td>${panne.id_pan}</td>
			                            <td>${panne.ressource.numero_inventaire}</td>
			                            <td>${panne.ressource.besoin.type}</td>
			                            <td>${panne.date_panne}</td>
			                            <td>${panne.etat_panne}</td>
			                        </tr>
			                        <c:set var="panneDisponible" value="true" />
			                    </c:if>
			                </c:forEach>
			                <!-- Vérifier si aucune panne n'est disponible à cet enseignant -->
			                <c:if test="${not panneDisponible}">
			                    <tr>
			                        <td colspan="5" class="text-center"><b style="color:#008080;">Aucune Panne Disponible à cet enseignant</b></td>
			                    </tr>
			                </c:if>
			            </c:otherwise>
			        </c:choose>
			    </tbody>
			</table>

        </div>
    </div>
</div>
<br> <br>


