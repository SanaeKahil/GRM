package myAppSpringBoot.ControllersJSP;
import myAppSpringBoot.Models.*;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import myAppSpringBoot.Controllers.OrdinateurController;
import myAppSpringBoot.Controllers.ImprimanteController;
import myAppSpringBoot.Repositories.BesoinRepository;
import myAppSpringBoot.Repositories.NotificationRepository;

@Controller
public class GererBesoinsControllerJSP {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private BesoinRepository BR;
	
	@Autowired
	 private NotificationRepository NR;
	
	@Autowired
	private OrdinateurController OC;
	
	@Autowired
	private ImprimanteController IC;
	
	@PostMapping("/supprimerBesoin")
	public ModelAndView traiterSuppression( @RequestParam("id") int besoinId, RedirectAttributes redirectAttributes) {
	    	BR.deleteById(besoinId);
	        redirectAttributes.addFlashAttribute("successMessage", "Besoin supprimé avec succès");
	        return new ModelAndView("redirect:/interface-chefDepartement?visibility=true"); // Ajoutez le paramètre visibility à l'URL de redirection
	}
	
	@PostMapping("/modifierBesoin")
	public ModelAndView  traiterModification( @RequestParam String disquedurInput,
                                     @RequestParam String cpuInput,
                                     @RequestParam String ecranInput,
                                     @RequestParam String ramInput,
                                     @RequestParam String resolutionInput,
                                     @RequestParam String vitesseInput,
                                     @RequestParam String besoinId,
                                     @RequestParam String typeInput, 
                                     RedirectAttributes redirectAttributes)
	{
		if("ordinateur".equals(typeInput)) {
			OrdinateurModel newOrdinateur=new OrdinateurModel(Integer.parseInt(cpuInput),Integer.parseInt(disquedurInput),Integer.parseInt(ecranInput),Integer.parseInt(ramInput));
			OC.updateOrdinateur(newOrdinateur,Integer.parseInt(besoinId));
		}
		else if("imprimante".equals(typeInput)) {
			ImprimanteModel newImprimante=new ImprimanteModel(Integer.parseInt(resolutionInput),Integer.parseInt(vitesseInput));
			IC.updateImprimante(newImprimante, Integer.parseInt(besoinId));
		}
		redirectAttributes.addFlashAttribute("successMessage", "Besoin modifié avec succès");
        return new ModelAndView("redirect:/interface-chefDepartement?visibility=true");
	}
	
	@PostMapping("/validerBesoins")
	public ModelAndView validerBesoins(RedirectAttributes redirectAttributes) {
	    List<BesoinModel> listBesoins = (List<BesoinModel>) session.getAttribute("listBesoins");
	    
	    UserModel responsable=(UserModel) session.getAttribute("responsable");
	    UserModel chefDepartement = (UserModel) session.getAttribute("ChefDepartement");
	    List<PersonnelAdministrationModel> listPersonnels=(List<PersonnelAdministrationModel>) session.getAttribute("listPersonnels");
	    
	    
	    StringBuilder message = new StringBuilder("Liste des affectations :\n");

	    for (BesoinModel besoin : listBesoins) {
	    	message.append(besoin.getPersonnelAdministration().getNom()).append(" ").append(besoin.getPersonnelAdministration().getPrenom()).append(" - >");
	        message.append(besoin.getType()).append(": ");

	        if (besoin.getType().equals("ordinateur")) {
	            OrdinateurModel ordinateur = (OrdinateurModel) besoin;
	            message.append("CPU:").append(ordinateur.getCpu()).append(", ");
	            message.append("RAM:").append(ordinateur.getRam()).append(", ");
	            message.append("DD:").append(ordinateur.getDisque_dur()).append(", ");
	            message.append("Écran:").append(ordinateur.getEcran()).append(".");
	        } else {
	            ImprimanteModel imprimante = (ImprimanteModel) besoin;
	            message.append("Vitesse:").append(imprimante.getVitesse()).append(", ");
	            message.append("Résolution:").append(imprimante.getResolution()).append(".");
	        }

	        message.append("\n");
	    }
	    
	    String result = message.toString();
	    
	    java.util.Date aujourdhui = new java.util.Date();   
	    java.sql.Date date = new java.sql.Date(aujourdhui.getTime());

	    int etat = 0;
	     
	    for(PersonnelAdministrationModel personnel:listPersonnels) {
	    	if(personnel.getCin()!=chefDepartement.getCin()) {
	    		NotificationModel notif=new NotificationModel();
		    	notif.setDate_notif(date);
		    	notif.setEtat(etat);
		    	notif.setUser_sour(chefDepartement);
		    	notif.setUser_dest(personnel);
		    	notif.setMessage(result);
		    	
		    	NR.save(notif);
	    	}
	    }
	    
	    NotificationModel notif=new NotificationModel();
	    notif.setDate_notif(date);
    	notif.setEtat(etat);
    	notif.setUser_sour(chefDepartement);
    	notif.setUser_dest(responsable);
    	notif.setMessage(result);
    	
    	NR.save(notif);
	    
    	redirectAttributes.addFlashAttribute("successMessage", "Liste d'affectations envoyée avec succès");
	     return new ModelAndView("redirect:/interface-chefDepartement");
	}

}
