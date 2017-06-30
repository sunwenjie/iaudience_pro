<%@ page language="java" contentType="text/html; charset=utf-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
	String url = request.getScheme() + "://" +request.getServerName() + ":" + 
        request.getServerPort()  + request.getContextPath() + "/";
    request.setAttribute("homeUrl",url);
%>

<c:set var="symphony_static_host">
	 <spring:eval expression="@configProperties['symphony_static_host']" />
</c:set>

<%@ page language="java" import="java.io.*" contentType="text/html; charset=utf-8" isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<title>404</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
<meta name="viewport" content="initial-scale=1,maximum-scale=1" />

<link rel="stylesheet" type="text/css" href="${symphony_static_host}/css/google-font.css">
<link rel="stylesheet" type="text/css" href="${symphony_static_host}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${symphony_static_host}/css/index.css">
<script type="text/javascript" src="${symphony_static_host}/js/jquery-1.7.1.min.js"></script>


</head>
<body class="error-bg">
	<div class="error-logo">
		<img src="${symphony_static_host}/images/error/logo_iclick.png" alt="logo">
	</div>
	<div class="error-container">
		<label class="error-title">Oops!</label> <label class="error-sub-title">Sorry, the page you requested does not exist.</label>
		<p>
			You may return to the <a href="javascript:;" onclick="history.go(-1)">previous page</a> or go to the <a href="http://symphony.optimix.asia">home page</a>.
		</p>
		<p>
			To report this issue or for additional support, please contact us at <a class="underline" href="mailto:technology@i-click.com">technology@i-click.com</a>.
		</p>
		<div class="error-back">
			<button class="btn btn-default" onclick="window.location='${homeUrl}'">Home</button>
		</div>
	</div>
	<div class="error-type">
		<label>404</label>
	</div>
</body>
</html>
