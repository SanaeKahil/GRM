package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.PropositionModel;


@Repository
public interface PropositionRepository extends JpaRepository<PropositionModel, Integer> {

}
