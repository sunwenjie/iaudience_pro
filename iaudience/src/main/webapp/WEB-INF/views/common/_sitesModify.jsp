<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<c:set var="fixedConstant" value="<%=com.iclick.adx.common.constant.ProfitShareEnum.FIXED%>" /> 
<c:set var="shareConstant" value="<%=com.iclick.adx.common.constant.ProfitShareEnum.SHARE%>" /> 
<c:set var="iaxSiteConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxSiteDo%>" /> 
<c:set var="iaxAppConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxAppDo%>" /> 
<c:set var="iaxPublisherConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxPublisherSettingDo%>" /> 
<div class="control-group">
  <label class="control-label"><s:message code="body.site.name" /></label>
  <div class="controls">
    <div class="clearfix">
      <input type="text" name="name" value="${iaxSiteDo.name}" />
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group">
  <label class="control-label"><s:message code="body.site.type" /></label>
  <div class="controls">
    <div class="dropdown">
      <input name="categoryId" type="hidden" value="" />
      <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <s:message code="common.select" />
        <span class="caret arrow-down"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <c:forEach items="${listType}" var="iaxCategory">
          <li data-value="${iaxCategory.id }"><a href="javascript:;">${iaxCategory.code} : ${iaxCategory.name}</a></li>
        </c:forEach>
      </ul>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group">
  <label class="control-label"><s:message code="body.site.url" /></label>
  <div class="controls">
    <div class="clearfix">
      <input type="text" name="url" value="${iaxSiteDo.url}"/>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group profitShareType">
<label class="control-label"><s:message code="body.revenue.setting" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.revenue.setting' />"></span></label>

<div class="controls">
      <div class="dropdown modifylabel">
	  <input name="revenueType" id="profitShareType" onchange="changeRevenueType(this.value)" type="hidden" value="${iaxSiteDo.profitShareType}"/>
	  <button class="btn dropdown-toggle" type="button" id="profitShareTypeButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	    <c:if test="${iaxSiteDo.profitShareType != null}">
	    	<s:message code='body.profit.type.${iaxSiteDo.profitShareType}'/>
    	</c:if>
    	<c:if test="${iaxSiteDo.profitShareType == null}">
    		<s:message code="common.select" />
    	</c:if>
	    <span class="caret arrow-down"></span>
	  </button>
	  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <li data-value=""><a href="javascript:;" id="profitShareTypeLink"><s:message code="common.select" /></a></li>
		<c:forEach items="${profitShareEnum}" var="profitShare">
          <li data-value="${profitShare}"><a href="javascript:;"><s:message code='body.profit.type.${profitShare}'/></a></li>
        </c:forEach>
	  </ul>
	</div>
	<div class="clearfix infolabel hide" id="profitShareTypeShow">
	<c:if test="${iaxSiteDo.profitShareType != null}">
		<s:message code='body.profit.type.${iaxSiteDo.profitShareType}'/>
	</c:if>
	</div>
</div>

