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
        <c:if test="${opt == 'info'}">
          <s:message code="menu.account.info"/>
        </c:if>
        <c:if test="${opt == 'update'}">
          <s:message code="menu.account.info"/>
        </c:if>
      </h1>
    </div>
  </div>
</div>

<!-- form -->
<div class="edit-container">
  <form class="form-horizontal" id="modifyForm" action="${path}/${role}/accounts" method="post">
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
    <div class="control-group">
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
      <label class="control-label" id="Publisher"><s:message code="body.publisher.name"/></label>
      <label class="control-label hide" id="DSP"><s:message code="body.dsp.name"/></label>
      <label class="control-label hide" id="Admin"><s:message code="body.admin.name"/></label>
      <label class="control-label hide" id="Finance"><s:message code="body.finance.name"/></label>
      <div class="controls">
        <div class="clearfix modifylabel">
          <input type="text" name="name" autocomplete="off" value="${iaxUserDo.name}"/>
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
          <input type="text" name="contactName" value="${iaxUserDo.contactName}"/>
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
          <input type="text" name="contactPhone" value="${iaxUserDo.contactPhone}"/>
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
          <input type="text" name="contactEmail" value="${iaxUserDo.contactEmail}"/>
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
          <input type="text" name="companyName" value="${iaxUserDo.companyName}"/>
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
          <input type="text" name="companyAddress" value="${iaxUserDo.companyAddress}" />
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
          <button class="btn dropdown-toggle" type="button" id="dropdownMenuTimeZone" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <i:displayTimeZone timeZoneId="${iaxUserDo.timeZone}"/>
            <span class="caret arrow-down"></span>
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <c:forEach items="${timeZoneList}" var="tz">
              <li data-value="${tz}"><a href="javascript:;"><i:displayTimeZone timeZoneId="${tz}"/></a></li>
            </c:forEach>
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
          </ul> -->
        </div>
        <div class="clearfix infolabel hide">
          <s:message code="body.status.${fn:toLowerCase(iaxUserDo.status)}"/>
        </div>
      </div>
    </div>

    <div class="control-group">
      <c:if test="${opt == 'update'}">
        <button type="button" class="btn btn-success" onclick="$('form').submit();">
          <s:message code="common.save"/>
        </button>
        <button type="button" class="btn btn-cancel" onclick="labelModify();">
          <s:message code="common.cancel"/>
        </button>
      </c:if>
      <c:if test="${opt == 'info'}">
        <button type="button" class="btn btn-success" onclick="labelInfo();">
          <s:message code="common.edit"/>
        </button>
        <button type="button" class="btn btn-cancel" onclick="window.location='${path}/${role}/accounts'">
          <s:message code="common.back"/>
        </button>
      </c:if>
    </div>
  </form>
</div>

<script type="text/javascript">
$(function(){
  var opt = '${opt}';
  if (opt == "info") {
    labelModify();
  } else if (opt == "update") {
    labelInfo();
  }
});

function labelInfo() {
  $(".infolabel").addClass("hide");
  $(".modifylabel").show();
  $(".btn-cancel").attr("onclick","labelModify()");
  $(".btn-cancel").text('<s:message code="common.back"/>');
  $(".btn-success").text('<s:message code="common.save"/>');
  $(".btn-success").attr("onclick","$('form').submit()");
  $(".error-message").removeClass("infohide");
}
function labelModify() {
  $(".modifylabel").hide();
  $(".infolabel").removeClass("hide");
  $(".btn-cancel").attr("onclick","window.location='${path}/${role}/accounts'");
  $(".btn-cancel").text('<s:message code="common.cancel"/>');
  $(".btn-success").text('<s:message code="common.edit"/>');
  $(".btn-success").attr("onclick","labelInfo()");
  $(".error-message").addClass("infohide");
  
}
function changeRole(thi) {
  var value = $(thi).val();
  if (value == "Publisher" || value == "DSP") {
    $(".nocompany").find("input").removeClass("noValid");
    $(".nocompany").show();
  } else {
    $(".nocompany").find("input").addClass("noValid");
    $(".nocompany").hide();
  }
}

