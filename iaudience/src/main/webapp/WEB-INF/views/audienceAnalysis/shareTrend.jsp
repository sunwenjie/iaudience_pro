<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
  
                <div class="" id="for_export_img" style="float:left;width:100%;">
                    <div class="plan-reports" id="report_content" style="margin-top:-7.5px;">
                      <div class="plan-reports-result clearfix">
                        <div class="plan-reports-result-inner" style="width:65%">
                          <!--Trend map-->
                          <div class="plan-result-graph" id="select_trend_map" style="width:100%;height:600px;padding: 0 7.5px 0 0;">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label id="date_header">Trend of Market Audience & Market Share
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                                <div class="report-dropdown" style="top:30px;right:20px;">
                                  <div class="date-range">
                                    <div class="date-range-ico"><i class="fa fa-calendar"></i></div> 
                                    <input type="text" id="daterange"
                                      style="width:155px;"
                                      placeholder="please select a period" value=""
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
                                    <div id="line_chart" class="line-chart-map" style="width:100%;height:200px;">
                                    </div>
                                    <!-- å¾çæå­åè¡¨ begin-->
                                    <div class="pic-title-list">
                                     
                                    </div>
                                    <!-- å¾çæå­åè¡¨ end-->
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
                                <label id="date_header">Audience Scale
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
                                <label id="date_header">Market Share
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
                                <label>Keywords
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content" style="padding-top:0">
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
                
