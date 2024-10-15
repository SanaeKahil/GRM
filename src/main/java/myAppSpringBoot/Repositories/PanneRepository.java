package myAppSpringBoot.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModel;
@Repository
public interface PanneRepository extends JpaRepository<PanneModel, Integer> {
	List<PanneModel> findByRessource(RessourceModel ressource);
}
