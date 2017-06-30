<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.iclick.symphony.iaudience.util.Constant" %>
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
  <link rel="stylesheet" type="text/css" href="${static_path}/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/bootstrap_iaccess.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/head.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/index.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/chosen.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/calendar.css">
  <link rel="stylesheet" type="text/css" href="${static_path}/css/jqcloud.css">


	<script type="text/javascript" src="${static_path}/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${static_path}/js/common.js"></script>
	<script type="text/javascript" src="${static_path}/bootstrap/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="${static_path}/js/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="${static_path}/js/echarts.min.js"></script>
    <script type="text/javascript" src="${static_path}/js/calendar.js"></script>
  <script type="text/javascript" src="${static_path}/js/china.js"></script>
  <script type="text/javascript" src="${static_path}/js/d3.v4.min.js"></script>
  <script type="text/javascript" src="${static_path}/js/venn.js"></script>
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

    <script type="text/javascript" src="${static_path}/js/hogan-2.0.0.min.js"></script>
     <script type="text/javascript" src="${static_path}/js/highcharts.js"></script>
    <script type="text/javascript" src="${static_path}/js/highcharts-more.js"></script>
    <script type="text/javascript" src="${static_path}/js/iax-tool.js"></script>
    <script type="text/javascript" src="${static_path}/js/iax-template.js"></script>
    <script type="text/javascript" src="${static_path}/js/iax-chart-tool.js"></script>
     <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=62a73830c63e6a4953da07f6dc92d898&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="text/javascript" src="${static_path}/js/jqcloud-1.0.4.js"></script>

