package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.PropositionModel;

@Repository
public interface GestionPropositionRepository extends JpaRepository<PropositionModel,Integer> {

}
