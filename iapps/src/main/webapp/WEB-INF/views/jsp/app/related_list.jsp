<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%--
<%@ include file="../include/init.jsp"%>
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%> 

<title><spring:message code="app.related.title" /></title>
<div class="x-main">
<div class="x-sidebar" id="x-sidebar">
	<c:choose>
		<c:when test="${param.moduleId eq 1}">
			<%@ include file="../menu/iaccess.jsp" %>
		</c:when>
		<c:otherwise>
			<%@ include file="../menu/iaccess.jsp" %>
		</c:otherwise>
	</c:choose>

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

	<!--                   feature 相关                    -->
	<div class="feature-main">
		<div class="feature-content">
			<div class="feature-inner">
				<div class="feature-detail">
					<label class="feature-title">
						<spring:message code="app.related.title" />
					</label>
					<p class="feature-sub-title">
						<spring:message code="app.related.sub_title" />
					</p>
					<p class="feature-sub-title">
						<spring:message code="app.related.description" />
					</p>
					<c:forEach items="${apps}" var="app">
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
										<p>${app.appCategory.name}</p>
									</div>
									<div class="feature-container-star">
										<span class="rating">
										<c:forEach begin="0" end="4" step="1" var="i">
											<c:choose>
												<c:when test="${5-i eq app.stars}">
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
											<input name="appId" type="hidden" value="${app.id }" />
											<c:choose>
                          						<c:when test="${empty boughtApps[app.appKey]}">
											<button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown">
												<spring:message code="app.get.button.name" />
												&nbsp;&nbsp;
												<span class="caret"></span>
												<span class="sr-only">Toggle Dropdown</span>
											</button>
											<ul class="dropdown-menu feature-dropdown" role="menu" style="border-top: 1px solid #dfdfdf !important; left: 100% !important; top: 0 !important;">
												<li class="noclick">
													<a href="javascript:;">
														<spring:message code="app.new.user.menu" />
													</a>
													<ul class="sub-drop-menu">
														<c:forEach items="${app.appPurchaseStrategies}" var="price">
															<li class="noclick toSignRequest" data-value="${price.id}">
																<a href="javascript:;">${price.display}</a>
															</li>
														</c:forEach>
													</ul>
													<span class="caret-right"></span>
												</li>
												<li class="noclick toAccountSet">
													<a href="javascript:;">
														<spring:message code="app.account.exist.menu" />
													</a>
												</li>
											</ul>
											</c:when>
											<c:when test="${not boughtApps[app.appKey].latestVersion }">
												<button type="button" class="btn btn-danger btn-xs update-app">
													<spring:message code="app.myapp.update.button.name" /> 
													<span class="">&nbsp;</span>
						                            <span class="sr-only">Toggle Dropdown</span>
												</button>
											</c:when>
				                          	<c:otherwise>
				                          		<button type="button" class="btn btn-danger btn-xs dropdown-toggle open-app">
						                            <spring:message code="app.open.button.name" />&nbsp;&nbsp;
						                            <span class="">&nbsp;</span>
						                            <span class="sr-only">Toggle Dropdown</span>
						                        </button>
				                          	</c:otherwise>
				                          </c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="clearboth"></div>
				</div>

				<div class="feature-detail">
					<label class="feature-title">
						<spring:message code="app.myapp.title" />
					</label>
					<c:forEach items="${myApps}" var="app">
						<c:if test="${not empty boughtApps[app.appKey] }" >
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
										<p>${app.name }</p>
										<p>${app.appCategory.name}</p>
									</div>
									<div class="feature-container-star">
										<span class="rating">
											<c:forEach begin="0" end="4" step="1" var="i">
												<c:choose>
													<c:when test="${5-i eq app.stars}">
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
										<div class="btn-group">
											<input name="appId" type="hidden" value="${app.id }" />
											<c:choose>
												<c:when test="${boughtApps[app.appKey].latestVersion }">
													<button type="button" class="btn btn-danger btn-xs open-app">
														<spring:message code="app.open.button.name" />&nbsp;&nbsp;
														<span class="">&nbsp;</span>
							                            <span class="sr-only">Toggle Dropdown</span>
						                            </button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-danger btn-xs update-app">
														<spring:message code="app.myapp.update.button.name" />
														<span class="">&nbsp;</span>
							                            <span class="sr-only">Toggle Dropdown</span>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
						</c:if>
					</c:forEach>

					<div class="clearboth"></div>

				</div>

				<div class="clearboth"></div>
			</div>
		</div>
		<div class="feature-sidebar" style="margin-top: 20px;">
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