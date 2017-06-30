package com.iclick.symphony.iaudience.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.iclick.symphony.iaudience.entity.AudienceNews;

/**
 * Created by wenjie.sun on 2017/6/21.
 */
public interface AudienceNewsRepository extends JpaRepository<AudienceNews,Integer> {
	
	@Query("select a from AudienceNews a where a.date = :date")
	 List<AudienceNews> getAudienceNewsList(@Param("date") String date);
	
	@Query("select a from AudienceNews a where a.audiencePlanId = :planId and a.date = :date and  a.type = :type order by  a.createTime desc ")
	 List<AudienceNews> getAudienceNewsList(@Param("planId") int planId,@Param("date") String date,@Param("type") int type);
	

	@Query("select a from AudienceNews a where (a.date between :begin and :end) and a.type = :type")
	 List<AudienceNews> getAudienceNewsListInPeriod(@Param("begin") String begin, @Param("end") String end, @Param("type") int type);
	
    @Modifying
    @Transactional
    @Query("delete from AudienceNews a where a.type = :type and a.date =:date and a.audiencePlanId =:audiencePlanId")
    int deleteNews(@Param("audiencePlanId") int audiencePlanId, @Param("type") int type, @Param("date") String date);
}
