<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
    .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.5);
            width: 80%;
            max-width: 600px;
            padding: 20px;
            border-radius: 5px;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .modal-header h5 {
            margin: 0;
            font-size: 18px;
        }

        .modal-header .close {
            cursor: pointer;
            font-size: 24px;
            color: #888;
        }

        .modal-body {
            margin-bottom: 20px;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
        }

        .modal-footer button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .modal-footer button:hover {
            background-color: #0056b3;
}
</style>
 <div class="modal" id="envoyerBesoinModal">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="envoyerBesoinModalLabel">Enregistrer le besoin</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background: none; border: none; font-size: 30px;">&times;</button>
        </div>
        <div class="modal-body">
         <form id="BesoinForm" action="/ajouterBesoinDepar" method="post">
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
	            
					<div class="form-group row" id="ordinateurFields">
					    <label class="col-sm-3 col-form-label">CPU :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="cpu" min="0" placeholder="CPU" required>
					    </div>
					    <label class="col-sm-3 col-form-label">Disque Dur :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="disqueDur"  min="0" placeholder="Disque Dur" required>
					    </div> <br/> <br/>
					    <label class="col-sm-3 col-form-label">Écran :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="ecran" min="0" placeholder="Écran" required>
					    </div>
					    <label class="col-sm-3 col-form-label">RAM :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="ram" min="0" placeholder="RAM" required>
					    </div> <br/> <br>
					</div>
			        
			        <div class="form-group row" id="imprimanteFields" style="display: none;">
					    <label class="col-sm-3 col-form-label">Resolution :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="resolution" min="0" placeholder="Resolution" required>
					    </div>
					    <label class="col-sm-3 col-form-label">Vitesse :</label>
					    <div class="col-sm-3">
					        <input type="number" class="form-control" name="vitesse" min="0" placeholder="Vitesse" required>
					    </div> <br/> <br>
					</div>				
					
					<div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="enseignantRadio" value="enseignant" style="margin-top:20px">
                            <label class="form-check-label" for="enseignantRadio" style="margin-top:20px">Enseignant</label>
                    </div>
                    <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="role" id="chefDepartementRadio" value="chef_departement" style="margin-top:20px">
                            <label class="form-check-label" for="chefDepartementRadio" style="margin-top:20px">Chef de département</label>
                    </div>	
				    <div class="modal-footer">
				        <button type="button" class="btn btn-primary" id="submitFormBtn">Enregistrer</button>
				      </div>
              </form>
      </div>
    </div>
</div>
<script>
$(document).ready(function() {
	var modal = $("#modal");
	var closeBtn = $(".close");
	
    $('#typeForm').change(function() {
        var selectedType = $(this).val();
        if (selectedType === 'ordinateur') {
            $('#ordinateurFields').show();
            $('#imprimanteFields').hide().find('input').val('0'); 
        } else if (selectedType === 'imprimante') {
            $('#imprimanteFields').show();
            $('#ordinateurFields').hide().find('input').val('0');      
        }
    });

    closeBtn.click(function() {
	    modal.css("display", "none");
	  });
    
    $('#submitFormBtn').click(function() {
        var selectedType = $('#typeForm').val();
        var formValid = true;
        var roleSelected = false; 
        var errorMessage = ''; 

        if (!selectedType) {
            formValid = false;
            errorMessage += 'Veuillez sélectionner un type de besoin (ordinateur ou imprimante).\n';
        }

        if (selectedType === 'ordinateur') {
            $('#ordinateurFields :input[required]').each(function() {
                if ($(this).val() === '') {
                    formValid = false;
                    errorMessage += 'Veuillez remplir tous les champs requis.\n';
                    return false;
                }
            });
        } else if (selectedType === 'imprimante') {
            $('#imprimanteFields :input[required]').each(function() {
                if ($(this).val() === '') {
                    formValid = false;
                    errorMessage += 'Veuillez remplir tous les champs requis.\n';
                    return false;
                }
            });
        }

        if (!$('#enseignantRadio').prop('checked') && !$('#chefDepartementRadio').prop('checked')) {
            roleSelected = false;
            errorMessage += 'Veuillez sélectionner un rôle.\n';
        } else {
            roleSelected = true;
        }

        if (!formValid || !roleSelected) {
            $('#envoyerBesoinModal').modal('hide');
            Swal.fire({
                icon: 'error',
                title: 'Erreur!',
                text: errorMessage,
            });
        } else {
            ajaxPost();
        }
    });

    function ajaxPost() {
        var formData = $("#BesoinForm").serialize();
        $.ajax({
            type: "POST",
            contentType: "application/x-www-form-urlencoded",
            url: "saveBesoinDepar",
            data: formData,
            success: function(response) {
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Succès!',
                    text: 'Besoin enregistré avec succès!',
                }).then((result) => {
                       window.location.reload();
                });
                $('#envoyerBesoinModal').modal('hide');
            },
            error: function(e) {
                console.log("Erreur: ", e);
            }
        });
    }
});
</script>