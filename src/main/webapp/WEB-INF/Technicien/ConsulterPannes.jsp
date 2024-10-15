<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- --------------------- Liste des Pannes Non Réparées  ----------------- -->
<br/> 
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <h3 class="mb-4"><i class="fas fa-exclamation-triangle mr-2 text-danger"></i> <span class="text-danger">Liste des Pannes Non Réparées :</span></h3>
            <table class="table table-striped table-bordered" >
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Num Inv</th>
                        <th scope="col">Type Ressource</th>
                        <th scope="col">Date Panne</th>
                        <th scope="col">État Panne</th>
                        <th style="width:8%">Réparer</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Vérifier si la liste des pannes est vide ou s'il n'y a pas de pannes non réparées -->
                    <c:choose>
                        <c:when test="${empty myListPannes || not myListPannes.stream().anyMatch(p -> p.etat_panne == 'Non réparée')}">
                            <tr>
                                <td colspan="6" class="text-center"><b style="color:#008080;">Aucune Panne Non Réparée Disponible</b></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <!-- Afficher uniquement les pannes non réparées -->
                            <c:forEach items="${myListPannes}" var="panne">
                                <c:if test="${panne.etat_panne == 'Non réparée'}">
                                    <tr>
                                        <td>${panne.id_pan}</td>
                                        <td>${panne.ressource.numero_inventaire}</td>
                                        <td>${panne.ressource.besoin.type}</td>
                                        <td>${panne.date_panne}</td>
                                        <td>${panne.etat_panne}</td>
                                        <td>
                                            <!-- Bouton pour réparer une panne -->
                                            <div class="reparerPanneBtn" style="color: #008080; cursor: pointer; margin-left: 20px; font-size: 22px;" title="Réparer Panne">
                                                <b><i class="fas fa-tools"></i></b>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Lorsque vous cliquez sur le bouton "Réparer Panne"
        $('.reparerPanneBtn').click(function() {
        	// Récupérer l'état de la panne de la ligne sélectionnée
            var etatPanne = $(this).closest('tr').find('td:eq(4)').text();       
            // Vérifier si l'état de la panne est déjà "Réparée" ou "Sévère"
            if (etatPanne === 'Réparée' || etatPanne === 'Sévère') {
                alert('Cette panne est déjà réparée ou sévère. Vous ne pouvez pas la réparer à nouveau.');
                return; // Arrêter l'exécution de la fonction
            }
        	
            // Afficher un message de confirmation
            if (confirm('Voulez-vous vraiment réparer cette panne ?')) {
            	// Récupérer l'ID de la panne de la ligne sélectionnée
                var id_panne = $(this).closest('tr').find('td:first').text();
                // Pré-remplir le champ "ID Panne" dans la fenêtre modale avec la valeur récupérée
                $('#reparerPanneModal').find('input[name="id_pan"]').val(id_panne);
                // Afficher la fenêtre modale
                $('#reparerPanneModal').modal('show'); // existe dans le fichier : ReparerPanne.jsp
            }
        });
    });
</script>

<!----------------------------------------  -->  
 <%@ include file="ReparerPanne.jsp" %>  
<!----------------------------------------  -->


<!-- --------------------- Liste des Pannes Réparées ----------------- -->
<br/> 
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <h3 class="mb-4"><i class="fas fa-check-circle mr-2 text-success"></i> <span class="text-success">Liste des Pannes Réparées :</span></h3>
            <table class="table table-striped table-bordered" >
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Num Inv</th>
                        <th scope="col">Type Ressource</th>
                        <th scope="col">Date Panne</th>
                        <th scope="col">État</th>
                        <th scope="col">Technicien</th>
                        <th scope="col">Fréquence</th>
                        <th scope="col">Ordre</th>
                        <th scope="col">Constat</th>
                        <th style="width:8%">Réparer</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Vérifier si la liste des pannes est vide ou s'il n'y a pas de pannes réparées ou aucune panne ne correspond au technicien authentifié -->
                    <c:if test="${empty myListPannes || not myListPannes.stream().anyMatch(p -> (p.etat_panne == 'En cours' || p.etat_panne == 'Réparée' || p.etat_panne == 'Sévère') && p.technicien.cin == sessionScope.Technicien.cin)}">
                        <tr>
                            <td colspan="10" class="text-center"><b style="color:#008080;">Aucune Panne Réparée Disponible</b></td>
                        </tr>
                    </c:if>
                    <!-- Si la liste des pannes n'est pas vide, afficher les pannes -->
                    <c:forEach items="${myListPannes}" var="panne">
                    <c:if test="${panne.etat_panne != 'Non réparée' && sessionScope.Technicien.cin == panne.technicien.cin}">
				    <tr>
				        <td>${panne.id_pan}</td>
				        <td>${panne.ressource.numero_inventaire}</td>
				        <td>${panne.ressource.besoin.type}</td>
				        <td>${panne.date_panne}</td>
				        <td>${panne.etat_panne}</td>
				        <td>${panne.technicien.nom} ${panne.technicien.prenom}</td>
				        <!-- Contrôler l'affichage des champs en fonction de l'état de la panne -->
				            <c:choose>
				                <c:when test="${panne.etat_panne eq 'En cours' || panne.etat_panne eq 'Réparée'}">
				                    <!-- Ne rien afficher pour l'état "En cours" ou "Réparée" -->
				                    <td colspan="3" class="table-active"></td>
				                </c:when>
				                <c:when test="${panne.etat_panne eq 'Sévère'}">
				                    <!-- Afficher les champs pour l'état "Sévère" -->
				                    <td>${panne.frequence}</td>
				                    <td>${panne.ordre}</td>
				                    <td>${panne.constat}</td>
				                </c:when>
				            </c:choose>
				       <td>
                          <!-- Bouton pour réparer une panne -->
                          <div class="reparerPanneBtn" style="color: #008080; cursor: pointer; margin-left: 20px; font-size: 22px;" title="Réparer Panne">
                              <b><i class="fas fa-tools"></i></b>
                          </div>
                      </td>
				    </tr>
				   </c:if>
				</c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>


