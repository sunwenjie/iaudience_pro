package com.iclick.symphony.iapps.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iclick.infrastructure.common.user.domain.EnhancedUserDetails;
import com.iclick.infrastructure.common.user.utils.UserUtil;
import com.iclick.symphony.iapps.domain.AppInfo;
import com.iclick.symphony.iapps.domain.JsonResult;
import com.iclick.symphony.iapps.domain.SiteMessage;
import com.iclick.symphony.iapps.service.AppInfoService;
import com.iclick.symphony.iapps.service.SiteMessageService;

@Controller
@RequestMapping("/message")
public class SiteMessageController extends BaseController {
    
    @Autowired
    private SiteMessageService siteMessageService;
    
    @Autowired
    private AppInfoService appInfoService;
    
    @ResponseBody
    @RequestMapping("/send/getapp")
    public JsonResult sendGetAppMessage(HttpServletRequest request, Integer appId,String priceId){
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
        
        EnhancedUserDetails u = UserUtil.getLoginUser();
        Integer agencyId = u.getAgencyId();
        String locale = LocaleContextHolder.getLocale().getLanguage();
        
        String appInfoUrl = getAppInfoUrl(request,appId,priceId);
        
        try{
            siteMessageService.sendGetAppMessage(u.getId(),agencyId,appInfoUrl,locale);
            result.setSuccess(true);
        }catch (Exception e) {
            result.setErrorMsg(e.getMessage());
        }
        
        return result;
    }
    
    private String getAppInfoUrl(HttpServletRequest request, Integer appId, String priceId) {
        String basePath = request.getScheme() + "://" +request.getServerName() + ":" + 
                request.getServerPort() + request.getContextPath() + "/";
        String url = basePath + "app/list?openAppId=" + appId;
        if(StringUtils.isNotBlank(priceId)){
            url += "&priceId=" + priceId;
        }
        return  url;
    }

    @ResponseBody
    @RequestMapping("/send/purcharge")
    public JsonResult sendPurchargeMessage(HttpServletRequest request,Integer appId,String priceId){
        JsonResult result = new JsonResult();
        
        EnhancedUserDetails u = UserUtil.getLoginUser();
        Integer agencyId = u.getAgencyId();
        String locale = LocaleContextHolder.getLocale().getLanguage();
        
        String appInfoUrl = getAppInfoUrl(request,appId,priceId);
        
        try{
            siteMessageService.sendPurchargeMessage(u.getId(),agencyId,appInfoUrl,locale);
            result.setSuccess(true);
        }catch (Exception e) {
            result.setErrorMsg(e.getMessage());
        }
        
        return result;
    }
    
    @ResponseBody
    @RequestMapping("/notify")
    public JsonResult getMessageNotify(){
        JsonResult result = new JsonResult();
        Integer userId = UserUtil.getLoginUserId();
        try{
            long num = siteMessageService.getUnreadMessageCount(userId);
            result.setSuccess(true);
            result.setData(num);
        }catch (Exception e) {
            result.setErrorMsg(e.getMessage());
        }
        return result;
    }
    
    @RequestMapping("/list")
    public String toMessageListPage(){
        Integer userId = UserUtil.getLoginUserId();
        siteMessageService.readAllMessage(userId);
        return "/message/list";
    }
    
    @ResponseBody
    @RequestMapping("/list/data")
    public Page<SiteMessage> getMessageListData(
            @PageableDefault(sort={ "sendTime" },direction=Direction.DESC) 
            Pageable pageable){
        Integer userId = UserUtil.getLoginUserId();
        return siteMessageService.getSiteMessageByPage(userId,pageable);
    }
}
