<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:set var="noNotify" value="<%=com.iclick.adx.common.model.IaxNotificationConfigDo.noNotify%>" /> 
<c:set var="webNotify" value="<%=com.iclick.adx.common.model.IaxNotificationConfigDo.webNotify%>" /> 
<c:set var="accountBalanceLow" value="<%=com.iclick.adx.common.constant.NotificationTypeEnum.AccountBalanceLow%>" /> 
<c:set var="bidRequestURLUnreachableRate" value="<%=com.iclick.adx.common.constant.NotificationTypeEnum.BidRequestURLUnreachableRate%>" /> 
<c:set var="bidResponseTimeoutRate" value="<%=com.iclick.adx.common.constant.NotificationTypeEnum.BidResponseTimeoutRate%>" /> 
<head>
<title><s:message code="menu.desc.notification.setting" /></title>
</head>
<div class="page_title">
  <div id="breadcrumb" class="row">
    <!-- Top left headings and links -->
    <div class="client-row"></div>
  </div>

  <div class="row">
    <div class="client-row">
      <h1>
        <s:message code="menu.account.notifications"/>
      </h1>
    </div>
  </div>
</div>
<div class="edit-container">
<h3 class="">
  <s:message code="body.notification.title" />
</h3>
<form class="form-horizontal" id="modifyForm" action="${path}/${role}/accounts/notification/save" method="post" onsubmit="false">
<c:forEach items="${iaxNotificationTypes}" var="notificationType">
	<div style="padding-top:0;margin-bottom:10px;height:35px;" class="clearfix">
		<label class="form-checkbox checkbox-inline" style="float:left">
			<nobr>
			<input type="checkbox" value="${notificationType.id}" id="notification_${notificationType.id}" name="notificationType" onclick="doClickNotification('${notificationType.id}')" <c:if test="${notificationType.notificationConfigDo != null && notificationType.notificationConfigDo.webSwitch == webNotify}">checked="checked"</c:if>>
			<s:message code="notification.${notificationType.describe}"/>
			</nobr>  
        </label>
		<div style="float:left">
			<c:choose>
              <c:when test="${fn:indexOf(notificationType.name, accountBalanceLow) > 0}">
              	<div class="input-append">
	                <input type="text" style="width: 100px;" class="align_right verify" id="value_${notificationType.id}" name="value" value="${notificationType.notificationConfigDo.value}" <c:if test="${notificationType.notificationConfigDo == null || notificationType.notificationConfigDo.webSwitch == noNotify}">disabled="true"</c:if>>
	              	<span class="add-on" style="width:50px"> CNY</span>
	            </div>
              </c:when>
              <c:when test="${fn:indexOf(notificationType.name, bidRequestURLUnreachableRate) > 0}">
              	<div class="input-append">
              		<input type="text" style="width: 100px;" class="align_right verify" id="value_${notificationType.id}" name="value" value="${notificationType.notificationConfigDo.value}" <c:if test="${notificationType.notificationConfigDo == null || notificationType.notificationConfigDo.webSwitch == noNotify}">disabled="true"</c:if>>
              		<span class="add-on" style="width:50px"> %</span>
	            </div>
              </c:when>
              <c:when test="${fn:indexOf(notificationType.name, bidResponseTimeoutRate) > 0}">
              	<div class="input-append">
              		<input type="text" style="width: 100px;" class="align_right verify" id="value_${notificationType.id}" name="value" value="${notificationType.notificationConfigDo.value}" <c:if test="${notificationType.notificationConfigDo == null || notificationType.notificationConfigDo.webSwitch == noNotify}">disabled="true"</c:if>>
              		<span class="add-on" style="width:50px"> %</span>
	            </div>
              </c:when>
              <c:otherwise>
              	<input type="hidden" id="value_${notificationType.id}" name="value" value="${notificationType.notificationConfigDo.value}" <c:if test="${notificationType.notificationConfigDo == null || notificationType.notificationConfigDo.webSwitch == noNotify}">disabled="true"</c:if>>
            </c:otherwise>
            </c:choose>
		</div>
	</div>
</c:forEach>
<div style="float: left">
<button type="button" class="btn btn-success" onclick="doSave()">
    <s:message code="common.save" />
</button>
</div>
</form>
</div>
<script>
function doClickNotification(id) {
	var notify = $("#notification_" + id).attr("checked");
	if (notify == "checked") {
		$("#value_" + id).attr("disabled", false);
	} else {
		$("#value_" + id).attr("disabled", true);
		$("#value_" + id).val("");
	}
}

function doSave() {
	var verifys = $(".verify");
	if (verifys) {
		for (var i=0; i < verifys.length; i++) {
			var verify = verifys[i];
			var disabled = verify.disabled;
			
			if (disabled == false) {
				var value = verify.value;
				
			    if (/^-?(0|[1-9]\d*)(\.\d{1,2})?$/.test(value)) {
			      if (value > 10000) {
			        SSP.notification("<s:message code='form.error.number.large' />",
			            "error");
			        return;
			      }
			    }else{
			    	SSP.notification("<s:message code='form.error.account.amount.error' />",
			        "error");
			        return;
			    }
			}
		}
		$("#modifyForm").submit();
		
	} else {
		$("#modifyForm").submit();
	}
}
</script>