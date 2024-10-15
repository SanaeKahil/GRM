function envoyerDemande(idRes,idFour){
	reparer=$("#reparer"+idRes).is(":checked")
	$.ajax({
				      url:"/envoiDemandePanne", 
				      type: 'POST',
				      data: {
						  	idRes :idRes,				      		 
				      		idFour : idFour,
				      		etat :reparer      		
				      	},
				      success: function(data) {
				       			    Swal.fire({
								      icon: 'success',
								      title: 'Succès !',
								      text: 'Votre modification a été effectuée avec succès.',
								      confirmButtonText: 'Fermer'
								    });
				        console.log(data);
				        
				      },
				      error: function(xhr, status, error) {
				        console.error(error);
						 Swal.fire({
						      icon: 'error',
						      title: 'Erreur !',
						      text: 'Une erreur est survenue lors de la modification.',
						      confirmButtonText: 'Fermer'
						    });
							       
				      }
				    });   
}