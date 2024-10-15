package myAppSpringBoot.Controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Services.BesoinServiceInterface;

@RestController
@RequestMapping("/backend/besoins")
public class BesoinController {
	
	@Autowired
    private BesoinServiceInterface besoinService;
	
	// Endpoint pour récupérer tous les besoins
    @GetMapping("/")
    public List<BesoinModel> getAllBesoins() {
        return besoinService.getAllBesoins();
    }
    
    @GetMapping("/getBesoinDetails")
    public Optional<BesoinModel> getBesoinDetails(@RequestParam int id) {
        return besoinService.getBesoinByid(id);
    }

}
