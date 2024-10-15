package myAppSpringBoot.ControllersJSP;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.NotificationRepository;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RestController
public class NotifierPersonnelsAdministrationControllerJSP {

	
	 @Autowired
	 private HttpSession session;
	 
	 @Autowired
	 private NotificationRepository BR;
	 
	 
	 @PostMapping("/envoyer-message")
	 public ModelAndView traiterMessage(@RequestParam("message") String message,RedirectAttributes redirectAttributes) {

	     List<PersonnelAdministrationModel> listPersonnels = (List<PersonnelAdministrationModel>) session.getAttribute("listPersonnels");
	     UserModel chefDepartement = (UserModel) session.getAttribute("ChefDepartement");

	     java.util.Date aujourdhui = new java.util.Date();   
	     java.sql.Date date = new java.sql.Date(aujourdhui.getTime());

	     int etat = 0;
	     UserModel userSource = new UserModel();
	     userSource.setCin(chefDepartement.getCin());

	     try {
	         for (PersonnelAdministrationModel personnel : listPersonnels) {
	             if (!chefDepartement.getCin().equals(personnel.getCin())) {
	                 NotificationModel nm = new NotificationModel(); // Créez une nouvelle instance à chaque itération
	                 UserModel userDest = new UserModel();
	                 userDest.setCin(personnel.getCin());

	                 nm.setDate_notif(date);
	                 nm.setEtat(etat);
	                 nm.setMessage(message);
	                 nm.setUser_sour(userSource);
	                 nm.setUser_dest(userDest);

	                 BR.save(nm); 
	             }
	         }
	     } 
	     catch (Exception ex) {
	         ex.printStackTrace();
	     }
	     
	     redirectAttributes.addFlashAttribute("successMessage", "Notifications envoyées avec succès");
	     return new ModelAndView("redirect:/interface-chefDepartement");

	 }

	
}
