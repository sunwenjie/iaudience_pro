<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<c:set var="siteConstant" value="<%=com.iclick.adx.common.constant.AdContextEnum.SITE%>" /> 
<c:set var="appConstant" value="<%=com.iclick.adx.common.constant.AdContextEnum.APP%>" /> 
<c:set var="fixedConstant" value="<%=com.iclick.adx.common.constant.ProfitShareEnum.FIXED%>" /> 
<c:set var="shareConstant" value="<%=com.iclick.adx.common.constant.ProfitShareEnum.SHARE%>" /> 
<c:set var="bannerConstant" value="<%=com.iclick.adx.common.constant.ContentMimeTypeEnum.BANNER%>" /> 
<c:set var="videoConstant" value="<%=com.iclick.adx.common.constant.ContentMimeTypeEnum.VIDEO%>" /> 
<c:set var="iaxSiteConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxSiteDo%>" /> 
<c:set var="iaxAppConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxAppDo%>" /> 
<c:set var="iaxPublisherConstant" value="<%=com.iclick.adx.common.constant.ProfitDefaultEnum.IaxPublisherSettingDo%>" /> 
<div class="control-group">
  <label class="control-label"><s:message code="body.ad.context" /></label>
  <div class="controls">
    <c:choose>
      <c:when test="${opt == 'create'}">
        <div class="dropdown modifylabel">
          <input name="adContext" id="adContext" type="hidden" value="1" onchange="changeContext(this);getDefaultRevenue(this);initPreload();" />
          <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <s:message code="body.site" />
            <span class="caret arrow-down"></span>
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <li data-value="1"><a href="javascript:;"><s:message code="body.site" /></a></li>
            <li data-value="2"><a href="javascript:;"><s:message code="body.apps" /></a></li>
          </ul>
        </div>
      </c:when>
      <c:otherwise>
        <div class="clearfix">
          <input type="text" name="hideadContext"
            value="<c:choose><c:when test='${iaxAdSlotDo.adContext == siteConstant.getCode()}'><s:message code="body.site"/></c:when><c:otherwise><s:message code="body.apps"/></c:otherwise>
        </c:choose>"
            disabled /> <input type="hidden" name="adContext" id="adContext" value="${iaxAdSlotDo.adContext}" />
        </div>
      </c:otherwise>
    </c:choose>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group name" id="name_1">
  <label class="control-label"><s:message code="body.site" /></label>
  <div class="controls">
    <c:if test="${opt=='create'}">
      <div class="dropdown modifylabel">
        <input name="siteId" id="siteId" type="hidden" value="" onchange="$(this).valid();getDefaultRevenue(this);" />
        <button class="btn  dropdown-toggle" type="iClick" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code="common.select" />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <c:forEach items="${siteList}" var="site">
            <li data-value="${site.id}"><a href="javascript:;">${site.name}</a></li>
          </c:forEach>
        </ul>
      </div>
    </c:if>
    <c:if test="${opt!='create'}">
      <div class="clearfix">
        <input type="text" name="hidesiteId" value="${iaxAdSlotDo.iaxSite.name}" disabled /> <input type="hidden" id="siteId" name="siteId"
          value="${iaxAdSlotDo.contextId}" />
      </div>
    </c:if>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group name hide" id="name_2">
  <label class="control-label"><s:message code="body.apps" /></label>
  <div class="controls">
    <c:if test="${opt=='create'}">
      <div class="dropdown modifylabel">
        <input name="appId" id="appId"  type="hidden" value="" disabled onchange="$(this).valid();getDefaultRevenue(this);" />
        <button class="btn  dropdown-toggle" type="iClick" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code="common.select" />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <c:forEach items="${appList}" var="app">
            <li data-value="${app.id}"><a href="javascript:;">${app.name}</a></li>
          </c:forEach>
        </ul>
      </div>
    </c:if>
    <c:if test="${opt!='create'}">
      <div class="clearfix">
        <input type="text" name="hideappId" value="${iaxAdSlotDo.iaxAppDo.name}" disabled /> <input type="hidden" id="appId" name="appId"
          value="${iaxAdSlotDo.contextId}" />
      </div>
    </c:if>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group">
  <label class="control-label"><s:message code="body.ad.unit.name" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="unitName" value="${iaxAdSlotDo.name}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdSlotDo.name}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.supported.impr.type" /></label>
  <div class="controls">
    <div class="modifylabel">
      <select class="select  required" multiple id="supportedImprType" name="allowedImpTypes" disname="chosen下拉" style="width: 380px">
        <option value="Banner"><s:message code="body.supported.impr.type.banner" /></option>
        <option value="Video"><s:message code="body.supported.impr.type.video" /></option>
      </select>
    </div>
    <div class="infolabel hide">
      <c:set var="allowedImprTypesArr" value="${fn:split(iaxAdSlotDo.allowedImpTypes, ',')}" />
      ${fn:join(allowedImprTypesArr, ', ')}
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group support" style="padding-top: 0" id="support_Banner">
  <div class="controls">
    <div class="clearfix">
      <div class="label-input">
        <s:message code="body.supported.banner.ad.type" />
      </div>
    </div>
    <div class="modifylabel">
      <select class="select required" multiple id="supportedBannerType" name="allowedBannerAdTypes" disname="chosen下拉" style="width: 380px">
        <c:forEach items="${listCode}" var="bannerType">
          <option value="${bannerType.id}"><s:message code="banner.ad.type.${bannerType.id}" text="${bannerType.descr}" /></option>
        </c:forEach>
      </select>
    </div>
    <div class="infolabel hide">${iaxAdSlotDo.allowedBannerAdTypes}</div>
    <div class="error-message hide" style="top: 30px;">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group support" style="padding-top: 0" id="support_Video">
  <div class="controls">
    <div class="clearfix">
      <div class="label-input">
        <s:message code="body.supported.video.protocols" />
      </div>
    </div>
    <div class="modifylabel">
      <select class="select  required" multiple id="supportedVideoProtocols" name="videoProtocolId" disname="chosen下拉" style="width: 380px">
        <c:forEach items="${listVideo}" var="video">
          <option value="${video.id }"><s:message code="banner.video.protocol.${video.id}" text="${video.descr}" /></option>
        </c:forEach>
      </select>
    </div>
    <div class="infolabel hide">${iaxAdSlotDo.videoProtocolId}</div>
    <div class="error-message hide" style="top: 30px;">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.supported.context.mimes" /></label>
  <div class="controls mimes" style="position: relative" id="mimes_Banner">
    <div class="clearfix">
      <div class="label-input" style="padding-top: 5px; margin-top: 0px; line-height: 18px;">
        <s:message code='body.supported.impr.type.banner' />
      </div>
    </div>
    <div class="modifylabel">
      <select class="select required" multiple id="supportedContextMimes" name="allowedContentMime" disname="chosen下拉" style="width: 380px">
        <c:forEach items="${listBannerMime}" var="bannerMime">
          <option value="${bannerMime.id}">${bannerMime.code}</option>
        </c:forEach>
      </select>
    </div>
    <div class="infolabel hide">
      <c:set var="contextMimeBannerArr" value="${fn:split(contentMimeBanner, ',')}" />
      ${fn:join(contextMimeBannerArr, ', ')}
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
  <div class="controls mimes" style="position: relative" id="mimes_Video">
    <div class="clearfix">
      <div class="label-input" style="padding-top: 5px; margin-top: 0px; line-height: 18px;">
        <s:message code='body.supported.impr.type.video' />
      </div>
    </div>
    <div class="modifylabel">
      <select class="select required" multiple id="supportedContextMimesVideo" name="allowedContentMimeVideo" disname="chosen下拉" style="width: 380px">
        <c:forEach items="${listVideoMime}" var="videoMime">
          <option value="${videoMime.id}">${videoMime.code}</option>
        </c:forEach>
      </select>
    </div>
    <div class="infolabel hide">
      <c:set var="contextMimeVideoArr" value="${fn:split(contentMimeVideo, ',')}" />
      ${fn:join(contextMimeVideoArr, ', ')}
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>

  <div class="control-group" id="adDuration">
    <label class="control-label"><s:message code="body.video.ad.duration" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.video.ad.duration' />"></span> </label>
    <div class="controls">
      <div class="input-append">
        <input type="text" value="${iaxAdSlotDo.iaxVideoConfig.durationMin}" style="width: 85px;" class="align_right numeric valid modifylabel"
          name="durationMin">
        <div class="clearfix infolabel hide align_right" style="width: 85px; float: left;">${iaxAdSlotDo.iaxVideoConfig.durationMin}</div>
        <span class="add-on"> Min (sec) </span> <span style="margin: 0 10px; float: left; line-height: 30px;"> - </span> <input type="text"
          style="width: 85px;" value="${iaxAdSlotDo.iaxVideoConfig.durationMax}" class="align_right numeric valid modifylabel" name="durationMax">
        <div class="clearfix infolabel hide align_right" style="width: 85px; float: left;">${iaxAdSlotDo.iaxVideoConfig.durationMax}</div>
        <span class="add-on"> Max (sec) </span>
      </div>
      <div class="error-message hide" style="height: auto; min-height: 28px;">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group" id="adStartDelay">
    <label class="control-label"><s:message code="body.video.ad.start.delay" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.video.ad.start.delay' />"></span></label>
    <div class="controls">
      <div class="dropdown modifylabel">
        <input name="startDelay" id="startDelay" type="hidden" value="${iaxAdSlotDo.iaxVideoConfig.startDelay}" onchange="videoStartDelayChange(this)" />
        <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code="common.select" />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li data-value="1"><a href="javascript:;"><s:message code="body.video.mid.roll" /></a></li>
          <li data-value="0"><a href="javascript:;"><s:message code="body.video.pre.roll" /></a></li>
          <li data-value="-1"><a href="javascript:;"><s:message code="body.video.mid.roll.generic" /></a></li>
          <li data-value="-2"><a href="javascript:;"><s:message code="body.video.post.roll.generic" /></a></li>

        </ul>
      </div>
      <div class="clearfix infolabel hide">${iaxAdSlotDo.iaxVideoConfig.startDelay}</div>

      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
    <div class="control-group hide" id="roll_mid" style="padding: 0;">
      <div class="controls">
        <div class="clearfix">
          <div class="label-input">
            <s:message code="body.video.ad.start.delay.mid" />
          </div>
        </div>
        <div class="input-append">
          <input type="text" value="${iaxAdSlotDo.iaxVideoConfig.startDelay}" style="width: 318px;" class="align_right numeric valid modifylabel"
            name="startDelayNumber" id="startDelayNumber">
          <div class="clearfix infolabel hide align_right" style="width: 318px; float: left;">${iaxAdSlotDo.iaxVideoConfig.startDelay}</div>
          <span class="add-on"> Sec </span>
        </div>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label"><s:message code="body.ad.unit.size" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.ad.unit.size' />"></span></label>
    <div class="controls">

      <div class="input-append">
        <input type="text" value="${iaxAdSlotDo.iaxSize.width}" style="width: 100px;" class="align_right numeric valid modifylabel" name="width">
        <div class="clearfix infolabel hide align_right" style="width: 100px; float: left;">${iaxAdSlotDo.iaxSize.width}</div>
        <span class="add-on"> W (px) </span> <span style="margin: 0 10px; float: left; line-height: 30px;">X</span> <input type="text"
          style="width: 100px;" value="${iaxAdSlotDo.iaxSize.height}" class="align_right numeric valid modifylabel" name="height">
        <div class="clearfix infolabel hide align_right" style="width: 100px; float: left;">${iaxAdSlotDo.iaxSize.height}</div>
        <span class="add-on"> H (px) </span>
      </div>
      <div class="error-message hide" style="height: auto; min-height: 28px;">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label"><s:message code="body.ad.unit.position" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.ad.unit.position' />"></span></label>
    <div class="controls">
      <div class="dropdown modifylabel">
        <input name="positionId" type="hidden" value="${iaxAdSlotDo.positionId}" onchange="$(this).valid()" />
        <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code="common.select" />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <c:forEach items="${plist}" var="iaxPosition">
            <c:set var="iaxPositionStr">
              <s:message code="ad.unit.position.id.${iaxPosition.id}" />
            </c:set>
            <c:if test='${fn:length(iaxPositionStr)>40 }'>
              <li data-value="${iaxPosition.id }"><a href="javascript:;" data-toggle="tooltip" data-placement="right" title="${iaxPositionStr}">${fn:substring(iaxPositionStr,0,40)}...</a></li>
            </c:if>
            <c:if test='${fn:length(iaxPositionStr)<41 }'>
              <li data-value="${iaxPosition.id }"><a href="javascript:;">${iaxPositionStr}</a></li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
      <div class="clearfix infolabel hide">${iaxAdSlotDo.iaxPosition.id}</div>

      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label"><s:message code="body.price.floor" /></label>
    <div class="controls">
      <div class="input-append selection-unit">
        <input type="text" id="budget_dis_input" value="${iaxAdSlotDo.decimalPrice}" style="width: 289px;"
          class="align_right numeric valid modifylabel" name="decimalPrice">
        <div class="dropdown">
          <input name="rateId" type="hidden" value="1" title="<s:message code='body.account.unit.cny' />">
          <button class="btn modifylabel dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
            aria-expanded="true">
            <s:message code='body.account.unit.cny' />
            <span class="caret arrow-down"></span>
          </button>
          <c:if test="${rateList!= null && fn:length(rateList) > 0}">
            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
              <!-- <li value="1" class="active"><a href="javascript:;">CNY</a></li> -->
              <c:forEach items="${rateList}" var="rate">
                <li data-value="${rate.id }"><a href="javascript:;">${rate.code }</a></li>
              </c:forEach>
            </ul>
          </c:if>
        </div>
        <div class="clearfix infolabel hide" style="width: 289px; float: left; text-align: right">${iaxAdSlotDo.decimalPrice}</div>
        <span class="add-on infolabel hide" style="width: 50px;"> ${iaxAdSlotDo.iaxExchangeRate.code} </span>
      </div>

      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group">
    <label class="control-label"><s:message code="body.backfill.type" /> <span class="glyphicon glyphicon-question-sign" aria-hidden="true"
      data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.backfill.type' />"></span> </label>
    <div class="controls">
      <div class="dropdown modifylabel">
        <input name="type" type="hidden" value="1" onchange="backfillChoose(this);" />
        <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code='body.backfill.type.none' />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li data-value="1"><a href="javascript:;"><s:message code='body.backfill.type.none' /></a></li>
          <li data-value="2"><a href="javascript:;"><s:message code='body.backfill.type.background' /></a></li>
          <li data-value="3"><a href="javascript:;"><s:message code='body.backfill.type.image' /></a></li>
          <li data-value="4"><a href="javascript:;"><s:message code='body.backfill.type.backfill' /></a></li>
          <li data-value="5"><a href="javascript:;"><s:message code='body.backfill.type.default' /></a></li>
        </ul>
      </div>
      <div class="clearfix infolabel hide">${iaxAdSlotDo.iaxAdBackfill.type}</div>
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group hide" id="backfill_info">
    <label class="control-label"></label>
    <div class="controls">
      <div class="clearfix infolabel hide"><c:out value="${iaxAdSlotDo.iaxAdBackfill.content}" escapeXml="true"></c:out></div>
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group backfill hide" id="backfill_2">
    <label class="control-label"> <s:message code="body.backfill.background" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.backfill.color' />"></span>
    </label>
    <div class="controls">
      <div class="clearfix modifylabel">
        <input type="text" class="backfillcontent" name="backgoundColor" disabled id="backgoundColor" value="" />
        <div id="color-picker" class="cp-default hide"></div>
      </div>
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group backfill hide" id="backfill_3">
    <label class="control-label"><s:message code="body.backfill.image" /> <span class="glyphicon glyphicon-question-sign" aria-hidden="true"
      data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.backfill.image' />"></span> </label>
    <div class="controls">
      <div class="clearfix modifylabel">
        <input type="text" class="backfillcontent" name="realPath" disabled value="" />
      </div>
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <div class="control-group backfill hide" id="backfill_4">
    <label class="control-label"><s:message code="body.backfill.code" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.backfill.code' />"></span></label>
    <div class="controls">
      <div class="clearfix modifylabel">
        <textarea class="input-xlarge span4 backfillcontent" name="backfillCode" disabled style="width: 360px !important;" rows="5" cols="20"></textarea>
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
	  <input name="revenueType" id="profitShareType" onchange="changeRevenueType(this.value)" type="hidden" value="${iaxAdSlotDo.profitShareType}"/>
	  <button class="btn dropdown-toggle" type="button" id="profitShareTypeButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
	    <c:if test="${iaxAdSlotDo.profitShareType != null}">
	    	<s:message code='body.profit.type.${iaxAdSlotDo.profitShareType}'/>
    	</c:if>
    	<c:if test="${iaxAdSlotDo.profitShareType == null}">
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
	<c:if test="${iaxAdSlotDo.profitShareType != null}">
		<s:message code='body.profit.type.${iaxAdSlotDo.profitShareType}'/>
	</c:if>
	</div>

