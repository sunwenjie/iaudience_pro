<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ include file="../include/init.jsp"%>
<!DOCTYPE html>
<html>
<head>
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

							<div class="x-top-menu">
								<ul class="nav navbar-nav">
									<li class="selected">
										<a href="#"><spring:message code="main.decorator.nav.iapps" /></a>
									</li>
								</ul>
							</div>
							<div class="navbar-form navbar-right">
								<a href="${path}/app/list">&nbsp;<spring:message code="guest.list.user.login" /></a>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>

		<div class="x-main">
			<div class="x-sidebar" id="x-sidebar">
				<ul class="x-menu nav">
					<li class="selected">
						<a href="#link-Featured">
							<i class="fa fa-star" aria-hidden="true"></i>
							<span class="x-m8">
								<spring:message code="main.decorator.left.menu.featured" />
							</span>
						</a>
					</li>
					<li id="li001" class="">
						<a href="#link-cate${categories[0].id}">
							<i class="fa fa-bandcamp" aria-hidden="true"></i>
							<span class="x-m8">
								<spring:message code="main.decorator.left.menu.categories" />
							</span>
							<i class="fa fa-caret-down fa-fw" aria-hidden="true"></i>
						</a>
						<ul class="sub-menu nav" style="display: block;">
							<c:forEach items="${categories}" var="cate">
								<li>
									<a href="#link-cate${cate.id}">
										<span class="x-m8">${cate.name}</span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</li>

				</ul>
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
				<!--                    图片轮播相关                    -->
				<div class="scroll-container">
					<div class="scroll-imglist">
						<ul>
							<c:forEach items="${activities}" var="activity">
								<li>
									<a href="javascript:;" target="_blank">
										<img src="${activity.pictureUrl}" alt="图片1" />
									</a>
								</li>
							</c:forEach>
						</ul>

						<div class="scroll-btnlist">
							<ul>
							</ul>
						</div>
					</div>
					<i id="toLeft" class="fa fa-angle-left link scroll-btn-prev" aria-hidden="true"></i>
					<i id="toRight" class="fa fa-angle-right link scroll-btn-next" aria-hidden="true"></i>
				</div>
				<!--                   feature 相关                    -->
				<div class="feature-main">
					<div class="feature-content">
						<div class="feature-inner">
							<div class="feature-detail">
								<label class="feature-title" id="link-Featured"> <spring:message code="main.decorator.left.menu.featured" /> </label>
								<c:forEach items="${featuredAppInfos}" var="app">
									<div class="feature-item">
										<input type="hidden" name="appId" value="${app.id}" />
										<div class="feature-item-inner">
											<div class="feature-pic">
												<a href="javascript:;">
													<c:choose>
														<c:when test="${empty app.icon}">
															<img style="background: #ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="90" width="90">
														</c:when>
														<c:otherwise>
															<img style="background: #ddd;" src="${app.icon}" height="90" width="90">
														</c:otherwise>
													</c:choose>
												</a>
											</div>
											<div class="feature-container">
												<div class="feature-container-title">
													<p>${app.name}</p>
													<p>${cate.name}</p>
												</div>
												<div class="feature-container-star">
													<span class="rating">
														<c:forEach begin="1" end="5" step="1" var="i">
															<c:choose>
																<c:when test="${i eq app.stars}">
																	<span class="star hover"></span>
																</c:when>
																<c:otherwise>
																	<span class="star"></span>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</span>
												</div>
												<div class="feature-container-opt">
													<div class="btn-group" style="display: inline-block;">
														<input type="hidden" value="" />
														<button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown">
															<spring:message code="app.get.button.name" />
															&nbsp;&nbsp;
															<span class="">&nbsp;</span>
															<span class="sr-only">Toggle Dropdown</span>
														</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
								<div class="clearboth"></div>
							</div>
							<c:forEach items="${categories}" var="cate">
								<div class="feature-detail">
									<label class="feature-title" id="link-cate${cate.id}"> ${cate.name} </label>
									<c:forEach items="${cate.appInfos}" var="app">
										<div class="feature-item">
											<input type="hidden" name="appId" value="${app.id}" />
											<div class="feature-item-inner">
												<div class="feature-pic">
													<a href="javascript:;">
														<c:choose>
															<c:when test="${empty app.icon}">
																<img style="background: #ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="90" width="90">
															</c:when>
															<c:otherwise>
																<img style="background: #ddd;" src="${app.icon}" height="90" width="90">
															</c:otherwise>
														</c:choose>
													</a>
												</div>
												<div class="feature-container">
													<div class="feature-container-title">
														<p>${app.name}</p>
														<p>${cate.name}</p>
													</div>
													<div class="feature-container-star">
														<span class="rating">
															<c:forEach begin="1" end="5" step="1" var="i">
																<c:choose>
																	<c:when test="${i eq app.stars}">
																		<span class="star hover"></span>
																	</c:when>
																	<c:otherwise>
																		<span class="star"></span>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</span>
													</div>
													<div class="feature-container-opt">
														<div class="btn-group" style="display: inline-block;">
															<input type="hidden" value="" />
															<button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown">
																<spring:message code="app.get.button.name" />
																&nbsp;&nbsp;
																<span class="">&nbsp;</span>
																<span class="sr-only">Toggle Dropdown</span>
															</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
									<div class="clearboth"></div>
								</div>
							</c:forEach>
							<!--                     iNsights example end                     --->
							<div class="clearboth"></div>
						</div>
					</div>
					<div class="feature-sidebar">
						<div class="feature-sidebar-search">
							<i class="fa fa-search"></i>
							<input class="input-search" placeholder="Search" id="input-search" autofocus="">
						</div>
						<div class="feature-sidebar-result">
							<label>
								<spring:message code="app.list.search.apps" />
							</label>
							<hr>
							<ul>
								<c:forEach items="${apps}" var="app">
									<li>
										<a href="javascript:;">${app.name}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<!--                   feature 相关 End                   -->
			</div>
			<div class="clearboth"></div>
		</div>
		<!-- footer -->
		<div class="clearfooter"></div>
		<div class="myfooter">
			<label class="x-footer"> Copyright © 2012 - 2017 iClick Technology,iClick Beijing,ICP 14026918. All Rights Reserved. </label>
		</div>
	</div>
	
	<div class="modal fade slide-box" style="display: none;">
	</div>
	<script type="text/javascript">
	$(function() {
		$('.sign-in-box').on('hidden.bs.modal', function() {
			$("body").addClass("modal-open");
		});
		
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

		$(document).on("click", ".slide-box .sub-nav-tabs a", function(e) {
			e.preventDefault();
			$(this).tab('show');
		})
		//搜索功能
		$(".feature-sidebar-search .input-search").keyup(function(e) {
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
						.append('<li id="feature-noresult"><spring:message code="" /></li>');
				}
								
			} else {
				$(".feature-sidebar-result").find("li").show();
			}
		});
		
		$(".feature-item :not(.btn) :not(.dropdown-menu a)").click(function(event) {
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
					$(".slide-box .feature-info .btn-xs").click(function(){
						var appId = $(this).prev();
						window.location.href="${path}/app/list?openAppId=" + appId;
					});
					//$("[href='#tab-intruduction']").click();
				},'html');
			}
			event.stopPropagation();
		});
		
		$(".feature-item .btn-xs").click(function(){
			window.location.href="${path}/app/list";
		});
					
		$("#request_app [name='servie']").parent()
			.click(function() {
					var isChecked = $(this).find("input").prop("checked");
					$(this).parent().parent().parent().next().find(
							".btn-success").attr("disabled", !isChecked);
		});
		
		//图片轮播
		new scrollImg({
			ulist : $('.scroll-imglist>ul'),
			blist : $('.scroll-btnlist>ul'),
			link : $('.link'),
			hoverbtn : $('.scroll-imglist>ul li, .scroll-btnlist>ul li'),
			autoInterval : 3000
		})
		//initCalendar("daterange");
	});

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
		setTimeout(function() {
			$(thi).next().click();
			IAX_TOOL.notification(
				"Request Login successfully.Our sales will contact you soon.",
				"success", 5000);
		}, 1000);
	}
</script>
</body>
</html>
