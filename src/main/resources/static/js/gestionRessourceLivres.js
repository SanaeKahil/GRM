function getRessources() {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: "/getAllNumInventaire",
            type: 'GET',
            success: function(data) {
				
                resolve(data); // Renvoyer les données lorsque la requête réussit
            },
            error: function(xhr, status, error) {
                console.error(error);
                reject(error); // Rejeter avec l'erreur lorsque la requête échoue
            }
        });
    });
}
function verfie(input,idRes){ //verfication  si numInventaire unique
	var divVide=$("#vide"+idRes)
		const values = $('.numInv').map(function() {
    return $(this).val();
}).get();
	const index = values.indexOf(input.value);
    values.splice(index, 1);//supprimer la valeur en cours de saisir
    console.log(values)
	getRessources().then(function(data) {
		if(data.includes(input.value) | values.includes(input.value)){
			divVide.text(input.value+" deja exite")
			divVide.show()
			$("#submit").prop("disabled",true)
		}
		else{
			divVide.hide();
			$("#submit").prop("disabled",false)			
		}

	   	console.log(data)
	}).catch(function(error) {
	    console.error(error); // Gérer les erreurs ici
	});	
}
function submitModif(){
	const numInv = $('.numInv');
	const idRes = $('.idRes');
	const data = [];
	if (numInv.length === idRes.length) {
	    numInv.each(function(index) {
	        const num = $(this).val();
	        const id = idRes.eq(index).val();        
	        envoiAuserveur(id,num);
	    });
	} else {
	    console.error("Le nombre d'éléments dans les deux classes est différent.");
	}	
}
function envoiAuserveur(idRes,numero_inventaire){
	$.ajax({
	            url: "/saveNumAventaire",
	            type: 'POST',
	            data : {numero_inventaire : numero_inventaire,idRes:idRes},
	            success: function(data) {				
			    Swal.fire({
			      icon: 'success',
			      title: 'Succès !',
			      text: 'Votre modification a été effectuée avec succès.',
			      confirmButtonText: 'Fermer'
			    });
			    },
	            error: function(xhr, status, error) {
	                console.error(error);
	                 
			    Swal.fire({
			      icon: 'error',
			      title: 'Erreur !',
			      text: 'Une erreur est survenue lors de la modification.',
			      confirmButtonText: 'Fermer'

	            })
	            }
	        });
}

function modiferEtatRoussource(idRes){
		$.ajax({
	            url: "/modiferEtatRoussource",
	            type: 'POST',
	            data : {etat : $("#oui_"+idRes).is(":checked"),idRes:idRes},
	            success: function(data) {				
			    },
	            error: function(xhr, status, error) {
	                console.error(error);
	                 
	            }
	        });
}
function getAllPersoone() {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: "/allPersonneells",
            type: 'GET',
            success: function(data) {
				
                resolve(data); // Renvoyer les données lorsque la requête réussit
            },
            error: function(xhr, status, error) {
                console.error(error);
                reject(error); // Rejeter avec l'erreur lorsque la requête échoue
            }
        });
    });
}
function modiferEtatAffectation(role,idRes,nom,prenom,cin,depratement,demandePar){
   
   
    var b=$("#affecteoui_"+idRes).is(":checked");
   
   if(b){ //ressource est affecter
   $("#cinS").val(cin);
   $("#nomS").val(cin);
   $("#prenomS").val(cin);
    document.getElementById("depP").innerText=depratement;
	if(demandePar=="enseignant"){
		
/*		document.getElementById("demande").innerText="enseignant"
		document.getElementById("nom").innerText =nom;
	    document.getElementById("prenom").innerText =prenom;
	    document.getElementById("cin").innerText =cin;*/
	    $("#affecDep").hide();
	     $("#etatAff").val("Affectée à une personne");
	     if(role=="ChefDepartement")
	     	$("#affecDep").show();
	     $("#role").text("role : "+role)
	    
	} 	
    else{
/*    	document.getElementById("demande").innerText="Departement";
		document.getElementById("nomP").innerText ="";
	    document.getElementById("prenomP").innerText ="";
	    document.getElementById("cinP").innerText ="";	*/
	    $("#etatAff").val("Affectée à un département");	
	    $("#affecDep").show();
	     $("#role").text("role : "+role)
	    $("#tousDepartementsOui").attr({'checked' : "checked"})
	}
   }else{
/*	   document.getElementById("depP").innerText="";
	    $("#etatAff").val("non affecter");
	    document.getElementById("demande").innerText=""*/
	    document.getElementById("msg").innerText="vous etes sur de retire affectation "
		document.getElementById("nomP").innerText ="";
	    document.getElementById("prenomP").innerText ="";
	    document.getElementById("cinP").innerText ="";	
   }
	$("#idResAff").val(idRes)
    $('#affectation').modal('show');
}


