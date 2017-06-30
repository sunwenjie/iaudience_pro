<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>  
  <title></title> 
  <link rel="stylesheet" type="text/css" href="${static_path}/css/chosen.css?v_time=${v_time}" /> 
  <link rel="stylesheet" type="text/css" href="${static_path}/css/keywordsLayer.css?v_time=${v_time}" /> 
  <link rel="stylesheet" type="text/css" href="${static_path}/css/multilayer-presale.css?v_time=${v_time}">
  <script type="text/javascript" src="${static_path}/js/keywordsLayer.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/jquery.dataTables.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/bootstrap/js/bootstrap.min.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/fnPagingInfo.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/extjs.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/calendar.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/jquery.treetable.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/chosen.jquery.min.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/sorttable.js?v_time=${v_time}"></script> 
  <script type="text/javascript" src="${static_path}/js/Sortable.js?v_time=${v_time}"></script>
  <script type="text/javascript" src="${static_path}/js/multilayer-presale.js?v_time=${v_time}"></script>
 
</head>
      <body>
       
        <div class="x-body" id="x-body">
          <div class="page_title">
      		  <div id="breadcrumb" class="row">
      		    <!-- Top left headings and links -->
      		   <div class="client-row">
      	   		 </div>
      		  </div>
      		  <div class="row"><div class="client-row"><h1><s:message code="planner.page.title"/></h1></div></div>
       		</div>
      		  <!-- Page title -->
      <!--  feature 相关 -->
          <div class="feature-main">
        		<div class="feature-content" >
              <div class="feature-inner">
              <form:form  modelAttribute="audiencePlan" class="form-horizontal" enctype="multipart/form-data" action="${path}/audiencePlanner/toDetail">  
                <div class="feature-detail feature-plan">
                 <!--keyWord lab start  -->
                    <div class="feature-plan-search">
                      <div class="feature-plan-search-title" id ="keyWord">
                        <i class="fa fa-caret-right"></i>
                        <label><s:message code="planner.keyWord.title"/> </label>
                         <input type="hidden" name="planId" value="${audiencePlan.planId}"/>
                         <input type="hidden" id="modifyKey" value="${audiencePlan.keyWord}"/>
                         <input type="hidden" id="keyWordType" name ="type" value="${audiencePlan.type}"/>
                         <input type="hidden" id="result" name="keyWord" value="${audiencePlan.keyWord}"/>
                         <input type="hidden" id="path" value ="${path}"/>
                      </div>
                      <div class="feature-plan-search-content keywords hide">
                        <div class="feature-plan-search-keywords">
                          <b><s:message code="planner.keyWord.info"/></b>
                           <label class="error-msg">${keyWordError} </label>
                           <label class="error-msg " id ="showMsg"><s:message code="planner.keyWord.input.error"/> </label>
                          <div id="keywordsLayer" style="margin-top:5px;"></div>
                        </div>

                        <div class="feature-plan-search-target">
                          <b><s:message code="planner.target"/></b>
                            <div class="control-group">
                              <label class="control-label"><s:message code="planner.gender"/></label>
                              <div class="controls">
                                <div class="clearfix">
                                 <input type="hidden" id="gender" value ="${audiencePlan.gender}"/>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                 	<form:radiobutton path="gender" id="gender0" value="0" />
                                     <label for="gender0"><s:message code="planner.unspecified"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                     <form:radiobutton path="gender" id="gender1" value="m" />
                                      <label for="gender1"><s:message code="planner.male"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                     <form:radiobutton path="gender" id="gender2" value="f"/>
                                      <label for="gender2"><s:message code="planner.female"/></label>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div class="control-group ">
                              <label class="control-label"><s:message code="planner.ageGroup"/></label>
                              <div class="controls compositeOption">
                                <div class="clearfix">
                                <input type="hidden" id="ageGroup" value ="${audiencePlan.age}"/>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                  	  <form:radiobutton path="age" id="age0" value="0" />
                                      <label for="age0"><s:message code="planner.unspecified"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                  	  <form:radiobutton path="age" id="age1" value="1" />
                                      <label for="age1"><s:message code="planner.customize"/></label>
                                  </div>
                                </div>
                                <div class="clearfix hide" id ="ageGroupArray">
                                
                                <c:forEach items="${audiencePlan.ageGroupArray}" var="ageGroupLab" varStatus="status">
                                  <div class="checkbox checkbox-primary checkbox-inline checkbox-minwidth checkbox-switch">
                                      <input type="checkbox" name="ageGroup" id="age-area${status.index}" value="${ageGroupLab}" 
                                       <c:forEach items="${audiencePlan.ageGroup}" var="ageGroup" >
                                       		<c:if test="${ageGroup==ageGroupLab}">checked="checked"</c:if>
                                       </c:forEach>
                                        >
                                      <label for="age-area${status.index}">${ageGroupLab} </label>
                                  </div>
                                  </c:forEach>
                                
                                </div>
                              </div>
                            </div>
                            <div class="control-group ">
                              <label class="control-label"><s:message code="planner.regions"/></label>
                              <div class="controls">
                                <div class="clearfix compositeOption">
                                 <input type="hidden" id="region" value ="${audiencePlan.regionStr}"/>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                     <form:radiobutton path="regions" id="regions0" value="0" />
                                      <label for="regions0"><s:message code="planner.unspecified"/> </label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                       <form:radiobutton path="regions" id="regions1" value="1"  />
                                      <label for="regions1"><s:message code="planner.customize"/></label>
                                  </div>
                                </div>
                                <div class="hide" style="position:relative;" id = "redigonArea">
                                  <select class="select  required" multiple id="regions" name="region" disname="chosen下拉" style="width: 380px">
                                <c:forEach items="${audiencePlan.regionArray}" var="region" varStatus="status">
                                    <option value="${region.provinceId}">${region.provinceName}</option> 
                                </c:forEach> 
                                  </select>
                                  <span class="caret arrow-down" style="left:380px;"></span>
                                </div>
                              </div>
                            </div>
                         <!--  </div> -->
                          </div>
                        <div class="feature-plan-search-submit">
                          <button type="submit" class="btn btn-success" onclick='$("#keyWordType").val(0)' ><s:message code="planner.btn.submit"/></button>
                          <button type="button" class="btn btn-cancel"  onclick="window.location='${path}/audiencePlanner/toIndex'"><s:message code="planner.btn.reset"/></button>
                        </div>
                      </div>
                    </div>
                   
                    <!--keyWord lab end  -->
                    <!-- interest lab start -->
                   <div class="feature-plan-search">
                      <div class="feature-plan-search-title" id ="multi">
                        <i class="fa fa-caret-right"></i>
                        <label><s:message code="planner.interest.title"/></label>
                      </div>
                      <div class="feature-plan-search-content multi hide">
                        <div class="feature-plan-search-keywords">
                          <b><s:message code="planner.interest.info"/></b>
                          <label class="error-msg">${interestError} </label>
                           <input type="hidden" id="interestKey"  value="${audiencePlan.interest}"/>
                          <input type="hidden" id="multiResult" name="interest" />
                           <input type="hidden" id="multiResultTitle" name= "interestLabName"/>
                          <div id="multilayer" style="margin-top:5px;"></div>
                        </div>

                        <div class="feature-plan-search-target">
                          <b><s:message code="planner.target"/></b>
                            <div class="control-group">
                              <label class="control-label"><s:message code="planner.gender"/></label>
                              <div class="controls">
                                <div class="clearfix">
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                        <form:radiobutton path="genderIn" id="gender_interest0" value="0" />
                                      <label for="gender_interest0"><s:message code="planner.unspecified"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                 	<form:radiobutton path="genderIn" id="gender_interest1" value="m" />
                                      <label for="gender_interest1"><s:message code="planner.male"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                     <form:radiobutton path="genderIn" id="gender_interest2" value="f" />
                                      <label for="gender_interest2"><s:message code="planner.female"/></label>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div class="control-group ">
                              <label class="control-label"><s:message code="planner.ageGroup"/></label>
                              <div class="controls compositeOption">
                                <input type="hidden" id="regionIn" value ="${audiencePlan.regionStr}"/>
                                <div class="clearfix">
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                         <form:radiobutton path="ageIn" id="age_interest0" value="0" />
                                      <label for="age_interest0"><s:message code="planner.unspecified"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                        <form:radiobutton path="ageIn" id="age_interest1" value="1" />
                                      <label for="age_interest1"><s:message code="planner.customize"/></label>
                                  </div>
                                </div>
                                <div class="clearfix hide">
                                  <c:forEach items="${audiencePlan.ageGroupArray}" var="ageGroupLab" varStatus="status">
                                  <div class="checkbox checkbox-primary checkbox-inline checkbox-minwidth checkbox-switch">
                                      <input type="checkbox" name="ageGroupIn" id="age_area_interest${status.index}" value="${ageGroupLab}" 
                                       <c:forEach items="${audiencePlan.ageGroupIn}" var="ageGroup" >
                                       		<c:if test="${ageGroup==ageGroupLab}">checked="checked"</c:if>
                                       </c:forEach>
                                        >
                                      <label for="age_area_interest${status.index}">${ageGroupLab} </label>
                                  </div>
                                  </c:forEach> 
                                </div>
                              </div>
                            </div>
                            <div class="control-group ">
                              <label class="control-label"><s:message code="planner.regions"/></label>
                              <div class="controls">
                                <div class="clearfix compositeOption">
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                        <form:radiobutton path="regionsIn" id="regions_interest0" value="0" />
                                      <label for="regions_interest0"><s:message code="planner.unspecified"/></label>
                                  </div>
                                  <div class="radio radio-primary radio-inline radio-minwidth radio-switch">
                                         <form:radiobutton path="regionsIn" id="regions_interest1" value="1" />
                                      <label for="regions_interest1"><s:message code="planner.customize"/></label>
                                  </div>
                                </div>
                                <div class="hide" style="position:relative;">
                                  <select class="select  required" multiple id="regions_interest" name="regionIn" disname="chosen下拉" style="width: 380px">
                                    <c:forEach items="${audiencePlan.regionArray}" var="region" varStatus="status">
                                    	<option value="${region.provinceId}">${region.provinceName}</option> 
                                	</c:forEach> 
                                  </select>
                                  <span class="caret arrow-down" style="left:380px;"></span>
                                </div>
                              </div>
                            </div>
                          </div>
                        <div class="feature-plan-search-submit">
                          <button type="submit" class="btn btn-success"  onclick='$("#keyWordType").val(1)'><s:message code="planner.btn.submit"/></button>
                          <button type="button" class="btn btn-cancel"  onclick="window.location='${path}/audiencePlanner/toIndex'"><s:message code="planner.btn.reset"/></button>
                        </div>
                      </div>
                    </div>
                  <!-- interest lab end -->
                    <div class="clearboth"></div>
                </div>
                </form:form>
              </div>
            </div>
            <div class="feature-sidebar" style="margin-top:0;">
              <div class="feature-sidebar-result">
                <label><s:message code="planner.save.plan"/></label>
                <hr>
                <ul>
               <c:forEach items="${audiencePlan.audiencePlanList}" var="plan" >
                  <li><a href="#" onclick="window.location='${path}/audiencePlanner/showPlan?planId=${plan.id}'">${plan.name}</a></li>
               </c:forEach>
                </ul>
              </div>
            </div>
          </div>
        <!--  feature 相关  End   -->

        </div>
     
