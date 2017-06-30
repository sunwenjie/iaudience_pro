<%@page import="com.iclick.infrastructure.common.user.utils.UserUtil"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<% 
	if(UserUtil.isLogin()){
	    response.sendRedirect("app/list"); 
	}else{
	    response.sendRedirect("app/guest_list");
	}
%>
