package com.iclick.symphony.iapps.repository;

import org.springframework.data.jpa.repository.Query;

import com.iclick.symphony.iapps.domain.UserApp;

public interface UserAppRepository extends BaseRepository<UserApp, Integer>{

    @Query("select ua from UserApp ua join ua.appInfo a where a.appKey=(?1) and ua.userId=(?2)")
    UserApp getByAppKeyAndUserId(String appKey, Integer userId);

}
