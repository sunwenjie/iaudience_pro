<%@page import="org.springframework.context.i18n.LocaleContextHolder"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<%
    final String path = request.getContextPath();
	request.setAttribute("path", path);

	final String queryString = request.getQueryString() == null
			? ""
			: request.getQueryString().replaceAll(
					"&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]",
					"");
	request.setAttribute("query", queryString);

	Locale locale = LocaleContextHolder.getLocale();
	String lang = locale.getLanguage();
	request.setAttribute("lang", lang);
%>
<c:set var="xquery" value="${fn:escapeXml(query)}" />
<c:set var="currentUrl" value="${xquery}${not empty xquery ? '&' : '?'}locale=" />