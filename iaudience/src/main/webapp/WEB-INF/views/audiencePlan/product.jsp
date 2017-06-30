<%@ page import="com.iclick.symphony.iaudience.model.view.BrandModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.iclick.symphony.iaudience.model.view.AudiencePlanModel" %>
<%@ page import="com.iclick.symphony.iaudience.model.view.BrandModel" %>
<%@ page import="java.util.List" %>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<div class="row product-suggest-con" id="row_product_${index}">
    <input type="hidden" name="product_json" value="{index:${index}}" />
    <div class="product-suggest-index">#${index+1}</div>
    <div class="product-suggest">
        <input type="hidden" class="maxProductIndex" value="${maxProductIndex}">
        <input type="text" id="product" name="brandModelList[${brandIndex}].productModelList[${maxProductIndex}].name" />
        <input type="hidden" class="productKeyWords" name="brandModelList[${brandIndex}].productModelList[${maxProductIndex}].keyWords">
        <c:if test="${index != 0}">
            <a href="javascript:;" style="margin-left:10px;" class="bluelink"><s:message code="audiencePlan.form.remove"/></a>
        </c:if>

        <div class="product-suggest-area">
            <div class="dropdown enter-select-con">
                <input type="hidden"  id="productCategory" name="brandModelList[${brandIndex}].productModelList[${maxProductIndex}].category"/>
                <div class="enter-select-enter">
                    <div>
                        <label class="enter_placeholder">
                            <s:message code="audiencePlan.form.selectCategoryTip"/>
                        </label>
                        <input type="text" name="enter_history"/>
                    </div>
                </div>
                <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                    <span class="caret arrow-down"></span>
                </button>
                <ul class="dropdown-menu doself"  aria-labelledby="dropdownMenu1">
                </ul>
            </div>
            <i class="fa fa-plus"></i>
            <div class="product-suggest-enter-area">
                <i class="fa fa-plus-circle"></i>
                <input type="text" class="hide-enter" placeholder="<s:message code="audiencePlan.form.enterKeyWordsTip"/> "/>
                <ul class="selected-area">

                </ul>
                <div class="area-button">
                    <button type="button" disabled class="btn btn-success">
                        <i class="fa fa-lightbulb-o"></i>
                        <s:message code="audiencePlan.form.keyWord.get" />
                    </button>
                    <label class="area-mesage"></label>
                </div>
            </div>
            <div class="product-suggest-suggest-area">
                <div class="suggest-area-init">
                    <label><s:message code="audiencePlan.form.keyWord.suggested" /></label>
                    <label class="noresult"><s:message code="audiencePlan.form.keyWord.noResult" /></label>
                </div>
                <ul class="selected-area">

                </ul>
            </div>
        </div>
    </div>
</div>

