package myAppSpringBoot.Repositories;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.FournisseurModel;


@Repository
public interface FournisseurRepository extends JpaRepository<FournisseurModel, Integer> {
	
	  FournisseurModel findById(int id);
	  FournisseurModel findFournisseurByNomSociete(String nomSociete);
	
	
	 
}
