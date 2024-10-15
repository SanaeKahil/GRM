<%@ include file="AjouterBesoinDepartement.jsp" %>
<div class="container">
    <div class="mb-3">
        <button id="envoyerBesoinButton" type="button" class="btn btn-secondary mb-3" style="background-color:#007bff; width: 200px; height: 45px; font-size: 18px;"><b>Ajouter un besoin</b></button>
    </div>
    <table class="table table-striped table-bordered">
        <thead>
            <th>Type</th>
            <th>Caractéristiques</th>
            <th>Demandé en tant que</th>
        </thead>
        <tbody> 
            <c:forEach items="${listBesoins}" var="besoin">
                <c:if test="${sessionScope.Enseignant != null && sessionScope.Enseignant.cin == besoin.personnelAdministration.cin && besoin.appelOffre == null}">
                    <tr>
                        <td>${besoin.type}</td> 
                        <td>
                            <c:choose>
                                <c:when test="${besoin.type eq 'ordinateur'}">
                                    CPU: ${besoin.cpu}, Disque Dur: ${besoin.disque_dur}, Ecran: ${besoin.ecran}, RAM: ${besoin.ram} 
                                </c:when>
                                <c:when test="${besoin.type == 'imprimante'}">
                                    Résolution: ${besoin.resolution}, Vitesse: ${besoin.vitesse}
                                </c:when>
                            </c:choose>
                        </td>
                        <td>${besoin.demander_par}</td> 
                    </tr>  
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    document.getElementById("envoyerBesoinButton").addEventListener("click", function() {
        $('#envoyerBesoinModal').modal('show');
    });
</script>