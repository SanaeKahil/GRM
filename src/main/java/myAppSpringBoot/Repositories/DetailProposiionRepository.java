package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.DetailsPropositionModel;

@Repository
public interface DetailProposiionRepository extends JpaRepository<DetailsPropositionModel,Integer>{

}
