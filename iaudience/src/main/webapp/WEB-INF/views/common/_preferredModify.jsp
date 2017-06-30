<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<div class="control-group">
  <label class="control-label"><s:message code="body.deal.name" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="dealName" value="${iaxDealDo.name}" />
    </div>
    <div class="clearfix infolabel hide">${iaxDealDo.name}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
   </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.deal.inventories" /></label>
  <div class="controls">
    <div class="modifylabel">
      <select class="select  required" multiple id="inventories" name="inventories" disname="chosen下拉" style="width: 380px">
      	<c:forEach items="${units}" var="unit">
          <option value="${unit.id}">
          	<c:if test="${unit.adContext == siteConstant.getCode()}">${unit.iaxSite.name} (site): </c:if>
          	<c:if test="${unit.adContext == appConstant.getCode()}">${unit.iaxAppDo.name} (app): </c:if>
			${unit.name}
          </option>
        </c:forEach>
      </select>
    </div>
    <div class="infolabel hide">
      <c:set var="allowedInventories" />
      <c:forEach items="${iaxDealDo.dealSlots}" var="dealSlots" varStatus="status">
      	<c:if test="${dealSlots.adContext == siteConstant.getCode()}">${dealSlots.siteName} (site): </c:if>
      	<c:if test="${dealSlots.adContext == appConstant.getCode()}">${dealSlots.appName} (app): </c:if>
      	${dealSlots.slotName}<c:if test="${status.count < iaxDealDo.dealSlots.size()}"><br></c:if>
      </c:forEach>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group allowedContent">
  <label class="control-label"><s:message code="body.deal.allowed" /></label>
  <input name="allowedJson" id="allowedJson" value="" type="hidden"/>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.status" /></label>
  <div class="controls">
    <div class="dropdown modifylabel">
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
var rateList = [],rateJson={},buyerList=[],buyerJson={};
  $(function() {
    var role = $("form").attr("ref");
    $("form").validate({
      rules : {
        "publisherId" : {
            required : true
          },
        "dealName" : {
          required : true
        },
        "inventories" : {
          required : true
        },
        "status" : {
          required : true
        }
      },
      errorPlacement : function(error, element) {
    	  if(element.parents(".controls").find(".error-message").length>0){
	        element.parents(".controls").find(".error-message").removeClass("hide");
	        error.appendTo(element.parents(".controls").find(".error-message").find(".clearfix"));
    	  }
      },
      messages : {
   	  	"publisherId" : {
             required : "<s:message code='form.error.publisher.empty' />"
           },
        "dealName" : {
          required : "<s:message code='form.error.name.empty' />"
        },
        "inventories" : {
          required : "<s:message code='form.error.inventories.empty' />"
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
        var error = justyJson();
		if(error>0){ $('[type="button"]').attr("disabled", false);return false;} 
        setJson();
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
    
    
    if ('${iaxDealDo.publisherId}' != '') {
        $("[name='publisherId']").parent().find("[data-value='${iaxDealDo.publisherId}']").trigger("click");
    }
	
    var inventories = [];
    <c:forEach items="${iaxDealDo.dealSlots}" var="dealSlots" varStatus="status">
       inventories.push('${dealSlots.slotId}');
    </c:forEach>
    $("#inventories").val(inventories);
    $("#inventories").chosen();
    
    
    if ('${iaxDealDo.status}' != '') {
      $("[name='status']").parent().find("[data-value='${iaxDealDo.status}']").trigger("click");
      $("[name='status']").parent().next().text($("[name='status']").attr("title"));
      if (role != "admin") {
        if ('${iaxDealDo.status}' == "SUSPENDED") {
          $("#statusLabel").text($("[name='status']").attr("title"));
          $("#statusLabel").prev().addClass("hide");
          $("#statusLabel").removeClass("hide");
        }
      }
    }
    if (role != "admin") {
      $("[name='status']").parent().find("[data-value='SUSPENDED']").remove();
    }
    
    //get allowed buyers
    <c:forEach items="${rateList}" var="rate">
    	rateJson={};
    	rateJson.id="${rate.id}";
    	rateJson.code="${rate.code}";
    	rateList.push(rateJson);
    </c:forEach>
    <c:forEach items="${buyerList}" var="buyer">
    	buyerJson={};
    	buyerJson.id="${buyer.id}";
    	buyerJson.name="${buyer.dspName}: ${buyer.seatName} (${buyer.seatId})";
    	buyerList.push(buyerJson);
	</c:forEach>
	
	//目前是单个写死的 
	var buyers = [],buyersName=[];
    <c:forEach items="${iaxDealDo.dealSeats}" var="dealSeats" varStatus="status">
    	buyers.push('${dealSeats.seatId}');
    	buyersName.push("${dealSeats.dspName}: ${dealSeats.seatName} (${dealSeats.seatNo})");
    </c:forEach>
    
    <c:choose>
	    <c:when test="${not empty allowedlist}">  
	    	 <c:forEach var="allowed" items="${allowedlist}" varStatus="idx">
		    	 var html = Hogan.compile(SSP_TEMPLATE.allowedExpand).render({
			          "decimalPrice" : '<fmt:formatNumber pattern="#,##0.00" value="${allowed.price}" />',
			          "code" : '${allowed.rateCode}',
			          "buyers" : buyersName,
			          "buyerTitle" : '<s:message code="body.deal.allowed.buyers" />',
			          "priceTitle" : '<s:message code="body.deal.allowed.price" />',
			          "defaultRate" : '<s:message code="body.account.unit.cny" />',
			          "rateList" : rateList,
			          "buyerList" : buyerList,
			          "contentId" : '${idx.index}'
			        });
				$(".allowedContent").append(html);	
				$("#expandDiv-${idx.index}").find("[name=buyers]").val(buyers);
				if ('${allowed.rateId}' != '') {
					$("#expandDiv-${idx.index}").find("[name='rateId']").parent().find("[data-value='${allowed.rateId}']").trigger("click");
		        } else {
		        	$("#expandDiv-${idx.index}").find("[name='rateId']").parent().find("ul").find("li:first").trigger("click");
		        }
			    $("#expandDiv-${idx.index}").find("[name=buyers]").chosen();
	    	 </c:forEach>
	    </c:when>
	    <c:otherwise>
		    var html = Hogan.compile(SSP_TEMPLATE.allowedExpand).render({
		    	  "decimalPrice" : '<fmt:formatNumber pattern="#,##0.00" value="${iaxDealDo.price}" />',
		    	  "buyerTitle" : '<s:message code="body.deal.allowed.buyers" />',
		          "priceTitle" : '<s:message code="body.deal.allowed.price" />',
		          "defaultRate" : '<s:message code="body.account.unit.cny" />',
		          "rateList" : rateList,
		          "buyerList" : buyerList,
		          "contentId" : 0
		        });
			$(".allowedContent").append(html);	
			$("#buyers").val(buyers);
			$("#expandDiv-0").find("[name=buyers]").chosen();
	    </c:otherwise>
	</c:choose>
	$(".glyphicon-minus-sign").parent().remove();
	$(".glyphicon-plus-sign").parent().remove();
  });
  
  	function setJson(){
		var jsonArray = [],json={};
		$(".expand-div").each(function(){
			json = {};
			json.buyers = $(this).find("[name=buyers]").val();
			json.decimalPrice = $(this).find("[name=decimalPrice]").val();
			json.rateId = $(this).find("[name=rateId]").val();
			jsonArray.push(json);
		})
		$("#allowedJson").val(jsonArray);
	}
	function justyJson(){
		var buyers,decimalPrice,error=0;
		$(".expand-div").each(function(){
			buyers=$(this).find("[name=buyers]").val();
			decimalPrice=$(this).find("[name=decimalPrice]").val();
			
			if(buyers==null || buyers.length==0){
				error++;
				$(this).find("[name=buyers]").parent().find(".error-message").removeClass("hide");
				$(this).find("[name=buyers]").parent().find(".error-message").find(".clearfix").html('<label generated="true" class="error"><s:message code="form.error.allowed.buyers.empty" /></label>');
			}else{
				$(this).find("[name=buyers]").parent().find(".error-message").addClass("hide");
			}
			if(decimalPrice==null || decimalPrice.replace(/\s/g, "")==""){
				error++;
				$(this).find("[name=decimalPrice]").parent().find(".error-message").removeClass("hide");
				$(this).find("[name=decimalPrice]").parent().find(".error-message").find(".clearfix").html('<label generated="true" class="error"><s:message code="form.error.allowed.price.empty" /></label>');
			}else if(!/^([1-9]\d*|0)(\.\d{1,2})?$/.test(decimalPrice)){
				error++;
				$(this).find("[name=decimalPrice]").parent().find(".error-message").removeClass("hide");
				$(this).find("[name=decimalPrice]").parent().find(".error-message").find(".clearfix").html('<label generated="true" class="error"><s:message code="form.error.allowed.price.invalid" /></label>');
			}else{
				$(this).find("[name=decimalPrice]").parent().find(".error-message").addClass("hide");
			}
		})
		return error;
	}
</script>