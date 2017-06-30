<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.iclick.symphony.iaudience.util.Constant" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Audiences</title>
     <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
	<meta name="viewport" content="initial-scale=1,maximum-scale=1"/>
	<link rel="stylesheet" type="text/css" href="${static_path}/css/google-font.css">
   	<link rel="stylesheet" type="text/css" href="${static_path}/css/bootstrap_iaccess.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/font-awesome.min.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/head.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/index.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/chosen.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/calendar.css">
  	<link rel="stylesheet" type="text/css" href="${static_path}/css/jqcloud.css">

   	<script type="text/javascript" src="${static_path}/js/calendar.js"></script>
    <script type="text/javascript" src="${static_path}/js/echarts.min.js"></script>
  	<script type="text/javascript" src="${static_path}/js/china.js"></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/base64.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jquery.tagcloud.js" ></script>
	<script type="text/javascript"  src="${static_path}/js/quotation_js/canvas2image.js" ></script>
	<script type="text/javascript"  src="${static_path}/js/quotation_js/html2canvas.js" ></script>
	<script type="text/javascript"  src="${static_path}/js/quotation_js/chart/chartwell.min.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/chart/chartwell_radar.min.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/jspdf.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/libs/FileSaver.js/FileSaver.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/libs/Blob.js/BlobBuilder.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/jspdf.plugin.addimage.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/jspdf.plugin.standard_fonts_metrics.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/jspdf.plugin.split_text_to_size.js" ></script>
  	<script type="text/javascript"  src="${static_path}/js/quotation_js/jsPDF/jspdf.plugin.from_html.js" ></script>
  	<script type="text/javascript" src="${static_path}/js/rgbcolor.js"></script>
  	<script type="text/javascript" src="${static_path}/js/StackBlur.js"></script>
  	<script type="text/javascript" src="${static_path}/js/canvg.js"></script>
    <script type="text/javascript" src="${static_path}/js/iax-template.js"></script>
    <script type="text/javascript" src="${static_path}/js/highcharts.js"></script>
    <script type="text/javascript" src="${static_path}/js/highcharts-more.js"></script>
    <script type="text/javascript" src="${static_path}/js/iax-chart-tool.js"></script>
    <script type="text/javascript" src="${static_path}/js/jqcloud-1.0.4.js"></script>

