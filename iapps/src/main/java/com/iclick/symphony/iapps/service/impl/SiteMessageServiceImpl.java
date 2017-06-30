package com.iclick.symphony.iapps.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import static com.iclick.symphony.iapps.constants.SiteMessageConstants.*;

import java.text.MessageFormat;
import java.util.Date;

import com.iclick.symphony.iapps.domain.MessageTemplate;
import com.iclick.symphony.iapps.domain.SiteMessage;
import com.iclick.symphony.iapps.repository.SiteMessageRepository;
import com.iclick.symphony.iapps.service.MessageTemplateServcie;
import com.iclick.symphony.iapps.service.SiteMessageService;

@Service
public class SiteMessageServiceImpl extends BaseService implements SiteMessageService{
    
    @Autowired
    private SiteMessageRepository siteMessageRepository;
    
    @Autowired
    private MessageTemplateServcie messageTemplateServcie;

    @Override
    public void sendGetAppMessage(int userId, int agencyId, String appInfoUrl, String locale) {
        MessageTemplate template = messageTemplateServcie.findByMessageCodeAndLocale(IAPPS_MODULE_ID, AGENCY_OPERATOR_GET_APP, locale);
        Assert.notNull(template);
        Assert.hasLength(template.getContent());
        
        SiteMessage m = new SiteMessage();
        if(StringUtils.isNotBlank(template.getTitle())){
            m.setTitle(template.getTitle());
        }
        Object[] params = new Object[]{appInfoUrl};
        m.setContent(MessageFormat.format(template.getContent(),params));
        m.setReceiveUserId(agencyId);
        m.setSendUserId(userId);
        m.setTemplateId(template.getId());
        m.setStatus(0);
        m.setSendTime(new Date());
        siteMessageRepository.save(m);
    }

    @Override
    public void sendPurchargeMessage(int userId, int agencyId, String appInfoUrl, String locale) {
        MessageTemplate template = messageTemplateServcie.findByMessageCodeAndLocale(IAPPS_MODULE_ID, AGENCY_OPERATOR_PURCHARGE_APP, locale);
        Assert.notNull(template);
        Assert.hasLength(template.getContent());
        
        SiteMessage m = new SiteMessage();
        if(StringUtils.isNotBlank(template.getTitle())){
            m.setTitle(template.getTitle());
        }
        Object[] params = new Object[]{appInfoUrl};
        m.setContent(MessageFormat.format(template.getContent(),params));
        m.setReceiveUserId(agencyId);
        m.setSendUserId(userId);
        m.setTemplateId(m.getTemplateId());
        m.setStatus(0);
        m.setSendTime(new Date());
        siteMessageRepository.save(m);
    }

    @Override
    public long getUnreadMessageCount(Integer userId) {
        SiteMessage m = new SiteMessage();
        m.setReceiveUserId(userId);
        m.setStatus(0);
        Example<SiteMessage> example = Example.of(m);
        return siteMessageRepository.count(example);
    }

    @Override
    public Page<SiteMessage> getSiteMessageByPage(Integer userId, Pageable pageable) {
        SiteMessage m = new SiteMessage();
        m.setReceiveUserId(userId);
        Example<SiteMessage> example = Example.of(m);
        return siteMessageRepository.findAll(example, pageable);
    }

    @Override
    @Transactional
    public void readAllMessage(Integer userId) {
        siteMessageRepository.updateMessageStatus(userId,1);
    }
    
}
