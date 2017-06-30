<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ include file="../include/init.jsp"%>
<title><spring:message code="symphony.notification.title" /></title>
<div class="x-main x-welcome">
<div class="x-sidebar" id="x-sidebar">
	<c:choose>
		<c:when test="${lang eq 'zh' }">
			<ul class="x-menu-lang">
				<li>
					<a href="${currentUrl}en">
						<i class="fa fa-cog fa-globe" aria-hidden="true"></i>
						<span class="x-m8">langauage English</span>
					</a>
				</li>
			</ul>
		</c:when>
		<c:otherwise>
			<ul class="x-menu-lang">
				<li>
					<a href="${currentUrl}zh_CN">
						<i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility: hidden;"></i>
						<span class="x-m8">简体中文</span>
					</a>
				</li>
			</ul>
		</c:otherwise>
	</c:choose>
</div>
<div class="x-body" id="x-body">
	<div class="page_title">
		<div class="row">
			<div class="main-title"><spring:message code="symphony.notification.title" /> </div>
		</div>
	</div>
	<div class="notification-content">
		<div class="notification-detail">
	        <div class="notification-item noti-more">
	          <label style="text-align:center">
	          	<a id="noti-more" href="#"><spring:message code="symphony.notification.more" /></a>
	          </label>
	          <input id="pageNumber" name="pageNumber" type="hidden" value="0" >
	        </div>
	    </div>
	</div>
</div>
	<div class="clearboth"></div>
</div>