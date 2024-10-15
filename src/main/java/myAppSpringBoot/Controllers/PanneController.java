package myAppSpringBoot.Controllers;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import myAppSpringBoot.Models.PanneModel;
import myAppSpringBoot.Models.RessourceModel;
import myAppSpringBoot.Services.PanneServiceInterface;

@RestController
@RequestMapping("/backend/pannes")
public class PanneController {

	@Autowired
    private PanneServiceInterface panneService;
	
	@GetMapping("")
    public PanneModel getPannesById(@RequestParam int id) {
        
		RessourceModel ressource = new RessourceModel();
	    ressource.setIdRes(id);
	    List<PanneModel> pannes = panneService.getPannesByRessource(ressource);

	    if(!pannes.isEmpty()) {
	    	Collections.sort(pannes, new Comparator<PanneModel>() {
		        @Override
		        public int compare(PanneModel panne1, PanneModel panne2) {
		            return panne2.getDate_panne().compareTo(panne1.getDate_panne()); 
		        }
		    });
	    }
	    
	    if(!pannes.isEmpty())
	      return pannes.get(0);
	    else 
	    	return null;
        
    }
	
}
