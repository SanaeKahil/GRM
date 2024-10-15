package myAppSpringBoot.ControllersJSP;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import myAppSpringBoot.Controllers.GestionAppelOffresController;
import myAppSpringBoot.Controllers.GestionRessourcesLivresController;
import myAppSpringBoot.Controllers.PersonnelAdministrationController;


@Controller
public class GestionRessourcesLivreControllerJSP {
	@Autowired
	GestionRessourcesLivresController controller;
	@Autowired
	PersonnelAdministrationController controller2;
	@Autowired
	GestionAppelOffresController appelOffresController;
	@GetMapping("/ressourcesLivre")
	public String toPageRessourceLivre(Model model) {
		model.addAttribute("listRessource",controller.getAllRessourcesLivre());	
		model.addAttribute("listPersonnel",controller2.getAllPersonnel());
		model.addAttribute("listAppel",appelOffresController.getAllAppelOffres());
		return "Responsable/gestionRessourcesLivres";
	}
//	@PostMapping("/modierEtatAffectation")
//	public String modierEtatAffectation(@RequestParam int idResAff,@RequestParam String etat) {
//		
//		controller.modierEtatAffectation(idResAff,etat);
//		return "redirect:/ressourcesLivre";
//	}
//	
	
}
