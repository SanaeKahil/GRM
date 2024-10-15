
<%@ include file="EnvoyerBesoin.jsp" %>

<!-- ------------------------------------------------------------------------------ -->
<div class='container'>
   
   <!-- Bouton pour envoyer un besoin -->
  <!-- <button id="envoyerBesoinButton" class="btn btn-primary mb-3" >Envoyer un besoin</button> -->
  <button id="envoyerBesoinButton" type="button" class="btn btn-secondary mb-3" style="background:#008080; width: 200px; height: 45px; font-size: 18px;"><b>Envoyer un besoin</b></button>
  
<%--   <p>CIN: ${sessionScope.Enseignant.cin}</p>  --%>
   
<table class='table table-striped table-bordered'>
    <thead>
        <!-- <th>Appel d'offre</th> -->
        <th>Type Ressource</th>
        <th>Personnel</th>
        <th>Role</th>
        <th>Caractéristiques</th>
        <!-- <th style="width:8%">Actions</th> -->
    </thead>
    <tbody> 
    
    <!-- Vérifier si la liste des besoins est vide -->
            <c:if test="${empty myListBesoins || not myListBesoins.stream().anyMatch(b -> b.personnelAdministration.cin eq sessionScope.Enseignant.cin) }">
                <tr>
                  <td colspan="4" class="text-center"><b style="color:#008080;">Aucune Besoin Disponible</b></td>
                </tr>
            </c:if>
    
        <c:forEach items="${myListBesoins}" var="besoin">
            <%-- Vérifier si l'utilisateur connecté est un enseignant et si son CIN correspond au CIN du personnel associé au besoin --%>
            <c:if test="${sessionScope.Enseignant != null && sessionScope.Enseignant.cin == besoin.personnelAdministration.cin}">
                <tr>
                    <%-- <td>${besoin.appelOffre.nom}</td> --%>
                    <td>${besoin.type}</td> 
                    <td>${besoin.personnelAdministration.nom} ${besoin.personnelAdministration.prenom}</td>  
                    <td>${besoin.personnelAdministration.roles}</td> 
                    <td>
                        <%-- Vérifier le type du besoin et afficher les caractéristiques appropriées --%>
                        <c:choose>
                            <c:when test="${besoin.type eq 'ordinateur'}">
                                <%-- Besoin est un ordinateur --%>
                                CPU: ${besoin.cpu} GHz, Disque Dur: ${besoin.disque_dur} Go, Ecran: ${besoin.ecran} pouces, RAM: ${besoin.ram} Go
                            </c:when>
                            <c:when test="${besoin.type == 'imprimante'}">
                                <%-- Besoin est une imprimante --%>
                                Résolution: ${besoin.resolution} dpi, Vitesse: ${besoin.vitesse} ppm
                            </c:when>
                        </c:choose>
                    </td>
                    <!-- <td> 
                        <div style="color: green; cursor: pointer; margin-left: 7px; font-size: 22px; display: inline-block;"
                             onclick="return confirm('Voulez-vous vraiment modifier ce besoin ?')"
                             title="Edit"> <i class="fas fa-edit"></i> 
                        </div>
                        <div style="color: red; cursor: pointer; margin-left: 8px; font-size: 22px; display: inline-block;"
                             onclick="return confirm('Voulez-vous vraiment supprimer ce besoin ?')"
                             title="Delete">
                            <i class="fas fa-trash-alt"></i>
                        </div>
                    </td> -->
                </tr>  
            </c:if>
        </c:forEach>
    </tbody>
</table>

            
             <!--  <div class="form-group row">
                  <div class="col-sm-5 offset-sm-10" >
                    <div onClick="Retour();">
                      <button style="width:30%; font-size:110%; background-color:#B0C4DE;" class="btn btn-info">Retour</button>
                    </div>                          
                  </div>
              </div>    -->                   
       </div>
       
<script>
    document.getElementById("envoyerBesoinButton").addEventListener("click", function() {
        $('#envoyerBesoinModal').modal('show');
    });
</script>

       