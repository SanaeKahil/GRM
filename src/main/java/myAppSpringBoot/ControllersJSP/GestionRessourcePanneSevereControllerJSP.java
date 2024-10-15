package myAppSpringBoot.ControllersJSP;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import myAppSpringBoot.Controllers.GestionRessourcePanneSevereController;
@Controller
public class GestionRessourcePanneSevereControllerJSP {
	@Autowired
	private  GestionRessourcePanneSevereController controller;
	@GetMapping("/gestionRessourceEnPanne")
	public String getMethodName(Model model) {	
		model.addAttribute("list",controller.getAllResssourceEnPanneSevere());
		return "Responsable/gestionRessourceEnPanne";
	}
	
}
