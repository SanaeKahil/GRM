package myAppSpringBoot.ControllersJSP;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LogoutControllerJSP {
	
	@PostMapping("/logout")
    public void logout(HttpSession session) {
        // Effacer les données de session
        session.invalidate();
        // Rediriger vers la page de connexion
        // return "redirect:/login";
    }

}
