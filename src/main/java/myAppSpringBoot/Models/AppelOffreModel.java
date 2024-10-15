package myAppSpringBoot.Models;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "Appel_Offre")
public class AppelOffreModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	protected int id_app_off;
	protected String nom;
	protected Date date_debut;
	protected Date date_fin;
	
	public AppelOffreModel(){

	}

	@JsonCreator
	public AppelOffreModel(@JsonProperty("id_app_off") int id_app_off, @JsonProperty("nom") String nom, @JsonProperty("date_debut") Date date_debut, @JsonProperty("date_fin") Date date_fin) {
	    this.id_app_off = id_app_off;
	    this.nom = nom;
	    this.date_debut = date_debut;
	    this.date_fin = date_fin;
	}


	public int getId_app_off() {
		return id_app_off;
	}

	public void setId_app_off(int id_app_off) {
		this.id_app_off = id_app_off;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Date getDate_debut() {
		return date_debut;
	}

	public void setDate_debut(Date date_debut) {
		this.date_debut = date_debut;
	}

	public Date getDate_fin() {
		return date_fin;
	}

	public void setDate_fin(Date date_fin) {
		this.date_fin = date_fin;
	}	

}//end AppelOffreModel