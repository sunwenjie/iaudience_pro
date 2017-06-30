package com.iclick.symphony.iapps.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.iclick.symphony.iapps.domain.SiteMessage;

public interface SiteMessageRepository extends BaseRepository<SiteMessage, Integer> {

    @Modifying
    @Query("update SiteMessage s set s.status=(?2) where s.receiveUserId=(?1) ")
    void updateMessageStatus(Integer userId,Integer status);

}
