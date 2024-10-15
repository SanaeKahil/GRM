<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- Définition de la fenêtre modale -->
<div class="modal fade" id="envoyerBesoinModal" tabindex="-1" role="dialog" aria-labelledby="envoyerBesoinModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style=" max-width: 800px !important; width: 100% !important; left: 100px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="envoyerBesoinModalLabel">Enregistrer le besoin</h5>
         <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background: none; border: none; font-size: 30px;">
		   <span aria-hidden="true">&times;</span>
		 </button>

      </div>
      <div class="modal-body">
        <!-- Contenu du formulaire pour enregistrer le besoin -->
        <form id="BesoinForm">
                 <div class="form-group row">
		            <label class="col-sm-3 col-form-label">Type Besoin :</label>
		            <div class="col-sm-9">
		              <select name="typeForm" id="typeForm" class="form-control" required>
		                <option value="" disabled selected>Choisir le type de besoin</option>
		                <option value="ordinateur">Ordinateur</option>
		                <option value="imprimante">Imprimante</option>
		              </select>
		            </div>
		          </div><br>
		          <%-- <div class="form-group row">
		            <label class="col-sm-3 col-form-label">Appel d'offre :</label>
		            <div class="col-sm-9">
		              <select name="appelOffreForm" class="form-control" required>
		                <c:forEach items="${myListAppelOffres}" var="appelOffre">
		                  <option value="${appelOffre.id_app_off}">${appelOffre.nom}</option>
		                </c:forEach>
		              </select>
		            </div>
		          </div><br> --%>
					<div class="form-group row">
					    <label class="col-sm-3 col-form-label">Personnel :</label>
					    <div class="col-sm-9">
					        <select name="personnelForm" class="form-control" required readonly style = "background-color: #f8f9fa; color: #495057;  cursor: not-allowed;">
					            <!-- Inclure les options dynamiquement depuis la base de données -->
					            <c:forEach items="${myListPersonnels}" var="personnel">
					                <%-- Vérifier si l'utilisateur connecté est un enseignant et si son CIN correspond au CIN du personnel --%>
					                <c:if test="${sessionScope.Enseignant != null && sessionScope.Enseignant.cin == personnel.cin}">
					                    <option value="${personnel.cin}">${personnel.nom} ${personnel.prenom} (${personnel.roles})</option>
					                </c:if>
					            </c:forEach>
					        </select>
					    </div>
					</div><br>
	            
		            <!-- Champs spécifiques à l'ordinateur -->
					<div class="form-group row" id="ordinateurFields">
					    <label class="col-sm-3 col-form-label">CPU :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="cpu" placeholder="CPU" required>
					    </div>
					    <label class="col-sm-3 col-form-label">Disque Dur :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="disqueDur" placeholder="Disque Dur" required>
					    </div> <br/> <br/>
					    <label class="col-sm-3 col-form-label">Écran :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="ecran" placeholder="Écran" required>
					    </div>
					    <label class="col-sm-3 col-form-label">RAM :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="ram" placeholder="RAM" required>
					    </div> <br/> <br>
					</div>
			        
			        <!-- Champs spécifiques à l'imprimante -->
			        <div class="form-group row" id="imprimanteFields" style="display: none;">
					    <label class="col-sm-3 col-form-label">Resolution :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="resolution" placeholder="Resolution" required>
					    </div>
					    <label class="col-sm-3 col-form-label">Vitesse :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="vitesse" placeholder="Vitesse" required>
					    </div> <br/> <br>
					</div>					
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
				        <!-- <button type="submit" class="btn btn-primary" >Enregistrer</button> -->
				        <button type="button" class="btn btn-primary" id="submitFormBtn">Enregistrer</button>
				      </div>
              </form>
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function() {
    $('#typeForm').change(function() {
        var selectedType = $(this).val();
        if (selectedType === 'ordinateur') {
            $('#ordinateurFields').show();
           // $('#imprimanteFields').hide();
            $('#imprimanteFields').hide().find('input').val('0'); // Masquer les champs d'imprimante et assigner une valeur par défaut
        } else if (selectedType === 'imprimante') {
            $('#imprimanteFields').show();
           // $('#ordinateurFields').hide();
            $('#ordinateurFields').hide().find('input').val('0'); // Masquer les champs d'ordinateur et assigner une valeur par défaut       
        }
    });

    $('#submitFormBtn').click(function() {
        // Vérifier le type de besoin sélectionné
        var selectedType = $('#typeForm').val();
        var formValid = true;

        if (selectedType === 'ordinateur') {
            // Vérifier si tous les champs requis pour l'ordinateur sont remplis
            $('#ordinateurFields :input[required]').each(function() {
                if ($(this).val() === '') {
                    formValid = false;
                    return false; // Sortir de la boucle each si un champ est vide
                }
            });
        } else if (selectedType === 'imprimante') {
            // Vérifier si tous les champs requis pour l'imprimante sont remplis
            $('#imprimanteFields :input[required]').each(function() {
                if ($(this).val() === '') {
                    formValid = false;
                    return false; // Sortir de la boucle each si un champ est vide
                }
            });
        }

        // Vérifier si tous les champs requis du formulaire principal sont remplis
        if (!$('#BesoinForm')[0].checkValidity()) {
            formValid = false;
        }

        // Si le formulaire est valide, procéder à l'envoi des données
        if (formValid) {
            ajaxPost();
        } else {
            // Afficher un message d'erreur avec SweetAlert si des champs sont vides
            Swal.fire({
                icon: 'error',
                title: 'Erreur!',
                text: 'Veuillez remplir tous les champs requis.',
            });
        }
    });

    function ajaxPost() {
        var formData = $("#BesoinForm").serialize();
        $.ajax({
            type: "POST",
            contentType: "application/x-www-form-urlencoded",
            url: "envoyerBesoin",
            data: formData,
            success: function(response) {
                console.log(response);
               // alert(JSON.stringify(response));
                Swal.fire({
                    icon: 'success',
                    title: 'Succès!',
                    text: 'Besoin enregistré avec succès!',
                }).then((result) => {
                	// Rediriger l'utilisateur vers la page interface-enseignant après la fermeture de l'alerte
                       // window.location.href = 'http://localhost:4040/interface-enseignant';
                    // Recharger la page après la fermeture de l'alerte
                       window.location.reload();
                });
                $('#envoyerBesoinModal').modal('hide');
            },
            error: function(e) {
                console.log("Erreur: ", e);
               // alert("Erreur lors de l'envoi des données au serveur.");
            }
        });
    }

});
</script>

