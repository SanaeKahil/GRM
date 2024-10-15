package myAppSpringBoot.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.FournisseurRepository;

@Service
public class FournisseurService implements FournisseurServiceInterface {
	 @Autowired
	    private FournisseurRepository fournisseurRepository;
	

	    public FournisseurModel findFournisseurById(int id) {
	        return fournisseurRepository.findById(id);
	        
	    }


		@Override
		public FournisseurModel findFournisseurByNomSociete(String nomSociete) {
			// TODO Auto-generated method stub
			 return fournisseurRepository.findFournisseurByNomSociete(nomSociete);
		}


	
	    
	   


}
