<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
  <div class="" id="for_export_all_img">
                  <div class="row hide" id="exportjpg" style="padding: 20px 30px 20px 0px;">
                    <div class="client-row">
                      <h1 style=" font-size: 30px;">Audience Analysis</h1>
                    </div>
                    <div style="float:right">
                      <img src="http://xmostg.optimix.asia/images/logo/xmo.optimix.asia.png" alt="" style="width:118px">
                    </div>
                  </div>

                  <div class="" id="for_export_img" style="float:left;width:100%;">
                    <div class="plan-reports" id="report_content" style="margin-top:-7.5px;">
                      <div class="plan-reports-result clearfix">
                        <div class="plan-reports-result-inner" style="width:65%">
                          <!--Total-->
                          <div class="plan-result-graph" style="width:100%;height:451px;padding: 0 7.5px 0 0;">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label id="date_header">Market Landscape
                                  <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content" style="width:100%;">
                                    <div id="bubble-container" class="bubble-container">
                                      <div class="bubble-info">
                                        <label>Brand(s)</label>
                                        <ul>
                                         
                                        </ul>
                                        <div class="bubble-info-selected">
                                          Selected brands: <span></span>
                                        </div>
                                      </div>
                                      <div class="bubble-map">
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="plan-reports-result-inner" style="width:35%">
                          <!--top 5 brands-->
                          <div class="plan-result-graph graph-top" style="width:100%;padding:0 0px 0 7.5px" id="select_top_brand">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label>Top 5 Brands</label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content">

                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--end-->

                          <!--top 5 brands-->
                          <div class="plan-result-graph graph-top" style="width:100%;" id="select_top_products">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label>Top 5 Products</label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content">

                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--end-->

                        </div>
                        <div class="plan-reports-result-inner" style="width:50%;">
                          <!--Total-->
                          <div class="plan-result-graph audience_total" id="select_audience" style="width:100%;position:relative;">
                            <div class="plan-result-text" style="border-right:none;width:50%;float:left;">
                              <div class="result-text-header clearfix">
                                <label id="date_header">Audience Scale
                                <i class="fa fa-question-circle-o" data-toggle="tooltip" data-placement="bottom" data-original-title="Find out how many of the same people are in your brand"></i>
                                </label>
                              </div>
                              <div class="result-text-info clearfix x-mt10">
                                <div class="result-text-word word-impr plan-reports-bg-total" style="height:120px;margin-top:20px;">
                                  <label class="titleRed" id="audience_total" style="">0</label>
                                </div>
                              </div>
                            </div>
                            <!-- ä¸­é´ä¿¡æ¯ -->
                            <div class="plan-result-middle-line">
                              <div class="plan-middle-line"></div>
                              <div class="plan-middle-line-info">
                                <label>All Market: <span>0</span></label>
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
                                      <label style="margin-top:-10px;">Estee Lauder overlaps All Market</label>
                                      <div id="market-map" class="market-map" style="width:230px;height:160px;">
                                      </div>
                                    </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--gender-->
                          <div class="plan-result-graph" id="select_gender" style="padding: 0 7.5px 0 0;width: 50%;">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label>Gender</label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-content" style="padding-top:0;">
                                    <div id="gender-map" class="gender-map" style="width:230px;height:170px;">
                                    </div>
                                    <div class="gender-map-info gender-male">
                                      <span class="gender-map-ico"></span>
                                      <p>0%</p>
                                      <span>Male</span>
                                    </div>
                                    <div class="gender-map-info gender-female">
                                      <span class="gender-map-ico"></span>
                                      <p>0%</p>
                                      <span>Female</span>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <!--å¹´é¾-->
                          <div class="plan-result-graph" id="select_age" style="padding: 0 7.5px;width: 50%;">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label>AGE GROUPS</label>
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
                        <div class="plan-reports-result-inner" style="width:50%;">
                          <!--å°å-->
                          <div class="plan-result-graph graph-region" style="width:100%;padding-left:7.5px;" id="select_province">
                            <div class="plan-result-text">
                              <div class="result-text-header clearfix">
                                <label>REGIONS</label>
                              </div>
                              <div class="result-graph-info x-mt10">
                                <div class="result-graph-word word-impr">
                                  <div class="result-graph-word-map">
                                    <div class="region-map" id="region-map"></div>
                                    <label style="position:absolute;left:25px;bottom:40px;">Distribution index</label>
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
                                <label>INTEREST CATEGORIES</label>
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
                
 <script type="text/javascript">

 </script>
