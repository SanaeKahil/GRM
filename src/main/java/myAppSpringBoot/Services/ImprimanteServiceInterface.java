package myAppSpringBoot.Services;

import java.util.List;
import java.util.Optional;

import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Models.OrdinateurModel;

public interface ImprimanteServiceInterface {
	
	public List<ImprimanteModel> getAllImprimantes();
	Optional<ImprimanteModel> getImprimanteById(int id_bes);
	public void updateImprimante(ImprimanteModel imprimanteModel,int id_bes);

}
