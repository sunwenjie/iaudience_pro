<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ include file="../include/init.jsp"%>


<div class="slide-close" data-dismiss="modal">
	<i class="fa fa-close" aria-hidden="true"></i>
</div>
<div class="slide-content">
	<div class="modal-content">
		<div class="modal-body">
			<ul class="nav nav-tabs sub-nav-tabs" id="myTabs">
				<li class="">
					<a data-toggle="tab" href="#tab-intruduction">
						<spring:message code="app.detail.introduction.tab.name" />
					</a>
				</li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade in active" id="tab-intruduction">
					<c:choose>
						<c:when test="${not empty errorMsg}">
							${errorMsg}
						</c:when>
						<c:otherwise>
					<div class="feature-main">
						<div class="feature-content">
							<div class="feature-inner" style="margin: 0 0 0 260px; width: 650px;">
								<div class="feature-detail">
									<div class="feature-item-detail">
										<div class="feature-item-inner">
											<div class="feature-container">
												<div class="feature-container-title">
													<p style="color: #999;">
														<spring:message code="app.detail.description.title" />
													</p>
													<hr>
													${app.description}
												</div>
												<div class="feature-container-update" style="margin-top: 30px; position: static;">${app.updateContent}</div>
											</div>
										</div>
									</div>
									<div class="clearboth"></div>
								</div>
								<!--                    图片预览                        -->
								<div class="feature-apps-show">
									<c:forEach items="${app.previewPictures}" var="pic">
										<div class="feature-apps-pic">
											<img src="${pic.url}" alt="图片" height="100%" width="100%" />
										</div>
									</c:forEach>
									<security:authorize access="isAuthenticated()">
									<div class="feature-apps-bought">
										<div class="feature-apps-bought-title"><spring:message code="app.detail.customer.bought.title" /> </div>
										<div class="feature-apps-bought-list">
											<ul>
												<c:forEach items="${myApps }" var="bought">
													<li>
														<a href="javascript:;">
															<c:choose>
																<c:when test="${empty bought.icon}">
																	<img style="background: #ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="90" width="90">
																</c:when>
																<c:otherwise>
																	<img style="background: #ddd;" src="${bought.icon}" height="90" width="90">
																</c:otherwise>
															</c:choose>
														</a>
														<div class="feature-apps-bought-app">
															<p>${bought.name }</p>
															<p>${bought.appCategory.name }</p>
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
									</security:authorize>
								</div>

								<!--                    图片预览  End                 -->
							</div>
						</div>
						<div class="feature-info" style="position: fixed; margin: 20px 0 0 0; width: 220px;">
							<div class="feature-pic" style="margin-bottom: 30px;">
								<a href="javascript:;">
									<c:choose>
										<c:when test="${empty app.icon}">
											<img style="background: #ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="200" width="200">
										</c:when>
										<c:otherwise>
											<img style="background: #ddd;" src="${app.icon}" height="200" width="200">
										</c:otherwise>
									</c:choose>
								</a>
								<div class="feature-container-opt">
									<label class="feature-opt-title"> ${app.name} </label>
									<div class="btn-group" style="display: inline-block;">
										<input name="appId" type="hidden" value="${app.id }" />
										<c:choose>
                          					<c:when test="${empty boughtApps[app.appKey]}">
										<button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown">
											Get&nbsp;&nbsp;
											<security:authorize access="isAuthenticated()">
											<span class="caret"></span>
											</security:authorize>
											<security:authorize access="isAnonymous()">
											<span class="">&nbsp;</span>
											</security:authorize>
											<span class="sr-only">Toggle Dropdown</span>
										</button>
										<security:authorize access="isAuthenticated()">
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
										</security:authorize>
										</c:when>
											<c:when test="${not boughtApps[app.appKey].latestVersion }">
												<button type="button" class="btn btn-danger btn-xs update-app">
													<spring:message code="app.myapp.update.button.name" />
													<span class="">&nbsp;</span>
						                            <span class="sr-only">Toggle Dropdown</span>
												</button>
											</c:when>
				                          	<c:otherwise>
				                          		<button type="button" class="btn btn-danger btn-xs open-app">
						                            <spring:message code="app.open.button.name" />&nbsp;&nbsp;
						                            <span class="">&nbsp;</span>
						                            <span class="sr-only">Toggle Dropdown</span>
						                        </button>
				                          	</c:otherwise>
				                          </c:choose>
									</div>
								</div>
							</div>
							<label class="feature-info-title" style="color: #999;">
								<spring:message code="app.detail.information.tilte" />
							</label>
							<hr>
							<div class="feature-info-result">
								<ul>
									<li>
										<span>
											<spring:message code="app.detail.information.categroy" />:
										</span>
										<span>${app.appCategory.name}</span>
									</li>
									<li>
										<span>
											<spring:message code="app.detail.information.rating" />:
										</span>
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
									</li>
									<li>
										<span>
											<spring:message code="app.detail.information.update_time" />:
										</span>
										<span>
											${app.updateTime}
										</span>
									</li>
									<li>
										<span>
											<spring:message code="app.detail.information.version" />:
										</span>
										<span>${app.version }</span>
									</li>
									<li>
										<span style="float: left;">
											<spring:message code="app.detail.information.price" />:
										</span>
										<div style="float: left; margin-left: 2px;">
											<c:forEach items="${app.appPurchaseStrategies}" var="price">
												<p>${price.display}</p>
											</c:forEach>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

