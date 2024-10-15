package myAppSpringBoot.Controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.ImprimanteModel;
import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Services.ImprimanteServiceInterface;

@RestController
@RequestMapping("/backend/imprimantes")
public class ImprimanteController {
	
	@Autowired
    private ImprimanteServiceInterface imprimanteService;
	
    @GetMapping("/")
    public List<ImprimanteModel> getAllImprimantes() {
        return imprimanteService.getAllImprimantes();
    }

    @GetMapping("/imprimante")
    public ImprimanteModel getImprimanteById(@RequestParam int id) {
        return imprimanteService.getImprimanteById(id).orElse(null);
        
    }
    
    public void updateImprimante(ImprimanteModel imprimanteModel,int id_bes) {
    	imprimanteService.updateImprimante(imprimanteModel,id_bes);
    }

}
