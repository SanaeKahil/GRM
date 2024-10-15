package myAppSpringBoot.Controllers;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.AppelOffreModelRespo;
import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Repositories.BesoinRepository;
import myAppSpringBoot.Services.BesoinService;
import myAppSpringBoot.Services.GestionAppelOffreService;

@RestController
public class GestionAppelOffresController {
   @Autowired
   private GestionAppelOffreService appelOffreService;
   @Autowired
   private BesoinService besoinService;
   @Autowired
   private BesoinRepository besoinRepository;
   public ArrayList<AppelOffreModelRespo> getAllAppelOffres(){
	   for (BesoinModel b : besoinService.getAllBesoins()) {
		  System.out.println(b);
	}
	   System.out.println();
       ArrayList<AppelOffreModelRespo> listAppelsOffres=new ArrayList<>();
       List<BesoinModel> listBesoisn=appelOffreService.getAllBesoisn();
       for (AppelOffreModel a : appelOffreService.getAllAppelOffre()) {
    	   AppelOffreModelRespo appelOffreModelRespo= new AppelOffreModelRespo(a.getId_app_off(),a.getNom(),a.getDate_debut(),a.getDate_fin());	
    	   for (BesoinModel besoinModel : listBesoisn) //remplire la list de besoins de chaque appelOffre 
    		   if(besoinModel.getAppelOffre()!=null &&  besoinModel.getAppelOffre().getId_app_off()==a.getId_app_off())
    			   appelOffreModelRespo.getListBesoins().add(besoinModel);
    	   listAppelsOffres.add(appelOffreModelRespo);
	    }
     
       //  trier par date de début dans l'ordre décroissant
       Comparator<AppelOffreModelRespo> comparator = new Comparator<AppelOffreModelRespo>() {
           @Override
           public int compare(AppelOffreModelRespo a1, AppelOffreModelRespo a2) {
               // Comparaison des dates de début dans l'ordre décroissant
               return a2.getDate_debut().compareTo(a1.getDate_debut());
           }
       };

       // Trier la liste en utilisant le comparateur
       Collections.sort(listAppelsOffres, comparator);
	   return listAppelsOffres;
   }
   @GetMapping("/a")
   public List<AppelOffreModel> getBesoinsNoTarite(){ //les besoins qui n'affect pas a aucun appel offre
//	   ArrayList<BesoinModel> res=new ArrayList<>();
//	   for (BesoinModel besoinModel : besoinService.getAllBesoins())
//		   if(besoinModel.getAppelOffre()==null)
//			   res.add(besoinModel);		
//	return res;	  
	return appelOffreService.getAllAppelOffre();
   }
   public void addAppelOffre(AppelOffreModelRespo appelOffreModel) {
		AppelOffreModel appelOffre=new AppelOffreModel();
		appelOffre.setId_app_off(appelOffreModel.getId_app_off());
		appelOffre.setNom(appelOffreModel.getNom());
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date dateParse = null;
		try {
			dateParse = dateFormat.parse(appelOffreModel.getDate_debutStr());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date dateDebut=new Date(dateParse.getTime());
		appelOffre.setDate_debut(dateDebut);
		try {
			dateParse = dateFormat.parse(appelOffreModel.getDate_finStr());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date dateFin=new Date(dateParse.getTime());
		appelOffre.setDate_debut(dateDebut);
		appelOffre.setDate_fin(dateFin);
		System.out.println("controlleur : "+appelOffre.toString());
		appelOffreService.addAppelOffre(appelOffre);
	}
public void setAppelOffreToBesoins(AppelOffreModelRespo appelOffreModel) {
	// TODO Auto-generated method stub
	AppelOffreModel appelOffre=new AppelOffreModel();
	appelOffre.setId_app_off(appelOffreModel.getId_app_off());
	appelOffre.setNom(appelOffreModel.getNom());
	java.util.Date dateParse;
	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
	ArrayList<BesoinModel> listBesoin=new ArrayList<>();
	try {
		dateParse = dateFormat.parse(appelOffreModel.getDate_debutStr());
		Date dateDebut=new Date(dateParse.getTime());
		appelOffre.setDate_debut(dateDebut);
		dateParse = dateFormat.parse(appelOffreModel.getDate_finStr());
		Date dateFin=new Date(dateParse.getTime());
		appelOffre.setDate_debut(dateDebut);
		appelOffre.setDate_fin(dateFin);
		System.out.println("avant");
		for (BesoinModel besoinModel : besoinService.getAllBesoins())
			System.out.println(besoinModel.toString());	
		for (BesoinModel besoinModel : besoinService.getAllBesoins())
			if(besoinModel.getAppelOffre()==null)
				besoinModel.setAppelOffre(appelOffre);	
		System.out.println("apres");
		for (BesoinModel besoinModel : besoinService.getAllBesoins())
			System.out.println(besoinModel.toString());	
		System.out.println(appelOffreModel.toString1());
//		appelOffreService.addAppelOffre(appelOffre);
//		appelOffreService.addAppelOffre(appelOffre,listBesoin);
//		besoinRepository.saveAll(listBesoin);
		appelOffreService.setAppelOffreTOBesoins(listBesoin);
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
}

