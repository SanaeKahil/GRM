package myAppSpringBoot.ControllersJSP;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import myAppSpringBoot.Controllers.GestionComptesFournnisseurController;
import myAppSpringBoot.Models.FournisseurModel;
@Controller
public class GestionComptesFournnisseurControllerJSP {
	@Autowired
	GestionComptesFournnisseurController controller;
  @GetMapping("/gestionComptesFournnisseur")
  public String toPageGestionComptesFournnisseur(Model model) {
	model.addAttribute("listComptes",controller.getListComptes());
	return "Responsable/gestionComptesFournnisseur";
	  
  }
  @PostMapping("/modiferInfoFournnisseur")
  public String modiferInfoFournnisseur(@ModelAttribute FournisseurModel fournisseurModel) {
	System.out.println("good");
	System.out.println(fournisseurModel);
	controller.ajouterModiferFournniseur(fournisseurModel);
	return "redirect:/gestionComptesFournnisseur";
  }
}
