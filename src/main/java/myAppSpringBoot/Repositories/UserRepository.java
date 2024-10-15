package myAppSpringBoot.Repositories;

import org.springframework.stereotype.Repository;

import myAppSpringBoot.Models.PersonnelAdministrationModel;
import myAppSpringBoot.Models.UserModel;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

@Repository
public interface UserRepository extends JpaRepository<UserModel, String> {

	 UserModel findUserByCin(String cin);
	 
	 UserModel findUserByEmail(String email);
	 
	 UserModel findUserByRoles(String roles);

	 

}
