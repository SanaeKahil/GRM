package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.ImprimanteModel;

@Repository
public interface ImprimanteRepository extends JpaRepository<ImprimanteModel, Integer> {

}
