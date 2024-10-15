package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.NotificationModel;

@Repository
public interface NotificationRepository extends JpaRepository<NotificationModel, Integer> {

}
