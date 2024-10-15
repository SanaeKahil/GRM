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
@Table(name = "Notification")
public class NotificationModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // pour auto-incrémenter
	private int id_notif;
	private Date date_notif;
	private String message;
	private int etat;
	
	@ManyToOne
    @JoinColumn(name = "cin_sour", referencedColumnName = "cin")
    private UserModel user_sour;

    @ManyToOne
    @JoinColumn(name = "cin_dest", referencedColumnName = "cin")
    private UserModel user_dest;
    
    @ManyToOne
    @JoinColumn(name = "id_fourN",referencedColumnName = "id_four")
    private FournisseurModel fournisseur;

	public NotificationModel(){

	}

	public NotificationModel(Date date_notif, String message, int etat, UserModel user_sour, UserModel user_dest,FournisseurModel  fournisseurModel) {
		super();
		this.date_notif = date_notif;
		this.message = message;
		this.etat = etat;
		this.user_sour = user_sour;
		this.user_dest = user_dest;
		this.fournisseur=fournisseurModel;
	}
	
	public int getId_notif() {
		return id_notif;
	}

	public void setId_notif(int id_notif) {
		this.id_notif = id_notif;
	}

	public Date getDate_notif() {
		return date_notif;
	}

	public void setDate_notif(Date date_notif) {
		this.date_notif = date_notif;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getEtat() {
		return etat;
	}

	public void setEtat(int etat) {
		this.etat = etat;
	}

	public UserModel getUser_sour() {
		return user_sour;
	}

	public void setUser_sour(UserModel user_sour) {
		this.user_sour = user_sour;
	}

	public UserModel getUser_dest() {
		return user_dest;
	}

	public void setUser_dest(UserModel user_dest) {
		this.user_dest = user_dest;
	}

	public FournisseurModel getFournisseur() {
		return fournisseur;
	}

	public void setFournisseur(FournisseurModel fournisseur) {
		this.fournisseur = fournisseur;
	}

	
	
	
	

}//end NotificationModel