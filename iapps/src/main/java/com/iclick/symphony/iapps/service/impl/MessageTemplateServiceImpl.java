package com.iclick.symphony.iapps.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.iclick.symphony.iapps.domain.MessageTemplate;
import com.iclick.symphony.iapps.repository.MessageTemplateRepository;
import com.iclick.symphony.iapps.service.MessageTemplateServcie;

@Service
public class MessageTemplateServiceImpl extends BaseService implements MessageTemplateServcie {
    
    private final String DEFAULT_MESSAGE_LCOALE = "en";
    
    @Autowired
    private MessageTemplateRepository messageTemplateRepository;
    
    public MessageTemplate findByMessageCodeAndLocale(Integer moduleId,String messageCode,String locale){
        
        Assert.isTrue(StringUtils.isNotBlank(messageCode));
        
        MessageTemplate mt = new MessageTemplate();
        mt.setMessageCode(messageCode);
        if(moduleId != null && moduleId > 0){
            mt.setModuleId(moduleId);
        }
        Example<MessageTemplate> example = Example.of(mt);
        
        List<MessageTemplate> mts = messageTemplateRepository.findAll(example);
        if(mts.size() < 1){
            return null;
        }
        
        if(StringUtils.isNotBlank(locale)){
            locale = DEFAULT_MESSAGE_LCOALE;
        }
        
        for(MessageTemplate m : mts){
            if(m.getLocale().equals(locale)){
                return m;
            }
        }
        
        return mts.get(0);
    }
}