function modiferSelect(element){
	getAllPersoone().then(function(data) {
		var personnel = data.find(function(objet) {
    			return objet.cin ===element.value;
			});
		   $("#cinS").val(personnel.cin);
		   $("#nomS").val(personnel.cin);
		   $("#prenomS").val(personnel.cin);
		   if(personnel.roles=="ChefDepartement"){
		   		 $("#affecDep").show();
		   		  $("#role").text("role : chef departement ")		
		   		     
		   }
		   else{
		   	 	 $("#affecDep").hide();
		   		 	  $("#role").text("role : enseignant")
		   		 	  
		   	}

	}).catch(function(error) {
	    console.error(error); // Gérer les erreurs ici
	});	
}


function confirmerAffectaion(){
	console.log()
$("#affectation").modal('hide');
  $("#etatAff").val("Affectée à une personne");
if($("#tousDepartementsOui").is(":checked"))
	  $("#etatAff").val("Affectée à un département");		
	$.ajax({
	    url: "/modierEtatAffectation",
	    type: 'POST',
	    data : {etat : $("#etatAff").val(),idRes:$("#idResAff").val(),cin : $("#cinS").val()},
	    success: function(data) {	
			Swal.fire({
			      icon: 'success',
			      title: 'Succès !',
			      text: 'Votre modification a été effectuée avec succès.',
			      confirmButtonText: 'Fermer'
			    });		
	    },
	    error: function(xhr, status, error) {
	        console.error(error);
	        			    Swal.fire({
			      icon: 'error',
			      title: 'Erreur !',
			      text: 'Une erreur est survenue lors de la modification.',
			      confirmButtonText: 'Fermer'

	            })
	         
	    }
	});	
}

