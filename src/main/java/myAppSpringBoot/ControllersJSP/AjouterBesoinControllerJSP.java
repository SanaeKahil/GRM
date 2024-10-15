package myAppSpringBoot.ControllersJSP;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Repositories.BesoinRepository;
import myAppSpringBoot.Repositories.ImprimanteRepository;
import myAppSpringBoot.Repositories.OrdinateurRepository;

@RestController
public class AjouterBesoinControllerJSP {
	
	@Autowired
    private BesoinRepository besoinRepository;
    @Autowired
    private OrdinateurRepository ordinateurRepository;
    @Autowired
    private ImprimanteRepository imprimanteRepository;
    
	@PostMapping(value = "/envoyerBesoin", consumes = "application/x-www-form-urlencoded")
    public String traiterRequete(@RequestParam Map<String, String> formData) {     
		String typeBesoin = formData.get("typeForm"); // name="typeForm"
		/* int idAppOff = Integer.parseInt(formData.get("appelOffreForm")); */
		String cinPers = formData.get("personnelForm");
		// System.out.println("typeBesoin ===> "+ typeBesoin);
		
		// BesoinModel besoin = new BesoinModel();
		// AppelOffreModel appelOffre = new AppelOffreModel();
		PersonnelAdministrationModel personnelAdministration = new PersonnelAdministrationModel(); 
		
	    //appelOffre.setId_app_off(idAppOff);
	    personnelAdministration.setCin(cinPers);
		
	    // Enregistrer les caractéristiques spécifiques dans la table appropriée (Ordinateur ou Imprimante)
	    if (typeBesoin.equals("ordinateur")) {
	        OrdinateurModel ordinateur = new OrdinateurModel();
	        ordinateur.setType(typeBesoin);
	        ordinateur.setDemander_par("enseignant");
	       // ordinateur.setAppelOffre(appelOffre);
	        ordinateur.setPersonnelAdministration(personnelAdministration);
		    
	        ordinateur.setCpu(Integer.parseInt(formData.get("cpu")));
	        ordinateur.setDisque_dur(Integer.parseInt(formData.get("disqueDur")));
	        ordinateur.setEcran(Integer.parseInt(formData.get("ecran")));
	        ordinateur.setRam(Integer.parseInt(formData.get("ram")));
	        
	        // Enregistrer les données dans la table Ordinateur
	        ordinateurRepository.save(ordinateur);
	    } else if (typeBesoin.equals("imprimante")) {
	        ImprimanteModel imprimante = new ImprimanteModel();
	        imprimante.setType(typeBesoin);
	        imprimante.setDemander_par("enseignant");
	       // imprimante.setAppelOffre(appelOffre);
	        imprimante.setPersonnelAdministration(personnelAdministration);
	        
	        imprimante.setResolution(Integer.parseInt(formData.get("resolution")));
	        imprimante.setVitesse(Integer.parseInt(formData.get("vitesse")));
	        
	        // Enregistrer les données dans la table Imprimante
	        imprimanteRepository.save(imprimante);
	    } 

	    return "Success"; // Réponse envoyée au client
	}
	

	  /*
		@PostMapping(value = "/save", consumes = "application/x-www-form-urlencoded")
	    public String traiterRequete(@ModelAttribute BesoinModel donnees) {
	        
			System.out.println("Type: " + donnees.getType());
	        System.out.println("Appel d'offre: " + donnees.getAppelOffre().getId_app_off());
	        System.out.println("Personnel: " + donnees.getPersonnelAdministration().getCin());
	        
	        besoinRepository.save(donnees);
	        
	        // Vous pouvez renvoyer une réponse à l'utilisateur, par exemple :
	        return "Données reçues avec succès!";
	    } */
	    /*
		@PostMapping(value = "/save", consumes = "application/x-www-form-urlencoded")
	    public String traiterRequete(@RequestParam Map<String, String> formData) {     
			String typeBesoin = formData.get("typeForm"); // name="typeForm"
			int idAppOff = Integer.parseInt(formData.get("appelOffreForm"));
			String cinPers = formData.get("personnelForm");
			// System.out.println("typeBesoin ===> "+ typeBesoin);
			
			BesoinModel besoin = new BesoinModel();
			AppelOffreModel appelOffre = new AppelOffreModel();
			PersonnelAdministrationModel personnelAdministration = new PersonnelAdministrationModel(); 
			
		    appelOffre.setId_app_off(idAppOff);
		    personnelAdministration.setCin(cinPers);
		    
		    besoin.setType(typeBesoin);
		    besoin.setAppelOffre(appelOffre);
		    besoin.setPersonnelAdministration(personnelAdministration);
	   
		   // Enregistrer le besoin dans la table Besoin et récupérer l'ID généré après l'enregistrement
		    BesoinModel besoinEnregistre = besoinRepository.save(besoin);
		    int idBesoinEnregistre = besoinEnregistre.getId_bes();
		    System.out.println("ID besoin enregistré ===> " + idBesoinEnregistre);
			
		    // Enregistrer les caractéristiques spécifiques dans la table appropriée (Ordinateur ou Imprimante)
		    if (typeBesoin.equals("ordinateur")) {
		        OrdinateurModel ordinateur = new OrdinateurModel();
		        ordinateur.setId_bes(idBesoinEnregistre);
		        ordinateur.setCpu(Integer.parseInt(formData.get("cpu")));
		        ordinateur.setDisque_dur(Integer.parseInt(formData.get("disqueDur")));
		        ordinateur.setEcran(Integer.parseInt(formData.get("ecran")));
		        ordinateur.setRam(Integer.parseInt(formData.get("ram")));
		        
		        // Enregistrer les données dans la table Ordinateur
		        ordinateurRepository.save(ordinateur);
		    } else if (typeBesoin.equals("imprimante")) {
		        ImprimanteModel imprimante = new ImprimanteModel();
		        imprimante.setId_bes(idBesoinEnregistre);
		        imprimante.setResolution(Integer.parseInt(formData.get("resolution")));
		        imprimante.setVitesse(Integer.parseInt(formData.get("vitesse")));
		        
		        // Enregistrer les données dans la table Imprimante
		        imprimanteRepository.save(imprimante);
		    } 

		    return "Success"; // Réponse envoyée au client
		} */
		
}
