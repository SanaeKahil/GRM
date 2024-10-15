package myAppSpringBoot.Controllers;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.apache.commons.lang3.ObjectUtils.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.DetailsPropositionModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Models.RessourceModelRespo;
import myAppSpringBoot.Repositories.DetailProposiionRepository;
import myAppSpringBoot.Repositories.RessourceRepository;
import myAppSpringBoot.Services.GestionPropositionService;
import myAppSpringBoot.Services.GestionRessourcesLivresService;
import myAppSpringBoot.Services.PersonnelAdministrationService;

@RestController
public class GestionRessourcesLivresController {
   @Autowired
   private  GestionPropositionService gestionPropositionService;
   @Autowired
   private GestionRessourcesLivresService gestionRessourcesLivresService;
   @Autowired
   private RessourceRepository  repository;
   @Autowired
   private PersonnelAdministrationController controller;
   @Autowired
   private PersonnelAdministrationService service;
   @GetMapping("/getAllRessources")
   public ArrayList<RessourceModelRespo> getAllRessourcesLivre(){	
	   List<DetailsPropositionModel> listDetails= gestionPropositionService.getDetilsProposition();
	   List<RessourceModel> listRessourceModels=gestionRessourcesLivresService.getAllRessources();
	   ArrayList<RessourceModelRespo> list=new ArrayList<>();
	   for (DetailsPropositionModel d : listDetails) {
		   if(d.getProposition().getEtat()!=null && d.getProposition().getEtat().equals("accepter")) {
			   for (RessourceModel r : listRessourceModels) {
				   if(d.getBesoin().getId_bes()==r.getBesoin().getId_bes()) {
					   RessourceModelRespo modelRespo=new RessourceModelRespo(d.getMarque(),d.getPrix());
					   modelRespo.setBesoin(d.getBesoin());
					   modelRespo.setIdRes(r.getIdRes());
					   modelRespo.setNumero_inventaire(r.getNumero_inventaire());
					   modelRespo.setEtat_affect(r.getEtat_affect());
					   modelRespo.setEtat_recep(r.getEtat_recep());
					   modelRespo.setFournisseurModel(d.getProposition().getFournisseur());
					   modelRespo.setDate_garenti(d.getDate_garenti());
					   list.add(modelRespo);
				   }
			 }
		   }
	   }
       return list;
   }
   @GetMapping("/getAllNumInventaire")
   public ArrayList<String> getAllNumInventaire(){	
	   List<RessourceModel> listRessourceModels=gestionRessourcesLivresService.getAllRessources();
	   ArrayList<String> list=new ArrayList<>();
	   for (RessourceModel r : listRessourceModels)
		   list.add(r.getNumero_inventaire());
       
	return list;
   }
	@PostMapping("/saveNumAventaire")
	public String saveNumAventaire(@RequestParam String numero_inventaire,@RequestParam int idRes) {
		RessourceModel model=new RessourceModel();
		for (RessourceModelRespo r : this.getAllRessourcesLivre()) {
			if(r.getIdRes()==idRes) {
				model.setIdRes(idRes);
				model.setNumero_inventaire(numero_inventaire);
				model.setEtat_affect(r.getEtat_affect());
				model.setEtat_recep("recue");
				model.setBesoin(r.getBesoin());
			
			}
		}
		gestionRessourcesLivresService.saveNumAventaire(model);
		return "succes";
	}
	@PostMapping("/modiferEtatRoussource")
	public void modiferEtatRoussource(@RequestParam int idRes,@RequestParam boolean etat) {
		Optional<RessourceModel> model=repository.findById(idRes);
		if(etat)
			model.get().setEtat_recep("recue");
		else
			model.get().setEtat_recep("non recue");
		System.err.println(model.get());
		repository.save(model.get());		
	}
	@GetMapping("/allPersonneells")
	public List<PersonnelAdministrationModel> getAllPersonneells() {
	
		return 	 controller.getAllPersonnel();
	}
	@PostMapping("/modierEtatAffectation")
	public void modierEtatAffectation(@RequestParam int idRes,@RequestParam String etat,@RequestParam String cin) {
		Optional<RessourceModel> model=repository.findById(idRes);
		PersonnelAdministrationModel model2=service.getIdDeparByCin(cin);
		model.get().setEtat_affect(etat);
		model.get().getBesoin().setPersonnelAdministration(model2);
		if(etat.equals("Affectée à une personne"))
			model.get().getBesoin().setDemander_par("enseignant");
		else
			model.get().getBesoin().setDemander_par("chef_departement");
		repository.save(model.get());

	}

	
	
}
