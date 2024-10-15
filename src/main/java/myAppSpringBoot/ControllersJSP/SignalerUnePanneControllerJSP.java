package myAppSpringBoot.ControllersJSP;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.PanneRepository;

@RestController
public class SignalerUnePanneControllerJSP {
	
	@Autowired
	private PanneRepository panneRepository;

	@PostMapping(value = "/signalerUnePanne", consumes = "application/x-www-form-urlencoded")
    public void signalerUnePanne(@ModelAttribute PanneModel panne) {
		panne.setEtat_panne("Non réparée"); // l'etat de la panne par defaut
		panneRepository.save(panne);
    }
	
	 @PostMapping("/signalerPanneChef")
	    public void signalerPanne(@RequestParam("ressourceId") String ressourceId,
	                                @RequestParam("selectedDate") String selectedDate) {
		 
		 PanneModel panne=new PanneModel();
	     RessourceModel ressource=new RessourceModel();
	     ressource.setIdRes(Integer.parseInt(ressourceId));
	     panne.setRessource(ressource);
	     panne.setEtat_panne("Non réparée");
	     
	     SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	   	 try {
	            java.util.Date utilDate = formatter.parse(selectedDate);
	            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	            panne.setDate_panne(sqlDate);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }	  
	   	 
	   	 panneRepository.save(panne);
	    }
	
	@PostMapping(value = "/reparerUnePanne", consumes = "application/x-www-form-urlencoded")
    public void reparerUnePanne(@ModelAttribute PanneModel panne, @RequestParam("cin_technicien") String CIN_Tech) {
		// Récupérer l'ID de la panne à partir du modèle
	    int panneId = panne.getId_pan();
	    Optional<PanneModel> panneExistante = panneRepository.findById(panneId);
	    
	    if (panneExistante.isPresent()) {
	        // Si la panne existe déjà
	        PanneModel panneToUpdate = panneExistante.get();
	        
	        UserModel technicien = new UserModel();
	        technicien.setCin(CIN_Tech);
	        
	        // Mettez à jour les attributs nécessaires
	        panneToUpdate.setEtat_panne(panne.getEtat_panne());
	        panneToUpdate.setTechnicien(technicien);
	        
	        panneToUpdate.setFrequence(panne.getFrequence());
	        panneToUpdate.setOrdre(panne.getOrdre());
	        panneToUpdate.setConstat(panne.getConstat());

	        // Enregistrez la panne mise à jour dans la base de données
	        panneRepository.save(panneToUpdate);
	    } else {
	    	// Si la panne n'existe pas déjà, affichez un message d'erreur
	        throw new RuntimeException("La panne avec l'ID " + panneId + " n'existe pas.");
	    }
    }
	
	/*
    @PostMapping("/signalerUnePanne")
    @ResponseBody
    public String signalerUnePanne(@RequestBody String formData) {
        // Traitez les données du formulaire ici
        // Assurez-vous d'ajuster le traitement en fonction de votre logique métier
        
        // Exemple : affichage des données reçues dans la console
        System.out.println(formData);

        // Retournez une réponse au client pour indiquer que le traitement a été effectué avec succès
        return "Panne signalée avec succès !";
    } */
}

