package com.iclick.symphony.iapps.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iclick.symphony.iapps.domain.AccountBalance;
import com.iclick.symphony.iapps.repository.AccountBlanceRepository;
import com.iclick.symphony.iapps.service.AccountBalanceService;

@Service
public class AccountBlanceServiceImpl extends BaseService implements AccountBalanceService {
    
    @Autowired
    private AccountBlanceRepository accountBlanceRepository;

    @Override
    public AccountBalance getUserAccountBalance(Integer userId) {
        AccountBalance balance = new AccountBalance();
        balance.setUserId(userId);
        Example<AccountBalance> example = Example.of(balance);
        
        List<AccountBalance> abs = accountBlanceRepository.findAll(example);
        if(abs.size() > 0){
            return abs.get(0);
        }
        return null;
    }

    @Transactional
    @Override
    public void updateAccountBalance(AccountBalance ab) {
        accountBlanceRepository.updateBalance(ab.getId(), ab.getBalance());
    }
}
