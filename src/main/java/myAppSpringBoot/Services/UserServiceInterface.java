package myAppSpringBoot.Services;

import java.util.List;

import myAppSpringBoot.Models.UserModel;

public interface UserServiceInterface {
	
	List<UserModel> getAllUsers();
	public UserModel getUserByCIN(String CIN); 
	void createUser(UserModel user);
	void updateUser(UserModel user, String cin);
    void deleteUserByCin(String cin);
    
    UserModel getUserByEmail(String email);
    public UserModel getUserByRole(String roles);

}