</div>
</div>
<div class="control-group profitShareValue">
	<label class="control-label"></label>
	<div class="controls">
		<div class="clearfix modifylabel">
			<c:if test="${iaxAdSlotDo.profitShareType == null}">
				<div class="input-append">
				<input type="text" id="revenueValue"  name="revenueValue" value="" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> CNY</span>
                </div>
			</c:if>
			<c:if test="${iaxAdSlotDo.profitShareType == fixedConstant}">
				<div class="input-append">
	              <input type="text" id="revenueValue" name="revenueValue" value="<fmt:formatNumber pattern='###0.00' value='${iaxAdSlotDo.profitShareValue / 100}'/>" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> CNY</span>
	            </div>
			</c:if>
			<c:if test="${iaxAdSlotDo.profitShareType == shareConstant}">
				<div class="input-append">
	              <input type="text" id="revenueValue" name="revenueValue" value="<fmt:formatNumber pattern='###0' value='${iaxAdSlotDo.profitShareValue}'/>" style="width: 289px;"
	                class="align_right numeric valid"> <span class="add-on" style="width:50px"> %</span>
	            </div>
			</c:if>
		</div>
		<div class="clearfix infolabel hide" style="width: 289px; float: left; text-align: right">
			<c:if test="${iaxAdSlotDo.profitShareType == fixedConstant}">
				<fmt:formatNumber pattern="#,##0.00" value="${iaxAdSlotDo.profitShareValue / 100}"/>
			</c:if>
			<c:if test="${iaxAdSlotDo.profitShareType == shareConstant}">
				<fmt:formatNumber pattern="#,##0" value="${iaxAdSlotDo.profitShareValue}"/>
			</c:if>
		</div>
        <span class="add-on infolabel hide" style="width: 50px;margin-left: -1px;padding: 4px 10px;text-align: center;">
        	<c:if test="${iaxAdSlotDo.profitShareType == fixedConstant}">
				CNY
			</c:if>
			<c:if test="${iaxAdSlotDo.profitShareType == shareConstant}">
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


