package com.iclick.symphony.iapps.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iclick.infrastructure.common.user.domain.EnhancedUserDetails;
import com.iclick.infrastructure.common.user.utils.UserUtil;
import com.iclick.symphony.iapps.domain.AccountBalance;
import com.iclick.symphony.iapps.domain.AppActivity;
import com.iclick.symphony.iapps.domain.AppCategory;
import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.domain.JsonResult;
import com.iclick.symphony.iapps.domain.Module;
import com.iclick.symphony.iapps.domain.UserApp;
import com.iclick.symphony.iapps.service.AccountBalanceService;
import com.iclick.symphony.iapps.service.AppActivityService;
import com.iclick.symphony.iapps.service.AppCategoryService;
import com.iclick.symphony.iapps.service.AppInfoService;
import com.iclick.symphony.iapps.service.UserAppService;

@Controller
@RequestMapping("/app")
public class AppInfoController extends BaseController {
    
    @Autowired
    private AppCategoryService appCategoryService;
    
    @Autowired
    private AppInfoService appInfoService;
    
    @Autowired
    private UserAppService userAppService;
    
    @Autowired
    private AppActivityService appActivityService;
    
    @Autowired
    private AccountBalanceService accountBalanceService;
    
    @RequestMapping("/list")
    public String getAppInfoList(Model model,Integer openAppId){
        if(!UserUtil.isLogin()){
            return "redirect:/app/guest_list";
        }
        
        Set<Integer> modules = UserUtil.getUserModules();
        if(openAppId != null && openAppId > 0){
            AppInfo appInfo = appInfoService.getAppInfoById(openAppId);
            if(!hasPermission(modules, appInfo.getModules())){
                model.addAttribute("errorMsg", "您没有权限访问此app");
                return "errors/no_permission";
            }
        }
        
        List<AppActivity> activities = appActivityService.getAllActivity();
        List<AppCategory> categories = appCategoryService.getCategoriesWithApps(modules);
        List<AppInfo> apps = appInfoService.getApps(modules);
        
        Integer userId = getUserId();
        
        Map<String, AppInfo> boughtApps = appInfoService.getBoughtAppMap(userId);
        List<AppInfo> featuredAppInfos = appInfoService.getFeatruedApps(modules);
        AccountBalance ab = accountBalanceService.getUserAccountBalance(userId);
        
        model.addAttribute("openAppId", openAppId);
        model.addAttribute("featuredAppInfos",featuredAppInfos);
        model.addAttribute("activities", activities);
        model.addAttribute("categories", categories);
        model.addAttribute("apps",apps);
        model.addAttribute("boughtApps", boughtApps);
        model.addAttribute("accountBalance", ab);
        
        return "app/list";
    }
    
    @RequestMapping("/guest_list")
    public String getGuestAppInfoList(Model model){
        if(UserUtil.isLogin()){
            return "redirect:/app/list";
        }
        
        List<AppActivity> activities = appActivityService.getAllActivity();
        List<AppCategory> categories = appCategoryService.getCategoriesWithApps();
        List<AppInfo> apps = appInfoService.getAllApps();
        List<AppInfo> featuredAppInfos = appInfoService.getFeatruedApps();
        
        model.addAttribute("featuredAppInfos",featuredAppInfos);
        model.addAttribute("activities", activities);
        model.addAttribute("categories", categories);
        model.addAttribute("apps",apps);
        
        return "app/guest_list";
    }
    
    @RequestMapping("/related_list")
    public String getRelatedAppInfoList(Integer moduleId, Model model){
        
        Set<Integer> modules = UserUtil.getUserModules();
        if(moduleId != null && moduleId > 0 && modules.contains(moduleId) ){
            Set<Integer> m = new HashSet<Integer>();
            m.add(moduleId);
            Integer userId = getUserId();
            List<AppInfo> apps = appInfoService.getApps(m);
            List<AppInfo> myApps = appInfoService.getMyApps(m,userId);
            
            Map<String, AppInfo> boughtApps = appInfoService.getBoughtAppMap(userId);
            AccountBalance ab = accountBalanceService.getUserAccountBalance(userId);
            
            model.addAttribute("boughtApps", boughtApps);
            model.addAttribute("apps",apps);
            model.addAttribute("myApps",myApps);
            model.addAttribute("accountBalance", ab);
        }else{
            model.addAttribute("errorMsg", 
                    messages.getMessage("app.controller.param_incorrect.no_permission",new Object[]{"moduleId"}));
        }
        
        return "app/related_list";
    }
    
