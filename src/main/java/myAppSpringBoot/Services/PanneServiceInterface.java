package myAppSpringBoot.Services;

import java.util.List;

import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModel;

public interface PanneServiceInterface {

	public List<PanneModel> getPannesByRessource(RessourceModel ressource);
}
