<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- --------------------- Liste des Pannes Non R�par�es  ----------------- -->
<br/> 
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <h3 class="mb-4"><i class="fas fa-exclamation-triangle mr-2 text-danger"></i> <span class="text-danger">Liste des Pannes Non R�par�es :</span></h3>
            <table class="table table-striped table-bordered" >
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Num Inv</th>
                        <th scope="col">Type Ressource</th>
                        <th scope="col">Date Panne</th>
                        <th scope="col">�tat Panne</th>
                        <th style="width:8%">R�parer</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- V�rifier si la liste des pannes est vide ou s'il n'y a pas de pannes non r�par�es -->
                    <c:choose>
                        <c:when test="${empty myListPannes || not myListPannes.stream().anyMatch(p -> p.etat_panne == 'Non r�par�e')}">
                            <tr>
                                <td colspan="6" class="text-center"><b style="color:#008080;">Aucune Panne Non R�par�e Disponible</b></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <!-- Afficher uniquement les pannes non r�par�es -->
                            <c:forEach items="${myListPannes}" var="panne">
                                <c:if test="${panne.etat_panne == 'Non r�par�e'}">
                                    <tr>
                                        <td>${panne.id_pan}</td>
                                        <td>${panne.ressource.numero_inventaire}</td>
                                        <td>${panne.ressource.besoin.type}</td>
                                        <td>${panne.date_panne}</td>
                                        <td>${panne.etat_panne}</td>
                                        <td>
                                            <!-- Bouton pour r�parer une panne -->
                                            <div class="reparerPanneBtn" style="color: #008080; cursor: pointer; margin-left: 20px; font-size: 22px;" title="R�parer Panne">
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
        // Lorsque vous cliquez sur le bouton "R�parer Panne"
        $('.reparerPanneBtn').click(function() {
        	// R�cup�rer l'�tat de la panne de la ligne s�lectionn�e
            var etatPanne = $(this).closest('tr').find('td:eq(4)').text();       
            // V�rifier si l'�tat de la panne est d�j� "R�par�e" ou "S�v�re"
            if (etatPanne === 'R�par�e' || etatPanne === 'S�v�re') {
                alert('Cette panne est d�j� r�par�e ou s�v�re. Vous ne pouvez pas la r�parer � nouveau.');
                return; // Arr�ter l'ex�cution de la fonction
            }
        	
            // Afficher un message de confirmation
            if (confirm('Voulez-vous vraiment r�parer cette panne ?')) {
            	// R�cup�rer l'ID de la panne de la ligne s�lectionn�e
                var id_panne = $(this).closest('tr').find('td:first').text();
                // Pr�-remplir le champ "ID Panne" dans la fen�tre modale avec la valeur r�cup�r�e
                $('#reparerPanneModal').find('input[name="id_pan"]').val(id_panne);
                // Afficher la fen�tre modale
                $('#reparerPanneModal').modal('show'); // existe dans le fichier : ReparerPanne.jsp
            }
        });
    });
</script>

<!----------------------------------------  -->  
 <%@ include file="ReparerPanne.jsp" %>  
<!----------------------------------------  -->


<!-- --------------------- Liste des Pannes R�par�es ----------------- -->
<br/> 
<div class="container">
    <div class="row">
        <div class="col-md-12" >
            <h3 class="mb-4"><i class="fas fa-check-circle mr-2 text-success"></i> <span class="text-success">Liste des Pannes R�par�es :</span></h3>
            <table class="table table-striped table-bordered" >
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Num Inv</th>
                        <th scope="col">Type Ressource</th>
                        <th scope="col">Date Panne</th>
                        <th scope="col">�tat</th>
                        <th scope="col">Technicien</th>
                        <th scope="col">Fr�quence</th>
                        <th scope="col">Ordre</th>
                        <th scope="col">Constat</th>
                        <th style="width:8%">R�parer</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- V�rifier si la liste des pannes est vide ou s'il n'y a pas de pannes r�par�es ou aucune panne ne correspond au technicien authentifi� -->
                    <c:if test="${empty myListPannes || not myListPannes.stream().anyMatch(p -> (p.etat_panne == 'En cours' || p.etat_panne == 'R�par�e' || p.etat_panne == 'S�v�re') && p.technicien.cin == sessionScope.Technicien.cin)}">
                        <tr>
                            <td colspan="10" class="text-center"><b style="color:#008080;">Aucune Panne R�par�e Disponible</b></td>
                        </tr>
                    </c:if>
                    <!-- Si la liste des pannes n'est pas vide, afficher les pannes -->
                    <c:forEach items="${myListPannes}" var="panne">
                    <c:if test="${panne.etat_panne != 'Non r�par�e' && sessionScope.Technicien.cin == panne.technicien.cin}">
				    <tr>
				        <td>${panne.id_pan}</td>
				        <td>${panne.ressource.numero_inventaire}</td>
				        <td>${panne.ressource.besoin.type}</td>
				        <td>${panne.date_panne}</td>
				        <td>${panne.etat_panne}</td>
				        <td>${panne.technicien.nom} ${panne.technicien.prenom}</td>
				        <!-- Contr�ler l'affichage des champs en fonction de l'�tat de la panne -->
				            <c:choose>
				                <c:when test="${panne.etat_panne eq 'En cours' || panne.etat_panne eq 'R�par�e'}">
				                    <!-- Ne rien afficher pour l'�tat "En cours" ou "R�par�e" -->
				                    <td colspan="3" class="table-active"></td>
				                </c:when>
				                <c:when test="${panne.etat_panne eq 'S�v�re'}">
				                    <!-- Afficher les champs pour l'�tat "S�v�re" -->
				                    <td>${panne.frequence}</td>
				                    <td>${panne.ordre}</td>
				                    <td>${panne.constat}</td>
				                </c:when>
				            </c:choose>
				       <td>
                          <!-- Bouton pour r�parer une panne -->
                          <div class="reparerPanneBtn" style="color: #008080; cursor: pointer; margin-left: 20px; font-size: 22px;" title="R�parer Panne">
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


