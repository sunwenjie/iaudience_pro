package com.iclick.symphony.iaudience.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.iclick.symphony.iaudience.entity.AudienceReportData;

/**
 * Created by wenjie.sun on 2017/6/20.
 */
public interface AudienceReportDataRepository extends JpaRepository<AudienceReportData,Integer> {

	@Query("select a from AudienceReportData a where a.audiencePlanId = :planId and a.date >= :startDay and  a.date <= :endDay order by a.createTime asc")
	List<AudienceReportData> getAudienceReportDataList(@Param("planId") int planId,@Param("startDay") String startDay,@Param("endDay") String endDay);
	
	@Query("select a from AudienceReportData a where a.audiencePlanId = :planId and a.date = :date")
	List<AudienceReportData> getAudienceReportDataByPlanId(@Param("planId") int planId,@Param("date") String date);
	
	@Query("select a from AudienceReportData a where a.audiencePlanId = :planId and a.date = :date and  a.type = :type order by  a.total desc")
	 List<AudienceReportData> getTop5DataList(@Param("planId") int planId,@Param("date") String date,@Param("type") int type);
	
	@Query("select d from AudienceReportData d where ( d.date between :startDate  and :endDate) and d.audiencePlanId =:audiencePlanId and d.type =:type order by d.createTime asc")
    List<AudienceReportData> findLastMonthsDataByType(@Param("audiencePlanId") int audiencePlanId,@Param("type") int type, @Param("startDate") String startDate,@Param("endDate") String endDate );

    @Query("select a from AudienceReportData a where a.audiencePlanId =:audiencePlanId and a.type =:type and a.date =:date")
	AudienceReportData findLastReportData(@Param("audiencePlanId") int audiencePlanId, @Param("type") int type, @Param("date") String date);
    
    @Modifying
    @Transactional
    @Query("delete from AudienceReportData a where a.type in (:typeBrand, :typeProduct) and a.date =:date and a.audiencePlanId =:audiencePlanId")
    int deleteBrandAndProductData(@Param("audiencePlanId") int audiencePlanId, @Param("typeBrand") int typeBrand, @Param("typeProduct") int typeProduct, @Param("date") String date);
}
