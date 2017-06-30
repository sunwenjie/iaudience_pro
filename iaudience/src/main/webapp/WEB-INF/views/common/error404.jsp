<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="year" />
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
  pageContext.setAttribute("path", path);
  pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><s:message code='login.desc.welcome' /></title>
<link rel="shortcut icon" href="${path}/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
<meta name="viewport" content="initial-scale=1,maximum-scale=1" />
<link rel="stylesheet" type="text/css" href="${path}/css/google-font.css">
<link rel="stylesheet" type="text/css" href="${path}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${path}/css/index.css">
<script type="text/javascript" src="${path}/js/jquery-1.7.1.min.js"></script>
</head>

<body class="error-bg">
  <div class="error-logo">
    <img src="${path}/images/error/logo_iclick.png" alt="logo">
  </div>
  <div class="error-container">
    <label class="error-title"><s:message code='page.error.opps' /></label>
    <label class="error-sub-title"><s:message code="page.error.notfound" /></label>
    <p>
      <s:message code="page.error.backurl" />
    </p>
    <p>
      <s:message code="page.error.help" />
    </p>
    <div class="error-back">
      <button class="btn btn-default" onclick="window.location='${basePath}'">
        <s:message code='menu.desc.home' />
      </button>
    </div>
  </div>
  <div class="error-type">
    <label>404</label>
  </div>
</body>
</html>