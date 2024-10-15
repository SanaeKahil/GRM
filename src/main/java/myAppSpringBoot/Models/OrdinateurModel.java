package myAppSpringBoot.Models;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "Ordinateur")
@PrimaryKeyJoinColumn(name="id_bes")
public class OrdinateurModel extends BesoinModel {

	private int cpu;
	private int disque_dur;
	private int ecran;
	private int ram;

	public OrdinateurModel(){

	}

	public int getCpu() {
		return cpu;
	}

	public void setCpu(int cpu) {
		this.cpu = cpu;
	}

	public int getDisque_dur() {
		return disque_dur;
	}

	public void setDisque_dur(int disque_dur) {
		this.disque_dur = disque_dur;
	}

	public int getEcran() {
		return ecran;
	}

	public void setEcran(int ecran) {
		this.ecran = ecran;
	}

	public int getRam() {
		return ram;
	}

	public void setRam(int ram) {
		this.ram = ram;
	}
	
	public OrdinateurModel(int cpu, int disque_dur, int ecran, int ram) {
		super();
		this.cpu = cpu;
		this.disque_dur = disque_dur;
		this.ecran = ecran;
		this.ram = ram;
	}

}//end OrdinateurModel