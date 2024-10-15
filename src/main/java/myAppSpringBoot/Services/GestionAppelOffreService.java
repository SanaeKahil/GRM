package myAppSpringBoot.Services;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.format.DataFormatDetector;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.AppelOffreModelRespo;
import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Repositories.GestionAppelOffreRepository;
import myAppSpringBoot.Repositories.GestionBesoinsRepositiry;
import myAppSpringBoot.Repositories.ImprimanteRepository;


@Service
public class GestionAppelOffreService {
	@Autowired
	private GestionAppelOffreRepository appelOffreRepository;
	@Autowired 
	private GestionBesoinsRepositiry besoins;
	public List<AppelOffreModel> getAllAppelOffre() {
		return appelOffreRepository.findAll();	
	}
	//Chercher appelOffreByid "S"
	//public Optional<AppelOffreModel> getAppelOffreById(int idAppelOffre) {
		//return appelOffreRepository.findById(idAppelOffre);	
	//}
	//
	public Optional<BesoinModel> getBesoinById(int id) {
		return besoins.findById(id);
	}
	public List<BesoinModel> getAllBesoisn(){
		return besoins.findAll();
	}
//	public void addAppelOffre(AppelOffreModel appelOffreModel,ArrayList<BesoinModel> listBesoin) {
//		// TODO Auto-generated method stub
//
//			// TODO Auto-generated catch block
//		System.out.println("service");
//		for (BesoinModel besoinModel : listBesoin) {
//			System.out.println(besoinModel.toString());
//		}
//		System.out.println("service : "+appelOffreModel.toString());
//
//		try {
//			appelOffreRepository.save(appelOffreModel);
////			for (BesoinModel besoinModel : listBesoin)
////				besoins.save(besoinModel);
//		} catch (Exception e) {
//			// TODO: handle exception
//			System.out.println(e.getMessage());
//		}		
//	}
	public void addAppelOffre(AppelOffreModel appelOffreModel) {
		System.out.println(114);
		System.out.println(appelOffreModel.toString());
		appelOffreRepository.save(appelOffreModel);
	}
	public void setAppelOffreTOBesoins(ArrayList<BesoinModel> listBesoin) {
		// TODO Auto-generated method stub
		besoins.saveAll(listBesoin);
	}
}
