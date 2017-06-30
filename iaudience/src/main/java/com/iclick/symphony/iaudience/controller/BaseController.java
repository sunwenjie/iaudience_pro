package com.iclick.symphony.iaudience.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.support.MessageSourceAccessor;

public class BaseController implements MessageSourceAware {
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    protected MessageSourceAccessor messages;

    @Override
    public void setMessageSource(MessageSource messageSource) {
        messages = new MessageSourceAccessor(messageSource);
    }
}
