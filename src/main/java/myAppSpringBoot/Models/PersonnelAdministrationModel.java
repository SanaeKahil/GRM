package myAppSpringBoot.Models;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "Personnel_Administration")
@PrimaryKeyJoinColumn(name="cin_pers")
public class PersonnelAdministrationModel extends UserModel {
	
	// @Id
	// private int id_pers;

	@ManyToOne
    @JoinColumn(name = "id_depart", referencedColumnName = "id_depart")
	public DepartementModel departement;

	public PersonnelAdministrationModel(){

	}

	public DepartementModel getDepartement() {
		return departement;
	}

	public void setDepartement(DepartementModel departement) {
		this.departement = departement;
	}

	@Override
	public String toString() {
		return "PersonnelAdministrationModel [departement=" + departement + ", getCin()=" + getCin() + ", getNom()="
				+ getNom() + ", getPrenom()=" + getPrenom() + ", getDate_naissance()=" + getDate_naissance() + "]";
	}

}//end Personnel d'administration



/*
Pour accéder à un attribut de la classe "PersonnelAdministrationModel", qui est héritée de la classe parente "UserModel", vous pouvez utiliser les méthodes getters et setters héritées de "UserModel" :
	PersonnelAdministrationModel personnelAdministration;
	personnelAdministration.getCin();
	personnelAdministration.getPrenom();
*/