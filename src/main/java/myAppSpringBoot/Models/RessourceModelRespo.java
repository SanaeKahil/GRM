package myAppSpringBoot.Models;

import java.sql.Date;

public class RessourceModelRespo extends RessourceModel {
	private String marque;
	private float prix;
	private FournisseurModel fournisseurModel;
	private Date date_garenti;
	
	public FournisseurModel getFournisseurModel() {
		return fournisseurModel;
	}
	public void setFournisseurModel(FournisseurModel fournisseurModel) {
		this.fournisseurModel = fournisseurModel;
	}
	public RessourceModelRespo(String type, float prix) {
		super();
		this.marque = type;
		this.prix = prix;
	}
	public RessourceModelRespo() {
		// TODO Auto-generated constructor stub
	}
	public String getMarque() {
		return marque;
	}
	public void setMarque(String type) {
		this.marque = type;
	}
	public float getPrix() {
		return prix;
	}
	public void setPrix(float prix) {
		this.prix = prix;
	}
	public Date getDate_garenti() {
		return date_garenti;
	}
	public void setDate_garenti(Date date_garenti) {
		this.date_garenti = date_garenti;
	}
	
}
