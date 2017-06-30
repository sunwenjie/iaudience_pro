<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<div class="feature-plan-search-content hide">
    <!-- my advanced settings container-->
    <div class="plan-container">

        <div class="plan-group">
            <input type="hidden" name="advancedSettingModel.advancedSettingId" value="${audiencePlan.advancedSettingModel.advancedSettingId}" />
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.tellAdvanced"/></label>
            <div class="plans" style="display:none">
                <label class="plan-sub-label"><s:message code="audiencePlan.form.tellAdvancedTip"/></label>
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType_location" data-target="" id="brandType_location0" value="0" checked="checked">
                        <label for="brandType_location0"><s:message code="audiencePlan.form.enterKeyWords"/></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType_location" data-target="uploadfile" id="brandType_location1" value="1">
                        <label for="brandType_location1"><s:message code="audiencePlan.form.uploadKeyWords"/></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType_location" data-target="chooseplan" id="brandType_location2" value="2">
                        <label for="brandType_location2"><s:message code="audiencePlan.form.importProduct"/></label>
                    </div>
                </div>

                <div class="keywords-con" style="display:none;">
                    <div class="uploadfile">
                        <input id="keyword" type="file" class="fileStyle" name="uploadKeywords" data-url="${path}/file/upload" style="width: 110px;" onchange="uploadFile(this)">
                            <i class="fa fa-upload" style="position: absolute; top: 10px; left: 10px;"></i>
                        <button class="btn dropdown-toggle" type="button">
                            <s:message code="audiencePlan.form.uploadFile"/>&nbsp;
                        </button>
                        <div class="uploadshow">
                            <span class="uploadText"><s:message code="audiencePlan.form.uploadFormat"/></span>
                            <a href="javascript:;" style="display:none;text-decoration:underline;color:#5D9CEC;" onclick="removeUpload(this)"><s:message code="audiencePlan.form.remove"/></a>
                        </div>
                        <div class="uploadtip">

                        </div>
                    </div>
                </div>
                <jsp:include page="chooseKeyWords.jsp"></jsp:include>
                <div class="keywords-con">
                    <input type="hidden" name="advancedSettingModel.keyWords" />
                    <div name="keywordsLayer" data-keyWords=${audiencePlan.advancedSettingModel.keyWordsShow}></div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>

        <div class="plan-group">
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.location"/></label>
            <div class="plans" style="display:none;">
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType_location" data-target="" id="productType_location0" value="0" checked="checked">
                        <label for="productType_location0"><s:message code="audiencePlan.form.selectLocation"/></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType_location" data-target="chooseplan" id="productType_location1" value="1">
                        <label for="productType_location1"><s:message code="audiencePlan.form.importLocation"/></label>
                    </div>
                </div>
                <div class="choose-from-plan" style="display:none">
                    <div class="addproduct chooseplan">
                        <i class="fa fa-chevron-down" style="position: relative; top: 25px; left: 10px;"></i>
                        <div class="dropdown tree-stop" style="width:auto;">
                            <input name="choosePlan" id="choosePlan" type="hidden"/>
                            <button class="btn  dropdown-toggle dropdown-stop" data-type="plan" type="button" style="width:auto;" id="dropdownMenu1" data-toggle="dropdown-stop" aria-haspopup="true" aria-expanded="true">
                                <s:message code="audiencePlan.form.choosePlan"/>
                            </button>
                            <div class="dropdown-menu dropdown-tree-con" aria-labelledby="dropdownMenu1">
                                <div class="dropdown-tree-category">
                                    <div class="parent_layer">
                                        <div class="pannel">
                                            <span><s:message code="audiencePlan.form.audiencePlan"/>: <b>${audiencePlanModeSize}</b></span>
                                            <span style="float:right; margin: 0 5px 0 0!important;">
                                                    <i class="fa fa-angle-right"></i>
                                                  </span>
                                        </div>
                                        <ul class="tree">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <label class="dropdown-plan-infos"></label>
                        </div>
                    </div>
                </div>

                <div class="location-con">
                    <div class="location-suggest-con">
                        <label class="location-label"><s:message code="audiencePlan.form.city"/></label>
                        <div style="position:relative;">
                            <select class="select  required"  id="region_city" name="advancedSettingModel.city" disname="chosen下拉" style="width: 380px">
                                <c:forEach items="${audiencePlan.cityArray}" var="city" varStatus="status">
                                    <c:if test="${city.cityId eq audiencePlan.advancedSettingModel.city}">
                                        <option value="${city.cityId}" selected="selected">${city.cityName}</option>
                                    </c:if>
                                    <c:if test="${city.cityId ne audiencePlan.advancedSettingModel.city}">
                                        <option value="${city.cityId}">${city.cityName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <span class="caret arrow-down" style="left:360px;"></span>
                        </div>
                    </div>
                    <div class="location-suggest-con">
                        <label class="location-label"><s:message code="audiencePlan.form.keyWords"/></label>
                        <input type="hidden" id="regionInput" name="advancedSettingModel.location" value="${audiencePlan.advancedSettingModel.location}"/>
                        <div style="position:relative;">
                            <input type="text" placeholder="Search" id="tipinput" class="location" value="${audiencePlan.advancedSettingModel.locationShow == null ? '' : audiencePlan.advancedSettingModel.locationShow[0]}">
                        </div>

                        <c:if test="${fn:length(audiencePlan.advancedSettingModel.locationShow) > 1}">
                        <c:forEach items="${audiencePlan.advancedSettingModel.locationShow}" var="location" begin="1" varStatus="status">
                                <div style="position:relative"><input type="text" value="${audiencePlan.advancedSettingModel.locationShow[status.index]}" id="tipinput_${index}" placeholder="<s:message code="audiencePlan.form.search"/>" name="Locations" class="location"><i class="fa fa-remove input-remove"></i></div>
                        </c:forEach>
                        </c:if>

                        <!-- <div class="plus-area">
                          <i class="fa fa-plus-circle" aria-hidden="true"></i>
                          <a>Add one more location</a>
                        </div> -->
                        <div class="plus-area">
                            <i class="fa fa-plus-circle"></i>
                            <button class="btn dropdown-toggle" type="button">
                                <s:message code="audiencePlan.form.addLocation"/>&nbsp;
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- my advanced settings container end-->

</div>
