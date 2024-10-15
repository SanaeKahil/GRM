package myAppSpringBoot.Services;

import java.util.List;
import java.util.Optional;

import myAppSpringBoot.Models.BesoinModel;

public interface BesoinServiceInterface {
	
	// Méthode pour récupérer tous les besoins
    public List<BesoinModel> getAllBesoins();

    
    public Optional<BesoinModel> getBesoinByid(int id);
    
}
