package myAppSpringBoot.ControllersJSP;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Controllers.GestionAppelOffresController;
import myAppSpringBoot.Controllers.GestionPropositionController;
import myAppSpringBoot.Models.PropositionModel;
import myAppSpringBoot.Models.PropositionModelRespo;
import myAppSpringBoot.Repositories.GestionPropositionRepository;

@Controller

public class GestionPropositionControllerJSP {
	@Autowired
	GestionPropositionController controller;
	@Autowired
	GestionAppelOffresController appelOffresController;
	@GetMapping("/propositions")
	public String toPageGestionProposition(Model model) {
		List<PropositionModelRespo> listProposition=controller.getAllProposition();	
		model.addAttribute("listProposition",listProposition);
		for (PropositionModelRespo propositionModelRespo : listProposition) {
			System.out.println("vv : "+propositionModelRespo.getTotal());
		}
		model.addAttribute("listAppel",appelOffresController.getAllAppelOffres());
		return "Responsable/gestionProposition" ;	
	}
}
