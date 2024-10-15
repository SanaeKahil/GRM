package myAppSpringBoot.Models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Ressource")
public class RessourceModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	protected int idRes;
	protected String numero_inventaire;
	protected String etat_recep; // etatReception : État de la ressource: reçue ou non
    protected String etat_affect; // etatAffectation : État d'affectation de la ressource: non affectée, affectée à une personne, affectée à un département

	@OneToOne
    @JoinColumn(name = "id_bes", referencedColumnName = "id_bes")
	public BesoinModel besoin;

	public RessourceModel(){

	}

	public String getNumero_inventaire() {
		return numero_inventaire;
	}

	public void setNumero_inventaire(String numero_inventaire) {
		this.numero_inventaire = numero_inventaire;
	}

	public String getEtat_recep() {
		return etat_recep;
	}

	public void setEtat_recep(String etat_recep) {
		this.etat_recep = etat_recep;
	}

	public String getEtat_affect() {
		return etat_affect;
	}

	public void setEtat_affect(String etat_affect) {
		this.etat_affect = etat_affect;
	}

	public BesoinModel getBesoin() {
		return besoin;
	}

	public void setBesoin(BesoinModel besoin) {
		this.besoin = besoin;
	}

	public int getIdRes() {
		return idRes;
	}

	public void setIdRes(int idRes) {
		this.idRes = idRes;
	}

	@Override
	public String toString() {
		return "RessourceModel [idRes=" + idRes + ", numero_inventaire=" + numero_inventaire + ", etat_recep="
				+ etat_recep + ", etat_affect=" + etat_affect + ", besoin=" + besoin + "]";
	}

}