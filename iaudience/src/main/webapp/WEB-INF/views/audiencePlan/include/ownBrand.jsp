<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.iclick.symphony.iaudience.model.view.BrandModel" %>
<%@ page import="com.iclick.symphony.iaudience.model.view.AudiencePlanModel" %>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<%
    AudiencePlanModel audiencePlanModel = (AudiencePlanModel) request.getAttribute("audiencePlan");
    BrandModel ownBrandModel = audiencePlanModel.ownBrandModel();
    request.setAttribute("ownBrandModel",ownBrandModel);
    request.setAttribute("brandModel",ownBrandModel);
%>

<div class="feature-plan-search-content">
    <input type="hidden" name="brandModelList[0].brandId" value="${ownBrandModel.brandId}" >
    <input type="hidden" name="brandModelList[0].competitor" value= "false" >
    <!-- my brand container-->
    <div class="plan-container">
        <label class="plan-title">
            <s:message code="audiencePlan.form.tellBrand" />
        </label>
        <div class="plan-group">
            <label class="plan-label"><s:message code="audiencePlan.form.brandName" /></label>
            <div class="plans">
                <div class="clearfix">
                    <input type="text" id="ownBrandName" name="brandModelList[0].name" value="${ownBrandModel.name}" placeholder="<s:message code="audiencePlan.form.blankBrandName" />"/>
                </div>
                <div class="warn-message hide">
                    <span class="nav-arrow"></span>
                    <div class="clearfix">
                        <s:message code="audiencePlan.form.brandNameTip" />
                    </div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>
        <div class="plan-group">
            <label class="plan-label"><s:message code="audiencePlan.form.selectCategory" /></label>
            <div class="plans">
                <div class="dropdown modifylabel tree-stop">
                    <input name="categoryId" id="category" type="hidden" value="${audiencePlan.categoryId}"/>
                    <button class="btn  dropdown-toggle dropdown-stop" type="button" id="dropdownMenu1" data-toggle="dropdown-stop" aria-haspopup="true" aria-expanded="true">
                        <c:if test="${not empty audiencePlan.categoryId}">
                            <c:out value="${audiencePlan.categoryName}"></c:out>
                        </c:if>

                        <c:if test="${ empty audiencePlan.categoryId}">
                            <s:message code="audiencePlan.form.selectOption" />
                        </c:if>
                        <span class="caret arrow-down"></span>
                    </button>
                    <div class="dropdown-menu dropdown-tree-con plus-tree" aria-labelledby="dropdownMenu1">
                        <div class="dropdown-tree-category clearfix">
                            <div class="parent_layer">
                                <div class="pannel">
                                    <span><s:message code="audiencePlan.form.catogeries" /></span>
                                </div>
                                <ul class="tree">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>
        <div class="plan-group">
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.describeKeyWords" /></label>
            <div class="plans" style="display:none">
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType" id="brandType0" data-target="" value="0" checked="checked">
                        <label for="brandType0"><s:message code="audiencePlan.form.enterKeyWords" /></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType" data-target="uploadfile" id="brandType1" value="1">
                        <label for="brandType1"><s:message code="audiencePlan.form.uploadKeyWords" /></label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="brandType" data-target="chooseplan" id="brandType2" value="2">
                        <label for="brandType2"><s:message code="audiencePlan.form.importKeyWords" /></label>
                    </div>
                </div>
                <div class="keywords-con" style="display:none">
                    <div class="uploadfile">
                        <%--<input type="file" class="fileStyle" id="keyword" name="uploadKeywords" style="width: 110px;" onchange="uploadFile(this)"/>--%>
                        <input id="keyword" type="file" class="fileStyle" name="uploadKeywords" data-url="${path}/file/upload" style="width: 110px;" onchange="uploadFile(this)">
                        <i class="fa fa-upload" style="position: absolute; top: 10px; left: 10px;"></i>
                        <button class="btn dropdown-toggle" type="button">
                            <s:message code="audiencePlan.form.uploadFile" />&nbsp;
                        </button>
                        <div class="uploadshow">
                            <span class="uploadText"><s:message code="audiencePlan.form.uploadFormat" /></span>
                            <a href="javascript:;" style="display:none;text-decoration:underline;color:#5D9CEC;" onclick="removeUpload(this)">Remove</a>
                        </div>
                        <div class="uploadtip">

                        </div>
                    </div>
                </div>
                <jsp:include page="chooseKeyWords.jsp"></jsp:include>
                <div class="keywords-con">
                    <input type="hidden" id="result" class="brandResult" name="brandModelList[0].keyWords" value="${ownBrandModel.keyWords}" />
                    <div name="keywordsLayer" data-keyWords=${ownBrandModel.keyWordsShow}></div>
                </div>
            </div>
        </div>
        <div class="split-line"></div>

        <div class="plan-group">
            <i class="fa fa-plus-square showHideIco"></i>
            <label class="plan-label"><s:message code="audiencePlan.form.describeProduct"/> </label>
            <label class="plan-sub-label"><s:message code="audiencePlan.form.describeProductTip"/> </label>
            <div class="plans" style="display:none;">
                <div class="select-radio-con">
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType" data-target="" id="productType0" value="0" checked="checked">
                        <label for="productType0"><s:message code="audiencePlan.form.inputProduct" /> </label>
                    </div>
                    <div class="radio radio-primary radio-switch">
                        <input type="radio" name="productType" data-target="chooseplan" id="productType1" value="1">
                        <label for="productType1"><s:message code="audiencePlan.form.importProduct"/> </label>
                    </div>
                </div>

                <div class="products" id="products">
                    <jsp:include page="choosePlanProduct.jsp"></jsp:include>
                    <div class="products-con">
                        <c:if test="${action eq 'update'}">
                        <jsp:include page="../editProduct.jsp">
                            <jsp:param name="brandIndex" value="0"></jsp:param>
                        </jsp:include>
                        </c:if>
                    </div>
                </div>

                <div class="addProduct" style="position: relative">
                    <i class="fa fa-plus-circle" style="position: absolute; top: 10px; left: 5px;"></i>
                    <button class="btn dropdown-toggle addOwnBrandProduct" type="button" onclick="addProduct();">
                        <s:message code="audiencePlan.form.addProduct"/>&nbsp;
                    </button>
                </div>


            </div>
        </div>
    </div>
    <!-- my brand container end-->

</div>