</head>
    <body>
    	<div class="container">
    	<!--body-->
      <div class="x-main">
        <div class="x-sidebar" id="x-sidebar">
          <ul class="x-menu">
            <li id="" class="">
              <a href="${static_path}/audiencePlan">
               <i class="fa fa-users" aria-hidden="true"></i>
              <span class="x-m8">Audience Plans</span>
              </a>
            </li>

            
            <li id="" class="selected">
              <a href="">
               <i class="fa fa-bar-chart" aria-hidden="true"></i>
                <span class="x-m8">Audience Analysis</span>
               <i class="fa fa-caret-down fa-fw" aria-hidden="true"></i>
              </a>
              <ul class="sub-menu" style="display: block;">
                <li class="active">
                  <a href="${path}/audienceAnalysis/marketAnalysis"><span class="x-m8">Market</span></a>
                </li>
                <li class="">
                  <a href="${path}/audienceAnalysis/brandAnalysis"><span class="x-m8">My Brand</span></a>

                </li>
              </ul>
            </li>
            
          </ul>
          <ul class="x-menu-lang-select">
            <li>
              <a href="#">
              <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                 <span class="x-m8">ç®ä½ä¸­æ</span>
              </a>
            </li>
            <li>
              <a href="#">
              <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                 <span class="x-m8">ç®ä½ä¸­æ</span>
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
              <div class="client-row"><h1>Audience Analysis:</h1></div> 
              <div class="client-row">
                <label style="line-height:20px;">
                  <div class="dropdown">
                    <input id="hasSavedPlan" type="hidden" value="1"/>
                    <a class=" dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="cursor:pointer;color:#ef4136;font-size:20px;">
                      ${planName}
                    </a>
                 	<form id="keywordForm" >
						<input type="hidden" name="keywordStr" value="${keyWord}" />
					    <input type="hidden"  name="regionStr" value="1156110001" />
						<input type="hidden"  id="locationData" value="{}" />
						<input type="hidden" name="planId" value="${planId}" />
		                <input type="hidden" name="name" value="${name}" />
		                
					</form> 
                    <i class="fa fa-caret-down" aria-hidden="true" style="position:absolute;top:5px;right:-10px;color:#ef4136;"></i>
                    <ul class="dropdown-menu ss"  aria-labelledby="dropdownMenu1" style="top:100%!important;border-top:1px solid #dfdfdf!important;min-width:240px;">
                      <li data-value="-1"><a href="javascript:;">google</a></li>
                      <li data-value="-1"><a href="javascript:;">baidu</a></li>
                    </ul>
                  </div>
                </label>
              </div>
            </div>
       		</div>
      		  <!-- Page title -->

          <ul class="nav nav-tabs sub-nav-tabs" id="myTab">
            <li class="" id ="init-share">
              <a data-toggle="tab" href="#tab-share" data-id="share">Market Share & Trend</a>
            </li>
            <li class="active">
              <a data-toggle="tab" href="#tab-analysis" data-id="market">Market Analysis</a>
            </li>
            <li class="">
              <a data-toggle="tab" href="#tab-location" data-id="location">Location Analysis</a>
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
      			<jsp:include page="shareTrend.jsp"></jsp:include> 
      			</div>

	      		<div class="tab-pane fade" id="tab-analysis">
	                <jsp:include page="analysis.jsp"></jsp:include> 
	      		</div>
      			
	           <div class="tab-pane fade" id="tab-location">
	            <div class="" id="">
	               <select class="select  required" id="regions" name="chooseRegiosn" disname="chosen下拉" style="width: 380px">
	                  <option value="1156310001">Shanghai</option>
	                  <option value="1156110001">Beijing</option>
	                  <option value="1156440100">Guangdong</option>
	                  <option value="1156440300">Shenzhen</option>
	               </select>
	                <input type ="hidden" id="1156310001" value="Shanghai">
	                <input type ="hidden" id="1156110001" value="Beijing">
	                <input type ="hidden" id="1156440100" value="Guangdong">
	                <input type ="hidden" id="1156440300" value="Shenzhen">
	                <div class="map-container">
	                  <div id="map_container"></div>
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
  var $form = $("#keywordForm");
  var resData = {};
  function getReportData(){
		   	 //模拟加载loading
		        var html = $("#for_export_img .plan-reports").hide();
		        var url = "${path}/ajax/getReportDataAjax";
		   	   $.ajax({
		   	        type: "POST",
		   	        url: url,
		   	        dataType: "json",
		   	        data: $form.serialize(),
		   	        beforeSend:function(){
		   	        	$("#for_export_img").append('<div class="loadingDiv"><i class="loadingGif fa fa-spinner fa-spin"></i></div>');
		   	        },
		   	        success: function(data) {
		   	        	$("#for_export_img .loadingDiv").remove();
		   	            $("#for_export_img .plan-reports").show();
		   	        	if(data){
		   	        		resData = data;
		   	        	}
		   	        }
		   	      });
		   	}
    var map = new AMap.Map('map_container', {
        resizeEnable: true,
        zoom:11,
        center: [116.486409,39.921489],
        scrollWheel:false,
        
    });
  
  $(function(){
	  getReportData();
	  $("#init-share").find("a").click();
    $('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var tab = $(e.target).attr("data-id") // 激活的标签页
        var json = {};
        function getData(data){
        	if(data){
        	   for (var i = 0; i < data.result.length; i++) {
                   if(tab == data.result[i].name){
                     json = data.result[i];
                   }
                 }
         }
    }
           
        getData(resData);
    
        if (tab=="market") {
          IAX_CHART_TOOL.initBubbleGraph("bubble-container",json.data);
        } else if(tab=="location"){
          $("#regions").val("1156110001");
          $("#regions").chosen();
          map.setZoom(11);
          getLbsData();
          var placeSearch = new AMap.PlaceSearch({
              map: map
          });
          
          $("#regions").on("change",function(){
        	 var city = $(this).val();
        	$("input[name='regionStr']").val(city);
            placeSearch.search($("#"+city+"").val()); 
            getLbsData();
          });
          var poiPolys = [],areaPolys = [],streetPolys = [],polygons=[];;
          //构造marker
        	function getLbsData(){
        	 var jsonReq = {};
      	     var url = "${path}/ajax/getLbsAjax";
      		   $.ajax({
      		        type: "GET",
      		        url: url,
      		        dataType: "json",
      		        data: $form.serialize(),
      		        success: function(jsonData) {
      		        	if(jsonData){
      		        		getMapData(jsonData);
      		        		$("#locationData").val(jsonData);
      		        		}
      			        }
      		      });
      		}
          
         function getMapData(jsonReq){
           for(var i in jsonReq){
            var json = jsonReq[i];
            if (i!="total") {
              for (var j = 0; j < json.length; j++) {
                markIcon(json[j]);
              };
            };
          } 
         }
         
         function markIcon(center){ 
        	//  alert(center);
            var content = '';
            var visible = true;
            var icon = '';
            if (center.level === "district") {
              // icon = 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png'
             content = '<div class="plate-overlay">'+center.name+'<br>pv:' + center.pv +'<br>uv:' + center.uv +'</div>';
              visible = true;
            }else if (center.level==="street") {
              content = '<div class="estate-overlay js_villageLabel"><div class="estate-overlay__count js_estateOverlayCount">' + center.name + ' pv:' + center.pv +' uv:' + center.uv + '</div><div class="estate-overlay__show-name"><span>pv:'+center.pv +'</span><span class="ml_10">uv:' + center.uv + '</span></div></div>';
              visible = false;
            }else if (center.level === "poi") {
              //content = '';
              //icon = 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png'
              var posArr = center.location.split(",");
              center.lat = posArr[0];
              center.lng = posArr[1];
              content = '<div class="estate-overlay js_villageLabel"><div class="estate-overlay-poi js_estateOverlayCount">' + center.name + ' pv:' + center.pv +' uv:' +center.uv + '</div><div class="estate-overlay__show-name"><span class="ml_10">' + center.street + '</span></div></div>';
              // content = '<div class="js_poi_lable" style="display:block">sdfkajlkfjadf'+center.pv +'</div>';
              visible = false;
            }
            var marker = new AMap.Marker({ //添加自定义点标记
              map: map,
              position: [center.lng, center.lat], //基点位置
              // offset: new AMap.Pixel(-17, -42), //
              bubble: true,
              draggable: false, //是否可拖动
              icon: icon,
              content: content, //自定义点标记覆盖物内容
              visible: visible,
              extData: center.name
            });
            if (center.level ==="poi") {
              poiPolys.push(marker)
            }
            if (center.level ==="street") {
              marker.on('click', function() {
              // 设置缩放级别和中心点
                map.setZoomAndCenter(15, [center.lng,center.lat]);
              });
              streetPolys.push(marker);
            }
            if (center.level === "district") {
              marker.on('click', function() {
                // 设置缩放级别和中心点
                map.setZoomAndCenter(12 , [center.lng,center.lat]);
                // 隐藏areaPloys 显示streetPloys
                for (var i = 0, l = areaPolys.length; i < l; i++) {
                  areaPolys[i].hide();
                }
                for (var i = 0, l = streetPolys.length; i < l; i++) {
                  streetPolys[i].show();
                }
              });
              marker.on('mouseover',function(){
                //绘制行政区
                searchStrict(center.name);
              })
              marker.on('mouseout',function(){
                //清除行政区
                 for (var i = 0, l = polygons.length; i < l; i++) {
                  polygons[i].setMap(null);
                }
              })
              areaPolys.push(marker);
            }
          }
         
          function searchStrict(name){
            //加载行政区划插件
            AMap.service('AMap.DistrictSearch', function() {
              var opts = {
                subdistrict: 1, //返回下一级行政区
                extensions: 'all', //返回行政区边界坐标组等具体信息
                level: 'city' //查询行政级别为 市
              };
              //实例化DistrictSearch
              district = new AMap.DistrictSearch(opts);
              district.setLevel('district');
              //行政区查询
              district.search(name, function(status, result) {
                var bounds = result.districtList[0].boundaries;
                if (bounds) {
                  for (var i = 0, l = bounds.length; i < l; i++) {
                    //生成行政区划polygon
                    var polygon = new AMap.Polygon({
                    map: map,
                    strokeWeight: 1,
                    path: bounds[i],
                    fillOpacity: 0.7,
                    fillColor: '#CCF3FF',
                    strokeColor: '#CC66CC'
                    });
                    polygons.push(polygon);
                  }
                 // map.setFitView();//地图自适应
                }
              });
            });
          } 
          //地图缩放监听
           map.on("zoomend",function(){
            var level = map.getZoom();
            if(level > 14){
              for (var i = 0, l = areaPolys.length; i < l; i++) {
                areaPolys[i].hide();
              }
              for (var i = 0, l = streetPolys.length; i < l; i++) {
                streetPolys[i].hide();
              }
              for (var i = 0, l = poiPolys.length; i < l; i++) {
               poiPolys[i].show();
              }
            }else if(level > 11) {
              for (var i = 0, l = areaPolys.length; i < l; i++) {
                areaPolys[i].hide();
              }
              for (var i = 0, l = streetPolys.length; i < l; i++) {
               streetPolys[i].show();
              }
              for (var i = 0, l = poiPolys.length; i < l; i++) {
                poiPolys[i].hide();
              }
            }else{
              for (var i = 0, l = areaPolys.length; i < l; i++) {
               areaPolys[i].show();
              }
              for (var i = 0, l = streetPolys.length; i < l; i++) {
                streetPolys[i].hide();
              }
              for (var i = 0, l = poiPolys.length; i < l; i++) {
                poiPolys[i].hide();
              }
            }
          } )//地图缩放监听 end 
        } else if(tab=="share") {
        	 $("#tab-share").find("div:first").hide();
             $("#tab-share").append('<div class="analysis-loading"><img class="analysis-gif" src="../images/loading.gif"></img></div>');
             //假设5秒后获取json数据，要先show，后init图表
             setTimeout(function(){
               $(".analysis-loading").remove();
               $("#tab-share").find("div:first").show();
            IAX_CHART_TOOL.initMixTrend("line_chart",json.data);
            IAX_CHART_TOOL.initTotalAudience("select_audience_share","audience_total_share","market-map_share",json.data);
            IAX_CHART_TOOL.initCloudTag("cloud_tag_share",json.data,300);
            initCalendar("daterange");
            },5000)
        }
        
      }) // tab click end 
     
     }); // function 初始化 end
  	
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
