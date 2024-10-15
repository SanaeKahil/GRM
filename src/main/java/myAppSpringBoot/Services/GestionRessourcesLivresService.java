package myAppSpringBoot.Services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Repositories.RessourceRepository;

@Service
public class GestionRessourcesLivresService {
	@Autowired
	RessourceRepository repositoryRessource;

	public List<RessourceModel> getAllRessources() {
		// TODO Auto-generated method stub
		return repositoryRessource.findAll();
	}
	public void saveNumAventaire(RessourceModel model) {
		repositoryRessource.save(model);
	}

}
