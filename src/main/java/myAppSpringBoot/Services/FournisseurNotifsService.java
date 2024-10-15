package myAppSpringBoot.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import myAppSpringBoot.Models.NotificationModel;
import myAppSpringBoot.Repositories.FournisseurNotifsRepository;


@Service
public class FournisseurNotifsService implements FournisseurNotifsServiceInterface{
	@Autowired
    private FournisseurNotifsRepository fournisseurNotifsRepository;

	@Override
	public List<NotificationModel> getAllNotifsFournisseur() {
	
		return fournisseurNotifsRepository.findAll();
	}


	
	
}
