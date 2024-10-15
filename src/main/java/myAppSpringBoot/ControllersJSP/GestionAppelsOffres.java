package myAppSpringBoot.ControllersJSP;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import antlr.collections.List;
import myAppSpringBoot.Controllers.BesoinController;
import myAppSpringBoot.Controllers.GestionAppelOffresController;
import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.AppelOffreModelRespo;
import myAppSpringBoot.Models.BesoinModel;


@Controller
public class GestionAppelsOffres {
	
	@Autowired
	private GestionAppelOffresController appelOffresController;
	@Autowired
	private BesoinController besoinController;
	@GetMapping("/gestionAppelOffre")
	public String toPageGestionAppelOffre(Model model) {	
		ArrayList<AppelOffreModelRespo> list=appelOffresController.getAllAppelOffres();
		 int lastIdAppelOffre=0;
		if(list.size()>0)
			lastIdAppelOffre=list.get(list.size()-1).getId_app_off();
		model.addAttribute("lastIdAppelOffre",lastIdAppelOffre);
		model.addAttribute("listAppelOffres",list);
		ArrayList<BesoinModel> arrayList=new ArrayList<>();
		for (BesoinModel besoinModel : besoinController.getAllBesoins())
			if(besoinModel.getAppelOffre()==null) //just les besoins n'affect aucun appelOffre
				arrayList.add(besoinModel);
		model.addAttribute("listBesoins",arrayList);
		return "Responsable/gestionAppelOffre";		
	}

	@PostMapping(value = "/ajouterAppelOffre", consumes = "application/x-www-form-urlencoded")
	public String ajouterAppelOffre(@RequestParam("titre") String titre,
								  @RequestParam("dateDebut") String dateDebuStr,
								  @RequestParam("dateFin") String dateFinStr,
								  @RequestParam("id") int id
			                     ){
	 AppelOffreModelRespo appelOffreModel=new AppelOffreModelRespo(titre,dateDebuStr,dateFinStr);
	 appelOffreModel.setId_app_off(id);
	 System.out.println("jsp : "+appelOffreModel.toString1());
	 appelOffresController.addAppelOffre(appelOffreModel);
	 appelOffresController.setAppelOffreToBesoins(appelOffreModel);
	 return "redirect:/gestionAppelOffre";
	}
}
