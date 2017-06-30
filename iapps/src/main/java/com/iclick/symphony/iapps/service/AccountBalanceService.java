package com.iclick.symphony.iapps.service;

import com.iclick.symphony.iapps.domain.AccountBalance;

public interface AccountBalanceService {

    AccountBalance getUserAccountBalance(Integer userId);

    void updateAccountBalance(AccountBalance ab);
    
}
