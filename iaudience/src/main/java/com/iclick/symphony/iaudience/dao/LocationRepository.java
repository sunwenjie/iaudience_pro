package com.iclick.symphony.iaudience.dao;

import java.util.List;

import com.iclick.symphony.iaudience.entity.LocationCity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.iclick.symphony.iaudience.entity.LocationProvince;

public interface LocationRepository extends JpaRepository<LocationProvince, Integer> {

    @Query("select a from LocationProvince a where a.provinceId = :id ")
     List<LocationProvince> findById(@Param("id") Integer provinceId);

    @Query("SELECT distinct new LocationProvince(a.provinceId, a.provinceNameCn , a.provinceNameEn) FROM LocationProvince a where  a.provinceId is not null ")
     List<LocationProvince> findProvinceList();

}
