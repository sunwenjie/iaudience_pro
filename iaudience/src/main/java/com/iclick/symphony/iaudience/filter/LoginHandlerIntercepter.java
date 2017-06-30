package com.iclick.symphony.iaudience.filter;

import com.iclick.symphony.iaudience.model.view.UserModel;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by wenjie.sun on 2017/6/29.
 */
public class LoginHandlerIntercepter implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = httpServletRequest.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user != null){
            return true;
        }else {
           String basePath = httpServletRequest.getContextPath();
//           httpServletRequest.getRequestDispatcher(basePath+"/login").forward(httpServletRequest,httpServletResponse);
            httpServletResponse.sendRedirect(basePath+"/login");
            return false;
        }

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