</head>
    <body>
    	<div class="container">
    	<!--body-->
      <div class="x-main">
        <div class="x-sidebar" id="x-sidebar">
          <ul class="x-menu">
            <li id="li001" class="">
              <a href="${static_path}/audiencePlans.html">
               <i class="fa fa-users" aria-hidden="true"></i>
              <span class="x-m8">Audience Plans</span>
              </a>
            </li>

            <li id="" class="selected">
              <a href="#">
               <i class="fa fa-bar-chart" aria-hidden="true"></i>
                <span class="x-m8">Audience Analysis</span>
               <i class="fa fa-caret-down fa-fw" aria-hidden="true"></i>
              </a>
              <ul class="sub-menu" style="display: block;">
                <li class="">
                  <a href="${path}/audienceAnalysis/marketAnalysis"><span class="x-m8">Market</span></a>
                </li>
                <li class="active">
                  <a href="${path}/audienceAnalysis/brandAnalysis"><span class="x-m8">My Brand</span></a>

                </li>
              </ul>
            </li>
            
          </ul>
          <ul class="x-menu-lang-select">
            <li>
              <a href="#">
              <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                 <span class="x-m8">简体中文</span>
              </a>
            </li>
            <li>
              <a href="#">
              <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                 <span class="x-m8">简体中文</span>
              </a>
            </li>
          </ul>
          <ul class="x-menu-lang">

            <li>
              <a href="javascript:;">
              <i class="fa fa-cog fa-globe" aria-hidden="true"></i>
                 <span class="x-m8">langauage English</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="x-body" id="x-body">
      		<div class="page_title">
      		  <div class="row">
              <div class="client-row"><h1><s:message code="brand.audienceAnalysis"/>:</h1></div> 
              <div class="client-row">
                <label style="line-height:20px;">
                  <div class="dropdown">
                    <input id="hasSavedPlan" type="hidden" value="1"/>
                    <a class=" dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="cursor:pointer;color:#ef4136;font-size:20px;">
                      <c:forEach var="plan" items="${audiencePlans}">
                      	<c:if test="${plan.id == audiencePlanId}">${plan.name}</c:if>
                      </c:forEach>
                    </a>
                    <i class="fa fa-caret-down" aria-hidden="true" style="position:absolute;top:5px;right:-10px;color:#ef4136;"></i>
                    <ul class="dropdown-menu ss"  aria-labelledby="dropdownMenu1" style="top:100%!important;border-top:1px solid #dfdfdf!important;min-width:240px;">
                      <c:forEach var="plan" items="${audiencePlans}">
                      	<c:if test="${plan.id != audiencePlanId}"><li data-value="-1"><a href="${static_path}/audienceAnalysis/brandAnalysis?audiencePlanId=${plan.id}">${plan.name}</a></li></c:if>
                      </c:forEach>
                    </ul>
                  </div>
                </label>
              </div>
            </div>
       		</div>
      		  <!-- Page title -->

          <ul class="nav nav-tabs sub-nav-tabs" id="myTab">
            <li class="active">
              <a data-toggle="tab" href="#tab-share" data-id="share"><s:message code="brand.brandShareTab"/></a>
            </li>
            <li class="">
              <a data-toggle="tab" href="#tab-brand" data-id="brand"><s:message code="brand.brandAnalysisTab"/></a>
            </li>
            <li class="">
              <a data-toggle="tab" href="#tab-product" data-id="product"><s:message code="brand.productAnalysis"/></a>
            </li>
          </ul>
          <div class="button-right" style="margin:-40px 0 10px 0;">
            <div class="dropdown btn-iclick dropdown-stop">
              <i class="fa fa-download" style="position: absolute; top: 10px; left: 10px;"></i>
              <button class="btn dropdown-toggle" type="button" onclick="">
                Export&nbsp;
              </button>
            </div>
          </div>

      		<!-- table -->
      		<div class="tab-content" id="myTabContent">
      			<div class="tab-pane fade in active" id="tab-share">
                <div class="" id="for_export_img" style="float:left;width:100%;">
                    <div class="plan-reports" id="report_content" style="margin-top:-7.5px;">
                      <div class="plan-reports-result clearfix">
                        <div class="plan-reports-result-inner" style="width:65%">
                          <!--Trend map-->
                          <div class="plan-result-graph" id="select_trend_map" style="width:100%;height:600px;padding: 0 7.5px 0 0;">
                            <div class="plan-result-text">
                              <div class="result-text-header">
                                <label id="date_header"><s:message code="brand.brandTrend"/>
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                                <div class="report-dropdown" style="top:30px;right:20px;">
                                  <div class="date-range">
                                    <div class="date-range-ico"><i class="fa fa-calendar"></i></div> 
                                    <input type="text" id="daterange"
                                      style="width:155px;"
                                      placeholder="<s:message code="brand.periodPlaceholder"/>" value=""
                                      class="form-control date-range-input xmoCalendarInputSchedule">
                                       <input type="hidden" id="min" name="begin" value="" />
                                      <input type="hidden" id="max" name="end" value="" />
                                     <span class="caret arrow-calendar"></span>
                                  </div>
                                </div>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content" style="width:100%;padding:0 20px;box-sizing:border-box;">
                                    <div id="mix_chart" class="line-chart-map" style="width:100%;height:200px;">
                                    </div>
                                    <!-- 图片文字列表 begin-->
                                      <div class="pic-title-list">
                                        
                                      </div>
                                      <!-- 图片文字列表 end-->
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="plan-reports-result-inner" style="width:35%">
                          <!--total-->
                          <div class="plan-result-graph graph-top" style="width:100%;padding:0 0px 0 7.5px" id="select_audience_share">
                            <div class="plan-result-text" style="border-right:none;width:50%;float:left;">
                              <div class="result-text-header clearfix">
                                <label id="date_header"><s:message code="brand.audienceScale"/>
                                <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-text-info clearfix x-mt10">
                                <div class="result-text-word word-impr plan-reports-bg-total" style="height:120px;margin-top:20px;">
                                  <label class="titleRed" id="audience_total_share" style="">0</label>
                                </div>
                              </div>
                            </div>
                            
                            <!--Market share-->
                            <div class="plan-result-text" style="border-left:none;width:50%;float:left;">
                              <div class="result-text-header">
                                <label id="date_header"><s:message code="brand.audienceShare"/>
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-content" style="padding-top:0;">
                                      <div id="market-map_share" class="market-map" style="width:180px;height:160px;">
                                      </div>
                                    </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--end-->

                          <!--cloud tag-->
                          <div class="plan-result-graph graph-top" style="width:100%;height:367px;" id="select_keywords_share">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label><s:message code="brand.keywords"/>
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content">
                                      <div id="cloud_tag_share" class="cloud-tag" style="width:340px;margin:0 -20px;height:300px;">
                                      </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--end-->

                        </div>
                      </div>
                    </div>
                  </div>
            </div>

      			<div class="tab-pane fade" id="tab-brand">
              <div class="" id="for_export_all_img">
                <div class="row hide" id="exportjpg" style="padding: 20px 30px 20px 0px;">
                  <div class="client-row">
                    <h1 style=" font-size: 30px;"><s:message code="brand.audienceScale"/></h1>
                  </div>
                  <div style="float:right">
                    <img src="http://xmostg.optimix.asia/images/logo/xmo.optimix.asia.png" alt="" style="width:118px">
                  </div>
                </div>

                <div class="" id="for_export_img" style="float:left;width:100%;">
                  <div class="plan-reports" id="report_content" style="margin-top:-7.5px;">
                    <div class="plan-reports-result clearfix">
                      <div class="plan-reports-result-inner">
                        <!--line-map-->
                        <div class="plan-result-graph" id="select_line_map" style="width:50%;height:280px;padding:0 7.5px 0 0;">
                          <div class="plan-result-text">
                            <div class="result-text-header clearfix">
                              <label id="date_header"><s:message code="brand.funnel"/>
                                <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                              </label>
                            </div>
                            <div class="result-graph-info x-mt10">
                              <div class="result-graph-word word-impr">
                                <div class="result-graph-word-content" style="width:100%;padding:0 20px;box-sizing:border-box;">
                                  <div id="audience-funnel" class="line-chart-map" style="width:100%;height:230px;">
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!--product-share-->
                        <div class="plan-result-graph" id="select_product_share" style="width:50%;height:280px;padding:0 0px 0 7.5px;">
                          <div class="plan-result-text">
                            <div class="result-text-header clearfix">
                              <label id="date_header"><s:message code="brand.productShare"/>
                                <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                              </label>
                            </div>
                            <div class="result-graph-info x-mt10">
                              <div class="result-graph-word word-impr">
                                <div class="result-graph-word-content" style="width:100%;padding:0 20px;box-sizing:border-box;">
                                  <div id="product-map" class="device-map" style="width:100%;height:220px;">
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    
                      <div class="plan-reports-result-inner" style="width:25%;">
                        <!--性别-->
                        <div class="plan-result-graph" id="select_gender" style="width:100%">
                          <div class="plan-result-text">
                            <div class="result-text-header clearfix">
                              <label><s:message code="brand.gender"/></label>
                            </div>
                            <div class="result-graph-info x-mt10">
                              <div class="result-graph-word word-impr">
                                <div class="result-graph-word-content" style="padding-top:0;">
                                  <div id="gender-map" class="gender-map" style="width:230px;height:170px;">
                                  </div>
                                  <div class="gender-map-info gender-male">
                                    <span class="gender-map-ico"></span>
                                    <p>0%</p>
                                    <span><s:message code="brand.male"/></span>
                                  </div>
                                  <div class="gender-map-info gender-female">
                                    <span class="gender-map-ico"></span>
                                    <p>0%</p>
                                    <span><s:message code="brand.female"/></span>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!--年龄-->
                        <div class="plan-result-graph" id="select_age" style="padding: 0 7.5px 0 0;width: 100%;">
                          <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label><s:message code="brand.age"/></label>
                              </div>
                              <div class="result-graph-info clearfix x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content">
                                   

                                  </div>
                                </div>
                              </div>
                            </div>
                        </div>
                        
                        <!--end-->
                      </div>
                      <!--inner end -->
                      <div class="plan-reports-result-inner" style="width:75%;">
                        <!--地域-->
                        <div class="plan-result-graph graph-region" style="width:100%;padding-left:7.5px;" id="select_province">
                          <div class="plan-result-text">
                            <div class="result-text-header clearfix">
                              <label><s:message code="brand.region"/></label>
                            </div>
                            <div class="result-graph-info x-mt10">
                              <div class="result-graph-word word-impr">
                                <div class="result-graph-word-map">
                                  <div class="region-map" id="region-map" style="width:500px;"></div>
                                  <label style="position:absolute;left:25px;bottom:40px;"><s:message code="brand.distribution"/></label>
                                </div>
                                <div class="result-graph-word-content">

                                 
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!--end-->
                      </div>
                      <!--inner end-->
                      <div class="plan-reports-result-inner">
                        <!--interests-->
                        <div class="plan-result-graph graph-interest" style="width:100%;padding:0;" id="select_interests">
                          <div class="plan-result-text">
                            <div class="result-text-header clearfix">
                              <label><s:message code="brand.interest"/></label>
                            </div>
                            <div class="result-graph-info x-mt10">
                              <div class="result-graph-word word-impr">
                                <div class="result-graph-word-map">
                                  <div class="interest-map" id="interest-map"></div>
                                </div>
                                <div class="result-graph-word-content">
                                  
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!-- end -->
                      </div>

                    </div>
                  </div>
                </div>

              </div>
        			
      			</div>
            <div class="tab-pane fade" id="tab-product">
                <div class="" id="for_export_all_img">
                    <div class="row hide" id="exportjpg" style="padding: 20px 30px 20px 0px;">
                      <div class="client-row">
                        <h1 style=" font-size: 30px;"><s:message code="brand.audienceAnalysis"/></h1>
                      </div>
                      <div style="float:right">
                        <img src="http://xmostg.optimix.asia/images/logo/xmo.optimix.asia.png" alt="" style="width:118px">
                      </div>
                    </div>

                    <div class="" id="for_export_img" style="float:left;width:100%;">
                      <div class="plan-reports" id="report_content" style="margin-top:5px;">
                        <div class="plan-reports-result">
                          <div class="plan-reports-result-inner">
                            <!--Total-->
                            <div class="plan-result-graph" id="select_line_map" style="width:100%;height:280px;padding:0;">
                              <div class="plan-result-text">
                                <div class="result-text-header">
                                  <label id="date_header"><s:message code="brand.productTrend"/>
                                    <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                  </label>
                                  <div class="report-dropdown" style="top:30px;right:20px;">
                                    <div class="date-range">
                                      <div class="date-range-ico"><i class="fa fa-calendar"></i></div> 
                                      <input type="text" id="daterange_product"
                                        style="width:155px;"
                                        placeholder="please select a period" value=""
                                        class="form-control date-range-input xmoCalendarInputSchedule">
                                         <input type="hidden"  name="begin" value="" />
                                        <input type="hidden"  name="end" value="" />
                                       <span class="caret arrow-calendar"></span>
                                    </div>
                                  </div>
                                </div>
                                <div class="result-graph-info x-mt10">
                                  <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-content" style="width:100%;padding:0 20px;box-sizing:border-box;">
                                      <div id="line_chart" class="line-chart-map" style="width:100%;height:220px;">
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <div class="clearboth"></div>
                        </div>
                       </div>
                       <!-- 过滤选项 -->
                       <form class="form-horizontal" id="multi-form">
                        <div class="control-group">
                          <label class="control-label"><s:message code="brand.selectProduct"/></label>
                          <div class="controls">
                            <div class="clearfix">
	            				<c:forEach items="${productResults}" var="project" varStatus="i">
	                              <div class="radio radio-primary radio-inline radio-minwidth radio-switch project-radio">
	                                  <input type="radio" name="product_radio" id="product_radio${i.index}" value="${project.name}" ${i.index == 0 ? "checked='checked'" : ""}>
	                                  <label for="product_radio${i.index}">${project.name}</label>
	                              </div>
	            				</c:forEach>
                            </div>
                          </div>
                        </div>
                        
                      </form>
                       <!-- 过滤选项 end-->
                       <div class="plan-reports" id="report_content" style="margin-top:5px;">
                        <div class="plan-reports-result clearfix">  
                          <div class="plan-reports-result-inner" style="width:50%;">
                            <!--Total-->
                            <div class="plan-result-graph" id="select_product" style="width:100%;position:relative;">
                              <div class="plan-result-text" style="border-right:none;width:50%;float:left;">
                                <div class="result-text-header clearfix">
                                  <label id="date_header"><s:message code="brand.productScale"/>
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                  </label>
                                </div>
                                <div class="result-text-info clearfix x-mt10">
                                  <div class="result-text-word word-impr plan-reports-bg-total" style="height:120px;margin-top:20px;">
                                    <label class="titleRed" id="product_total" style="">0</label>
                                  </div>
                                </div>
                              </div>
                              <!-- 中间信息 -->
                              <div class="plan-result-middle-line">
                                <div class="plan-middle-line"></div>
                                <div class="plan-middle-line-info">
                                  <label><s:message code="brand.myBrand"/>: <span>0</span></label>
                                </div>
                              </div>
                              <!--Product share-->
                              <div class="plan-result-text" style="border-left:none;width:50%;float:left;">
                                <div class="result-text-header">
                                  <label id="date_header"><s:message code="brand.productShare"/>
                                    <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                  </label>
                                </div>
                                <div class="result-graph-info x-mt10">
                                  <div class="result-graph-word word-impr">
                                      <div class="result-graph-word-content" style="padding-top:0;">
                                        <label style="margin-top:-10px;"><s:message code="brand.shareInfo"/></label>
                                        <div id="market-brand-map" class="market-map" style="width:230px;height:160px;">
                                        </div>
                                      </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            
                            <!--年龄-->
                            <div class="plan-result-graph" id="select_age_brand" style="padding: 0 7.5px;width: 50%;">
                              <div class="plan-result-text">
                                <div class="result-text-header clearfix">
                                  <label><s:message code="brand.age"/></label>
                                </div>
                                <div class="result-graph-info clearfix x-mt10">
                                  <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-content">
                                      
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <!--gender-->
                            <div class="plan-result-graph" id="select_gender_brand" style="padding: 0 7.5px 0 0;width: 50%;">
                              <div class="plan-result-text">
                                <div class="result-text-header clearfix">
                                  <label><s:message code="brand.gender"/></label>
                                </div>
                                <div class="result-graph-info x-mt10">
                                  <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-content" style="padding-top:0;">
                                      <div id="gender-brand-map" class="gender-brand-map" style="width:230px;height:170px;">
                                      </div>
                                      <div class="gender-map-info gender-male">
                                        <span class="gender-map-ico"></span>
                                        <p>0%</p>
                                        <span><s:message code="brand.male"/></span>
                                      </div>
                                      <div class="gender-map-info gender-female">
                                        <span class="gender-map-ico"></span>
                                        <p>0%</p>
                                        <span><s:message code="brand.female"/></span>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <!--end-->
                          </div>
                          <!--inner end -->
                          <div class="plan-reports-result-inner" style="width:50%;">
                            <!--地域-->
                            <div class="plan-result-graph graph-region" style="width:100%;padding-left:7.5px;" id="select_province">
                              <div class="plan-result-text">
                                <div class="result-text-header clearfix">
                                  <label><s:message code="brand.region"/></label>
                                </div>
                                <div class="result-graph-info x-mt10">
                                  <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-map">
                                      <div class="region-map" id="region-brand-map"></div>
                                      <label style="position:absolute;left:25px;bottom:40px;"><s:message code="brand.distribution"/></label>
                                    </div>
                                    <div class="result-graph-word-content">

                                      
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <!--end-->
                          </div>
                          <!--inner end-->
                          <div class="plan-reports-result-inner">
                            <!--interests-->
                            <div class="plan-result-graph graph-interest" style="width:100%;padding:0;" id="select_interests">
                              <div class="plan-result-text">
                                <div class="result-text-header clearfix">
                                  <label><s:message code="brand.interest"/></label>
                                </div>
                                <div class="result-graph-info x-mt10">
                                  <div class="result-graph-word word-impr">
                                    <div class="result-graph-word-map">
                                      <div class="interest-map" id="interest-brand-map"></div>
                                    </div>
                                    <div class="result-graph-word-content">
                                      
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <!-- end -->
                          </div>

                        </div>
                      </div>
                    </div>

                  </div>
             
      			</div>
            
      		</div>


          </div>
        <div class="clearboth"></div>
      </div>
       
    </div>
    <!--container end-->
   

  <script type="text/javascript">

  	$(function(){
      
      var data = {"result": [{
            "data": {
                "age_group": {
                    "18-24": ${brandResult.data.age_group.get("18-24")},
                    "25-34": ${brandResult.data.age_group.get("25-34")},
                    "35-44": ${brandResult.data.age_group.get("35-44")},
                    "45-54": ${brandResult.data.age_group.get("45-54")},
                    "55-64": ${brandResult.data.age_group.get("55-64")},
                    "65+": ${brandResult.data.age_group.get("65+")}
                },
                "audience": "3.3M",
                "allMarket": "2,567K",
                "device": {
                    "Mobile": 852,
                    "PC": 1246,
                    "Tablet": 179
                },
                "gender": {
                    "female": ${brandResult.data.gender.get("f")/1000},
                    "male": ${brandResult.data.gender.get("m")/1000}
                },
                "product_share": {
                	<c:forEach items="${productResults}" var="project" varStatus="i">
                		"${project.name}": ${project.data.audience},
                	</c:forEach>
                },
                "audienceFunnel":{
                  "dataPeriod":"Period: ${period}",
                  "result":{
                   "bar":${JSONObject.toJSONString(trend.potentialWeek)},
                    "line":${JSONObject.toJSONString(trend.brandLine)},
                  }
                },
                "top5brand":{
                  "Estee Lauder":852,
                  "Lancome":789,
                  "Shiseido":507,
                  "Bobbi Brown":456,
                  "SKII":278,
                },
                "top5products":{
                  "Makeup":852,
                  "Skincare":789,
                  "Foundation":507,
                  "Concealer":456,
                  "Body Wash":278,
                },
                "market_share":{
                  "market":666,
                  "market_show":333,
                },
                "interest": ${JSONObject.toJSONString(brandResult.data.interestEN)},
                "regions": ${JSONObject.toJSONString(brandResult.data.regionsZH)}
            },
            "id": "1",
            "name": "brand"
        },{
            "data": {
            	<c:forEach items="${productResults}" var="project" varStatus="i">
            		"${project.name}": {
                        "age_group": {
                            "18-24": ${project.data.age_group.get("18-24")},
                            "25-34": ${project.data.age_group.get("25-34")},
                            "35-44": ${project.data.age_group.get("35-44")},
                            "45-54": ${project.data.age_group.get("45-54")},
                            "55-64": ${project.data.age_group.get("55-64")},
                            "65+": ${project.data.age_group.get("65+")}
                        },
                        "audience": "<fmt:formatNumber value="${project.data.audience/1000.0}" pattern="#,##0.00"/>K",
                        "allMarket": "<fmt:formatNumber value="${brandResult.data.audience/1000.0/1000.0}" pattern="#,##0.00"/>M",
                        "device": {
                            "Mobile": 852,
                            "PC": 1246,
                            "Tablet": 179
                        },
                        "gender": {
                            "female": ${project.data.gender.get("f")/1000},
                            "male": ${project.data.gender.get("m")/1000}
                        },
                        "product_share": {
                            "Stay-in-Place Makeup": 23500,
                            "Prefectionist": 12246,
                            "Advanced Night Cream": 11179,
                            "Resilience Lift":10000,
                        },
                        "top5brand":{
                          "Estee Lauder":852,
                          "Lancome":789,
                          "Shiseido":507,
                          "Bobbi Brown":456,
                          "SKII":278,
                        },
                        "top5products":{
                          "Makeup":852,
                          "Skincare":789,
                          "Foundation":507,
                          "Concealer":456,
                          "Body Wash":278,
                        },
                        "top5productsTrend":{
                          "dataPeriod":"<s:message code="brand.period"/>: ${period}",
                          "result": ${JSONObject.toJSONString(trend.top5ProductsAudienceList)}
                        },
                        "market_share":{
                          "market":${brandResult.data.audience/1000.0},
                          "market_show":${project.data.audience/1000.0},
                        },
                        "interest": ${JSONObject.toJSONString(project.data.interestEN)},
                        "regions": ${JSONObject.toJSONString(project.data.regionsZH)}
            		},
          		</c:forEach>
            },
            "id": "1",
            "name": "product"
        },{
            "data": {
                "age_group": {
                    "18-24": 30,
                    "25-34": 25,
                    "35-44": 65,
                    "45-54": 10,
                    "55-64": 10,
                    "65+": 30
                },
                "audience": "<fmt:formatNumber value="${brandResult.data.audience/1000.0/1000.0}" pattern="#,##0.00"/>M",
                "allMarket": "3,267K",
                "device": {
                    "Mobile": 852,
                    "PC": 1246,
                    "Tablet": 179
                },
                "gender": {
                    "female": 11,
                    "male": 55
                },
                "product_share": {
                    "Stay-in-Place Makeup": 3333,
                    "Prefectionist": 12246,
                    "Advanced Night Cream": 222,
                    "Resilience Lift":10000,
                },
                "mixTrend":{
                  "dataPeriod":"<s:message code="brand.period"/>: ${period}",
                  "result":{"Brand Audience": ${JSONObject.toJSONString(trend.brandAudience)},
                    "Brand Share": ${JSONObject.toJSONString(trend.brandShare)}
                    	},
                "topBrands": ${JSONObject.toJSONString(trend.topBrandList)},
                },
                "market_share":{
                  "market": ${(trend.marketAudience - brandResult.data.audience)/1000.00},
                  "market_show":${brandResult.data.audience/1000.00},
                },
                "cloud_tag" : ${JSONObject.toJSONString(keyWords)}
            },
            "id": "2",
            "name": "share",
        }]
      };
      $('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var tab = $(e.target).attr("data-id") // 激活的标签页
        var json = {};
        for (var i = 0; i < data.result.length; i++) {
          if(tab == data.result[i].name){
            json = data.result[i];
          }
        };
        if (tab=="brand") {
          IAX_CHART_TOOL.initProductShare("product-map",json.data);
          IAX_CHART_TOOL.initGender("gender-map",json.data);
          IAX_CHART_TOOL.initAgeGroup("select_age",json.data);
          IAX_CHART_TOOL.initRegions("region-map",json.data);
          IAX_CHART_TOOL.initInterests("interest-map",json.data);
          IAX_CHART_TOOL.initAudienceFunnel("audience-funnel",json.data);
        }else if (tab=="product") {
          var project_name = $(".project-radio").eq(0).find("label").text();
          IAX_CHART_TOOL.initTop5Trend("line_chart",json.data[project_name]);
          IAX_CHART_TOOL.initTotalAudience("select_product","product_total","market-brand-map",json.data[project_name]);
          IAX_CHART_TOOL.initGender("gender-brand-map",json.data[project_name]);
          IAX_CHART_TOOL.initAgeGroup("select_age_brand",json.data[project_name]);
          IAX_CHART_TOOL.initRegions("region-brand-map",json.data[project_name]);
          IAX_CHART_TOOL.initInterests("interest-brand-map",json.data[project_name]);
          initCalendar("daterange_product");
        };
      })
      //初始化
      var json = {};
      for (var i = 0; i < data.result.length; i++) {
        if("share" == data.result[i].name){
          json = data.result[i];
        }
      };
      IAX_CHART_TOOL.initMixTrend("mix_chart",json.data);
      IAX_CHART_TOOL.initTotalAudience("select_audience_share","audience_total_share","market-map_share",json.data);
      IAX_CHART_TOOL.initCloudTag("cloud_tag_share",json.data,300);
      initCalendar("daterange");
    	
	  $("[name='product_radio']").click(function(){
	    var json = {};
	    for (var i = 0; i < data.result.length; i++) {
	      if("product" == data.result[i].name){
	        json = data.result[i];
	      }
	    };
  		var project_name = $(this).val();
        IAX_CHART_TOOL.initTop5Trend("line_chart",json.data[project_name]);
        IAX_CHART_TOOL.initTotalAudience("select_product","product_total","market-brand-map",json.data[project_name]);
        IAX_CHART_TOOL.initGender("gender-brand-map",json.data[project_name]);
        IAX_CHART_TOOL.initAgeGroup("select_age_brand",json.data[project_name]);
        IAX_CHART_TOOL.initRegions("region-brand-map",json.data[project_name]);
        IAX_CHART_TOOL.initInterests("interest-brand-map",json.data[project_name]);
        initCalendar("daterange_product");
  	});

    });

    function initCalendar(id) {
       new xmoCalendar({
         inputId : '#' + id,
         lang : "zh", //"zh" "en"
         wrapContainer: $('#'+id).parents(".result-text-header"),
         relativeTop:"60",
         relativeRight:20,
         initTime : '2013-10-28',
         menu : [ "last_7_days", "last_30_days", "this_week", "this_month",
             "this_yeah", "last_week", "last_month", "last_3_month" ],
         submitCallback : function() {
           search_column(id);
         },
       })
     }
     function search_column(id) {
      var during = $("#" + id).val();
      var duringArr = during.split(" ~ ");
      $("#" + id).parent().find("[name=begin]").val(duringArr[0]);
      $("#" + id).parent().find("[name=end]").val(duringArr[1]);
      // $("#form").submit();
    }
  </script>
 </body>
</html>

