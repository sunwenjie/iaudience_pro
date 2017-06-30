package com.iclick.symphony.iaudience.dao;

import com.iclick.symphony.iaudience.entity.AudiencePlan;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
public interface AudiencePlanRepository  extends JpaRepository<AudiencePlan, Integer> {

    List<AudiencePlan> findByIsDeletedFalseAndClientIdIn(List<Integer> clientIds,Sort sort);
    List<AudiencePlan> findByIsDeletedFalseAndClientId(int clientId,Sort sort);
    List<AudiencePlan> findByIsDeletedFalse(Sort sort);


    
    @Query("select a from AudiencePlan a where a.isDeleted = :deleted ")
    Page<AudiencePlan> findAllPlans(@Param("deleted") boolean deleted, Pageable pr);

}
