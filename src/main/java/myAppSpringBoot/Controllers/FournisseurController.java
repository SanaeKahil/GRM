package myAppSpringBoot.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Services.FournisseurServiceInterface;
import myAppSpringBoot.Services.UserServiceInterface;
@RequestMapping("/b")
@RestController
public class FournisseurController {
	
	@Autowired
    private FournisseurServiceInterface FournisseurService;

    @GetMapping("/Fournisseur/{id}")
    public FournisseurModel getFournisseurByID(@PathVariable("id") int id_four) {
        return FournisseurService.findFournisseurById(id_four);
       
    }
    @GetMapping("/{nomSociete}")
    public FournisseurModel getFournisseurByNomSociete(@PathVariable("nomSociete") String nomSociete) {
        return FournisseurService.findFournisseurByNomSociete(nomSociete);
        // http://localhost:4040/b/ABC Company
    }
    
  
}
