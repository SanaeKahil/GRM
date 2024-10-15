package myAppSpringBoot.Services;

import myAppSpringBoot.Models.FournisseurModel;

public interface FournisseurServiceInterface {
	
	public FournisseurModel findFournisseurById(int id_four);
	public FournisseurModel findFournisseurByNomSociete(String lieu);
}
