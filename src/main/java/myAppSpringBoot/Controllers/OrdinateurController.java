package myAppSpringBoot.Controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.OrdinateurModel;
import myAppSpringBoot.Services.OrdinateurServiceInterface;

@RestController
@RequestMapping("/backend/ordinateurs")
public class OrdinateurController {
	
	@Autowired
    private OrdinateurServiceInterface ordinateurService;
	
    @GetMapping("/")
    public List<OrdinateurModel> getAllOrdinateurs() {
        return ordinateurService.getAllOrdinateurs();
    }

    @GetMapping("/ordinateur")
    public OrdinateurModel getOrdinateurById(@RequestParam int id) {
        return ordinateurService.getOrdinateurById(id).orElse(null);
        
    }
    
    public void updateOrdinateur(OrdinateurModel ordinateurModel,int id_bes) {
    	ordinateurService.updateOrdinateur(ordinateurModel,id_bes);
    }

   
}
