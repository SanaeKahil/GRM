package myAppSpringBoot.Controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Repositories.FournisseurRepository;
import myAppSpringBoot.Services.GestionPropositionService;
@RestController
public class GestionComptesFournnisseurController {
	@Autowired
	FournisseurRepository repository;
	@Autowired
	GestionPropositionService service;
	@GetMapping("/getAllFournnisseur")
	public List<FournisseurModel> getListComptes() {
		// TODO Auto-generated method stub
		return repository.findAll();
	}
	public void ajouterModiferFournniseur(FournisseurModel fournisseurModel) {
		// TODO Auto-generated method stub
		service.ajouterInfoFournisseur(fournisseurModel);
	}

}
