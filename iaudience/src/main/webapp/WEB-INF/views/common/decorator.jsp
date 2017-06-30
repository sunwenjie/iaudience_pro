<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="commonTag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><sitemesh:title /></title>
<link rel="shortcut icon" href="/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
<meta name="viewport" content="initial-scale=1,maximum-scale=1" />

<link rel="stylesheet" type="text/css" href="${static_path}/css/google-font.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/bootstrap/css/bootstrap.min.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/bootstrap_iaccess.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/font-awesome.min.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/head.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/index.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/chosen.css?v_time=${v_time}">
<%-- <link rel="stylesheet" type="text/css" href="${static_path}/css/jquery.treetable.theme.default.css?v_time=${v_time}">
<link rel="stylesheet" type="text/css" href="${static_path}/css/jquery.treetable.css?v_time=${v_time}"> --%>


<script type="text/javascript" src="${static_path}/js/jquery-1.7.1.min.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/common.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/hogan-2.0.0.min.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/bootstrap/js/bootstrap.min.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/iax-tool.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/chosen.jquery.min.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/underscore-min.js?v_time=${v_time}"></script>

<%-- <script type="text/javascript" src="${static_path}/js/iax-template.js?v_time=${v_time}"></script> --%>

<sitemesh:head />
</head>

<body>
  <div class="container">
    <%@ include file="header.jsp"%>
    <div class="x-main">
	    <%@ include file="left.jsp"%>
	    <sitemesh:body />
    </div>
    <div class="clearfooter"></div>
  	<!--container end-->
  	<%@ include file="footer.jsp"%>
  </div>
</body>
</html>