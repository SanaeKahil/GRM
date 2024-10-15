package myAppSpringBoot.Controllers;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Models.DetailsPropositionModel;
import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PropositionModel;
import myAppSpringBoot.Models.PropositionModelRespo;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.FournisseurRepository;
import myAppSpringBoot.Repositories.NotificationFournisseurRepository;
import myAppSpringBoot.Services.GestionPropositionService;
import org.springframework.web.bind.annotation.RequestBody;




@RestController
public class GestionPropositionController {

	@Autowired
	GestionPropositionService gestionPropositionService;
	@Autowired
	NotificationFournisseurRepository fournisseurRepository;
	@Autowired
	HttpSession httpSession;
	@Autowired
	FournisseurRepository fournisseurRepository2;
	@GetMapping("/getAllProposition")
	public List<PropositionModelRespo> getAllProposition(@RequestParam Long appelOffreId) {
		ArrayList<PropositionModelRespo> listProposition=new ArrayList<>();
		List<DetailsPropositionModel> listDetails=gestionPropositionService.getDetilsProposition();
		for (PropositionModel pr : gestionPropositionService.getAllProposition()) {
			PropositionModelRespo model=new PropositionModelRespo(pr.getId_prop(),pr.getDate_livraison(),pr.getTotal(),pr.getEtat(),pr.getAppelOffre(),pr.getFournisseur());
			for (DetailsPropositionModel details : listDetails)
				if(details.getProposition().getId_prop()==pr.getId_prop())
					model.getDetails().add(details);
			if(model.getAppelOffre().getId_app_off()==appelOffreId)
				listProposition.add(model);
			System.out.println(model);
			
		}
		System.out.println(appelOffreId);
		return listProposition;
	}
	@GetMapping("/getAllPropositionJSP")
	public List<PropositionModelRespo> getAllProposition() {
		ArrayList<PropositionModelRespo> listProposition=new ArrayList<>();
		List<DetailsPropositionModel> listDetails=gestionPropositionService.getDetilsProposition();
		for (PropositionModel pr : gestionPropositionService.getAllProposition()) {
			PropositionModelRespo model=new PropositionModelRespo(pr.getId_prop(),pr.getDate_livraison(),pr.getTotal(),pr.getEtat(),pr.getAppelOffre(),pr.getFournisseur());
			for (DetailsPropositionModel details : listDetails)
				if(details.getProposition().getId_prop()==pr.getId_prop())
					model.getDetails().add(details);
		    listProposition.add(model);
		}
		return listProposition;
	}
	@GetMapping("/getNotification")
	public List<NotificationModel> getNotif() {
			return fournisseurRepository.findAll();
	}
	@PostMapping("/reponseProposition")
	public boolean reponseProposition(@RequestParam int idPro,@RequestParam int idFour,@RequestParam boolean etat) {
		UserModel resposable=new UserModel();
		resposable=(UserModel) httpSession.getAttribute("Responsable");
		System.out.println(resposable.getCin());
		ArrayList<BesoinModel> besoins=new ArrayList<>();
		FournisseurModel fournisseurModel=new FournisseurModel();
		PropositionModel propostion = null;
		System.out.println(idPro+" : "+idFour+" : "+etat);
		for (PropositionModelRespo  pr:this.getAllProposition()) {
			if(pr.getId_prop()==idPro) {
				fournisseurModel=pr.getFournisseur();
				propostion=new PropositionModel(pr.getId_prop(),pr.getDate_livraison(),pr.getTotal(),pr.getEtat(),pr.getAppelOffre(),pr.getFournisseur());
				for (DetailsPropositionModel detail : pr.getDetails())
						besoins.add(detail.getBesoin());
			}
		}
		Date dateActuel=new Date(System.currentTimeMillis());
		NotificationModel notif=new NotificationModel(dateActuel,"",0,resposable,null,fournisseurModel);
		ArrayList<RessourceModel> listRessource=new ArrayList<>();
		for (BesoinModel besoinModel : besoins) {
			RessourceModel model=new RessourceModel();
			model.setBesoin(besoinModel);
			listRessource.add(model);
			System.out.println(besoinModel.getType()+"dddd");
		
		}
		for (RessourceModel ressourceModel : listRessource) {
			System.out.println(ressourceModel.getBesoin().getType());
		}
         try {
        	String type="ar";//type notification 'ar' sgnifie que c'est une notification pour acceptation ou refuser proposition
        	gestionPropositionService.notificationToFournisseur(notif,etat,type);
        	gestionPropositionService.accepteRefuseProposition(propostion, etat,listRessource);        
        	return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}	
	
	}
	@PostMapping("/modiferEtatFournisseur")
	public boolean modiferEtatFournisseur(@RequestParam int id_four,@RequestParam boolean etat) {

			FournisseurModel fournisseurModel=new FournisseurModel();
			fournisseurModel=fournisseurRepository2.findById(id_four);
			UserModel resposable=new UserModel();
			resposable=(UserModel) httpSession.getAttribute("Responsable");
			Date dateActuel=new Date(System.currentTimeMillis());
			int etatFour=0;
			if(etat)
				etatFour=1;		
			fournisseurModel.setEtat(etatFour);
			fournisseurRepository2.save(fournisseurModel);
			NotificationModel notif=new NotificationModel(dateActuel,"",0,resposable,null,fournisseurModel);
			String type="e";//type notification 'e' sgnifie que c'est une notification pour liste noire
			gestionPropositionService.notificationToFournisseur(notif, etat, type);
			return true;
	}
	@PostMapping("/ajouterInfoFournisseur")
	public String ajouterInfoFournisseur(@RequestParam int id_four,@RequestParam String site_internet,@RequestParam String adresse,@RequestParam String gerant,@RequestParam String lieu) {
		FournisseurModel fournisseurModel=fournisseurRepository2.findById(id_four);
		fournisseurModel.setAdresse(adresse);
		fournisseurModel.setLieu(lieu);
		fournisseurModel.setGerant(gerant);
		fournisseurModel.setSite_internet(site_internet);
		gestionPropositionService.ajouterInfoFournisseur(fournisseurModel);
		return "succes";
	}

	
	
}