</div>
<div class="control-group profitShareValue">
	<label class="control-label"></label>
	<div class="controls">
		<div class="clearfix modifylabel">
			<c:if test="${iaxSiteDo.profitShareType == null}">
				<div class="input-append">
				<input type="text" id="revenueValue"  name="revenueValue" value="" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> CNY</span>
                </div>
			</c:if>
			<c:if test="${iaxSiteDo.profitShareType == fixedConstant}">
				<div class="input-append">
	              <input type="text" id="revenueValue" name="revenueValue" value="<fmt:formatNumber pattern='###0.00' value='${iaxSiteDo.profitShareValue / 100}'/>" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> CNY</span>
	            </div>
			</c:if>
			<c:if test="${iaxSiteDo.profitShareType == shareConstant}">
				<div class="input-append">
	              <input type="text" id="revenueValue" name="revenueValue" value="<fmt:formatNumber pattern='###0' value='${iaxSiteDo.profitShareValue}'/>" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> %</span>
	            </div>
			</c:if>
		</div>
		<div class="clearfix infolabel hide" style="width: 289px; float: left; text-align: right">
			<c:if test="${iaxSiteDo.profitShareType == fixedConstant}">
				<fmt:formatNumber pattern="#,##0.00" value="${iaxSiteDo.profitShareValue / 100}"/>
			</c:if>
			<c:if test="${iaxSiteDo.profitShareType == shareConstant}">
				<fmt:formatNumber pattern="#,##0" value="${iaxSiteDo.profitShareValue}"/>
			</c:if>
		</div>
        <span class="add-on infolabel hide" style="width: 50px;margin-left: -1px;padding: 4px 10px;text-align: center;">
        	<c:if test="${iaxSiteDo.profitShareType == fixedConstant}">
				CNY
			</c:if>
			<c:if test="${iaxSiteDo.profitShareType == shareConstant}">
				%
			</c:if>
        </span>
		<div class="error-message hide">
           	<span class="glyphicon glyphicon-alert"></span>
           	<div class="clearfix">
           	</div>
           </div>
	</div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.status" /></label>
  <div class="controls">
    <div class="dropdown">
      <input name="status" type="hidden" value="LIVE" />
      <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <s:message code="body.status.live" />
        <span class="caret arrow-down"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <li data-value="LIVE" class="active"><a href="javascript:;"><s:message code="body.status.live" /></a></li>
        <li data-value="STOPPED"><a href="javascript:;"><s:message code="body.status.stopped" /></a></li>
        <li data-value="SUSPENDED"><a href="javascript:;"><s:message code="body.status.suspended" /></a></li>
      </ul>
    </div>
    <div class="clearfix infolabel hide" id="statusLabel"></div>
  </div>
</div>

