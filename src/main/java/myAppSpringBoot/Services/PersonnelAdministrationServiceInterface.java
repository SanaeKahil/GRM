package myAppSpringBoot.Services;

import java.util.List;

import myAppSpringBoot.Models.DepartementModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;

public interface PersonnelAdministrationServiceInterface {
	
	public List<PersonnelAdministrationModel> getAllPersonnel();

	public PersonnelAdministrationModel getIdDeparByCin(String cin);
	
	public List<PersonnelAdministrationModel> findPersonnelByDepartement(DepartementModel departement);
}
