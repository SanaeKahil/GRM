package myAppSpringBoot.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.DepartementModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Services.PersonnelAdministrationServiceInterface;

@RestController
@RequestMapping("/backend/personnel-administrations/")
public class PersonnelAdministrationController {
	
	@Autowired
	private PersonnelAdministrationServiceInterface personnelAdministrationService;
	
	@GetMapping
    public List<PersonnelAdministrationModel> getAllPersonnel() {
        return personnelAdministrationService.getAllPersonnel();
    }
	
	@GetMapping("/department/{cin}")
    public int getDepartmentIdByCin(@PathVariable String cin) {
        return personnelAdministrationService.getIdDeparByCin(cin).getDepartement().getId_depart();
    }
	
	@GetMapping("/departmentPersonnels/{cin}")
	public List<PersonnelAdministrationModel> getPersonnelsDepartmentChef(@PathVariable String cin){
		PersonnelAdministrationModel PAM=personnelAdministrationService.getIdDeparByCin(cin);
		
		DepartementModel DM=new DepartementModel();
		DM.setId_depart(PAM.getDepartement().getId_depart());
		
		List<PersonnelAdministrationModel> listPAM=personnelAdministrationService.findPersonnelByDepartement(DM);
		return listPAM;
	}
}