    @RequestMapping("/myapp_list")
    public String getMyAppInfoList(Integer moduleId, Model model){
        
        Set<Integer> modules = UserUtil.getUserModules();
        
        Integer userId = getUserId();
        List<AppCategory> categories = appCategoryService.getCategories();
        List<AppInfo> apps = appInfoService.getApps(modules);
        List<AppInfo> myApps = appInfoService.getMyApps(modules,userId);
        
        Map<String, AppInfo> boughtApps = appInfoService.getBoughtAppMap(userId);
        
        model.addAttribute("boughtApps", boughtApps);
        
        AccountBalance ab = accountBalanceService.getUserAccountBalance(userId);
        model.addAttribute("categories",categories);
        model.addAttribute("apps",apps);
        model.addAttribute("myApps",myApps);
        model.addAttribute("accountBalance", ab);
        
        return "app/myapp_list";
    }
    
    @RequestMapping("/detail")
    public String getAppInfoDetail(Integer appId,Integer moduleId, Model model){
        String errorMsg = null;
        if(appId != null && appId > 0){
            Set<Integer> modules = UserUtil.getUserModules();
            
            AppInfo app = appInfoService.getAppInfoById(appId);
            if(app != null){
                model.addAttribute("app",app);
                
                Set<Integer> moduleIds = new HashSet<Integer>();
                if(moduleId != null && moduleId > 0 && modules.contains(moduleId) ){
                    moduleIds.add(moduleId);
                }else{
                    moduleIds.addAll(modules);
                }
                Integer userId = getUserId();
                AccountBalance ab = accountBalanceService.getUserAccountBalance(userId);
                List<AppInfo> myApps = appInfoService.getMyApps(moduleIds,userId);
                Map<String, AppInfo> boughtApps = appInfoService.getBoughtAppMap(userId);
                
                model.addAttribute("myApps",myApps);
                model.addAttribute("boughtApps",boughtApps);
                model.addAttribute("accountBalance", ab);
               
            }else{
                errorMsg = messages.getMessage("app.controller.object_not_exist",new Object[]{"appInfo"});
            }
        }else{
            errorMsg = messages.getMessage("app.controller.param_incorrect",new Object[]{"appId"}); 
        }
        
        model.addAttribute("errorMsg",errorMsg);
        
        return "app/detail";
    }

    @ResponseBody
    @RequestMapping("/get")
    public JsonResult getApp(Integer appId,Integer priceId){
        
        JsonResult result = validate(appId,priceId);
        if(StringUtils.isNotBlank(result.getErrorMsg())){
            return result;
        }
        
        Integer userId = UserUtil.getLoginUserId();
        try{
            userAppService.saveUserApp((AppInfo) result.getData(),userId,priceId);
            result.setSuccess(true); 
            result.setData(null);
        }catch (Exception e) {
            result.setErrorMsg(
                    messages.getMessage("app.controller.get_failure", new Object[]{e.getMessage()}));
        }
                    
        return result;
    }
    
    @ResponseBody
    @RequestMapping("/bind")
    public JsonResult bidApp(Integer appId){
        JsonResult result = new JsonResult();
        if(appId == null || appId < 1){
            result.setErrorMsg(
                    messages.getMessage("app.controller.param_incorrect", new Object[]{"appId"}));
            return result;
        }
        
        AppInfo app = appInfoService.getAppInfoById(appId);
        if(app == null){
            result.setErrorMsg(
                    messages.getMessage("app.controller.object_not_exist", new Object[]{"appInfo"}));
            return result;
        }
        
        Integer userId = UserUtil.getLoginUserId();
        try{
            userAppService.saveUserApp(app,userId);
            result.setSuccess(true); 
        }catch (Exception e) {
            result.setErrorMsg(
                    messages.getMessage("app.controller.get_failure", new Object[]{e.getMessage()}));
        }
                    
        return result;
    }
    
