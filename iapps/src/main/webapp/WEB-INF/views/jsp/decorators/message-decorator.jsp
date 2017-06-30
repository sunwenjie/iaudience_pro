<%@ page import="org.springframework.context.i18n.LocaleContextHolder"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>

<%@ include file="../include/init.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property='title' /></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
<meta name="viewport" content="initial-scale=1,maximum-scale=1" />
<%@ include file="../include/static.jsp"%>
</head>
<body data-target="#x-sidebar" id="scroll-spy" data-offset="-340">
	<div class="container">
		<!--头部-->
		<div class="myheading">
			<nav class="navbar navbar-inverse">
				<div class="x-navbar">
					<div class="container-fluid">
						<div class="navbar-header">
							<a href="http://xmostg.optimix.asia/" class="navbar-brand" data-toggle="offcanvas">
								<img src="http://xmostg.optimix.asia/images/logo/xmo.optimix.asia.png" alt="" style="" width="120" height="50">
							</a>
						</div>

						<div class="collapse navbar-collapse clearfix" id="bs-example-navbar-collapse-1">
							<!-- Single button -->
							<%@ include file="../advertiser/select-list.jsp" %>
							
							<div class="x-top-menu">
								<ul class="nav navbar-nav">
									<li class="">
										<a href="#">
											<spring:message code="main.decorator.nav.symphony" />
										</a>
									</li>

									<li class="<c:if test="${param.moduleId eq 1 }">selected</c:if>">
										<a href="${path}/app/related_list?moduleId=1">
											<spring:message code="main.decorator.nav.iaudience" />
										</a>
									</li>

									<li class="<c:if test="${param.moduleId eq 2 }">selected</c:if>">
										<a href="${path}/app/related_list?moduleId=2">
											<spring:message code="main.decorator.nav.iaccess" />
										</a>
									</li>

									<li class="<c:if test="${param.moduleId eq 3 }">selected</c:if>">
										<a href="${path}/app/related_list?moduleId=3">
											<spring:message code="main.decorator.nav.iactivate" />
										</a>
									</li>

									<li class="<c:if test="${param.moduleId eq 4 }">selected</c:if>">
										<a href="${path}/app/related_list?moduleId=4">
											<spring:message code="main.decorator.nav.iexperience" />
										</a>
									</li>

									<li class="<c:if test="${param.moduleId eq 5 }">selected</c:if>">
										<a href="${path}/app/related_list?moduleId=5">
											<spring:message code="main.decorator.nav.insights" />
										</a>
									</li>
									<li class='<c:if test="${empty param.moduleId }">selected</c:if>'>
										<a href="${path}/app/list">
											<spring:message code="main.decorator.nav.iapps" />
										</a>
									</li>
								</ul>
							</div>
							<!-- Single button -->
							<div class="x-user-main  navbar-right">
								<div class="x-user-con" style="max-width: 135px; background: none">
									<!-- <img class="x-user " src="https://git.bznx.net/assets/logo-white-ed4a8c29c69c582954818a833b737e7a.png"> -->
									<span class="x-user-dis">
										<i class="fa fa-user" style="color: #666;" aria-hidden="true"></i>
										&nbsp;
										<security:authentication property="principal.username" />
									</span>
									<i class="fa fa-caret-down fa-fw head_drop_down" aria-hidden="true"></i>
								</div>

								<ul class="x-user-list">
									<span class="nav-arrow"></span>
									<li>
										<a href="#" class="x-user-config">
											<i class="fa fa-user-o icon_setting">
											</i>
											<spring:message code="main.decorator.user.accountinfo" />
										</a>
									</li>
									<li>
										<a href="#" class="x-user-config">
											<span class="fa fa-lock icon_setting">
											</span>
											<spring:message code="main.decorator.user.changepass" />
										</a>
									</li>
									<li>
										<a href="${path}/logout" class="x-user-config">
											<span class="fa fa-sign-out icon_setting">
											</span>
											<spring:message code="main.decorator.user.logout" />
										</a>
									</li>
								</ul>
							</div>

							<div class="navbar-form navbar-right">
								<a href="javascript:void(0);">
									<i class="fa fa-question-circle" aria-hidden="true"></i>
									&nbsp;
									<spring:message code="main.decorator.nav.faqs" />
								</a>
							</div>
							<div class="x-user-main navbar-right">
								<div class="x-user-con" style="max-width: 135px; background: none; position: relative;">
									<span class="fa fa-bell" style="color: #acb0bc; font-size: 24px; line-height: 32px; padding: 5px;" aria-hidden="true"></span>
									&nbsp;
									<i class="bell-tip" aria-hidden="true" style="position: absolute; top: 5px; right: 12px;">2</i>
								</div>
								<ul class="x-user-list" style="width: 350px; left: -150px;" id="notifys">
									<span class="nav-arrow" style="left: 50%"></span>
									<li>
										<a href="${path}/message/list" style="width: 360px; display: inline-block; font-weight: bold">
											<spring:message code="symphony.notification.all_message" />
										</a>
									</li>
									<hr style="margin: 5px 0">
									<div style="height: 33px; text-align: center;">
										<label style="line-height: 33px; color: #acb0bc;">
											<spring:message code="symphony.notification.no_unread_message" />
										</label>
									</div>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>

		<sitemesh:write property='body' />
		
		<!-- footer -->
		<div class="clearfooter"></div>
		<div class="myfooter">
			<label class="x-footer"> Copyright © 2012 - 2017 iClick Technology,iClick Beijing,ICP 14026918. All Rights Reserved.</label>
		</div>
	</div>
	<!--container end-->
	<div class="modal fade slide-box" style="display: none;">
	</div>
</body>
<script type="text/javascript">
	$(function() {
		loadMoreNotifications();
		
		$('#noti-more').click(function(){
			loadMoreNotifications();
		})
		
		function loadMoreNotifications(){
			var pageNum = $('#pageNumber').val();
			$.get('${path}/message/list/data',{
				pageNumber : pageNum
			},function(data){
				if(data){
					var messages = data.content;
					if(messages.length < 1){
						$('.noti-more label').text('No more Notifications');
					}else{
						$.each(messages,function(index, value, array) {
							var html = '<div class="notification-title">' + value.title + '&nbsp;&nbsp;' + value.sendTime + '</div>'
					        	html += '<div class="notification-item">';
					            html += value.content;
					        	html += '</div>';
					        $('.noti-more').before(html);
						});
						$('#pageNumber').val(pageNum + 1);
					}
				}
			},'json')
		}
		
	});
</script>
</html>
