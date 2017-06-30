package com.iclick.symphony.iaudience.controller;

import com.iclick.infrastructure.common.user.utils.UserUtil;
import com.iclick.symphony.iaudience.dao.AudiencePlanRepository;
import com.iclick.symphony.iaudience.entity.AudiencePlan;
import com.iclick.symphony.iaudience.model.view.AudiencePlanModel;
import com.iclick.symphony.iaudience.model.view.City;
import com.iclick.symphony.iaudience.service.AudiencePlanService;
import com.iclick.symphony.iaudience.service.AudienceReportDataService;
import com.iclick.symphony.iaudience.util.CommonUtil;
import com.iclick.symphony.iaudience.util.Constant;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContext;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Created by wenjie.sun on 2017/5/17.
 */
@Controller
@RequestMapping("/audiencePlan")
public class AudiencePlanController {
    @Resource
    private AudiencePlanService audiencePlanService;
    @Resource
    private AudiencePlanRepository audiencePlanRepository;
    @Resource
    private AudienceReportDataService audienceReportDataService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(HttpServletRequest request, HttpServletResponse response, Model model){
        int clientId = 1001;
        List<AudiencePlan> list = audiencePlanService.getAudiencePlanList(clientId);
        if (list.isEmpty()){
            return "redirect:/create";
        }
        model.addAttribute("clientId",clientId);
        model.addAttribute("list",list);
        Map<Integer, Object> audienceMap = audienceReportDataService.getLastReportData(list);
        model.addAttribute("audienceMap",audienceMap);
        return "audiencePlan/audiencePlanList";
    }

    @RequestMapping(value = "/create",method = RequestMethod.GET)
    public String toCreate(Model model, HttpServletRequest request) {
        int clientId = 1001;
        RequestContext requestContext = new RequestContext(request);
        Locale locale = requestContext.getLocale();
        List<AudiencePlanModel> audiencePlanModelList = audiencePlanService.getAudienceModelList(clientId);
        AudiencePlanModel audiencePlanModel = new AudiencePlanModel();
        init(audiencePlanModel,locale);
        model.addAttribute("audiencePlan",audiencePlanModel);
        model.addAttribute("audiencePlanModelList", audiencePlanModelList.toString());
        model.addAttribute("audiencePlanModeSize", audiencePlanModelList.size());
        model.addAttribute("action","create");
        return "audiencePlan/audiencePlanForm";
    }

    @RequestMapping(value = "/create",method = RequestMethod.POST)
    public String create(@ModelAttribute("audiencePlan") AudiencePlanModel audiencePlanModel, HttpServletRequest request,RedirectAttributes redirectAttributes) {
        Boolean success = saveOrUpdate(audiencePlanModel);
        redirectAttributes.addFlashAttribute("message", success ? CommonUtil.getProperty(request,"plan.create.success") :  CommonUtil.getProperty(request,"plan.create.fail"));
        return "redirect:/audiencePlan";
    }

    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String toUpdate(@PathVariable("id") int id, Model model, HttpServletRequest request) {
        int clientId = 1001;
        RequestContext requestContext = new RequestContext(request);
        Locale locale = requestContext.getLocale();
        List<AudiencePlanModel> audiencePlanModelList = audiencePlanService.getAudienceModelList(clientId);
        AudiencePlanModel audiencePlanModel = audiencePlanService.getAudiencePlanModel(id);
        init(audiencePlanModel,locale);
        model.addAttribute("audiencePlan",audiencePlanModel);
        model.addAttribute("audiencePlanModelList", audiencePlanModelList.toString());
        model.addAttribute("audiencePlanModeSize", audiencePlanModelList.size());
        model.addAttribute("action","update");
        return "audiencePlan/audiencePlanForm";
    }

    @RequestMapping(value = "update",method = RequestMethod.POST)
    public String update(@ModelAttribute("audiencePlan") AudiencePlanModel audiencePlanModel,HttpServletRequest request,RedirectAttributes redirectAttributes){
        Boolean success = saveOrUpdate(audiencePlanModel);
        if (success){
            AudiencePlan audiencePlan = audiencePlanRepository.findOne(audiencePlanModel.getPlanId());
            audienceReportDataService.updateAnalyseStatus(audiencePlan, Constant.UNSTART);
        }
        redirectAttributes.addFlashAttribute("message", success ? CommonUtil.getProperty(request,"plan.update.success") :  CommonUtil.getProperty(request,"plan.update.fail"));
        return "redirect:/audiencePlan";
    }

    @RequestMapping(value = "delete/{id}",method = RequestMethod.GET)
    public String delete(@PathVariable("id") int id,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes){
        audiencePlanService.deleteAudiencePlan(id);
        redirectAttributes.addFlashAttribute("message", CommonUtil.getProperty(request, "plan.delete.success"));
        return "redirect:/audiencePlan";
    }

    /**
     * 初始化页面信息
     *
     * @param audiencePlanModel
     * @param locale
     */

    private void init(AudiencePlanModel audiencePlanModel, Locale locale) {
        String interestLab = audiencePlanService.getInterestList(locale);
        List<City> cityList = getCityNameList(locale);
        if (audiencePlanModel.getCategoryId() != null){
         audiencePlanModel.setCategoryName(audiencePlanService.getInterestName(audiencePlanModel.getCategoryId(),locale));
        }
        audiencePlanModel.setInterestLab(interestLab);
        audiencePlanModel.setCityArray(cityList);
    }



    /**
     * 获得地域的名称
     * @param locale
     * @return 地域名称列表
     */

    public List<City> getCityNameList(Locale locale) {
        if (Locale.ENGLISH.equals(locale)) {
            return audiencePlanService.getCityNameEnList();
        }
        return audiencePlanService.getCityNameCnList();
    }

    private Boolean saveOrUpdate(AudiencePlanModel audiencePlanModel){
        Integer userId = UserUtil.getLoginUserId();
        audiencePlanModel.setUserId(userId);
        return audiencePlanService.saveOrUpdate(audiencePlanModel);
    }



}