    private JsonResult validate(Integer appId, Integer priceId) {
        JsonResult result = new JsonResult();
        if(appId == null || appId < 1 || priceId == null || priceId < 1){
            result.setErrorMsg(
                    messages.getMessage("app.controller.param_incorrect", new Object[]{"appId or priceId"}));
            return result;
        }
        
        AppInfo app = appInfoService.getAppInfoById(appId);
        if(app == null){
            result.setErrorMsg(
                    messages.getMessage("app.controller.object_not_exist", new Object[]{"appInfo"}));
            return result;
        }
        
        Set<Module> m = app.getModules();
        Set<Integer> modules = UserUtil.getUserModules();
        if(!hasPermission(modules,m)){
            result.setErrorMsg(
                    messages.getMessage("app.controller.no_permission"));
            return result;
        }
        
        result.setData(app);
        return result;
    }

    @ResponseBody
    @RequestMapping("/update")
    public JsonResult updateApp(Integer appId){
        JsonResult result = new JsonResult();
        if(appId == null || appId < 1){
            result.setErrorMsg(
                    messages.getMessage("app.controller.param_incorrect", new Object[]{"appId"}));
            return result;
        }
        
        Integer userId = getUserId();
        Set<Integer> modules = UserUtil.getUserModules();
        UserApp ua = userAppService.getByUserId(appId,userId);
        
        if(ua == null || ua.getAppInfo() == null){
            result.setErrorMsg(
                    messages.getMessage("app.controller.object_not_exist", new Object[]{"appInfo"}));
            return result;
        }
        
        AppInfo app = ua.getAppInfo();
        Set<Module> m = app.getModules();
        if(!hasPermission(modules,m)){
            result.setErrorMsg(
                    messages.getMessage("app.controller.no_permission"));
            return result;
        }
        
        try{
            userAppService.updateUserApp(ua);
            result.setSuccess(true);
        }catch (Exception e) {
            result.setErrorMsg(
                    messages.getMessage("app.controller.update_failure", new Object[]{e.getMessage()}));
        }
        
        return result;
    }
    
    @RequestMapping("/open")
    public JsonResult openApp(Integer appId,Model model){
        JsonResult result = new JsonResult();
        if(appId == null || appId < 1){
            result.setErrorMsg(
                   messages.getMessage("app.controller.param_incorrect", new Object[]{"appId"}));
            return result;
        }
        
        Set<Integer> modules = UserUtil.getUserModules();
        AppInfo app = appInfoService.getAppInfoById(appId);
        if(app == null){
            result.setErrorMsg(
                    messages.getMessage("app.controller.object_not_exist", new Object[]{"appInfo"}));
            return result;
        }
        
        Set<Module> m = app.getModules();
        if(!hasPermission(modules,m)){
            result.setErrorMsg(
                    messages.getMessage("app.controller.no_permission"));
            return result;
        }
        
        Integer userId = getUserId();
        if(isExpired(app,userId)){
            result.setErrorMsg(
                    messages.getMessage("app.controller.expired"));
            return result;
        }
        
        result.setSuccess(true);
        result.setData(app.getIndexUrl());
        return result;
    }
    
    @ResponseBody
    @RequestMapping("/purcharge")
    public JsonResult openApp(Integer appId,Integer priceId,Model model){
        JsonResult result = validate(appId,priceId);
        if(StringUtils.isNotBlank(result.getErrorMsg())){
            return result;
        }
        
        Integer userId = UserUtil.getLoginUserId();
        try{
            userAppService.purchargeApp((AppInfo)result.getData(),userId,priceId);
            result.setSuccess(true);
        }catch (Exception e) {
            result.setErrorMsg(
                    messages.getMessage("app.controller.purcharge.error"));
        }
        
        return result;
    }
    
    
    private Integer getUserId(){
        EnhancedUserDetails u = UserUtil.getLoginUser();
        if(u == null){
            return null;
        }
        
        if(u.getAgencyId() > 1 && u.getAgencyId() != u.getId()){
            return u.getAgencyId();
        }
        
        return u.getId();
    }

    private boolean isExpired(AppInfo app,Integer userId) {
        UserApp ua = userAppService.getByUserId(app.getId(),userId);
        if(ua == null){
            return true;
        }
        
        if((ua.getBuyNum() > 0 && ua.getUseNum() >= ua.getBuyNum()) || (ua.getExpireTime() != null && new Date().after(ua.getExpireTime()))){
            return true;
        }
        
        return false;
    }

    private boolean hasPermission(Set<Integer> moduleIds, Set<Module> modules) {
        for(Module m : modules){
            if(moduleIds.contains(m.getId())){
                return true;
            }
        }
        return false;
    }
}
