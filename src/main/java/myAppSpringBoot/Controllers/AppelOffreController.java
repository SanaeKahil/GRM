package myAppSpringBoot.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Services.AppelOffreServiceInterface;

@RestController
@RequestMapping("/backend/appel-offres/")
public class AppelOffreController {
	
	private final AppelOffreServiceInterface appelOffreService;

    @Autowired
    public AppelOffreController(AppelOffreServiceInterface appelOffreService) {
        this.appelOffreService = appelOffreService;
    }

    @GetMapping
    public List<AppelOffreModel> getAllAppelOffres() {
        return appelOffreService.getAllAppelOffres();
    }

}
