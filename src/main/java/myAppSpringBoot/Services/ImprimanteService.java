package myAppSpringBoot.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Repositories.ImprimanteRepository;

@Service
public class ImprimanteService implements ImprimanteServiceInterface{
	
	@Autowired
	private ImprimanteRepository imprimanteRepository;

	
	@Override
	public List<ImprimanteModel> getAllImprimantes(){
		return imprimanteRepository.findAll();
	}
	
	@Override
	public Optional<ImprimanteModel> getImprimanteById(int id_bes) {
		return imprimanteRepository.findById(id_bes);
	}
	
	@Override
    public void updateImprimante(ImprimanteModel imprimanteModel,int id_bes) {
		
		ImprimanteModel existingimprimante=imprimanteRepository.findById(id_bes).orElse(null);
		
		if(existingimprimante!=null) {
			existingimprimante.setResolution(imprimanteModel.getResolution());
			existingimprimante.setVitesse(imprimanteModel.getVitesse());
			
		}
		
		imprimanteRepository.save(existingimprimante);
	}
		
	
	

}
