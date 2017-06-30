<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ include file="../include/init.jsp"%>
<title><spring:message code="app.myapp.title" />--iApps</title>
<div class="x-main">
<div class="x-sidebar" id="x-sidebar">
	<ul class="x-menu nav">
		<li class="">
			<a href="${path}/app/list#link-Featured">
				<i class="fa fa-star" aria-hidden="true"></i>
				<span class="x-m8">
					<spring:message code="main.decorator.left.menu.featured" />
				</span>
			</a>
		</li>
		<li id="li001" class="">
			<a href="${path}/app/list#link-cate${categories[0].id}">
				<i class="fa fa-bandcamp" aria-hidden="true"></i>
				<span class="x-m8">
					<spring:message code="main.decorator.left.menu.categories" />
				</span>
				<i class="fa fa-caret-down fa-fw" aria-hidden="true"></i>
			</a>
			<ul class="sub-menu nav" style="display: block;">
				<c:forEach items="${categories}" var="cate">
					<li>
						<a href="${path}/app/list#link-cate${cate.id}">
							<span class="x-m8">${cate.name}</span>
						</a>
					</li>
				</c:forEach>
			</ul>
		</li>
		<li class="selected">
			<a href="${path}/app/myapp_list">
				<i class="fa fa-gg-circle" aria-hidden="true"></i>
				<span class="x-m8">
					<spring:message code="main.decorator.left.menu.myapps" />
				</span>
				<i class="bell-tip" aria-hidden="true">2</i>
			</a>
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

	<!--                   feature 相关                    -->
	<div class="feature-main">
		<div class="feature-content">
			<div class="feature-inner">
				<div class="feature-detail">
					<label class="feature-title"><spring:message code="app.myapp.title" /></label>
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
											<input type="hidden" name="appId" value="${app.id}" />
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
		<div class="feature-sidebar">
			<div class="feature-sidebar-search">
				<i class="fa fa-search"></i>
				<input class="input-search" placeholder="Search" id="input-search" autofocus="">
			</div>
			<div class="feature-sidebar-result">
				<label><spring:message code="app.list.search.apps" /></label>
		      <hr>
	          <ul>
	          	<c:forEach items="${apps}" var="app">
	            	<li><a href="javascript:;">${app.name}</a></li>
	            </c:forEach>
	          </ul>
			</div>
		</div>
	</div>
	<!--                   feature 相关 End                   -->
</div>
<div class="clearboth"></div>
	</div>
