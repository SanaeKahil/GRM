package myAppSpringBoot.Models;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;

public class PropositionModelRespo extends PropositionModel {
	@Autowired
	private ArrayList<DetailsPropositionModel> details;

	public PropositionModelRespo() {
		super();
		this.details =new ArrayList<>();
	}

	public ArrayList<DetailsPropositionModel> getDetails() {
		return details;
	}

	public void setDetails(ArrayList<DetailsPropositionModel> details) {
		this.details = details;
	}

	public PropositionModelRespo(int id_prop, Date date_livraison, float total, String etat, AppelOffreModel appelOffre,
			FournisseurModel fournisseur) {
		super(id_prop, date_livraison, total, etat, appelOffre, fournisseur);
		this.details =new ArrayList<>();
		// TODO Auto-generated constructor stub
	}
	
	
}