<div class="control-group preload" id="preload">
  <label class="control-label"><s:message code="body.preload" /> <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.preload' />"></span></label>
  <div class="controls">
      <div class="dropdown modifylabel">
        <input name="preload" value="true" type="checkbox" <c:if test="${iaxAdSlotDo.preload}">checked="checked"</c:if>>
      </div>
      <div class="clearfix infolabel hide" style="background: #fff; border: none; padding-left: 0;">
		<input disabled type="checkbox" <c:if test="${iaxAdSlotDo.preload}">checked="checked"</c:if>>
	  </div>
      <div class="error-message hide">
       <span class="glyphicon glyphicon-alert"></span>
       <div class="clearfix"></div>
      </div>
  </div>
</div>
<div class="control-group vr" id="vr">
  <label class="control-label">VR <span class="glyphicon glyphicon-question-sign"
      aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.vr' />"></span></label>
  <div class="controls">
      <div class="dropdown modifylabel">
        <input name="vr" value="true" type="checkbox" <c:if test="${iaxAdSlotDo.vr}">checked="checked"</c:if>>
      </div>
      <div class="clearfix infolabel hide" style="background: #fff; border: none; padding-left: 0;">
		<input disabled type="checkbox" <c:if test="${iaxAdSlotDo.vr}">checked="checked"</c:if>>
	  </div>
      <div class="error-message hide">
       <span class="glyphicon glyphicon-alert"></span>
       <div class="clearfix"></div>
      </div>
  </div>
