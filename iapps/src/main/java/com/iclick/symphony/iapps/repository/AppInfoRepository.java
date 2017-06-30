package com.iclick.symphony.iapps.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.Query;

import com.iclick.symphony.iapps.domain.AppInfo;

public interface AppInfoRepository extends BaseRepository<AppInfo, Integer> {

    @Query("select distinct a from AppInfo a join a.modules m where a.enabled=true and a.latestVersion=true and m.id in (?1) order by a.id desc")
    public List<AppInfo> findAppsByModules(List<Integer> modules);
    
    @Query("select distinct a from AppInfo a join a.appCategory c join a.modules m where a.enabled=true and a.latestVersion=true and m.id in (?1) and c.id=(?2) order by a.id desc")
    public List<AppInfo> findAppsByModulesAndCategory(Set<Integer> modules, Integer cateId);
    
    
    @Query("select distinct a from AppInfo a join a.modules m where a.enabled=true and a.featured=true and a.latestVersion=true and m.id in (?1) order by a.id desc")
    public List<AppInfo> findFeatruedAppsByModules(ArrayList<Integer> arrayList);
    

    @Query("select distinct a from AppInfo a join a.modules m join a.userApps ua where a.enabled=true and a.latestVersion=true and m.id in (?1) "
            + " and ua in (select distinct u from UserApp u where u.userId = (?2) ) order by a.id desc")
    public List<AppInfo> findMyAppsByModules(List<Integer> modules, Integer userId);

    
    
    @Query("select distinct a from AppInfo a join a.userApps ua where ua.userId = (?1) order by a.id desc")
    public List<AppInfo> findBoughtApps(Integer userId);

    
}
