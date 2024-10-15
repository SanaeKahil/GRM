package myAppSpringBoot.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import myAppSpringBoot.Models.BesoinModel;
@Repository
public interface GestionBesoinsRepositiry extends JpaRepository<BesoinModel,Integer> {
//	  @Transactional
//	  @Modifying
//	  @Query(nativeQuery = true,value ="UPDATE besoin SET id_app_off = :idAppOff WHERE id_bes = :idBes")
//	  int updateIdAppOff(@Param("idBes") Integer idBes, @Param("idAppOff") Integer idAppOff);
}
