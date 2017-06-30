package com.iclick.symphony.iapps.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.iclick.symphony.iapps.domain.SiteMessage;

public interface SiteMessageService {

    void sendGetAppMessage(int userId, int agencyId, String appInfoUrl, String locale);

    void sendPurchargeMessage(int userId, int agencyId, String appInfoUrl, String locale);

    long getUnreadMessageCount(Integer userId);

    Page<SiteMessage> getSiteMessageByPage(Integer userId, Pageable pageable);

    void readAllMessage(Integer userId);

}
