package com.iclick.symphony.iapps.service;

import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.domain.UserApp;

public interface UserAppService {

    public void saveUserApp(AppInfo app, Integer userId, Integer priceId);
    
    public void saveUserApp(AppInfo app, Integer userId);

    public void updateUserApp(UserApp app);

    public void purchargeApp(AppInfo app, Integer userId, Integer priceId);

    public UserApp getByUserId(Integer id, Integer userId);

    public UserApp getUserApp(Integer userAppId);

}
