package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.BesoinModel;

@Repository
public interface BesoinRepository extends JpaRepository<BesoinModel, Integer> {

}
