package com.iclick.symphony.iaudience.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.iclick.symphony.iaudience.entity.AudienceAnalysisRecord;


public interface AudienceAnalysisRecordRespository extends JpaRepository<AudienceAnalysisRecord,Integer>{

	@Query("select a from AudienceAnalysisRecord a where a.planId = :planId")
	AudienceAnalysisRecord getAudiencePlanByPlanId(@Param("planId") int planId);
	
	@Query("select a from AudienceAnalysisRecord a where a.planId = :planId and a.type = :type")
	AudienceAnalysisRecord getAnalysisRecordByPlanId(@Param("planId") int planId, @Param("type") int type);
}
