package myAppSpringBoot.ControllersJSP;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import myAppSpringBoot.Controllers.FournisseurController;
import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.UserModel;

@Controller
public class FournisseurLoginControllerJSP {
	
	@Autowired
    private HttpSession httpSession; // Injection de l'objet HttpSession
	@Autowired
	private FournisseurController fournisseurController;
	
	
    @RequestMapping("/loginFournisseur")
    public String showLoginPage() {
        return "Fournisseur/LoginFournisseur";  
      
    }
    
    @RequestMapping("/logoutFournisseur")
    public String showLogoutPage(HttpSession session) {
        if (session != null) {
            session.invalidate(); // Invalider la session existante
        }
        return "redirect:/PagePublique"; // Rediriger vers la page publique
    }
    

    @PostMapping("/loginFournisseurP")
    public String login(@RequestParam("nomSociete") String nomSociete,
    		            @RequestParam("motDePasse") String motDePasse,
    		            HttpSession session,
                        RedirectAttributes redirectAttributes) {
    	  FournisseurModel fournisseur = fournisseurController.getFournisseurByNomSociete(nomSociete);
    	 
           if (fournisseur != null && fournisseur.getMotDePasse().equals(motDePasse) ) {
        	   //MotDePasse et nomSociete correcte
        		httpSession.setAttribute("Fournisseur", fournisseur);
        		 String idAppel = (String) session.getAttribute("idAppel");
        		 if(idAppel != null) {
        			
        			 return "redirect:/proposition/" + idAppel;
        		 }else {
        			
        			 return "redirect:/PagePublique"; 
        		 }
        		 
        } else {
            // Si les informations d'identification sont incorrectes, affichez un message d'erreur
            redirectAttributes.addFlashAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            return "redirect:/loginFournisseur"; // Redirige vers la page de connexion
        }
    }
 
}
