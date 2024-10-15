package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.NotificationModel;

@Repository
public interface FournisseurNotifsRepository extends JpaRepository<NotificationModel, Integer> {
	
}
