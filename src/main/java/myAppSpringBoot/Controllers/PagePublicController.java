package myAppSpringBoot.Controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.AppelOffreModelRespo;
import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Models.DetailsPropositionModel;
import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PropositionModel;
import myAppSpringBoot.Repositories.BesoinRepository;
import myAppSpringBoot.Repositories.DetailsPropositionRepository;
import myAppSpringBoot.Repositories.FournisseurNotifsRepository;
import myAppSpringBoot.Repositories.PropositionRepository;
import myAppSpringBoot.Services.BesoinService;
import myAppSpringBoot.Services.FournisseurNotifsService;
import myAppSpringBoot.Services.GestionAppelOffreService;

@RestController
public class PagePublicController {
	 @Autowired
	   private GestionAppelOffreService appelOffreService;
	   @Autowired
	   private BesoinService besoinService;
	   @Autowired
	   private BesoinRepository besoinRepository;
	   
	   @Autowired
	   private PropositionRepository propositionRepository;
	   
	   @Autowired
	   private DetailsPropositionRepository detailsPropositionRepository;
	   @Autowired
	   private FournisseurNotifsService fournisseurNotifsService;
	   
	   

	   public ArrayList<AppelOffreModelRespo> getAllAppelOffres_PP(){
		   
		   //System.out.println();
		   //Récuperer tout les appels offres
	       ArrayList<AppelOffreModelRespo> listAppelsOffres=new ArrayList<>();
	       //récuperer tout les besoins 
	       List<BesoinModel> listBesoins=appelOffreService.getAllBesoisn();
	       
	       for (AppelOffreModel appelOffre : appelOffreService.getAllAppelOffre()) {
	    	   AppelOffreModelRespo appelOffreModelRespo= new AppelOffreModelRespo(appelOffre.getId_app_off(),appelOffre.getNom(),appelOffre.getDate_debut(),appelOffre.getDate_fin());	
	    	   for (BesoinModel besoinModel : listBesoins) //remplire la list de besoins de chaque appelOffre 
	    		   if(besoinModel.getAppelOffre()!=null &&  besoinModel.getAppelOffre().getId_app_off()==appelOffre.getId_app_off())
	    			   appelOffreModelRespo.getListBesoins().add(besoinModel);
	    	   listAppelsOffres.add(appelOffreModelRespo);
		    }
		   return listAppelsOffres;
	   }
	   
	  
		   public ArrayList<BesoinModel> getBesoinsAppelOffre(int id){
			   //recuperer appelOffre
			     
			   //récuperer tout les besoins 
			   ArrayList<BesoinModel> listBesoinsAppelOffre=new ArrayList<>();
		       List<BesoinModel> listBesoins=appelOffreService.getAllBesoisn();
		       for (BesoinModel besoinModel : listBesoins) {
		    	   if(besoinModel.getAppelOffre().getId_app_off() == id) {
		    		   listBesoinsAppelOffre.add(besoinModel);
		    	   }
		       }
		       
			   return listBesoinsAppelOffre;

              }
		   
		   public AppelOffreModel getAppelOffre(int idAppelOffre) {
			
			   for (AppelOffreModel appelOffre : appelOffreService.getAllAppelOffre()) {
			     if(appelOffre.getId_app_off()== idAppelOffre) {
			    	 return appelOffre;
			     }
			   }
			   return null;
			   
		   }
		   public BesoinModel getBesoinId(int idBesoin) {
			for (BesoinModel besoin :besoinService.getAllBesoins()) {
				if(besoin.getId_bes()== idBesoin) {
					return besoin;
				}
			}
			return null;
			   
		   }
		   public PropositionModel saveProposition(PropositionModel proposition) {
			   propositionRepository.save(proposition);

			return proposition;
			   
		   }


		public DetailsPropositionModel saveDetailsProposition(DetailsPropositionModel detailPropositionModel) {
			detailsPropositionRepository.save(detailPropositionModel);
			return detailPropositionModel;
		}
		   
	    //recuperer notifs 
		public ArrayList<NotificationModel> getAllNotifsFournisseur(int id_fournisseur){
			
			 
			   ArrayList<NotificationModel> listNotifs=new ArrayList<>();
		       List<NotificationModel> listAllNotifs=fournisseurNotifsService.getAllNotifsFournisseur();
		       for (NotificationModel notificationModel : listAllNotifs) {
		    	   if(notificationModel.getFournisseur() != null && notificationModel.getFournisseur().getId_four() == id_fournisseur) {
		    		   System.out.println("Notifs"+notificationModel.getMessage() +" : "+notificationModel.getFournisseur().getId_four());
		    		   listNotifs.add(notificationModel);
		    	   }
		       }
			return listNotifs;
			
		}
		
		public ArrayList<PropositionModel> getAllPropositionFournisseur(int id_fournisseur){
			
			  
			   ArrayList<PropositionModel> listPropositions=new ArrayList<>();
		       List<PropositionModel> listAllPropositions= propositionRepository.findAll();
		       for (PropositionModel propositionModel : listAllPropositions) {
		    	   if(propositionModel.getFournisseur().getId_four() == id_fournisseur) {
		    		   listPropositions.add(propositionModel);
		    	   }
		       }
			return listPropositions;
			
		}
		
		public List<DetailsPropositionModel> getAllDetailsProposition(){
			
			 
			   List<DetailsPropositionModel> listAllDetailsProp=new ArrayList<>();
		       listAllDetailsProp= detailsPropositionRepository.findAll();
		      
			return listAllDetailsProp;
			
		}
		
		public int VerfierProposition(int id_fournisseur,int id_AppelOffre) {
			ArrayList<PropositionModel> listProposition =getAllPropositionFournisseur(id_fournisseur);
			 for (PropositionModel propositionModel : listProposition) {
		    	   if(propositionModel.getAppelOffre().getId_app_off() == id_AppelOffre) {
		    		   return 1;
		    	   }
		       }
			 return 0;
		}
}
