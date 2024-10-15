package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.OrdinateurModel;

@Repository
public interface OrdinateurRepository extends JpaRepository<OrdinateurModel, Integer> {

}
