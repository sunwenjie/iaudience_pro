package com.iclick.symphony.iapps.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.iclick.symphony.iapps.domain.AppInfo;

public interface AppInfoService {
    public List<AppInfo> getApps(Set<Integer> modules);

    public List<AppInfo> getAllApps();
    
    
    public List<AppInfo> getFeatruedApps();
    
    public List<AppInfo> getFeatruedApps(Set<Integer> modules);
    

    public List<AppInfo> getMyApps(Set<Integer> modules,Integer userId);
    

    public AppInfo getAppInfoById(Integer appId);

    /**
     * @param userId
     * @return
     */
    public Map<String, AppInfo> getBoughtAppMap(Integer userId);
}
