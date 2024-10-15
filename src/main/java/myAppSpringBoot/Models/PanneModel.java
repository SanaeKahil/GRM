package myAppSpringBoot.Models;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "Panne")
public class PanneModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	private int id_pan;
	private Date date_panne;
	private String frequence;
	private String ordre;
	private String constat; // Text
	// L'attribut "etat_panne" avec la valeur par défaut "Non réparée"
    private String etat_panne; // Non réparée, En cours, Réparée, Sévère
	
	@ManyToOne
    @JoinColumn(name = "cin_tech", referencedColumnName = "cin")
	public UserModel technicien;
	
	@ManyToOne
    @JoinColumn(name = "id_res", referencedColumnName = "idRes")
	public RessourceModel ressource;

	public PanneModel(){

	}

	public int getId_pan() {
		return id_pan;
	}

	public void setId_pan(int id_pan) {
		this.id_pan = id_pan;
	}

	public Date getDate_panne() {
		return date_panne;
	}

	public void setDate_panne(Date date_panne) {
		this.date_panne = date_panne;
	}

	public String getFrequence() {
		return frequence;
	}

	public void setFrequence(String frequence) {
		this.frequence = frequence;
	}

	public String getOrdre() {
		return ordre;
	}

	public void setOrdre(String ordre) {
		this.ordre = ordre;
	}

	public String getConstat() {
		return constat;
	}

	public void setConstat(String constat) {
		this.constat = constat;
	}

	public UserModel getTechnicien() {
		return technicien;
	}

	public void setTechnicien(UserModel technicien) {
		this.technicien = technicien;
	}

	public RessourceModel getRessource() {
		return ressource;
	}

	public void setRessource(RessourceModel ressource) {
		this.ressource = ressource;
	}

	public String getEtat_panne() {
		return etat_panne;
	}

	public void setEtat_panne(String etat_panne) {
		this.etat_panne = etat_panne;
	}

}//end PanneModel


/*
 UPDATE Panne SET etat_panne = 'Non réparée' WHERE etat_panne IS NULL OR etat_panne = '';
 ALTER TABLE Panne ALTER COLUMN etat_panne SET DEFAULT 'Non réparée';

*/



