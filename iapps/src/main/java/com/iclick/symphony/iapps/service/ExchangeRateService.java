package com.iclick.symphony.iapps.service;

import com.iclick.symphony.iapps.domain.ExchangeRate;

public interface ExchangeRateService {

    ExchangeRate getRateByUnit(Integer currencyUnit, Integer unit);

}
