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
		function doActived(self) {
			var isSelected = $(self).parent().hasClass("selected");
			$('#x-sidebar').find(".selected").removeClass("selected");
			$('#x-sidebar').find(".actived").removeClass("actived");
			$(self).parent().addClass("actived");
			if ($(self).parent().parent().hasClass("sub-menu")) {
				$(self).parent().parent().parent().addClass("selected");
			} else {
				$(self).parent().addClass("selected");
			}
		}
		//根据#获取高亮nav
		var url = window.location.href;
		if (url.split("#").length > 1) {
			var navId = url.split("#").pop();
			var $navLi = $("[href='#" + navId + "']:last");
			doActived($navLi);
		}
		//滚动监听
		$('#x-sidebar').scrollspy();

		$(".x-menu>li>a").unbind("click");
		$(".sub-menu>li>a").unbind("click");
		var offset = $(".myheading").height() + 5;

		$('.x-menu li a').click(function(event) {
			if ($(window).width() > 1280) {
				event.preventDefault();
				$($(this).attr('href'))[0]
						&& $($(this).attr('href'))[0].scrollIntoView();
				scrollBy(0, -offset);
			}
			//新增，不滚动监听所需内容
			doActived(this);
		});

		$(document).on("click",".slide-box .sub-nav-tabs a",function(e) {
			e.preventDefault();
			$(this).tab('show');
		});
		
		$(document).on("click",".feature-dropdown li:not(.divider)",function() {
			var $submenu = $(this).find(".sub-drop-menu");
			var hasChild = $submenu.length > 0;
			if (hasChild) {
				$(this).parent().parent().addClass("open");
				$submenu.css("display", "block");
			}
		});
		
		$(document).on("click",".toAccountSet",function() {
			var appId = $(this).parents('.btn-group').children('input[name="appId"]').val();
			var params = [];
			params.push({
				'input' : {'name' : 'email','placeholder' : 'Email','type' : 'text','ico-css' : 'fa-envelope'}
			});
			params.push({
				'input' : {'name' : 'password','placeholder' : 'Password','type' : 'password','ico-css' : 'fa-lock'}
			});
			
			IAX_TOOL.loginForm({
				'title' : 'Login',
				'subTitle' : 'Please bind the 3rd party account to symphony.',
				'action' : '',
				'params' : params,
				'fn' : 'toLogin(this,'+ appId +')',
				'save' : 'Login',
				'cancel' : 'Cancel'
			});
		});
		
		$(document).on("click",".toSignRequest",function() {
			var selectApp = $(this).parents(
					".feature-container").find(
					".feature-container-title").find("p:first")
					.text();
			
			var appPrice = $(this).find("a").text();
			var appId = $(this).parents('.btn-group').children('input[name="appId"]').val();
			var priceId = $(this).data('value');
			
			<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_AGENCY_MANAGER')">
			var params = [];
			params.push({
				'input' : {'name' : 'email','placeholder' : 'Email','type' : 'text','ico-css' : 'fa-envelope'}
			});
			params.push({
				'input' : {'name' : 'password','placeholder' : 'Password','type' : 'password','ico-css' : 'fa-lock'}
			});
			
			IAX_TOOL.loginForm({
				'title' : 'Login',
				'subTitle' : 'Please login to confirm the app purchase.',
				'action' : '',
				'params' : params,
				'selectApp' : selectApp,
				'appPrice' : appPrice,
				'accountBalance' : '${accountBalance.display}',
				'fn' : 'toBuy(this,' + appId + ',' + priceId +')',
				'save' : 'Buy',
				'cancel' : 'Cancel'
			});
			</security:authorize>
			<security:authorize access="hasRole('ROLE_AGENCY')">
			IAX_TOOL.loginForm({
	            'title':'Request Purchase',
	            'subTitle':'Send a request to angecy manager for app purchase.',
	            'action':'',
	            'selectApp':selectApp,
	            'appPrice':appPrice,
	            'accountBalance':'${accountBalance.display}',
	            'fn':'toSend(this,' + appId + ')',
	            'save':'Send',
	            'cancel':'Later'
	          });
			</security:authorize>
		});
		
		$('.sign-in-box').on('hidden.bs.modal', function() {
			$("body").addClass("modal-open");
		})
		
		//搜索功能
		$(document).on("keyup",".feature-sidebar-search .input-search",function(e) {
			var event = e || window.event;
			var this_val = $.trim($(this).val());
			if (e.keyCode != 13 && this_val != "")
				return;
			$("#feature-noresult").remove();
			if (this_val != "") {
				var reg = new RegExp(this_val, "gi");
				var searchResult = $(".feature-sidebar-result")
						.find("li").find("a").map(function() {
							return {
								"obj" : $(this).parent(),
								"text" : $(this).text()
							};
						}).get();
				$(".feature-sidebar-result").find("li").hide();
				var nores = 0;
				for (var i = 0; i < searchResult.length; i++) {
					if (reg.test(searchResult[i]["text"])) {
						searchResult[i]["obj"].show();
						nores = 1;
					}
					reg.lastIndex = 0;
				}
				
				if (nores == 0) {
					$(".feature-sidebar-result")
							.find("ul")
							.append("<li id='feature-noresult'>No results.</li>")
				}
			} else {
				$(".feature-sidebar-result").find("li").show();
			}
		});
		
		$(document).on("click",".feature-item :not(.btn) :not(.dropdown-menu a)",function(event) {
			var event = event || window.event;
			if ($(this)[0].tagName != "LI"
					&& $(this)[0].tagName != "UL"
					&& $(this)[0].tagName != "BUTTON") {
				var appId = $(this).parents('.feature-item')
					.children('input[name="appId"]').val();
				$.get('${path}/app/detail',{
					appId:appId
				},function(data,status,xhr){
					$(".slide-box").empty()
						.html(data)
						.modal("show");
				},'html');
			}
			event.stopPropagation();
		});
		
		$(document).on("click",".update-app",function() {
			var $parent = $(this).parent();
			var appId = $parent.children('input[name="appId"]').val();
			$parent.html("Updating...");
			$.post('${path}/app/update',{
				appId:appId
			},function(data, textStatus, jqXHR){
				if(data.success){
					$parent.html('<input type="hidden" name="appId" value="' + appId + '" />' +
							'<button type="button" class="btn btn-danger btn-xs open-app">' + 
							'<spring:message code="app.open.button.name" />&nbsp;&nbsp;' + 
							'<span class="">&nbsp;</span>' + 
        					'<span class="sr-only">Toggle Dropdown</span></button>');
				}else{
					IAX_TOOL.notification(data.errorMsg);
				}
			},'json');
		});
		
		$(document).on("click",".open-app",function() {
			var $parent = $(this).parent();
			var appId = $(this).parents('.btn-group').children('input[name="appId"]').val();
			$.post('${path}/app/open',{
				appId:appId
			},function(data, textStatus, jqXHR){
				if(data.success){
					window.open(data.data);
				}else{
					IAX_TOOL.notification(data.errorMsg);
				}
			},'json');
		});
		
		$("#request_app [name='servie']").parent().click(function() {
			var isChecked = $(this).find("input").prop("checked");
			$(this).parent().parent().parent().next().find(
					".btn-success").attr("disabled", !isChecked);
		});
				
		if($('.scroll-imglist>ul').length > 0){
			//图片轮播
			new scrollImg({
				ulist : $('.scroll-imglist>ul'),
				blist : $('.scroll-btnlist>ul'),
				link : $('.link'),
				hoverbtn : $('.scroll-imglist>ul li, .scroll-btnlist>ul li'),
				autoInterval : 3000
			});
		}
		//initCalendar("daterange");
	});
	
	function toLogin(self,appId,priceId) {
		
		$.post('${path}/app/bind',{
			appId:appId
		},function(data, textStatus, jqXHR){
			if(data.success){
				IAX_TOOL.notification('3rd party account has bind');
				window.location.reload();
			}else{
				IAX_TOOL.notification(data.errorMsg);
			}
			$(".sign-in-box").modal("hide");
		},'json');
	}
	
	function toBuy(self,appId,priceId) {
		
		$.post('${path}/app/get',{
			appId:appId,
			priceId:priceId
		},function(data, textStatus, jqXHR){
			if(data.success){
				IAX_TOOL.notification('buy app success');
				window.location.reload();
			}else{
				IAX_TOOL.notification(data.errorMsg);
			}
			$(".sign-in-box").modal("hide");
		},'json');
	}
	
	function toSend(self,appId){
		$.post('${path}/message/send/getapp',{
			appId:appId
		},function(data, textStatus, jqXHR){
			if(data.success){
				IAX_TOOL.notification('send message succes');
				window.location.reload();
			}else{
				IAX_TOOL.notification(data.errorMsg);
			}
			$(".sign-in-box").modal("hide");
		},'json');
    }
	
	function initCalendar(id) {
		new xmoCalendar({
			inputId : '#' + id,
			wrapContainer : $('#' + id).parents(".control-group"),
			maskContainer : $('#' + id).parents(".edit-container"),
			relativeTop : "100%",
			relativeLeft : 210,
			lang : "zh", //"zh" "en"
			initTime : '2013-10-28',
			menu : [ "last_7_days", "last_30_days", "this_week", "this_month",
					"this_yeah", "last_week", "last_month", "last_3_month" ],
			submitCallback : function() {
				search_column(id);
			},
		})
	}
	function search_column(id) {
		var during = $("#" + id).val();
		var duringArr = during.split(" ~ ");
		$("#min").val(duringArr[0]);
		$("#max").val(duringArr[1]);
		//  $("#form").submit();
	}
	function requestUser(thi) {
		//ajax请求
		// $(thi).attr("disabled",true);
		setTimeout(
				function() {
					$(thi).next().click();
					// $(thi).attr("disabled",false);
					IAX_TOOL
							.notification(
									"Request Login successfully.Our sales will contact you soon.",
									"success", 5000);
				}, 1000)
	}
</script>
</html>
