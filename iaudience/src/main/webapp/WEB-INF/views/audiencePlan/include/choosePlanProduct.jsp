<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>

<div class="choose-from-plan" style="display:none">
    <div class="addproduct chooseplan">
        <i class="fa fa-chevron-down" style="position: relative; top: 25px; left: 10px;"></i>
        <div class="dropdown tree-stop" style="width:auto;">
            <input name="choosePlan" id="choosePlan" type="hidden"/>
            <button class="btn  dropdown-toggle dropdown-stop" data-type="plan" type="button" style="width:auto;" id="dropdownMenu1" data-toggle="dropdown-stop" aria-haspopup="true" aria-expanded="true">
                Choose plan
            </button>
            <div class="dropdown-menu dropdown-tree-con" aria-labelledby="dropdownMenu1">
                <div class="dropdown-tree-category">
                    <div class="parent_layer">
                        <div class="pannel">
                            <span><s:message code="audiencePlan.form.audiencePlan"/>: <b>${audiencePlanModeSize}</b></span>
                            <span style="float:right; margin: 0 5px 0 0!important;"><i class="fa fa-angle-right"></i></span>
                        </div>
                        <ul class="tree">
                        </ul>
                    </div>
                    <div class="child_layer">
                        <div class="pannel">
                            <span><s:message code="audiencePlan.form.segments"/> </span>
                            <span style="float:right; margin: 0 5px 0 0!important;"><i class="fa fa-angle-right"></i></span>
                        </div>
                        <input type="hidden" value="" name="plan_text"/>
                        <ul class="tree">
                        </ul>
                    </div>

                    <div class="child_layer">
                        <div class="pannel">
                            <span><s:message code="audiencePlan.form.products"/> </span>
                        </div>
                        <input type="hidden" value="" name="plan_text"/>
                        <ul class="tree">

                        </ul>
                    </div>

                </div>
            </div>
            <label class="dropdown-plan-infos"></label>
        </div>
    </div>
</div>
