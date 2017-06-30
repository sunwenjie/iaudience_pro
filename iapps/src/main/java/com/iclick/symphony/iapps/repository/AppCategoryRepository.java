package com.iclick.symphony.iapps.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.iclick.symphony.iapps.domain.AppCategory;

public interface AppCategoryRepository extends BaseRepository<AppCategory, Integer> {

    @Query("select distinct c from AppCategory c join c.appInfos a join a.modules m where c.enabled=true and a.enabled=true and a.latestVersion=true and m.id in (:modules) order by c.id")
    List<AppCategory> findByModules(@Param(value="modules") List<Integer> modules);
    
    @Query("select distinct c from AppCategory c join c.appInfos a where c.enabled=true and a.enabled=true and a.latestVersion=true order by c.id")
    List<AppCategory> findAllWithApps();
}
