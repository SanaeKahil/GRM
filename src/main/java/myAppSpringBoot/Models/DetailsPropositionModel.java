package myAppSpringBoot.Models;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Details_Proposition")
public class DetailsPropositionModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	private int id_det_prop;
	private String marque;
	private float prix;
	private Date date_garenti;
	
	@ManyToOne
    @JoinColumn(name = "id_bes", referencedColumnName = "id_bes")
	public BesoinModel besoin;
	
	@ManyToOne
    @JoinColumn(name = "id_prop", referencedColumnName = "id_prop")
	public PropositionModel proposition;

	public DetailsPropositionModel(){

	}

	
	public DetailsPropositionModel(String marque, float prix, BesoinModel besoin, PropositionModel proposition) {
		super();
		this.marque = marque;
		this.prix = prix;
		this.besoin = besoin;
		this.proposition = proposition;
	}


	public int getId_det_prop() {
		return id_det_prop;
	}

	public void setId_det_prop(int id_det_prop) {
		this.id_det_prop = id_det_prop;
	}

	public String getMarque() {
		return marque;
	}

	public void setMarque(String marque) {
		this.marque = marque;
	}

	public float getPrix() {
		return prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}

	public BesoinModel getBesoin() {
		return besoin;
	}

	public void setBesoin(BesoinModel besoin) {
		this.besoin = besoin;
	}

	public PropositionModel getProposition() {
		return proposition;
	}

	public void setProposition(PropositionModel proposition) {
		this.proposition = proposition;
	}


	public Date getDate_garenti() {
		return date_garenti;
	}


	public void setDate_garenti(Date date_garenti) {
		this.date_garenti = date_garenti;
	}
	

}//end DetailsPropositionModel