package myAppSpringBoot.Controllers;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModelRespo;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.FournisseurNotifsRepository;
import myAppSpringBoot.Repositories.FournisseurRepository;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class GestionRessourcePanneSevereController {
	@Autowired
	private RessourceController ressourceController;
	@Autowired
	private GestionRessourcesLivresController controller;
	@Autowired
	private FournisseurNotifsRepository notifsRepository;
	@Autowired
	private FournisseurRepository fournisseurRepository;
	@Autowired
	HttpSession httpSession;
	public class  PanneRessource{
		private RessourceModelRespo ressourece;
		private PanneModel infoPanne;
		
		public PanneRessource(RessourceModelRespo ressourece, PanneModel infoPanne) {
			super();
			this.ressourece = ressourece;
			this.infoPanne = infoPanne;
		}
		public PanneRessource() {
			// TODO Auto-generated constructor stub
		}
		public RessourceModelRespo getRessourece() {
			return ressourece;
		}
		public void setRessourece(RessourceModelRespo ressourece) {
			this.ressourece = ressourece;
		}
		public PanneModel getInfoPanne() {
			return infoPanne;
		}
		public void setInfoPanne(PanneModel infoPanne) {
			this.infoPanne = infoPanne;
		}
	}
	
	@GetMapping("/getAllResssourceEnPanneSevere")
	public ArrayList<PanneRessource> getAllResssourceEnPanneSevere() {
		ArrayList<PanneRessource> list=new ArrayList<>();
		for (PanneModel panne : ressourceController.getListePannes())
			for (RessourceModelRespo ressource : controller.getAllRessourcesLivre())
				if(panne.getRessource().getIdRes()==ressource.getIdRes() && panne.getEtat_panne().equals("Sévère"))
					list.add(new PanneRessource(ressource,panne));						
		return list;	
	}
	
	@PostMapping("/envoiDemandePanne")
	public void envoiDemande(@RequestParam int idRes,@RequestParam int idFour,@RequestParam boolean etat) {
			FournisseurModel fournisseurModel=fournisseurRepository.findById(idFour);
			UserModel resposable=new UserModel();
			resposable=(UserModel) httpSession.getAttribute("Responsable");
			PanneRessource panneRessource=new PanneRessource();
			for (PanneRessource p : this.getAllResssourceEnPanneSevere()) 
				if(p.getRessourece().getIdRes()==idRes)
					panneRessource=p;
			
		    String datePanne =panneRessource.getInfoPanne().getDate_panne().toString();
	        String frequence =panneRessource.getInfoPanne().getFrequence();
	        String ordre =panneRessource.getInfoPanne().getOrdre();
	        String constat = panneRessource.getInfoPanne().getConstat();
	        String technicien =panneRessource.getInfoPanne().getTechnicien().getNom()+"  "+panneRessource.getInfoPanne().getTechnicien().getPrenom();

	        // Action prévue (réparer ou changer)
	        String action = "changer";
	        if(etat)
	        	action="réparer";
	        StringBuilder message = new StringBuilder();
	        message.append("Nous avons informé qu'une des ressources que vous avez livrées est tombée en panne. La garantie n'a pas expiré. Merci de prendre les mesures nécessaires pour "+action+" la ressource défectueuse dès que possible..\n");
	        message.append("Information ressources : \n");	     
	        message.append("Type :").append(panneRessource.ressourece.getBesoin().getType()).append("\n");
	        message.append("Marque :").append(panneRessource.ressourece.getMarque()).append("\n");
	        message.append("les détails de la panne :\n");
	        message.append("Date de la panne : ").append(datePanne).append("\n");
	        message.append("Fréquence de la panne : ").append(frequence).append("\n");
	        message.append("Ordre de la panne : ").append(ordre).append("\n");
	        message.append("Constat de la panne : ").append(constat).append("\n");
	        message.append("Technicien assigné : ").append(technicien).append("\n\n");
	        String msg=message.toString();
			NotificationModel notificationModel=new NotificationModel(new Date(System.currentTimeMillis()),msg,0, resposable, null, fournisseurModel);
			notifsRepository.save(notificationModel);
	}
	
}
