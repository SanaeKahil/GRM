package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.RessourceRepository;

@Service
public class RessourceService implements RessourceServiceInterface {
	
	@Autowired
    private RessourceRepository ressourceRepository;
	
	// Récupère tous les ressources de la base de données
    // @Override
    public List<RessourceModel> getAllRessources() {
        return ressourceRepository.findAll();
    }

}
