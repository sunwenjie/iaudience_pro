package com.iclick.symphony.iaudience.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.iclick.symphony.iaudience.entity.InterestStructure;

public interface InterestStructureRepository extends JpaRepository<InterestStructure, Integer> {
	
	@Query("SELECT a FROM InterestStructure a where a.status=1  order by a.id desc")
	 List<InterestStructure> findInterestList();

	@Query("select a from InterestStructure a where a.status = 1 and a.id < 100 order by a.id asc ")
	 List<InterestStructure> findOneLevelInterestList();
	
}
