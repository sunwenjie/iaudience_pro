package com.iclick.symphony.iapps.service.impl;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iclick.symphony.iapps.domain.AccountBalance;
import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.domain.AppPurchaseRecord;
import com.iclick.symphony.iapps.domain.AppPurchaseStrategy;
import com.iclick.symphony.iapps.domain.ExchangeRate;
import com.iclick.symphony.iapps.domain.UserApp;
import com.iclick.symphony.iapps.repository.AppInfoRepository;
import com.iclick.symphony.iapps.repository.AppPurchaseRecordRepository;
import com.iclick.symphony.iapps.repository.AppPurchaseStrategyRepository;
import com.iclick.symphony.iapps.repository.UserAppRepository;
import com.iclick.symphony.iapps.service.AccountBalanceService;
import com.iclick.symphony.iapps.service.ExchangeRateService;
import com.iclick.symphony.iapps.service.UserAppService;

@Service
public class UserAppServiceImpl extends BaseService implements UserAppService {
    
    @Autowired
    private UserAppRepository userAppRepository;
    
    @Autowired
    private AccountBalanceService accountBalanceService;
    
    @Autowired
    private ExchangeRateService exchangeRateService;
    
    @Autowired
    private AppPurchaseRecordRepository appPurchaseRecordRepository;
    
    @Autowired
    private AppPurchaseStrategyRepository appPurchaseStrategyRepository;
    
    @Autowired
    private AppInfoRepository appInfoRepository;
    
    @Transactional
    @Override
    public void saveUserApp(AppInfo app, Integer userId, Integer priceId) {
        
        UserApp ua = userAppRepository.getByAppKeyAndUserId(app.getAppKey(),userId); 
        
        if(ua != null){
            throw new RuntimeException("The app had been bought");
        }
        
        AppPurchaseStrategy strategy = appPurchaseStrategyRepository.findOne(priceId);
        AccountBalance ab = accountBalanceService.getUserAccountBalance(userId);
        
        BigDecimal price = BigDecimal.ZERO;
        if(ab.getUnit() == strategy.getCurrencyUnit()){
            price = strategy.getPrice();
        }else{
           ExchangeRate rate = exchangeRateService.getRateByUnit(strategy.getCurrencyUnit(),ab.getUnit());
           if(rate == null || rate.getRate() == null){
               price = strategy.getPrice();
           }else{
               price = strategy.getPrice().multiply(rate.getRate());
           }
        }
        BigDecimal balance = ab.getBalance().subtract(price);
        if(balance.doubleValue() < 0){
            throw new RuntimeException("Balance is not enough");
        }
        ab.setBalance(balance);
        
        accountBalanceService.updateAccountBalance(ab);
        UserApp userApp = new UserApp();
        userApp.setAppInfo(app);
        userApp.setActiveTime(new Date());
        if(strategy.getType() == 2){
            userApp.setBuyNum(strategy.getNum());
        }
       
        Date today = new Date();
        if(strategy.getType() == 3){
            userApp.setExpireTime(DateUtils.addDays(today, strategy.getNum()));
        }else if(strategy.getType() == 4){
            userApp.setExpireTime(DateUtils.addMonths(today, strategy.getNum()));
        }else if(strategy.getType() == 5){
            userApp.setExpireTime(DateUtils.addYears(today, strategy.getNum()));
        }
        
        if(userApp.getBuyNum() == null){
            userApp.setBuyNum(0);
        }
        if(userApp.getUseNum() == null){
            userApp.setUseNum(0);
        }
        
        userApp.setUserId(userId);
        userAppRepository.save(userApp);
        
        AppPurchaseRecord record = new AppPurchaseRecord();
        record.setPurchaseTime(new Date());
        record.setPurchaseStrategyId(strategy.getId());
        
        appPurchaseRecordRepository.save(record);
    }
    
    @Transactional
    @Override
    public void saveUserApp(AppInfo app, Integer userId){
        UserApp userApp = new UserApp();
        userApp.setAppInfo(app);
        userApp.setActiveTime(new Date());
        userApp.setBuyNum(0);
        userApp.setUseNum(0);
        userApp.setUserId(userId);
        userAppRepository.save(userApp);
    }

    @Override
    public void updateUserApp(UserApp userApp) {
        String appKey = userApp.getAppInfo().getAppKey();
        
        AppInfo app = new AppInfo();
        app.setAppKey(appKey);
        app.setDel(false);
        app.setEnabled(true);
        app.setLatestVersion(true);
        AppInfo info = appInfoRepository.findOne(Example.of(app));
        userApp.setAppInfo(info);
        userAppRepository.save(userApp);
    }

    @Override
    public void purchargeApp(AppInfo app, Integer userId, Integer priceId) {
        
    }

    @Override
    public UserApp getByUserId(Integer appId, Integer userId) {
        AppInfo info = appInfoRepository.getOne(appId);
        if(info == null){
            throw new RuntimeException("Could not find app!");
        }
        
        UserApp ua = userAppRepository.getByAppKeyAndUserId(info.getAppKey(),userId); 
        
        return ua;
    }

    @Override
    public UserApp getUserApp(Integer userAppId) {
        return userAppRepository.getOne(userAppId);
    }
}
