package com.iclick.symphony.iaudience.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

public abstract class BaseService {
    protected Logger logger = LoggerFactory.getLogger(this.getClass());
    
    protected PageRequest buildPageRequest(int pageNumber, int pagzSize, Sort sort) {
        return new PageRequest(pageNumber - 1, pagzSize, sort);
    }
}