<script type="text/javascript">

  	$(function(){
      $(document).on("click",".feature-main .feature-plan-search-title",function(){
        $(this).parent().parent().find(".feature-plan-search-content").slideUp();
        var $fa = $(this).find(".fa");
        var isUp = $fa.hasClass("fa-caret-right");
        $(this).parent().parent().find(".fa-caret-down").removeClass("fa-caret-down").addClass("fa-caret-right");
        $(this).parent().parent().find(".toggle-down").removeClass("toggle-down");

        if(isUp){
          $fa.removeClass("fa-caret-right").addClass("fa-caret-down");
          $(this).parent().addClass("toggle-down");
          $(this).next().slideDown();
        }else{
          $fa.removeClass("fa-caret-down").addClass("fa-caret-right");
          $(this).parent().removeClass("toggle-down");
          $(this).next().slideUp();
        }

      })
     //前端特殊符号提示信息
     $("#showMsg").hide();
      
  	 //修改时数据回填，关键词
     if($("#keyWordType").val() == "0"){ 
			$("#keyWord").click();
			<c:forEach items="${audiencePlan.wordList}" var="word">
			   $(".keywords_search .keywords_input").val('${word}');
			   $(".keywords_search").find("i").click()
		    </c:forEach>
		//修改时数据回填，兴趣标签 
	   } else if($("#keyWordType").val()=="1"){  
				$("#multi").click();
		}
    

    $(".compositeOption input[type=radio]").on("change",function(){
      	var checkedVal = $(this).val();
      	if(checkedVal=="1"){
      	  $(this).parent().parent().next().show();
      	}else{
      	  $(this).parent().parent().next().find(":checked").removeAttr("checked");
      	  $(this).parent().parent().next().find("select").each(function(){
              $(this).val("");
              $(this).trigger("liszt:updated");
              $(this).chosen();
            });
      	  $(this).parent().parent().next().hide();
      	}
      });
    $(".compositeOption input[type=radio]:checked").trigger("change");
      
	
    $("#regions").val($("#region").val().split(","));
    $("#regions").chosen();
    $("#regions_interest").val($("#regionIn").val().split(","));
    $("#regions_interest").chosen();
	});
  	
    //keywordsLayer loading
    var keywordsLayer = new keywordsLayer({
    	lang : { pLabel : ['<s:message code="planner.keyWord"/>','<s:message code="planner.keyWord.suggested"/>', '<s:message code="planner.keyWord.suggest"/>','<s:message code="planner.noResult"/>','<s:message code="planner.keyWord.input"/>','<s:message code="planner.remove"/>','<s:message code="planner.keyWord.get"/>','<s:message code="planner.keyWord.loading"/>','<s:message code="planner.keyWord.move"/>']},
        container : $("#keywordsLayer"),
       //这个用的是之前的数据，实际应该只有name,name_en这一列。
        values:[],
        result:$("#result"),
        maxKeywords:20,
        path:"${path}/ajax/getKeywords?keyWord=",
        callback:callBackFun
    })
   function callBackFun(ids){
      if(ids.length>0){
        $(".feature-plan-search-submit .btn-success").attr("disabled",false);
      }else{
        $(".feature-plan-search-keywords .error-msg").show();
        $(".feature-plan-search-submit .btn-success").attr("disabled",true);
      }
    }
    var selectedMulti="";
    var interest = ${audiencePlan.interest};
    if(interest == ""){
    	 selectedMulti = [] ;
    } else {
    	selectedMulti = interest;
    }
  
   var multi = new multilayer_presale({
    	lang :{ pLabel : ['<s:message code="planner.interest.lab"/>','<s:message code="planner.selectL"/>', '<s:message code="planner.selectR"/>','<s:message code="planner.remove"/>','<s:message code="planner.remove"/>','<s:message code="planner.interest.reach"/>']},
	  	container : $("#multilayer"),
        values:${audiencePlan.interestLab},
	  	selected:selectedMulti,
	  	result:$("#multiResult"),
	  	callback:callBackFunMulti
		})
    
   function callBackFunMulti(ids){
		console.log(ids);
		var array = ids.split(",");
		var title = [];
		for(var i=0;i<array.length;i++){
			title.push($("#"+array[i]).attr("title"));
		}
		$("#multiResultTitle").val(title.join(","));
      if(ids.length>0){
        $(".multi .btn-success").attr("disabled",false);
      }else{
        $(".multi .error-msg").show();
        $(".multi .btn-success").attr("disabled",true);
      }
	}
    
   function resetForm(formId,componentId) {
      $("#"+formId).find(".hide").hide();
      $("#"+formId).find(".chzn-done").each(function(){
        $(this).val("");
        $(this).trigger("liszt:updated");
        $(this).chosen();
      })
      document.getElementById(formId).reset();
      if($("#"+componentId).length>0){
        $("#"+componentId+" .clearAll").trigger("click");
      }
    }
  </script>
  </body>
</html>
