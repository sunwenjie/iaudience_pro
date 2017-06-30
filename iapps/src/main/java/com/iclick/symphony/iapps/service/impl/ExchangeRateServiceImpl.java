package com.iclick.symphony.iapps.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import com.iclick.symphony.iapps.domain.ExchangeRate;
import com.iclick.symphony.iapps.repository.ExchangeRateRepository;
import com.iclick.symphony.iapps.service.ExchangeRateService;

@Service
public class ExchangeRateServiceImpl extends BaseService implements ExchangeRateService {
    @Autowired
    private ExchangeRateRepository exchangeRateRepository;
    
    @Override
    public ExchangeRate getRateByUnit(Integer fromUnit, Integer toUnit) {
        
        ExchangeRate rate = new ExchangeRate();
        rate.setFromUnit(fromUnit);
        rate.setToUnit(toUnit);
        Example<ExchangeRate> example = Example.of(rate);
        return exchangeRateRepository.findOne(example);
    }

}
