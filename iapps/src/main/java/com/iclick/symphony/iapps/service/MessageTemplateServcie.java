package com.iclick.symphony.iapps.service;

import com.iclick.symphony.iapps.domain.MessageTemplate;

public interface MessageTemplateServcie {
    /**
     * @param moduleId
     * @param messageCode
     * @param locale
     * @return 
     * 获取对应消息模板，如果locale为空，则默认为en,如果找不到匹配的locale的消息，则返会查询列表的第一条（列表不为空时）
     */
    MessageTemplate findByMessageCodeAndLocale(Integer moduleId,String messageCode,String locale);
}
