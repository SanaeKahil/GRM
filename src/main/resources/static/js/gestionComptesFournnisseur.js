function modfierInfoFournisseur(idFour,nomSociete, motDePasse, gerant, adresse, lieu, site_internet) {
    var modalContent = `
        <div class="modal fade" id="consulerAppelOffre" tabindex="-1" aria-labelledby="consulerAppelOffreLabel" aria-hidden="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center" id="consulerAppelOffreLabel">Modifier les Informations du Fournisseur</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="fournisseurForm" method="POST" action="/modiferInfoFournnisseur">
                           	<input name="id_four" value="${idFour}" hidden> 
                            <div class="mb-3">
                                <label for="nomSociete" class="form-label">Nom de la société</label>
                                <input type="text" class="form-control" id="nomSociete" name="nomSociete" value="${nomSociete}">
                            </div>
                            <div class="mb-3">
                                <label for="motDePasse" class="form-label">Mot de passe</label>
                                <input type="password" class="form-control" id="motDePasse" name="motDePasse" value="${motDePasse}">
                            </div>
                            <div class="mb-3">
                                <label for="gerant" class="form-label">Gérant</label>
                                <input type="text" class="form-control" id="gerant" name="gerant" value="${gerant}">
                            </div>
                            <div class="mb-3">
                                <label for="adresse" class="form-label">Adresse</label>
                                <input type="text" class="form-control" id="adresse" name="adresse" value="${adresse}">
                            </div>
                            <div class="mb-3">
                                <label for="lieu" class="form-label">Lieu</label>
                                <input type="text" class="form-control" id="lieu" name="lieu" value="${lieu}">
                            </div>
                            <div class="mb-3">
                                <label for="site_internet" class="form-label">Site Internet</label>
                                <input type="text" class="form-control" id="site_internet" name="site_internet" value="${site_internet}">
                            </div>
                            <button type="submit" class="btn btn-primary">Enregistrer</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                    </div>
                </div>
            </div>
        </div>
    `;
    document.body.insertAdjacentHTML('beforeend', modalContent);
    var monModal = new bootstrap.Modal(document.getElementById('consulerAppelOffre'));
    monModal.show();
    monModal._element.addEventListener('hidden.bs.modal', function () {
        document.getElementById('consulerAppelOffre').remove();
    });
}
