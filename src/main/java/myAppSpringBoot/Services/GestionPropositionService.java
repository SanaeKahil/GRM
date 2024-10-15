package myAppSpringBoot.Services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Models.DetailsPropositionModel;
import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PropositionModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Repositories.DetailProposiionRepository;
import myAppSpringBoot.Repositories.FournisseurRepository;
import myAppSpringBoot.Repositories.GestionPropositionRepository;
import myAppSpringBoot.Repositories.NotificationFournisseurRepository;
import myAppSpringBoot.Repositories.RessourceRepository;

@Service
public class GestionPropositionService {

	@Autowired
	GestionPropositionRepository gestionPropositionRepository;
	@Autowired
	DetailProposiionRepository detailProposiion;
	@Autowired
	NotificationFournisseurRepository fournisseurRepository;
	@Autowired
	RessourceRepository ressourceRepository;
	@Autowired
	FournisseurRepository fournisseurRepository2;
	public List<PropositionModel> getAllProposition() {
		// TODO Auto-generated method stub
		return gestionPropositionRepository.findAll();
	}
	public List<DetailsPropositionModel> getDetilsProposition(){
		return detailProposiion.findAll();
	}
	public void accepteRefuseProposition(PropositionModel model,boolean etat,ArrayList<RessourceModel> listRessource){
		System.out.println("good");
		for (RessourceModel ressourceModel : listRessource) {
			System.out.println(ressourceModel.getBesoin().getType());
		//	ressourceRepository.save(ressourceModel);		
		
		}
		if(etat){
			model.setEtat("accepter");
			for (RessourceModel ressourceModel : listRessource) {
				System.out.println(ressourceModel.getBesoin().getType());
				ressourceRepository.save(ressourceModel);		
			
			}
			System.out.println(etat);
		}			
		
		else
			model.setEtat("refuse");
		System.out.println(etat);
		System.out.println("good2");
		gestionPropositionRepository.save(model);		
	}
	public void notificationToFournisseur(NotificationModel notif, boolean etat, String type) {
		if(type.equals("ar")) {
			if(etat) //proposition est accepter
				notif.setMessage("Votre proposition pour l'appel d'offres a été acceptée. En attente de livraison.");
			else	//proposition est refuser	
			  notif.setMessage("votre propositon est refuse");
		}else {

			if(etat) //ajouter a liste noire
				notif.setMessage("Nous avons de vous informer que vous avez été ajouté à notre liste noire, et par conséquent, vous n'êtes pas autorisé à soumettre des propositions pour nos appels d'offres");
			else	//retire list noire
			  notif.setMessage("Nous avons le plaisir de vous informer que vous avez été retiré de notre liste noire. Vous êtes à nouveau autorisé à soumettre des propositions pour nos appels d'offres.");	
		}
		fournisseurRepository.save(notif);	
	}
	public void ajouterInfoFournisseur(FournisseurModel fournisseurModel) {
		fournisseurRepository2.save(fournisseurModel);
		
	}
	
}