function getAllRessource() {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: "/getAllRessources",
            type: 'GET',
            success: function(data) {
				
                resolve(data); // Renvoyer les données lorsque la requête réussit
              

            },
            error: function(xhr, status, error) {
                console.error(error);
                reject(error); // Rejeter avec l'erreur lorsque la requête échoue
            }
        });
    });
}
function updateTable(listRessources) {
    // Sélectionnez le corps du tableau où vous souhaitez mettre à jour les données
    var tbody = $('.table tbody');
    
    // Effacez le contenu actuel du corps du tableau
    tbody.empty();

    // Parcourez la liste de ressources et créez une nouvelle ligne pour chaque ressource
    $.each(listRessources, function(index, ressource) {
        // Créez une nouvelle ligne de tableau
        var tr = $('<tr>');

        // Créez et remplissez chaque cellule de la ligne de tableau avec les données de la ressource
        var tdAppelOffre = $('<td>').text(ressource.besoin.appelOffre.nom);
        var tdType = $('<td>').text(ressource.besoin.type);
        var tdMarque = $('<td>').text(ressource.marque);
        var tdPrix = $('<td>').text(ressource.prix);

        var inputNumeroInventaire = $('<input>', {
            type: 'text',
            name: 'numero_inventaire',
            class: 'form-control numInv',
            value: ressource.numero_inventaire,
            id: 'num' + ressource.idRes,
            oninput: 'verfie(this,' + ressource.idRes + ')'
        });
        var divVide = $('<div>', {
            id: 'vide' + ressource.idRes,
            class: 'vide',
            css: { display: 'none' }
        });

        var tdNumeroInventaire = $('<td>').append(inputNumeroInventaire, divVide);
var isRecu=ressource.etat_recep=="recue"

var radioLivraison = $('<input>', {
            type: 'radio',
            class: 'form-check-input',
            name: 'recue_' + ressource.idRes,
            id: 'oui_' + ressource.idRes,
            checked : isRecu,
            onclick : 'modiferEtatRoussource("'+ressource.idRes+'")'
        });
        var labelOuiLivraison = $('<label>', {
            class: 'form-check-label',
            for: 'oui_' + ressource.idRes
        }).text('Recue');
        var radioNonLivraison = $('<input>', {
            type: 'radio',
            class: 'form-check-input',
            name: 'recue_' + ressource.idRes,
            id: 'non_' + ressource.idRes,
            checked : !isRecu,
            onclick : 'modiferEtatRoussource("'+ressource.idRes+'")'
            
        });
        var isAffecter=ressource.etat_affect=="Affectée à un département" || ressource.etat_affect=="Affectée à une personne"
        var labelNonLivraison = $('<label>', {
            class: 'form-check-label',
            for: 'non_' + ressource.idRes
        }).text('Non Recue');
        var divLivraison = $('<div>', {
            class: 'form-check form-check-inline ml-5'
        }).append(radioLivraison, labelOuiLivraison);
        var divNonLivraison = $('<div>', {
            class: 'form-check form-check-inline'
        }).append(radioNonLivraison, labelNonLivraison);
        var tdLivraison = $('<td>').append(divLivraison, divNonLivraison);

     
        var radioAffectation = $('<input>', {
            type: 'radio',
            class: 'form-check-input',
            name: 'affecte_' + ressource.idRes,
            id: 'affecteoui_' + ressource.idRes,
            checked : isAffecter,
            onclick : 'modiferEtatAffectation("'+ressource.besoin.personnelAdministration.roles+'","'+ressource.idRes+'","'+ressource.besoin.personnelAdministration.nom+'","'+ressource.besoin.personnelAdministration.prenom+'","'+ressource.besoin.personnelAdministration.cin+'","'+ressource.besoin.personnelAdministration.departement.nom_depart+'","'+ressource.besoin.demander_par+'")'
        });
        var labelOuiAffectation = $('<label>', {
            class: 'form-check-label',
            for: 'affecteoui_' + ressource.idRes
        }).text('Affecte');
        var radioNonAffectation = $('<input>', {
            type: 'radio',
            class: 'form-check-input',
            name: 'affecte_' + ressource.idRes,
            id: 'affectenon_' + ressource.idRes,
            checked : !isAffecter,
            onclick : 'modiferEtatAffectation("'+ressource.besoin.personnelAdministration.roles+'","'+ressource.idRes+'","'+ressource.besoin.personnelAdministration.nom+'","'+ressource.besoin.personnelAdministration.prenom+'","'+ressource.besoin.personnelAdministration.cin+'","'+ressource.besoin.personnelAdministration.departement.nom_depart+'","'+ressource.besoin.demander_par+'")'

        });
        var labelNonAffectation = $('<label>', {
            class: 'form-check-label',
            for: 'affectenon_' + ressource.idRes
        }).text('Non Affecte');
        var divAffectation = $('<div>', {
            class: 'form-check form-check-inline ml-5'
        }).append(radioAffectation, labelOuiAffectation);
        var divNonAffectation = $('<div>', {
            class: 'form-check form-check-inline'
        }).append(radioNonAffectation, labelNonAffectation);
        var tdAffectation = $('<td>').append(divAffectation, divNonAffectation);

       
        var detailsLink = $('<a>', {
            'data-bs-toggle': 'modal',
            'data-bs-target': '#d' + ressource.idRes,
            style: 'color: #000; cursor: pointer; text-decoration: underline;',
            text: 'Plus de détails'
        });
        var tdDetails = $('<td>').append(detailsLink);

       
        tr.append(tdAppelOffre, tdType, tdMarque, tdPrix, tdNumeroInventaire, tdLivraison, tdAffectation, tdDetails);

       
        tbody.append(tr);
    });
}

  var tableauResultats = [];
$(document).ready(function() {
	 var selectedAppelOffre
    $('#selectAppelOffre1').change(function() {
        selectedAppelOffre= $(this).val();
        console.log(selectedAppelOffre);
    
		getAllRessource()
		    .then(function(data) {		
				   
		        tableauResultats = data; 
		    })
		    .catch(function(error) {
		        console.error("Erreur lors de la récupération des données :", error);
		    });
		    
var resultatsFiltres =[]
if(selectedAppelOffre!="all"){
tableauResultats.forEach(function(ressource){

	 	if(ressource.besoin.appelOffre.id_app_off==selectedAppelOffre){				
			resultatsFiltres.push(ressource);

 }	
})
updateTable(resultatsFiltres)
}else
	updateTable(tableauResultats)


    });



    
});




