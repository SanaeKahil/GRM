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
<div class="modal fade" id="signalerPanneModal" tabindex="-1" role="dialog" aria-labelledby="signalerPanneModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 800px !important; width: 100% !important; left: 100px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="signalerPanneModalLabel">Signaler une panne</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background: none; border: none; font-size: 30px;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Contenu du formulaire pour signaler une panne -->
        <form id="PanneForm">
          <div class="form-group row">
            <label class="col-sm-3 col-form-label">ID Ressource :</label>
            <div class="col-sm-9">
              <input type="text" name="ressource" class="form-control" placeholder="Numéro Inventaire" required readonly style = "background-color: #f8f9fa; color: #495057;  cursor: not-allowed;">
            </div>
          </div><br>
          <div class="form-group row">
            <label class="col-sm-3 col-form-label">Date Panne :</label>
            <div class="col-sm-9">
              <input type="date" name="date_panne" class="form-control" required>
            </div>
          </div><br>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            <!-- <button type="submit" class="btn btn-primary" >Enregistrer</button> -->
            <button type="button" class="btn btn-primary" id="submitFormBtnPanne">Enregistrer</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>


<script>
  $(document).ready(function() {
    // Lorsque vous cliquez sur le bouton "Enregistrer"
    $('#submitFormBtnPanne').click(function() {
      // Vérifier si tous les champs requis sont remplis
      var isValid = true;
      $('#PanneForm input[required], #PanneForm select[required], #PanneForm textarea[required]').each(function() {
        if ($.trim($(this).val()) == '') {
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
        url: 'signalerUnePanne',
        method: 'POST',
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


