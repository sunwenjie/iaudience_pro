<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<div class="row plan-competitor"  id="competitorBox_${maxCompetitorIndex}">
    <input type="hidden" name="competitor_json" value="{index:${maxCompetitorIndex}}"/>
    <input type="hidden" class="maxCompetitorIndex" value="${maxCompetitorIndex}">
    <input type="hidden" name="brandModelList[${maxCompetitorIndex}].competitor" value= "true" >
    <div class="split-line"></div>
    <label class="plan-title">
        <s:message code="audiencePlan.form.competitor"/> ${index}
    </label>

    <div class="plan-competion-con">
        <div class="plan-group">
            <label class="plan-label"><s:message code="audiencePlan.form.competitorName"/></label>
            <div class="plans">
                <div class="clearfix">
                    <input type="text" id="competitorName" name="brandModelList[${maxCompetitorIndex}].name" value="" placeholder="<s:message code="audiencePlan.form.blankCompetitorName"/>"/>
                </div>
                <div class="warn-message hide">
                    <span class="nav-arrow"></span>
                    <div class="clearfix">
                        <s:message code="audiencePlan.form.brandNameTip"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>

        <div class="plan-group">
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.describeCompetitor"/></label>
            <div class="plans" style="display:none">
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">

                        <input type="radio" name="brandType_competitor_${maxCompetitorIndex}" data-target="" id="brandType_competitor0_${maxCompetitorIndex}" value="0" checked="checked">
                        <label for="brandType_competitor0_${maxCompetitorIndex}"><s:message code="audiencePlan.form.enterKeyWords"/></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType_competitor_${maxCompetitorIndex}" data-target="uploadfile" id="brandType_competitor1_${maxCompetitorIndex}" value="1">
                        <label for="brandType_competitor1_${maxCompetitorIndex}"><s:message code="audiencePlan.form.uploadKeyWords"/></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType_competitor_${maxCompetitorIndex}" data-target="chooseplan" id="brandType_competitor2_${maxCompetitorIndex}" value="2">
                        <label for="brandType_competitor2_${maxCompetitorIndex}"><s:message code="audiencePlan.form.importKeyWords"/></label>
                    </div>
                </div>

                <div class="keywords-con" style="display:none">
                    <div class="uploadfile">
                        <%--<input type="file" class="fileStyle" id="keyword" name="uploadKeywords" style="width: 110px;" onchange="uploadFile(this)"/>--%>
                        <input id="keyword" type="file" class="fileStyle fileCompetitor" name="uploadKeywords" data-url="${path}/file/upload" style="width: 110px;" onclick="clickFile()" onchange="uploadFile(this)">
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
                <jsp:include page="include/chooseKeyWords.jsp"></jsp:include>

                <div class="keywords-con">
                    <input type="hidden" id="result" name="brandModelList[${maxCompetitorIndex}].keyWords" />
                    <div name="keywordsLayer" data-keywords=""></div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>

        <div class="plan-group">
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.desCompetitorProduct"/></label>
            <label class="plan-sub-label"><s:message code="audiencePlan.form.describeProductTip"/></label>
            <div class="plans" style="display:none;">
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType_competitor_${maxCompetitorIndex}" data-target="" id="productType_competitor0_${maxCompetitorIndex}" value="0" checked="checked">
                        <label for="productType_competitor0_${maxCompetitorIndex}"><s:message code="audiencePlan.form.inputComProduct"/> </label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType_competitor_${maxCompetitorIndex}" data-target="chooseplan" id="productType_competitor1_${maxCompetitorIndex}" value="1">
                        <label for="productType_competitor1_${maxCompetitorIndex}"><s:message code="audiencePlan.form.importComProduct"/></label>
                    </div>
                </div>

                <div class="competitor_products" id="competitor_products">
                    <jsp:include page="include/choosePlanProduct.jsp"></jsp:include>
                    <div class="products-con">

                    </div>
                </div>

                <div class="addProduct" style="position: relative">
                    <i class="fa fa-plus-circle" style="position: absolute; top: 10px; left: 5px;"></i>
                    <button class="btn dropdown-toggle addCompetitorProduct" type="button" onclick="addCompetitorProduct(${maxCompetitorIndex});">
                        <s:message code="audiencePlan.form.addProduct"/>&nbsp;
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
