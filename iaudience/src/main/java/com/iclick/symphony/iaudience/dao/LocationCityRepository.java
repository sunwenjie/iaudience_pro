package com.iclick.symphony.iaudience.dao;

import com.iclick.symphony.iaudience.entity.LocationCity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by wenjie.sun on 2017/5/22.
 */
public interface LocationCityRepository extends JpaRepository<LocationCity, Integer> {
    @Query("select a from LocationCity a where a.cityId = :id ")
     List<LocationCity> findCityById(@Param("id") Integer cityId);

    @Query("SELECT distinct new LocationCity(a.cityId, a.cityNameCn , a.cityNameEn) FROM LocationCity a where (a.tierLevel = 1 or a.cityId = 1344000000 ) and a.cityId is not null ")
     List<LocationCity> findCityList();
}
