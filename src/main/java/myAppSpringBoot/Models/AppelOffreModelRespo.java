package myAppSpringBoot.Models;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;

public class AppelOffreModelRespo extends AppelOffreModel{
	@Autowired
	private ArrayList<BesoinModel> listBesoins;
	protected String date_debutStr;
	protected String date_finStr;
	public AppelOffreModelRespo(int id_app_off, String nom, String date_debut, String date_fin,ArrayList<BesoinModel> listBesoins) {
		super();
		this.id_app_off = id_app_off;
		this.nom = nom;
		this.date_debutStr= date_debut;
		this.date_finStr= date_fin;
		for (BesoinModel besoinModel : listBesoins)
			this.listBesoins.add(besoinModel);
		listBesoins=new ArrayList<>();
	}
	public AppelOffreModelRespo(int id_app_off, String nom, Date date_debut, Date date_fin) {
		super();
		this.id_app_off = id_app_off;
		this.nom = nom;
		this.date_debut = date_debut;
		this.date_fin = date_fin;
		listBesoins=new ArrayList<>();
	}
	public AppelOffreModelRespo(String nom, String date_debut, String date_fin) {
		super();
		this.nom = nom;
		this.date_debutStr = date_debut;
		this.date_finStr = date_fin;
	}
	public ArrayList<BesoinModel> getListBesoins() {
		return listBesoins;
	}
	public void setListBesoins(ArrayList<BesoinModel> listBesoins) {
		this.listBesoins = listBesoins;
	}
	public String getDate_debutStr() {
		return date_debutStr;
	}
	public void setDate_debutStr(String date_debutStr) {
		this.date_debutStr = date_debutStr;
	}
	public String getDate_finStr() {
		return date_finStr;
	}
	public void setDate_finStr(String date_finStr) {
		this.date_finStr = date_finStr;
	}
	@Override
	public String toString() {
		String besoins="";
		for (BesoinModel besoinModel : listBesoins) {
			besoins+=besoinModel.toString();
		}
		return "AppelOffreModelRespo [listBesoins=" + besoins + "]";
	}	
	public String toString1() {
		
		return "AppelOffreModelRespo  : "+this.getNom()+this.date_debutStr+this.date_finStr;
	}	
}
