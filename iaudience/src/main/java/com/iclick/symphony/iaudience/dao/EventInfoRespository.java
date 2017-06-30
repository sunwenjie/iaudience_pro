package com.iclick.symphony.iaudience.dao;

import com.iclick.symphony.iaudience.entity.EventInfo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Created by jerry.li on 2017/3/29.
 */
public interface EventInfoRespository extends JpaRepository<EventInfo,Integer>{
	
	@Query("select a from EventInfo a where a.clientId = :clientId ")
	 List<EventInfo> getEventInfosByClientId(@Param("clientId") Integer clientId);
	
}
