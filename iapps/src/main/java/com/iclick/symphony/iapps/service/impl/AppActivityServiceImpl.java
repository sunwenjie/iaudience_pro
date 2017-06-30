package com.iclick.symphony.iapps.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iclick.symphony.iapps.domain.AppActivity;
import com.iclick.symphony.iapps.repository.AppActivityRepository;
import com.iclick.symphony.iapps.service.AppActivityService;

@Service
public class AppActivityServiceImpl extends BaseService implements AppActivityService {
    
    @Autowired
    private AppActivityRepository appActivityRepository;
    
    @Override
    public List<AppActivity> getAllActivity() {
        return appActivityRepository.findAll();
    }
}
