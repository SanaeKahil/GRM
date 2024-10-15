package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.ResourceNotFoundException;
import myAppSpringBoot.Models.UserModel;
import myAppSpringBoot.Repositories.UserRepository;

@Service
public class UserService implements UserServiceInterface {

    @Autowired
    private UserRepository userRepository;

    // Récupère tous les utilisateurs de la base de données
    @Override
    public List<UserModel> getAllUsers() {
        return userRepository.findAll();
    }

    // Récupère un utilisateur par son CIN
    @Override
    public UserModel getUserByCIN(String CIN) {
        return userRepository.findUserByCin(CIN);
    }

    // Crée un nouvel utilisateur dans la base de données
    @Override
    public void createUser(UserModel user) {
          userRepository.save(user);
    }

    // Met à jour les informations d'un utilisateur existant dans la base de données
    @Override
    public void updateUser(UserModel user, String cin) {
        // Vérifie si l'utilisateur existe dans la base de données
        // UserModel existingUser = userRepository.findUserByCin(user.getCin());
        UserModel existingUser = userRepository.findUserByCin(cin);
        if (existingUser != null) {
            // Mise à jour des données de l'utilisateur existant avec les nouvelles données
            existingUser.setNom(user.getNom());
            existingUser.setPrenom(user.getPrenom());
            existingUser.setDate_naissance(user.getDate_naissance());
            existingUser.setEmail(user.getEmail());
            existingUser.setPassword(user.getPassword());
            
            // Enregistrer les modifications dans la base de données
               userRepository.save(existingUser);
        } else {
            // Si l'utilisateur n'existe pas
        	throw new ResourceNotFoundException("User de CIN : " + cin + " n'existe pas");
        }
    }

    // Supprime un utilisateur de la base de données par son CIN
    @Override
    public void deleteUserByCin(String cin) {	
    	UserModel existingUser = userRepository.findUserByCin(cin);
        userRepository.delete(existingUser);
    }
    
    
 // Implémentation de la méthode pour récupérer un utilisateur par son email
    @Override
    public UserModel getUserByEmail(String email) {
        return userRepository.findUserByEmail(email);
    }
    
    @Override
    public UserModel getUserByRole(String roles) {
    	return userRepository.findUserByRoles(roles);
    }
    
}
