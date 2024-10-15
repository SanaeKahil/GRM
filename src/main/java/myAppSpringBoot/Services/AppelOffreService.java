package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Repositories.AppelOffreRepository;

@Service
public class AppelOffreService implements AppelOffreServiceInterface {
	
	@Autowired
	private AppelOffreRepository appelOffreRepository;
	
	@Override
    public List<AppelOffreModel> getAllAppelOffres() {
        return appelOffreRepository.findAll();
    }
	

	

}
