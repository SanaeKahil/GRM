package myAppSpringBoot.ControllersJSP;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import myAppSpringBoot.Controllers.AppelOffreController;
import myAppSpringBoot.Controllers.BesoinController;
import myAppSpringBoot.Controllers.PersonnelAdministrationController;
import myAppSpringBoot.Controllers.RessourceController;
import myAppSpringBoot.Controllers.UserController;
import myAppSpringBoot.Models.AppelOffreModel;
import myAppSpringBoot.Models.BesoinModel;
import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.NotificationRepository;
import myAppSpringBoot.Repositories.PanneRepository;

@Controller
public class LoginControllerJSP {
	
	@Autowired
	private UserController userController;
	@Autowired
	private RessourceController ressourceController;
	@Autowired
	private BesoinController besoinController;
	@Autowired
	private AppelOffreController appelOffreController;
	@Autowired
	private PersonnelAdministrationController personnelAdministrationController;
	@Autowired
	private PanneRepository panneRepository;
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Autowired
    private HttpSession httpSession; // Injection de l'objet HttpSession
	@Autowired
    private PasswordEncoder passwordEncoder; // Injecter le bean PasswordEncoder

    @RequestMapping("/login")
    public String showLoginPage() {
        return "Login/LoginInterface";   // Le nom du fichier JSP (LoginInterface.jsp)
          // http://localhost:4040/login
    }
    
    @RequestMapping("/interface-enseignant")
    public String showPagePrincipaleEnseignant(Model model) {
        List<BesoinModel> besoins = besoinController.getAllBesoins();
        model.addAttribute("myListBesoins", besoins);
        
        List<AppelOffreModel> appelOffres = appelOffreController.getAllAppelOffres();
        model.addAttribute("myListAppelOffres", appelOffres);
        
        List<PersonnelAdministrationModel> personnels = personnelAdministrationController.getAllPersonnel();
        model.addAttribute("myListPersonnels", personnels);
        
        List<UserModel> users = userController.getAllUsers();
        model.addAttribute("myListUsers", users);
        
        List<PanneModel> listePannes = panneRepository.findAll();
        model.addAttribute("listePannes", listePannes);
        
        List<NotificationModel> myListNotifications = notificationRepository.findAll();
        model.addAttribute("myListNotifications", myListNotifications);
        
     // Récupérer l'utilisateur actuellement connecté à partir de la session
        UserModel currentUserEns = (UserModel) httpSession.getAttribute("Enseignant");
        if (currentUserEns == null) {
            // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
            return "redirect:/login";
        }
       // Récupérer le CIN de l'utilisateur connecté
        String cinUtilisateur = currentUserEns.getCin();
    	List<RessourceModel> allRessources  = ressourceController.getAllRessources();
    	// Filtrer les ressources en fonction du CIN de l'utilisateur
        List<RessourceModel> userRessources = new ArrayList<>();
        for (RessourceModel ressource : allRessources) {
            // Vous devrez ajuster cette logique en fonction de la structure de votre modèle d'utilisateur et de ressource
            if (ressource.getBesoin().getPersonnelAdministration().getCin().equals(cinUtilisateur)) {
                userRessources.add(ressource);
            }
        } 	
    	model.addAttribute("myListRessources", userRessources);
        
        return "Enseignant/InterfacePrincipaleEnseignant";
      // Le nom du fichier JSP (InterfacePrincipaleEnseignant.jsp) existe dans le dossier "Enseignant"
          // http://localhost:4040/interface-enseignant
    }
    
    @RequestMapping("/interface-chefDepartement")
    public String showPagePrincipaleChefDepartement(Model model) {
    	
        UserModel currentChef = (UserModel) httpSession.getAttribute("ChefDepartement");
        UserModel responsable=userController.getUserByRoles("Responsable");
        List<PersonnelAdministrationModel> listPersonnelsChef= personnelAdministrationController.getPersonnelsDepartmentChef(currentChef.getCin());
        List<BesoinModel> besoins = besoinController.getAllBesoins();
        List<RessourceModel> ressources=ressourceController.getAllRessources();

        httpSession.setAttribute("listPersonnels", listPersonnelsChef);
        httpSession.setAttribute("listBesoins", besoins);
        httpSession.setAttribute("visibility","False");
        httpSession.setAttribute("responsable", responsable);
        httpSession.setAttribute("Enseignant", currentChef);
        httpSession.setAttribute("ressources", ressources);
        
        return "ChefDepartement/InterfacePrincipaleChefDepartement";
    }

    @RequestMapping("/interface-responsable")
    public String showPagePrincipaleResponsable() {
        return "Responsable/InterfacePrincipaleResponsable";
    }

    @RequestMapping("/interface-fournisseur")
    public String showPagePrincipaleFournisseur() {
        return "Fournisseur/InterfacePrincipaleFournisseur";
    }

    @RequestMapping("/interface-technicien")
    public String showPagePrincipaleTechnicien(Model model) {
    	// Récupérer l'utilisateur actuellement connecté à partir de la session
        UserModel technicien = (UserModel) httpSession.getAttribute("Technicien");
        if (technicien == null) {
            // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
            return "redirect:/login";
        }
    	
    	List<PanneModel> listePannes = panneRepository.findAll();
        model.addAttribute("myListPannes", listePannes);
        
        return "Technicien/InterfacePrincipaleTechnicien";
    }
    
   // Endpoint pour vérifier les informations d'identification de l'utilisateur
    @PostMapping("/loginForm") // ce chemin existe dans la formulaire action = "/loginForm"
    public String VerifierLoginPassword(@RequestParam("emailForm") String email, 
                        @RequestParam("passwordForm") String password, 
                        Model model) {
    	// Récupérer l'utilisateur par e-mail
        String hashedPassword = passwordEncoder.encode(password);
        System.out.println("pass : " +hashedPassword);
        UserModel existingUser = userController.getUserByEmail(email);
        if (existingUser != null  && passwordEncoder.matches(password, existingUser.getPassword())) {
        	// Stocker l'utilisateur dans la session
            // httpSession.setAttribute("currentUser", existingUser);
        	
            // Vérifier le rôle de l'utilisateur
            String role = existingUser.getRoles();
            switch (role) {
                case "ChefDepartement":
                	httpSession.setAttribute("ChefDepartement", existingUser);
                    return "redirect:/interface-chefDepartement";
                case "Responsable":
                	httpSession.setAttribute("Responsable", existingUser);
                    return "redirect:/interface-responsable";
                case "Enseignant":
                	httpSession.setAttribute("Enseignant", existingUser);
                    return "redirect:/interface-enseignant";
                case "FournisseurModel":
                	httpSession.setAttribute("ChefDepartement", existingUser);
                    return "redirect:/interface-fournisseur";
                case "Technicien":
                	httpSession.setAttribute("Technicien", existingUser);
                    return "redirect:/interface-technicien";
                default:
                    return "Login/LoginInterface";
              }
	       } else {
	           model.addAttribute("errorMessage", "Erreur d'authentification...! Veuillez réessayer.");
	            return "Login/LoginInterface";
	       }
   }
        
    
}