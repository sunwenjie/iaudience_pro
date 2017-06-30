package com.iclick.symphony.iapps.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.repository.AppInfoRepository;
import com.iclick.symphony.iapps.service.AppInfoService;

@Service
public class AppInfoServiceImpl extends BaseService implements AppInfoService{
    
    @Autowired
    private AppInfoRepository appInfoRepository;

    @Override
    public List<AppInfo> getApps(Set<Integer> modules) {
        return appInfoRepository.findAppsByModules(new ArrayList<Integer>(modules));
    }

    @Override
    public List<AppInfo> getAllApps() {
        AppInfo info = new AppInfo();
        info.setLatestVersion(true);
        info.setEnabled(true);
        Example<AppInfo> example = Example.of(info);
        return appInfoRepository.findAll(example);
    }
    
    
    
    @Override
    public List<AppInfo> getFeatruedApps() {
        AppInfo info = new AppInfo();
        info.setLatestVersion(true);
        info.setEnabled(true);
        info.setFeatured(true);
        Example<AppInfo> example = Example.of(info);
        return appInfoRepository.findAll(example);
    }
    
    @Override
    public List<AppInfo> getFeatruedApps(Set<Integer> modules) {
        return appInfoRepository.findFeatruedAppsByModules(new ArrayList<Integer>(modules));
    }
    
    

    @Override
    public List<AppInfo> getMyApps(Set<Integer> modules,Integer userId) {
        if(userId == null){
            return  new ArrayList<AppInfo>(0);
        }
        return appInfoRepository.findMyAppsByModules(new ArrayList<Integer>(modules),userId);
    }
    

    
    @Override
    public AppInfo getAppInfoById(Integer appId) {
        return appInfoRepository.findOne(appId);
    }

    
    
    @Override
    public Map<String, AppInfo> getBoughtAppMap(Integer userId) {
        List<AppInfo> apps = appInfoRepository.findBoughtApps(userId);
        Map<String, AppInfo> results = new HashMap<String, AppInfo>();
        for(AppInfo app:apps){
            results.put(app.getAppKey(), app);
        }
        return results;
    }
}