$(function() {
  $("form").validate({
    rules:{
      "name":{
        required: true
      },
      "password": {
        required: true,
        minlength: 6
      },
      "passwordConfirm": {
        required: true,
        minlength: 6,
        equalTo: "#password"
      },
      "contactName": {
        required: true
      },
      "contactPhone": {
        required: true,
        isMobile: true
      },
      "contactEmail": {
        required: true,
        email: true
      },
      "companyName": {
        required: true
      },
      "companyAddress": {
        required: true
      },
      "timeZone": {
        required: true
      }
    },
    errorPlacement: function(error, element) { 
      element.parents(".controls").find(".error-message").removeClass("hide");
      error.appendTo(element.parents(".controls").find(".error-message").find(".clearfix")); 
    },
    ignore: ".noValid,disabled",
    messages: {
      "name": {
        required: "<s:message code='form.error.name.empty'/>",
        remote: "<s:message code='form.error.name.isexist'/>"
      },
      "password": {
        required: "<s:message code='form.error.user.password.empty'/>",
        minlength: jQuery.format("<s:message code='form.error.user.password.range'/>")
      },
      "passwordConfirm": {
        required: "<s:message code='form.error.user.password.empty'/>",
        minlength: jQuery.format("<s:message code='form.error.user.password.range'/>"),
        equalTo: "<s:message code='form.error.user.password.equal'/>"
      },
      "contactName": {
        required: "<s:message code='form.error.contact.name.empty'/>"
      },
      "contactPhone": {
        required: "<s:message code='form.error.contact.phone.empty'/>"
      },
      "contactEmail": {
        required: "<s:message code='form.error.contact.email.empty'/>",
        email: "<s:message code='form.error.contact.email.valid'/>"
      },
      "companyName": {
        required: "<s:message code='form.error.company.name.empty'/>"
      },
      "companyAddress": {
        required: "<s:message code='form.error.company.address.empty'/>"
      },
      "timeZone": {
        required: "<s:message code='form.error.time.zone.empty'/>"
      }
    },
    success: function(label) {
      $(label).parents(".error-message").addClass("hide");
    },
    submitHandler: function(form) {  //éè¿ä¹ååè°
      $('[type="button"]').attr("disabled",true);
      form.submit();  
    },
    invalidHandler: function(form, validator) {  //ä¸éè¿åè° 
      $("label.error").parent().parent().removeClass("hide");
      return false; 
    }
  });
  
  // ææºå·ç éªè¯    
  jQuery.validator.addMethod("isMobile", function(value, element) {    
    var length = value.length;    
    return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));    
  }, "<s:message code='register.error.mobile.invalid'/>");
  
  jQuery.validator.addMethod("publisherOrDSP", function(value, element) {    
    var length = value.length;   
    var id = $(element).parents(".control-group").attr("id");
    if ($(element).parents(".control-group").hasClass("hide")) {
      return true;
    } else {
      return length > 0;
    }
  }, "<s:message code='form.error.name.empty'/>");
  
  $("#userTypeDropdown").find("li").on("click", function() {
    var id = $(this).attr("data-value");
    $("#Publisher,#DSP,#Admin,#Finance").addClass("hide");
    $("#"+id).removeClass("hide");
  });
  
  if ('${iaxUserDo.roleName}' != '') {
    $("[name='roleName']").parent().find("[data-value='${iaxUserDo.roleName}']").trigger("click");
    $("#Publisher,#DSP,#Admin,#Finance").addClass("hide");
    $("#"+'${iaxUserDo.roleName}').removeClass("hide");
    var value = '${iaxUserDo.roleName}';
    if (value == "Publisher" || value == "DSP") {
      $(".nocompany").find("input").removeClass("noValid");
      $(".nocompany").show();
    } else {
      $(".nocompany").find("input").addClass("noValid");
      $(".nocompany").hide();
    }
  } else {
    $(".nocompany").find("input").removeClass("noValid");
    $(".nocompany").show();
  }
  
  if ('${iaxUserDo.status}' != '') {
    $("[name='status']").parent().find("[data-value='${iaxUserDo.status}']").trigger("click");
    $("[name='status']").parent().next().text($("[name='status']").attr("title"));
  }
});
</script>