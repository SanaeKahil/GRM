package myAppSpringBoot.Models;

import java.util.List;

import javax.persistence.CascadeType;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Fournisseur")
public class FournisseurModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	private int id_four;
	@Column(name = "nom_societe") // Spécifier le nom de la colonne dans la base de données
    private String nomSociete;
	private String motDePasse;
	private String gerant;
	private String adresse;
	private String lieu;
	private String site_internet;
	private int etat;
	
	
//    @OneToMany(mappedBy = "fournisseur")
//    private List<NotificationModel> notifications;

//	public List<NotificationModel> getNotifications() {
//		return notifications;
//	}
//
//	public void setNotifications(List<NotificationModel> notifications) {
//		this.notifications = notifications;
//	}

	public FournisseurModel(){

	}

	public String getMotDePasse() {
		return motDePasse;
	}

	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}

	public int getId_four() {
		return id_four;
	}

	public void setId_four(int id_four) {
		this.id_four = id_four;
	}

	public String getNomSociete() {
		return nomSociete;
	}

	public void setNomSociete(String nomSociete) {
		this.nomSociete = nomSociete;
	}

	public String getGerant() {
		return gerant;
	}

	public void setGerant(String gerant) {
		this.gerant = gerant;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}

	public String getLieu() {
		return lieu;
	}

	public void setLieu(String lieu) {
		this.lieu = lieu;
	}

	public String getSite_internet() {
		return site_internet;
	}

	public void setSite_internet(String site_internet) {
		this.site_internet = site_internet;
	}

	public int getEtat() {
		return etat;
	}

	public void setEtat(int etat) {
		this.etat = etat;
	}

	@Override
	public String toString() {
		return "FournisseurModel [id_four=" + id_four + ", nomSociete=" + nomSociete + ", motDePasse=" + motDePasse
				+ ", gerant=" + gerant + ", adresse=" + adresse + ", lieu=" + lieu + ", site_internet=" + site_internet
				+ ", etat=" + etat + "]";
	}
	

}//end FournisseurModel