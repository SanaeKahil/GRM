package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.DepartementModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Repositories.PersonnelAdministrationRepository;

@Service
public class PersonnelAdministrationService implements PersonnelAdministrationServiceInterface {

	@Autowired
	private PersonnelAdministrationRepository personnelAdministrationRepository;
	
	@Override
    public List<PersonnelAdministrationModel> getAllPersonnel() {
        return personnelAdministrationRepository.findAll();
    }
	
	@Override
	public PersonnelAdministrationModel getIdDeparByCin(String cin) {
		return personnelAdministrationRepository.findIdDeparByCin(cin);
	}
	
	@Override
	public List<PersonnelAdministrationModel> findPersonnelByDepartement(DepartementModel departement){
		return personnelAdministrationRepository.findPersonnelByDepartement(departement);
	}
}
