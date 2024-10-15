package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import myAppSpringBoot.Models.FournisseurModel;
import myAppSpringBoot.Models.NotificationModel;

public interface NotificationFournisseurRepository extends JpaRepository<NotificationModel,Integer>{

}
