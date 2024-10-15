package myAppSpringBoot.ControllersJSP;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.BesoinRepository;
import myAppSpringBoot.Repositories.ImprimanteRepository;
import myAppSpringBoot.Repositories.OrdinateurRepository;

@RestController
public class AjouterBesoinDeparControllerJSP {
	
	@Autowired
	private HttpSession session;
	@Autowired
    private BesoinRepository besoinRepository;
    @Autowired
    private OrdinateurRepository ordinateurRepository;
    @Autowired
    private ImprimanteRepository imprimanteRepository;
    
	
	
	@PostMapping(value = "/saveBesoinDepar", consumes = "application/x-www-form-urlencoded")
    public String traiterRequete(@RequestParam Map<String, String> formData) {     
		String typeBesoin = formData.get("typeForm"); 
		String role = formData.get("role");
	    UserModel chefDepartement = (UserModel) session.getAttribute("ChefDepartement");

		PersonnelAdministrationModel personnelAdministration = new PersonnelAdministrationModel(); 
		
	    personnelAdministration.setCin(chefDepartement.getCin());
		
	    if (typeBesoin.equals("ordinateur")) {
	        OrdinateurModel ordinateur = new OrdinateurModel();
	        ordinateur.setType(typeBesoin);
	        ordinateur.setPersonnelAdministration(personnelAdministration);
		    
	        ordinateur.setCpu(Integer.parseInt(formData.get("cpu")));
	        ordinateur.setDisque_dur(Integer.parseInt(formData.get("disqueDur")));
	        ordinateur.setEcran(Integer.parseInt(formData.get("ecran")));
	        ordinateur.setRam(Integer.parseInt(formData.get("ram")));
	        ordinateur.setDemander_par(role);
	        
	        ordinateurRepository.save(ordinateur);
	    } else if (typeBesoin.equals("imprimante")) {
	        ImprimanteModel imprimante = new ImprimanteModel();
	        imprimante.setType(typeBesoin);
	        imprimante.setPersonnelAdministration(personnelAdministration);
	        
	        imprimante.setResolution(Integer.parseInt(formData.get("resolution")));
	        imprimante.setVitesse(Integer.parseInt(formData.get("vitesse")));
	        imprimante.setDemander_par(role);
	        
	        imprimanteRepository.save(imprimante);
	    } 

	    return "Success"; 
	}
		
}
