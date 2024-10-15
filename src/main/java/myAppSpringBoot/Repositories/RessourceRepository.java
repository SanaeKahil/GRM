package myAppSpringBoot.Repositories;

import myAppSpringBoot.Models.RessourceModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RessourceRepository extends JpaRepository<RessourceModel,Integer> {

}
