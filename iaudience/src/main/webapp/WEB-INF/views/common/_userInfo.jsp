<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="i" uri="http://iax.optimix.asia/jsp/jstl/timezone"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<!-- Page title -->
<div class="page_title">
  <div id="breadcrumb" class="row">
    <!-- Top left headings and links -->
    <div class="client-row"></div>
  </div>

  <div class="row">
    <div class="client-row">
      <h1>
        <s:message code="menu.account.info"/>
      </h1>
    </div>
  </div>
</div>

<!-- form -->
<div class="edit-container">
  <form class="form-horizontal" id="modifyForm" action="" method="post">
    <div class="control-group">
      <label class="control-label"><s:message code="body.user.id"/></label>
      <div class="controls">
        <div class="clearfix">
          <input type="text" name="hideId" value="${iaxUserDo.id}" disabled/>
          <input type="hidden" name="_method" value="PUT"/>
        </div>
      </div>
    </div>
      
    <div class="control-group">
      <label class="control-label"><s:message code="body.user.type"/></label>
      <div class="controls">
        <div class="clearfix">
          <input type="text" name="hideroleName" value="<s:message code='common.${fn:toLowerCase(iaxUserDo.roleName)}' />" disabled/>
          <input type="hidden" name="roleName" value="${iaxUserDo.roleName}"/>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group hide">
      <label class="control-label"><s:message code="body.user.name"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="loginName" value="${iaxUserDo.loginName}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.loginName}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" id="${iaxUserDo.roleName}">
        <c:choose>
          <c:when test="${iaxUserDo.roleName == 'Publisher'}">
            <s:message code="body.publisher.name"/>
          </c:when>
          <c:when test="${iaxUserDo.roleName == 'DSP'}">
            <s:message code="body.dsp.name"/>
          </c:when>
          <c:when test="${iaxUserDo.roleName == 'Admin'}">
            <s:message code="body.admin.name"/>
          </c:when>
          <c:when test="${iaxUserDo.roleName == 'Finance'}">
            <s:message code="body.finance.name"/>
          </c:when>
          <c:otherwise>
          </c:otherwise>
        </c:choose>
      </label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="name" autocomplete="off" value="${iaxUserDo.name}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.name}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="body.contact.name"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="contactName" value="${iaxUserDo.contactName}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.contactName}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="body.contact.phone"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="contactPhone" value="${iaxUserDo.contactPhone}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.contactPhone}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="body.contact.email"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="contactEmail" value="${iaxUserDo.contactEmail}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.contactEmail}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group nocompany">
      <label class="control-label"><s:message code="body.company.name"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="companyName" value="${iaxUserDo.companyName}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.companyName}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group nocompany">
      <label class="control-label"><s:message code="body.company.address"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="companyAddress" value="${iaxUserDo.companyAddress}" disabled/>
        </div>
        <div class="clearfix infolabel hide">${iaxUserDo.companyAddress}</div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="body.time.zone"/></label>
      <div class="controls">
        <div class="dropdown modifylabel">
          <input name="timeZone" type="hidden" value="${iaxUserDo.timeZone}"/>
          <button class="btn dropdown-toggle" type="button" id="dropdownMenuTimeZone" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" disabled>
            <i:displayTimeZone timeZoneId="${iaxUserDo.timeZone}"/>
            <span class="caret arrow-down"></span>
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <!--<c:forEach items="${timeZoneList}" var="tz">
              <li data-value="${tz}"><a href="javascript:;">${tz}</a></li>
            </c:forEach>-->
          </ul>
        </div>
        <div class="clearfix infolabel hide">
          <i:displayTimeZone timeZoneId="${iaxUserDo.timeZone}"/>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label"><s:message code="body.status"/></label>
      <div class="controls">
        <div class="dropdown modifylabel">
          <input name="status" type="hidden" value="${iaxUserDo.status}"/>
          <button class="btn dropdown-toggle" style="background:#F5F5F5;border:1px solid #DFDFDF;color:#555;opacity:1;"
            type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" disabled>
            <s:message code="body.status.${fn:toLowerCase(iaxUserDo.status)}"/>
            <!--<span class="caret arrow-down"></span>-->
          </button>
          <!--<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <li data-value="ACTIVE"><a href="javascript:;"><s:message code="body.status.active"/></a></li>
            <li data-value="SUSPENDED"><a href="javascript:;"><s:message code="body.status.suspended"/></a></li>
            <li data-value="STOPPED"><a href="javascript:;"><s:message code="body.status.stopped" /></a></li>
          </ul>-->
        </div>
        <div class="clearfix infolabel hide">
          <s:message code="body.status.${fn:toLowerCase(iaxUserDo.status)}"/>
        </div>
      </div>
    </div>

    <div class="control-group">
      <button type="button" class="btn btn-cancel" onclick="javascript:history.go(-1);">
        <s:message code="common.back"/>
      </button>
    </div>
  </form>
</div>

