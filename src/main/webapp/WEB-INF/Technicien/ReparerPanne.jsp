<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->

<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<!-- Définition de la fenêtre modale -->
<div class="modal fade" id="reparerPanneModal" tabindex="-1" role="dialog" aria-labelledby="reparerPanneModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 800px !important; width: 100% !important; left: 100px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reparerPanneModalLabel">Réparer une panne</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background: none; border: none; font-size: 30px;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Contenu du formulaire pour réparer une panne -->
        <form id="PanneForm">
          <div class="form-group row">
            <label class="col-sm-3 col-form-label">ID Panne :</label>
            <div class="col-sm-9">
              <input type="text" name="id_pan" class="form-control" placeholder="ID Panne" required readonly style = "background-color: #f8f9fa; color: #495057;  cursor: not-allowed;">
            </div>
          </div><br>
           <div class="form-group row">
		     <label class="col-sm-3 col-form-label">Technicien :</label>
		     <div class="col-sm-9">
		      <!-- Champ caché pour stocker l'ID du technicien -->
		        <input type="hidden" name="cin_technicien" value="${sessionScope.Technicien.cin}">
		        <!-- Affichage du nom complet du technicien (lecture seule) -->
		        <input name="technicien" class="form-control" required readonly style="background-color: #f8f9fa; color: #495057; cursor: not-allowed;" value="${sessionScope.Technicien.nom} ${sessionScope.Technicien.prenom} (${sessionScope.Technicien.cin})">		     
		     </div>
		   </div><br>
		    <div class="form-group row">
            <label class="col-sm-3 col-form-label">État Panne :</label>
            <div class="col-sm-9">
              <select name="etat_panne" class="form-control" required onchange="handleStateChange(this)">
                <option value="" disabled selected>Choisir l'état de la panne</option>
                <option value="En cours">En cours</option>
                <option value="Réparée">Réparée</option>
                <option value="Sévère">Sévère</option>
              </select>
            </div>
          </div><br>
          <div class="form-group row" id="frequence_div">
            <label class="col-sm-3 col-form-label">Fréquence :</label>
            <div class="col-sm-9">
              <select name="frequence" class="form-control" required>
                <option value="" disabled selected>Choisir la fréquence</option>
                <option value="Rare">Rare</option>
                <option value="Fréquente">Fréquente</option>
                <option value="Permanente">Permanente</option>
              </select>
            </div>
          </div><br>
          <div class="form-group row" id="ordre_div">
            <label class="col-sm-3 col-form-label">Ordre :</label>
            <div class="col-sm-9">
              <select name="ordre" class="form-control" required>
                <option value="" disabled selected>Choisir l'ordre</option>
                <option value="Défaut du Système">Défaut du Système</option>
                <option value="Défaut du Logiciel Utilitaire">Défaut du Logiciel Utilitaire</option>
                <option value="Défaut du Matériel">Défaut du Matériel</option>
              </select>
            </div>
          </div><br>
          <div class="form-group row" id="constat_div">
            <label class="col-sm-3 col-form-label">Constat :</label>
            <div class="col-sm-9">
              <textarea name="constat" class="form-control" rows="3" placeholder="Constat" required></textarea>
            </div>
          </div><br>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            <!-- <button type="submit" class="btn btn-primary" >Enregistrer</button> -->
            <button type="button" class="btn btn-primary" id="submitFormBtnReparerPanne">Enregistrer</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Votre script JavaScript -->
<script>
    // Lorsque la valeur de l'état de la panne change
    function handleStateChange(select) {
        var etat_panne = select.value;
        if (etat_panne === 'En cours' || etat_panne === 'Réparée') {
            // Masquer les champs Frequence, Ordre, Constat
            $('#frequence_div').hide();
            $('#ordre_div').hide();
            $('#constat_div').hide();
        } else {
            // Afficher les champs Frequence, Ordre, Constat
            $('#frequence_div').show();
            $('#ordre_div').show();
            $('#constat_div').show();
        }
    }
</script>



<script>
  $(document).ready(function() {
    // Lorsque vous cliquez sur le bouton "Enregistrer"
    $('#submitFormBtnReparerPanne').click(function() {
      // Vérifier si tous les champs requis sont remplis
      var isValid = true;
      $('#PanneForm input[required], #PanneForm select[required], #PanneForm textarea[required]').each(function() {
    	// Vérifier si le champ est visible et non vide
          if ($(this).is(":visible") && $.trim($(this).val()) == '') {
          isValid = false;
          return false; // Sortir de la boucle si un champ requis est vide
        }
      });

      // Si des champs sont vides, afficher un message d'erreur
      if (!isValid) {
        Swal.fire({
          title: 'Erreur!',
          text: 'Veuillez remplir tous les champs obligatoires.',
          icon: 'error',
          confirmButtonText: 'OK'
        });
        return; // Arrêter la soumission du formulaire
      }

      // Si tous les champs requis sont remplis, envoyer les données du formulaire au serveur via AJAX
      var formData = $('#PanneForm').serialize();
        // alert(JSON.stringify(formData));
      $.ajax({
        url: 'reparerUnePanne',
        method: 'POST', // Utilisez la méthode POST pour modifier la panne
        // contentType: "application/x-www-form-urlencoded",
        data: formData,
        success: function(response) {
          // Gérer la réponse du serveur si nécessaire
          Swal.fire({
            title: 'Succès!',
            text: 'Les données ont été enregistrées avec succès.',
            icon: 'success',
            confirmButtonText: 'OK'
          }).then((result) => {
            location.reload(); // Recharger la page après la confirmation
          });
        },
        error: function(xhr, status, error) {
          // Gérer les erreurs en cas d'échec de la requête AJAX
          console.error(error);
          Swal.fire({
            title: 'Erreur!',
            text: 'Une erreur s\'est produite lors de l\'enregistrement des données.',
            icon: 'error',
            confirmButtonText: 'OK'
          });
        }
      });
    });
  });
</script>


