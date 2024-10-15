package myAppSpringBoot.Models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Besoin")
@Inheritance(strategy = InheritanceType.JOINED)
public class BesoinModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // Utiliser GenerationType.IDENTITY pour auto-incrémenter
	// @GeneratedValue(strategy = GenerationType.AUTO) // Utiliser GenerationType.AUTO pour laisser Hibernate choisir la meilleure stratégie
	private int id_bes;
	private String type;
	private String demander_par; // soit enseignant soit chef_departement
	
	@ManyToOne
    @JoinColumn(name = "id_app_off", referencedColumnName = "id_app_off")
	public AppelOffreModel appelOffre;
	
	@ManyToOne
    @JoinColumn(name = "cin_pers", referencedColumnName = "cin_pers")
	public PersonnelAdministrationModel personnelAdministration;

	public BesoinModel(){

	}

	public int getId_bes() {
		return id_bes;
	}

	public void setId_bes(int id_bes) {
		this.id_bes = id_bes;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public AppelOffreModel getAppelOffre() {
		return appelOffre;
	}

	public void setAppelOffre(AppelOffreModel appelOffre) {
		this.appelOffre = appelOffre;
	}

	public PersonnelAdministrationModel getPersonnelAdministration() {
		return personnelAdministration;
	}

	public void setPersonnelAdministration(PersonnelAdministrationModel personnelAdministration) {
		this.personnelAdministration = personnelAdministration;
	}

	public String getDemander_par() {
		return demander_par;
	}

	public void setDemander_par(String demander_par) {
		this.demander_par = demander_par;
	}

	@Override
	public String toString() {
		return "BesoinModel [id_bes=" + id_bes + ", type=" + type + ", appelOffre=" + appelOffre
				+ ", personnelAdministration=" + personnelAdministration + "]";
	}
	

}//end BesoinModel