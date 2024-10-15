package myAppSpringBoot.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Repositories.OrdinateurRepository;

@Service
public class OrdinateurService implements OrdinateurServiceInterface{
	
	@Autowired
	private OrdinateurRepository ordinateurRepository;

	
	@Override
	public List<OrdinateurModel> getAllOrdinateurs(){
		return ordinateurRepository.findAll();
	}
	
	@Override
	public Optional<OrdinateurModel> getOrdinateurById(int id_bes) {
		return ordinateurRepository.findById(id_bes);
	}
	@Override
    public void updateOrdinateur(OrdinateurModel ordinateurModel,int id_bes) {
		
		OrdinateurModel existingOrdinateur=ordinateurRepository.findById(id_bes).orElse(null);
		if(existingOrdinateur!=null) {
			existingOrdinateur.setCpu(ordinateurModel.getCpu());
			existingOrdinateur.setDisque_dur(ordinateurModel.getDisque_dur());
			existingOrdinateur.setRam(ordinateurModel.getRam());
			existingOrdinateur.setEcran(ordinateurModel.getEcran());
			
			ordinateurRepository.save(existingOrdinateur);
		}
		
	}

}
