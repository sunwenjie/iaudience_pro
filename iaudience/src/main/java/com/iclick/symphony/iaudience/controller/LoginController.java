package com.iclick.symphony.iaudience.controller;

import com.iclick.symphony.iaudience.model.remote.AudienceLogin;
import com.iclick.symphony.iaudience.model.view.UserModel;
import com.iclick.symphony.iaudience.service.UserSerivce;
import com.iclick.symphony.iaudience.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by wenjie.sun on 2017/6/27.
 */
@Controller
@SessionAttributes("user")
@RequestMapping(value = "/login")
public class LoginController {
    @Resource
    private UserSerivce userSerivce;

    @RequestMapping(method = RequestMethod.GET)
    public String login(HttpServletRequest request,Model model) {
        UserModel user = (UserModel) model.asMap().get("user");
        if (user != null){
            return "redirect:/audiencePlan";
        }
        return "/login";
    }

    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    public String doLogin(HttpServletRequest request,RedirectAttributes redirectAttributes,Model model) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("username:"+username+",password:"+password);
        AudienceLogin audienceLogin = userSerivce.verifyUser(username,password);
        if (audienceLogin.getError_code() == 0){
            //设置session
            UserModel userModel = new UserModel();
            userModel.setId(audienceLogin.getRet_msg().getUserid());
            userModel.setName(username);
            model.addAttribute("user",userModel);
        }else {
            redirectAttributes.addFlashAttribute("error", CommonUtil.getProperty(request,"audiencePlan.login.fail"));
            return "redirect:/login";
        }
        return "redirect:/audiencePlan";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return "/login";
    }


}
