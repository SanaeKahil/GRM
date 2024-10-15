package myAppSpringBoot.Models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Departement")
public class DepartementModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	private int id_depart;
	private String nom_depart;

	public DepartementModel(){

	}

	public DepartementModel(int id_depart, String nom_depart) {
		super();
		this.id_depart = id_depart;
		this.nom_depart = nom_depart;
	}

	public int getId_depart() {
		return id_depart;
	}

	public void setId_depart(int id_depart) {
		this.id_depart = id_depart;
	}

	public String getNom_depart() {
		return nom_depart;
	}

	public void setNom_depart(String nom_depart) {
		this.nom_depart = nom_depart;
	}


}//end DepartementModel