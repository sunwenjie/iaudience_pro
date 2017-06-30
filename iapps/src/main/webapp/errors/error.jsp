<%@ page language="java" import="java.io.*" contentType="text/html; charset=utf-8" isErrorPage="true"%>

<h1>ERROR</h1> 

Message:
<%=exception.getMessage()%>

StackTrace:
<%
	StringWriter stringWriter = new StringWriter();
	PrintWriter printWriter = new PrintWriter(stringWriter);
	exception.printStackTrace(printWriter);
	out.println(stringWriter);
	printWriter.close();
	stringWriter.close();
%>