<!-- 
<script>
$(document).ready(
		function() {

			// SUBMIT FORM
			$("#BesoinForm").submit(function(event) {
				// Prevent the form from submitting via the browser.
				event.preventDefault();
				ajaxPost();
			});

			function ajaxPost() {

				// PREPARE FORM DATA
				/* var formData = {
					type : $("#type").val(),
					appelOffre : $("#appelOffre").val(),
					personnelAdministration : $("#personnelAdministration").val()
				} */
				// Récupérer les données du formulaire en utilisant serialize()
			    var formData = $("#BesoinForm").serialize();
				
				// Afficher les valeurs dans des alertes
				//alert(formData.type);
				//alert(formData.appelOffre);
				//alert(formData.personnelAdministration);

				// DO POST
				$.ajax({
			        type: "POST",
			        contentType: "application/x-www-form-urlencoded",
			        url: "save",
			        //data: JSON.stringify(formData),
			        data: formData, // Supprimer la conversion JSON ici
			        // data: $.param(formData),
			        // dataType: 'json',
			        success: function(response) {
			            console.log(response);
			            // Afficher les données récupérées dans la console ou sur la page
			           // alert(JSON.stringify(response));
			            Swal.fire({
		                    icon: 'success',
		                    title: 'Succès!',
		                    text: 'Besoin enregistré avec succès!',
		                });
		                // Fermer la modal
		                $('#envoyerBesoinModal').modal('hide');
		            },
			        error: function(e) {
			            console.log("Erreur: ", e);
			           // alert("Erreur lors de l'envoi des données au serveur.");
			        }
			    });

			}

		})
</script>
-->
