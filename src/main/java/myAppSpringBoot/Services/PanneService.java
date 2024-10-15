package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Repositories.PanneRepository;

@Service
public class PanneService implements PanneServiceInterface{
	@Autowired
	private PanneRepository panneRepository;

	@Override
	public List<PanneModel> getPannesByRessource(RessourceModel ressource) {
		return panneRepository.findByRessource(ressource);
	}
}
