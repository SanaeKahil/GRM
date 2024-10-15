package myAppSpringBoot.Repositories;

import myAppSpringBoot.Models.DepartementModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.PersonnelAdministrationModel;
@Repository
public interface PersonnelAdministrationRepository extends JpaRepository<PersonnelAdministrationModel, String> {

	PersonnelAdministrationModel findIdDeparByCin(String cin);
	
    List<PersonnelAdministrationModel> findPersonnelByDepartement(DepartementModel departement);

}