</div>


  <div class="control-group">
    <label class="control-label"><s:message code="body.status" /></label>
    <div class="controls">
      <div class="dropdown modifylabel">
        <input name="status" type="hidden" value="LIVE" onchange="$(this).valid();" />
        <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          <s:message code="body.status.live" />
          <span class="caret arrow-down"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
          <li data-value="LIVE"><a href="javascript:;"><s:message code="body.status.live" /></a></li>
          <li data-value="STOPPED"><a href="javascript:;"><s:message code="body.status.stopped" /></a></li>
          <li data-value="SUSPENDED"><a href="javascript:;"><s:message code="body.status.suspended" /></a></li>
        </ul>
      </div>
      <div class="clearfix infolabel hide" id="statusLabel">
        <s:message code="body.status.${fn:toLowerCase(iaxAdSlotDo.status)}" />
      </div>
      <div class="error-message hide">
        <span class="glyphicon glyphicon-alert"></span>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>

  <script type="text/javascript">
      $(function() {
        var role = $("form").attr("ref");
        /*$("#backgoundColor").ColorPicker({
          onSubmit : function(hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
          },
          onBeforeShow : function() {
            $(this).ColorPickerSetColor(this.value);
          }
        }).bind('keyup', function() {
          $(this).ColorPickerSetColor(this.value);
        });*/
        var c = ColorPicker(document.getElementById('color-picker'), function(
            hex, hsv, rgb) {
          $("#backgoundColor").val(hex.substr(1));
        });
        $("#backgoundColor").click(function() {
          $("#color-picker").toggle();
          if ($("#backgoundColor").val() != "") {
            c.setHex("#" + $("#backgoundColor").val());
          }
        });

		var profitShareType = $("#profitShareType").val();
		if (profitShareType == '${fixedConstant}') {
			$(".profitShareValue").show();
		} else if (profitShareType == '${shareConstant}'){
			$(".profitShareValue").show();
		} else {
			$(".profitShareValue").hide();
		}

        $("#supportedImprType")
            .val('${iaxAdSlotDo.allowedImpTypes}'.split(","));
        if ('${iaxAdSlotDo.allowedBannerAdTypes}' != '') {
          var adTypes = '${iaxAdSlotDo.allowedBannerAdTypes}';
          var adTypesArr = adTypes.split(",")
          var text = [];
          $("#supportedBannerType").val(adTypesArr);
          for (var i = 0; i < adTypesArr.length; i++) {
            text.push($("#supportedBannerType").find(
                "option[value='" + adTypesArr[i] + "']").text());
          }
          $("#supportedBannerType").parent().next().text(text.join(", "));
        }
        if ('${contentMimeBannerIds}' != '') {
          var contentMimeBanner = '${contentMimeBannerIds}'.replace(/\s/g, "");
          $("#supportedContextMimes").val(contentMimeBanner.split(","));
        }
        if ('${contentMimeVideoIds}' != '') {
          var contentMimeVideo = '${contentMimeVideoIds}'.replace(/\s/g, "");
          $("#supportedContextMimesVideo").val(contentMimeVideo.split(","));
        }
        if ('${iaxAdSlotDo.videoProtocolId}' != '') {
          var videoProtocolId = '${iaxAdSlotDo.videoProtocolId}';
          var videoProtocolArr = videoProtocolId.split(",")
          var text = [];
          $("#supportedVideoProtocols").val(videoProtocolArr);
          for (var i = 0; i < videoProtocolArr.length; i++) {
            text.push($("#supportedVideoProtocols").find(
                "option[value='" + videoProtocolArr[i] + "']").text());
          }
          $("#supportedVideoProtocols").parent().next().text(text.join(", "));
        }

        $("#supportedImprType").chosen();
        $("#supportedContextMimes").chosen();
        $("#supportedContextMimesVideo").chosen();
        $("#supportedBannerType").chosen();
        $("#supportedVideoProtocols").chosen();

        $("form")
            .validate(
                {
                  rules : {
                    "publisher" : {
                      publisher : true
                    },
                    "unitName" : {
                      required : true
                    },
                    "siteId" : {
                      required : true
                    },
                    "appId" : {
                      required : true
                    },
                    "allowedImpTypes" : {
                      required : true
                    },
                    "allowedBannerAdTypes" : {
                      required : true
                    },
                    "allowedContentMime" : {
                      required : true
                    },
                    "allowedContentMimeVideo" : {
                      required : true
                    },
                    "videoProtocolId" : {
                      required : true
                    },
                    "positionId" : {
                      required : true
                    },
                    "backfillType" : {
                      required : true
                    },
                    "status" : {
                      required : true
                    },
                    "width" : {
                      required : true,
                      digits : true
                    },
                    "height" : {
                      required : true,
                      digits : true
                    },
                    "decimalPrice" : {
                      required : true,
                      limitDigit : true
                    },
                    "backgoundColor" : {
                      required : true
                    },
                    "realPath" : {
                      required : true
                    },
                    "backfillCode" : {
                      required : true
                    },
                    "durationMin" : {
                      required : true,
                      digits : true
                    },
                    "startDelay" : {
                        required : true,
                        // digits : true
                    },
                    "startDelayNumber" : {
                        required : true,
                        digits : true
                    },
                    "revenueValue" : {
                      isprofitShareValue : true
                    },
                    "durationMax" : {
                      required : true,
                      digits : true,
                      duration : true
                    }

                  },
                  errorPlacement : function(error, element) {
                    element.parents(".controls").find(".error-message")
                        .removeClass("hide");
                    error.appendTo(element.parents(".controls").find(
                        ".error-message").find(".clearfix"));
                  },
                  ignore : "disabled",
                  messages : {
                    "siteId" : {
                      required : "<s:message code='form.error.site.empty' />"
                    },
                    "appId" : {
                      required : "<s:message code='form.error.apps.name.empty' />"
                    },
                    "unitName" : {
                      required : "<s:message code='form.error.ad.unit.name.empty' />"
                    },
                    "allowedImpTypes" : {
                      required : "<s:message code='form.error.supported.imprType.empty' />"
                    },
                    "allowedBannerAdTypes" : {
                      required : "<s:message code='form.error.supported.bannerType.empty' />"
                    },
                    "allowedContentMime" : {
                      required : "<s:message code='form.error.supported.contextMimes.empty' />"
                    },
                    "allowedContentMimeVideo" : {
                      required : "<s:message code='form.error.supported.contextMimes.empty' />"
                    },
                    "videoProtocolId" : {
                      required : "<s:message code='form.error.supported.video.protocol.empty' />"
                    },
                    "positionId" : {
                      required : "<s:message code='form.error.ad.unit.position.empty' />"
                    },
                    "backfillType" : {
                      required : "<s:message code='form.error.backfill.type.empty' />"
                    },
                    "status" : {
                      required : "<s:message code='form.error.status.empty' />"
                    },
                    "width" : {
                      required : "<s:message code='form.error.ad.unit.width.empty' />",
                      digits : "<s:message code='form.error.digits' />"
                    },
                    "height" : {
                      required : "<s:message code='form.error.ad.unit.height.empty' />",
                      digits : "<s:message code='form.error.digits' />"
                    },
                    "decimalPrice" : {
                      required : "<s:message code='form.error.price.floor.empty' />"
                    },
                    "backgoundColor" : {
                      required : "<s:message code='form.error.backfill.background.empty' />"
                    },
                    "realPath" : {
                      required : "<s:message code='form.error.backfill.image.empty' />"
                    },
                    "backfillCode" : {
                      required : "<s:message code='form.error.backfill.code.empty' />"
                    },
                    "durationMin" : {
                      required : "<s:message code='form.error.duration.min.empty' />",
                      digits : "<s:message code='form.error.digits' />"
                    },
                    "durationMax" : {
                      required : "<s:message code='form.error.duration.max.empty' />",
                      digits : "<s:message code='form.error.digits' />"
                    }

                  },
                  beforeSend : function() {
                    $('[type="button"]').attr("disabled", true);
                  },
                  success : function(label) {
                    var fors = $(label).attr("for");
                    if (fors == "width" || fors == "height") {
                      $("label.error").each(
                          function() {
                            if ($(this).html().length) {
                              $(this).parents(".error-message").removeClass(
                                  "hide");
                            } else {
                              $(this).parents(".error-message")
                                  .addClass("hide");
                            }
                          })
                      return false;
                    }
                    $(label).parents(".error-message").addClass("hide");
                  },
                  submitHandler : function(form) { //通过之后回调

                    form.submit();

                  },
                  invalidHandler : function(form, validator) { //不通过回调
                    $("label.error").each(
                        function() {
                          $(this).html().length
                              && $(this).parents(".error-message").removeClass(
                                  "hide");
                        })
                    return false;
                  }

                })
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

        // 小数点精确两位验证
        jQuery.validator.addMethod("limitDigit", function(value, element) {
          var reg = /^([1-9]\d*|0)(\.\d{1,2})?$/;
          var isLimit = reg.test(value);
          return isLimit;
        }, "<s:message code='form.error.digits' />");

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


        // duration验证
        jQuery.validator.addMethod("duration", function(value, element) {
          var durationMin = $("[name='durationMin']").val();
          var durationMax = $("[name='durationMax']").val();

          return parseInt(durationMin) <= parseInt(durationMax)

        }, "<s:message code='form.error.duration.range' />");

        $("body").on("change", "#supportedImprType", function() {
          var value = $(this).val();
          $(".mimes").addClass("hide");
          $(".mimes").parent().removeClass("hide");
          $(".mimes").find("select").attr("disabled", true);
          //support
          $(".support").addClass("hide");
          $(".support").find("select").attr("disabled", true);

          $("#adDuration").addClass("hide");
          $("#adDuration").find("input").attr("disabled", true);
          $("#adStartDelay").addClass("hide");
          $("#adStartDelay").find("input").attr("disabled", true);

          if (value) {
            for ( var i in value) {
              var v = value[i];
              $("#mimes_" + v).removeClass("hide");
              $("#mimes_" + v).find("select").attr("disabled", false);
              $("#mimes_" + v).find("select").valid();

              $("#support_" + v).removeClass("hide");
              $("#support_" + v).find("select").attr("disabled", false);
              $("#support_" + v).find("select").valid();
            }
            if ($.inArray("Video", value) > -1) {
              $("#adDuration").removeClass("hide");
              $("#adDuration").find("input").attr("disabled", false);
              $("#adDuration").find("input").valid();
              $("#adStartDelay").removeClass("hide");
              $("#adStartDelay").find("input").attr("disabled", false);
              $("#adStartDelay").find("input").valid();
              
              if ($("#startDelay").val() < 1) {
            	  $("#startDelayNumber").attr("disabled", true);
              }
            }
          } else {
            $(".mimes").parent().addClass("hide");
            $(".support").addClass("hide");
          }
          initPreload();
        })
        $("#supportedImprType").change();

        $("#supportedImprType").change(function() {
          $(this).valid();
        })
        $("#supportedContextMimes").change(function() {
          $(this).valid();
        })
        $("#supportedContextMimesVideo").change(function() {
          $(this).valid();
        })
        $("#supportedBannerType").change(function() {
          $(this).valid();
        })
        $("#supportedVideoProtocols").change(function() {
          $(this).valid();
        })

        $("[name='width'],[name='height']").on("keyup", function() {
          var _this = this;
          $(_this).parent().next().addClass("hide");
          var inputs = $(_this).parent().find("input").map(function() {
            $(this).valid();
            return $(this).val().replace(/\s/g, "");
          }).get();
          for (var i = 0; i < inputs.length; i++) {
            if (!(/^[0-9]*$/g).test(inputs[i]) || inputs[i] == "") {
              $(_this).parent().next().removeClass("hide");
              break;
            }
          }

        })

        if ('${iaxAdSlotDo.publisherName}' != '' || '${publisherName}' != '') {
          var publiserName = '${iaxAdSlotDo.publisherName}'
              || '${publisherName}';
          $("[name='publisherName']").parent().find(
              "[data-value='" + publiserName + "']").trigger("click");
        }
        if ('${iaxAdSlotDo.iaxSite.id }' != '' || '${siteId}' != '') {
          var siteId = '${iaxAdSlotDo.iaxSite.id }' || '${siteId}';
          $("[name='siteId']").parent().find("[data-value='" + siteId + "']")
              .trigger("click");
        }
        if ('${iaxAdSlotDo.iaxAppDo.id }' != '' || '${appId}' != '') {
          var appId = '${iaxAdSlotDo.iaxAppDo.id }' || '${appId}';
          $("[name='appId']").parent().find("[data-value='" + appId + "']")
              .trigger("click");
        }
        if ('${iaxAdSlotDo.adContext }' != '' || '${adContext}' != '') {
          var adContext = '${iaxAdSlotDo.adContext }' || '${adContext}';
          $("[name='adContext']").parent().find(
              "[data-value='" + adContext + "']").trigger("click");
          $("[name='adContext']").parent().next().text(
              $("[name='adContext']").attr("title"));
          if (adContext == 2) {
            $("#name_2").show();
            $("#name_1").hide();
          }
        }
        if ('${iaxAdSlotDo.positionId}' != '') {
          $("[name='positionId']").parent().find(
              "[data-value='${iaxAdSlotDo.positionId}']").trigger("click");
          $("[name='positionId']").parent().next().text(
              $("[name='positionId']").attr("title"));
        }
        if ('${iaxAdSlotDo.iaxAdBackfill.type}' != '') {
          $("[name='type']").parent().find(
              "[data-value='${iaxAdSlotDo.iaxAdBackfill.type}']").trigger(
              "click");
          $("[name='type']").parent().next().text(
              $("[name='type']").attr("title"));
          var label = $("#backfill_${iaxAdSlotDo.iaxAdBackfill.type}").find(
              "label:first").text();
          if (!label) {
            $("#backfill_info").hide();
          } else {
            $("#backfill_info").find("label:first").text(label);
            $("#backfill_${iaxAdSlotDo.iaxAdBackfill.type}").find(
                ".backfillcontent").val(
                $("#backfill_info").find(".infolabel").text());
          }
        }
        if ('${iaxAdSlotDo.rateId}' != '') {
          $("[name='rateId']").parent().find(
              "[data-value='${iaxAdSlotDo.rateId}']").trigger("click");
        } else {
          $("[name='rateId']").parent().find("ul").find("li:first").trigger(
              "click");
        }
        if ('${iaxAdSlotDo.iaxVideoConfig.startDelay}' != '') {
          var startDelay = '${iaxAdSlotDo.iaxVideoConfig.startDelay}';
          if (",0,-1,-2,".indexOf(',${iaxAdSlotDo.iaxVideoConfig.startDelay},') == -1) {
            startDelay = 1;
          }
          $("[name='startDelay']").parent().find(
              "[data-value='" + startDelay + "']").trigger("click");
          $("[name='startDelay']").parent().next().text(
              $("[name='startDelay']").attr("title"));
        }
        if ('${iaxAdSlotDo.status}' != '') {
          $("[name='status']").parent().find(
              "[data-value='${iaxAdSlotDo.status}']").trigger("click");
          $("[name='status']").parent().next().text(
              $("[name='status']").attr("title"));
          if (role != "admin") {
            if ('${iaxAdSlotDo.status}' == "SUSPENDED") {
              $("#statusLabel").text($("[name='status']").attr("title"));
              $("#statusLabel").prev().hide();
              $("#statusLabel").prev().removeClass("modifylabel");
              $("#statusLabel").removeClass("hide");
              $("#statusLabel").removeClass("infolabel");
            }
          }

        }
        if (role != "admin") {
          $("[name='status']").parent().find("[data-value='SUSPENDED']")
              .remove();
          $(".profitShareType").find("input").removeClass("noValid");
    	  $(".profitShareType").hide();
          $(".profitShareValue").find("input").removeClass("noValid");
    	  $(".profitShareValue").hide();
        }
        
      })

      function backfillChoose(thi) {
        var value = $(thi).val();
        $(".backfill").addClass("hide");
        $(".backfill").find("input,textarea").each(function() {
          $(this).attr("disabled", "disabled");
        })
        $("#backfill_" + value).removeClass("hide");
        $("#backfill_" + value).find("input,textarea").attr("disabled", false);
      }
      function changeContext(thi) {
        var value = $(thi).val();
        $(".name").addClass("hide");
        $(".name").find("input:hidden").attr("disabled", true);
        $("#name_" + value).removeClass("hide");
        $("#name_" + value).show();
        $("#name_" + value).find("input:hidden").attr("disabled", false);
        $("#name_" + value).find("input:hidden").valid();
      }
      function videoStartDelayChange(thi) {
        var value = $(thi).val();
        $("#roll_mid").addClass("hide");
        $("#roll_mid").find("input").attr("disabled", true);
        if (value == "1") {
          $("#roll_mid").removeClass("hide");
          $("#roll_mid").find("input").attr("disabled", false);
          $("#roll_mid").find("input").valid();
        }
      }
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

      function getDefaultRevenue(thi) {
        var url = "${path}/admin/inventories/ajaxDefaultRevenue";
        var adContext = $("#adContext").val();
        var contextId = null;
        
        if (adContext == '${siteConstant.getCode()}') {
        	if (thi.name == "appId") {
        		return;
        	}
        	contextId = $("#siteId").val();
        }
        
        if (adContext == '${appConstant.getCode()}') {
        	if (thi.name == "siteId") {
        		return;
        	}
        	contextId = $("#appId").val();
        }
        if (adContext == "" || contextId == "") {
        	$("#profitShareTypeButton").html("<span class=\"caret arrow-down\"></span>");
        	$("#profitShareTypeLink").html("");
        	return;
        }
        $.ajax({
            type : "POST",
            url : url,
            dataType : "json",
            data : {
              "contextId" : contextId,
              "adContext" : adContext
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
	    	  var adContext = $("#adContext").val();
		      if (adContext == '${siteConstant.getCode()}') {
		      	getDefaultRevenue($("#siteId").get(0));
		      }
		      if (adContext == '${appConstant.getCode()}') {
		      	getDefaultRevenue($("#appId").get(0));
		      }
          }
      }
      
      
      initDefaultRevenue();
      
      function initPreload() {
    	  $("#preload").hide();
    	  $("#vr").hide();
    	  
    	  var adContext = $("#adContext").val();
    	  var supportedImprType = $("#supportedImprType").val();
    	  
    	  if (supportedImprType && (adContext == '${appConstant.getCode()}')) {
              var supportType = supportedImprType.toString().toUpperCase();
              if (supportType.indexOf('${bannerConstant}') >= 0) {
            	  $("#vr").show();
              } else {
            	  $("#vr").hide();
              }
              if (supportType.indexOf('${videoConstant}') >= 0) {
            	  $("#preload").show();
              } else {
            	  $("#preload").hide();
              }
    	  }
      }
      initPreload();
    </script>