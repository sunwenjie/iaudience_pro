package com.iclick.symphony.iapps.service.impl;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import com.iclick.symphony.iapps.domain.AppCategory;
import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.repository.AppCategoryRepository;
import com.iclick.symphony.iapps.repository.AppInfoRepository;
import com.iclick.symphony.iapps.service.AppCategoryService;

@Service
public class AppCategoryServiceImpl extends BaseService implements AppCategoryService {
    
    @Autowired
    private AppCategoryRepository appCategoryRepository;
    
    @Autowired
    private AppInfoRepository appInfoRepository;

    @Override
    public List<AppCategory> getCategoriesWithApps(Set<Integer> modules) {
        AppCategory c = new AppCategory();
        c.setEnabled(true);
        Example<AppCategory> example = Example.of(c);
        
        List<AppCategory> categories  = appCategoryRepository.findAll(example);
        for(AppCategory cate : categories){
           List<AppInfo> infos = appInfoRepository.findAppsByModulesAndCategory(modules,cate.getId());
           cate.setAppInfos(new LinkedHashSet<AppInfo>(infos));
        }
        return categories;
    }

    @Override
    public List<AppCategory> getCategoriesWithApps() {
        List<AppCategory> cates = appCategoryRepository.findAllWithApps();
        return cates;
    }

    @Override
    public List<AppCategory> getCategories() {
        return appCategoryRepository.findAll();
    }
}
