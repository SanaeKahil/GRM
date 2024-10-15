package myAppSpringBoot.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Services.UserService;
import myAppSpringBoot.Services.UserServiceInterface;

//@CrossOrigin(origins = "*")
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/backend/users")
public class UserController {

	@Autowired
    private UserServiceInterface userService;
	// private UserService userService;
	
	// Endpoint pour récupérer tous les utilisateurs
    @GetMapping
    public List<UserModel> getAllUsers() {
        return userService.getAllUsers();
        // http://localhost:4040/backend/users
    }

    // Endpoint pour récupérer un utilisateur par son CIN
    @GetMapping("/{CIN}")
    public UserModel getUserByCIN(@PathVariable("CIN") String Cin) {
        return userService.getUserByCIN(Cin);
        // http://localhost:4040/backend/users/CN12345
    }

    // Endpoint pour créer un nouvel utilisateur
    @PostMapping
    public void createUser(@RequestBody UserModel user) {
          userService.createUser(user);
    }

    // Endpoint pour mettre à jour les informations d'un utilisateur
    @PutMapping("/{cin}")
    public void updateUser(@RequestBody UserModel user, @PathVariable("cin") String cin) {
         userService.updateUser(user, cin);
    }

    // Endpoint pour supprimer un utilisateur par son CIN
    @DeleteMapping("/{cin}")
    public ResponseEntity<Void> deleteUserByCIN(@PathVariable("cin") String cin) {
        userService.deleteUserByCin(cin);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
    
    
    // Endpoint pour récupérer un utilisateur par son email
    @GetMapping("/email/{email}")
    public UserModel getUserByEmail(@PathVariable("email") String email) {
    	return userService.getUserByEmail(email);
    	// http://localhost:4040/backend/users/test@gmail.com
    }
	
    @GetMapping("/roles/{roles}")
    public UserModel getUserByRoles(@PathVariable("roles") String roles) {
    	return userService.getUserByRole(roles);
    }
}