<script type="text/javascript">
  $(function() {
    var profitShareType = $("#profitShareType").val();
	if (profitShareType == '${fixedConstant}') {
		$(".profitShareValue").show();
	} else if (profitShareType == '${shareConstant}'){
		$(".profitShareValue").show();
	} else {
		$(".profitShareValue").hide();
	}
	
    var role = $("form").attr("ref");
    $("form").validate({
      rules : {
        "userId" : {
          required : true
        },
        "name" : {
          required : true
        },
        "categoryId" : {
          required : true
        },
        "url" : {
          required : true,
          url : true
        },
        "revenueValue" : {
            isprofitShareValue : true
        },
        "status" : {
          required : true
        }
      },
      errorPlacement : function(error, element) {
        element.parents(".controls").find(".error-message").removeClass("hide");
        error.appendTo(element.parents(".controls").find(".error-message").find(".clearfix"));
      },
      messages : {
        "userId" : {
          required : "<s:message code='form.error.publisher.empty' />"
        },
        "name" : {
          required : "<s:message code='form.error.site.name.empty' />"
        },
        "categoryId" : {
          required : "<s:message code='form.error.site.type.empty' />"
        },
        "url" : {
          required : "<s:message code='form.error.site.url.empty' />",
          url : "<s:message code='form.error.url.invalid' />"
        },
        "status" : {
          required : "<s:message code='form.error.status.empty' />"
        }
      },
      success : function(label) {
        $(label).parents(".error-message").addClass("hide");
      },
      submitHandler : function(form) { //通过之后回调
        $('[type="button"]').attr("disabled", true);
        form.submit();
      },
      invalidHandler : function(form, validator) { //不通过回调 
        $("label.error").each(
          function() {
            $(this).html().length && $(this).parents(".error-message").removeClass("hide");
          }
        );
        return false;
      }
    });
    // publisher验证    
    jQuery.validator.addMethod("publisher", function(value, element) {
      var length = value.replace(/\s/g, "").length;
      var isExist = $(element).length > 0;
      if (isExist) {
        return length > 0;
      } else {
        return true;
      }
    }, "<s:message code='form.error.publisher.empty' />");
    if ('${iaxSiteDo.userId}' != '') {
      $("[name='userId']").parent().find("[data-value='${iaxSiteDo.userId}']").trigger("click");
    }
    if ('${iaxSiteDo.categoryId}' != '') {
      $("[name='categoryId']").parent().find("[data-value='${iaxSiteDo.categoryId}']").trigger("click");
    }
    if ('${iaxSiteDo.status}' != '') {
      $("[name='status']").parent().find("[data-value='${iaxSiteDo.status}']").trigger("click");
      $("[name='status']").parent().next().text($("[name='status']").attr("title"));
      if (role != "admin") {
        if ('${iaxSiteDo.status}' == "SUSPENDED") {
          $("#statusLabel").text($("[name='status']").attr("title"));
          $("#statusLabel").prev().addClass("hide");
          $("#statusLabel").removeClass("hide");
        }
      }
    }
    if (role != "admin") {
      $("[name='status']").parent().find("[data-value='SUSPENDED']").remove();
      $(".profitShare").find("input").removeClass("noValid");
	  $(".profitShare").hide();
    }
    jQuery.validator.addMethod("isprofitShareValue", function(value, element) {
    	var profitShareType = $("#profitShareType").val();
		if (profitShareType == '${fixedConstant}') {
		 return (value != "" && value >= 0 && /^-?(0|[1-9]\d*)(\.\d{1,2})?$/.test(value));    
		} else if (profitShareType == '${shareConstant}') {
		 return (value != "" && value >= 0 && value < 100 && /^-?(0|[1-9]\d*)?$/.test(value));    
		} else {
		 element.value = "";
		 return true;
		}
    }, "<s:message code='form.error.profitShare.value.invalid' />");
  });
  // 
  
  function changeRevenueType(type) {
	if (type == '${fixedConstant}') {
		$("#revenueValue").val("");
		$("#revenueValue").next().html("CNY");
		$(".profitShareValue").show();
	} else if (type == '${shareConstant}'){
		$("#revenueValue").val("");
		$("#revenueValue").next().html("%");
		$(".profitShareValue").show();
	} else {
		$("#revenueValue").val("");
		$("#revenueValue").next().html("CNY");
		$(".profitShareValue").hide();
	}
  }
  
  function getDefaultRevenue() {
      var url = "${path}/admin/inventories/sites/ajaxDefaultRevenue";
	  var publisherId = $("#userId").val();
      if (publisherId == "") {
      	$("#profitShareTypeButton").html("<span class=\"caret arrow-down\"></span>");
      	$("#profitShareTypeLink").html("");
      	return;
      }
      $.ajax({
          type : "POST",
          url : url,
          dataType : "json",
          data : {
            "publisherId" : publisherId
          },
          async : false,
          beforeSend : function() {
          },
          success : function(data) {
            if (data != null) {
              var showContent = '<s:message code="body.profit.default" />';

              var profitShareSouce = data.defaultProfitShareSouce;
              var profitShareType = data.defaultProfitShareType;
              var profitShareValue = data.defaultProfitShareValue;
              var defaultName = data.defaultName;
              
              if (profitShareType == '${fixedConstant}') {
                showContent += '<s:message code="body.profit.type.${fixedConstant}" /> - ';
                showContent += (profitShareValue / 100).toFixed(2);
                showContent += "CNY";
              }
              if (profitShareType == '${shareConstant}') {
                showContent += '<s:message code="body.profit.type.${shareConstant}" /> - ';
                showContent += profitShareValue;
                showContent += "%";
              }
              
              if (profitShareSouce == '${iaxSiteConstant}') {
	                showContent += ' (' + '<s:message code="body.profit.IaxSiteDo" />: ' + defaultName + ')';
              }
				if (profitShareSouce == '${iaxAppConstant}') {
					showContent += ' (' + '<s:message code="body.profit.IaxAppDo" />: ' + defaultName + ')';
              }
				if (profitShareSouce == '${iaxPublisherConstant}') {
					showContent += ' (' + '<s:message code="body.profit.IaxPublisherSettingDo" />: ' + defaultName + ')';
				}
              
              
              if ($("#profitShareType").val() == "") {
	                $("#profitShareTypeButton").html(showContent + "<span class=\"caret arrow-down\"></span>");
              }
              
              $("#profitShareTypeLink").html(showContent);
              <c:if test="${iaxAdSlotDo.profitShareType == null}">
              $("#profitShareTypeShow").html(showContent);
              </c:if>
            } else {
              //SSP.notification(data.message,data.result);
            }
          },
          error : function(data) {
          },
          complete : function(msg) {
          }
        });
    }
  
  function initDefaultRevenue() {
	  var role = $("form").attr("ref");
      if (role == "admin") {
	     getDefaultRevenue();
      }
  }
  
  initDefaultRevenue();
</script>