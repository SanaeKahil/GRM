package myAppSpringBoot.ControllersJSP;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Repositories.NotificationRepository;

@RestController
public class ModifierEtatNotificationControllerJSP {
	
	@Autowired
	private NotificationRepository notificationRepository;
	
	@PutMapping("/updateEtatNotificationById")
    public void updateNotificationById(@RequestParam int notificationId) {
	   // Recherche de la notification par son ID
		 NotificationModel notification = notificationRepository.findById(notificationId).orElse(null);	
	   // Modifier l'état de la notification (par exemple, de 0 à 1)
         notification.setEtat(1); // Mettre l'état à 1 (lu)
       // Enregistrer les modifications dans la base de données
         notificationRepository.save(notification);
    }

}
