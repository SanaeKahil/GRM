package myAppSpringBoot.Services;

import java.util.List;
import java.util.Optional;

import myAppSpringBoot.Models.OrdinateurModel;

public interface OrdinateurServiceInterface {
	
	public List<OrdinateurModel> getAllOrdinateurs();
	public void updateOrdinateur(OrdinateurModel ordinateurModel,int id_bes);
	Optional<OrdinateurModel> getOrdinateurById(int id_bes);
}
