package myAppSpringBoot.Models;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "Imprimante")
@PrimaryKeyJoinColumn(name="id_bes")
public class ImprimanteModel extends BesoinModel {

	private int resolution;
	private int vitesse;

	public ImprimanteModel(){

	}

	public int getResolution() {
		return resolution;
	}

	public void setResolution(int resolution) {
		this.resolution = resolution;
	}

	public int getVitesse() {
		return vitesse;
	}

	public void setVitesse(int vitesse) {
		this.vitesse = vitesse;
	}

	public ImprimanteModel(int resolution, int vitesse) {
		super();
		this.resolution = resolution;
		this.vitesse = vitesse;
	}
	
}//end ImprimanteModel