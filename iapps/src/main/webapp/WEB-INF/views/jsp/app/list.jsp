<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%@ include file="../include/init.jsp" %>
<title>iApps</title>
<div class="x-main">
<div class="x-sidebar" id="x-sidebar">
	<ul class="x-menu nav">
		<li class="selected">
			<a href="#link-Featured">
				<i class="fa fa-star" aria-hidden="true"></i>
				<span class="x-m8"><spring:message code="main.decorator.left.menu.featured" /></span>
			</a>
		</li>
		<li id="li001" class="">
			<a href="#link-cate${categories[0].id}">
				<i class="fa fa-bandcamp" aria-hidden="true"></i>
				<span class="x-m8"><spring:message code="main.decorator.left.menu.categories" /></span>
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
		<li class="">
			<a href="${path}/app/myapp_list">
				<i class="fa fa-gg-circle" aria-hidden="true"></i>
				<span class="x-m8"><spring:message code="main.decorator.left.menu.myapps" /></span>
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
<!--                    图片轮播相关                    -->
    <div class="scroll-container">
      <div class="scroll-imglist">
        <ul>
          <c:forEach items="${activities}" var="activity">
	          <li><a href="javascript:;" target="_blank"><img src="${activity.pictureUrl}" alt="图片1"/></a></li>
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
  		<div class="feature-content" >
        <div class="feature-inner">
        <div class="feature-detail">
              <label class="feature-title" id="link-Featured">
                <spring:message code="main.decorator.left.menu.featured" />
              </label>
              <c:forEach items="${featuredAppInfos}" var="app">
              <div class="feature-item">
              <input type="hidden" name="appId" value="${app.id}" />
                <div class="feature-item-inner">
                  <div class="feature-pic">
                    <a href="javascript:;">
                    	<c:choose>
                    		<c:when test="${empty app.icon}">
                    			<img style="background:#ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="90" width="90">
                    		</c:when>
                    		<c:otherwise>
                    			<img style="background:#ddd;" src="${app.icon}" height="90" width="90">
                    		</c:otherwise>
                    	</c:choose>
                    	
                    </a>
                  </div>
                  <div class="feature-container">
                      <div class="feature-container-title">
                        <p data-toggle="tooltip" data-placement="bottom" title="${app.name}">${app.name}</p>
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
                        <div class="btn-group" style="display:inline-block;">
                          <input name="appId" type="hidden" value="${app.id }"/>
                          <c:choose>
                          	<c:when test="${empty boughtApps[app.appKey]}">
                          	  <button type="button" class="btn btn-danger btn-xs dropdown-toggle get" data-toggle="dropdown">
	                            <spring:message code="app.get.button.name" />&nbsp;&nbsp;
	                            <span class="caret"></span>
	                            <span class="sr-only">Toggle Dropdown</span>
	                          </button>
	                          <ul class="dropdown-menu feature-dropdown" role="menu" style="border-top: 1px solid #dfdfdf!important;left: 100%!important;top:0!important;">
	                            <li class="noclick"><a href="javascript:;"><spring:message code="app.new.user.menu" /></a>
	                              <ul class="sub-drop-menu">
	                              	<c:forEach items="${app.appPurchaseStrategies}" var="price">
		                                <li class="noclick toSignRequest" data-value="${price.id}"><a href="javascript:;">${price.display}</a></li>
	                                </c:forEach>
	                              </ul>
	                              <span class="caret-right"></span>
	                            </li>
	                            <li class="noclick toAccountSet" >
	                            	<a href="javascript:;"><spring:message code="app.account.exist.menu" /></a>
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
                </div>
              </div>
              </c:forEach>
              <div class="clearboth"></div>
           </div>
        <c:forEach items="${categories}" var="cate">
          <div class="feature-detail">
              <label class="feature-title" id="link-cate${cate.id}">
                ${cate.name}
              </label>
              <c:forEach items="${cate.appInfos}" var="app">
              <div class="feature-item">
              <input type="hidden" name="appId" value="${app.id}" />
                <div class="feature-item-inner">
                  <div class="feature-pic">
                    <a href="javascript:;">
                    	<c:choose>
                    		<c:when test="${empty app.icon}">
                    			<img style="background:#ddd;" src="${symphony_static_host}/images/icon_conversions.png" height="90" width="90">
                    		</c:when>
                    		<c:otherwise>
                    			<img style="background:#ddd;" src="${app.icon}" height="90" width="90">
                    		</c:otherwise>
                    	</c:choose>
                    	
                    </a>
                  </div>
                  <div class="feature-container">
                      <div class="feature-container-title">
                        <p data-toggle="tooltip" data-placement="bottom" title="${app.name}">${app.name}</p>
                        <p>${cate.name}</p>
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
                        <div class="btn-group" style="display:inline-block;">
                          <input name="appId" type="hidden" value="${app.id }"/>
                          <c:choose>
                          	<c:when test="${empty boughtApps[app.appKey]}">
                          	  <button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown">
	                            <spring:message code="app.get.button.name" />&nbsp;&nbsp;
	                            <span class="caret"></span>
	                            <span class="sr-only">Toggle Dropdown</span>
	                          </button>
	                          <ul class="dropdown-menu feature-dropdown" role="menu" style="border-top: 1px solid #dfdfdf!important;left: 100%!important;top:0!important;">
	                            <li class="noclick"><a href="javascript:;"><spring:message code="app.new.user.menu" /></a>
	                              <ul class="sub-drop-menu">
	                              	<c:forEach items="${app.appPurchaseStrategies}" var="price">
		                                <li class="noclick toSignRequest" data-value="${price.id}"><a href="javascript:;">${price.display}</a></li>
	                                </c:forEach>
	                              </ul>
	                              <span class="caret-right"></span>
	                            </li>
	                            <li class="noclick toAccountSet" >
	                            	<a href="javascript:;"><spring:message code="app.account.exist.menu" /></a>
	                            </li>
	                          </ul>
                          	</c:when>
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
          <input class="input-search" placeholder="Search" id="input-search" autofocus="" >
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
  