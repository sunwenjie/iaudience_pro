<%@ page import="com.iclick.symphony.iaudience.util.Constant" %>
<%@ page import="com.iclick.symphony.iaudience.constants.ReportDataTypeEnum" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/commonTag.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
	<script type="text/javascript" src="js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="${static_path}/js/fnPagingInfo.js"></script>
	<script type="text/javascript" src="${static_path}/js/extjs.js"></script>
  <script type="text/javascript" src="${static_path}/js/echarts.min.js"></script>
  <script type="text/javascript" src="${static_path}/js/iax-template.js"></script>

</head>
<body>
<c:set var="unstart" value= "<%=Constant.UNSTART%>" />
<c:set var="running" value= "<%=Constant.RUNNING%>" />
<c:set var="complete" value= "<%=Constant.COMPLETE%>" />
<c:set var="brand" value= "<%=ReportDataTypeEnum.BRAND.getType()%>" />
<c:set var="competitors" value= "<%=ReportDataTypeEnum.COMPETITORS.getType()%>" />
<c:set var="potential" value= "<%=ReportDataTypeEnum.POTENTIAL.getType()%>" />

<div class="x-body" id="x-body">
		<div class="page_title">
		  <div id="breadcrumb" class="row">
		    <!-- Top left headings and links -->
		   <div class="client-row">
		   </div>


		  </div>
		  <div class="row"><div class="client-row"><h1><s:message code="audiencePlan.index.title"/></h1></div></div>
 		</div>
      <div>
        <ul class="nav nav-pills event_filter" style="float:left;">
          <li class="filter_icon active">
            <a class="pull-left add-button" href="${path}/audiencePlan/create"><i class="fa fa-plus"></i><span style="margin: 0 10px 0 5px;"><s:message code="audiencePlan.index.new" /> </span></a>
          </li>
        </ul>

				<div class="table_white" style="float:left;width:100%">
					<div id="client_list_wrapper" class="dataTables_wrapper no-footer"><div class="x"></div>
					<table id="audiencePlanList" class="table table-bordered table-condensed width_100 dataTable no-footer" cellspacing="0" width="100%" role="grid" aria-describedby="client_list_info">
						<thead>
						<tr>
							<th><s:message code="audiencePlan.index.planName" /> </th>
							<th><s:message code="audiencePlan.index.brand" /> </th>
							<th><s:message code="audiencePlan.index.competitors"/> </th>
							<th><s:message code="audiencePlan.index.potential" /> </th>
							<th><s:message code="audiencePlan.index.analysis"/> </th>
							<th><s:message code="audiencePlan.index.action" /> </th>
						</tr>
						</thead>
			        <tbody>

			            <c:forEach items="${list}" var="plan" varStatus="stat">
			            	<tr id="tr_${plan.id}" role="row" class="${stat.index % 2 == 0 ? 'odd' : 'even'}">
			            		<td><a href="${path}/audienceAnalysis/marketAnalysis?id=${plan.id}" class="bluelink">${plan.name}</a></td>
			            		<td style="position:relative"><i class="fa fa-bar-chart-o" style="cursor:pointer" data-type = "${brand}" onclick="showGraph(this)"></i><label style="float:right" class="audienceData">${audienceMap.get(plan.id).get(brand)}</label></td>
			            		<td style="position:relative"><i class="fa fa-bar-chart-o" style="cursor:pointer" data-type = "${competitors}" onclick="showGraph(this)"></i><label style="float:right" class="audienceData">${audienceMap.get(plan.id).get(competitors)}</label></td>
			            		<td style="position:relative"><i class="fa fa-bar-chart-o" style="cursor:pointer" data-type = "${potential}" onclick="showGraph(this)"></i><label style="float:right" class="audienceData">${audienceMap.get(plan.id).get(potential)}</label></td>
								<td class="align_center">
									<c:if test="${plan.analyseStatus == unstart}">
										<a href="javascript:;" class="bluelink" onclick="startAnalysis(this)"><s:message code="audiencePlan.index.startAnalysis"/></a>
									</c:if>
									<c:if test="${plan.analyseStatus == running}">
										<div style="position:relative;"><i class="fa fa-spinner fa-spin" style="font-size:18px;"></i></div>

									</c:if>
									<c:if test="${plan.analyseStatus == complete}">
										<a href="${path}/audienceAnalysis/marketAnalysis?id=${plan.id}" class="bluelink" ><s:message code="audiencePlan.index.viewResult"/> </a>
									</c:if>

								</td>
								<td class="align_center">
									<c:if test="${plan.analyseStatus == unstart || plan.analyseStatus == complete}">
										<a href="${path}/audiencePlan/update/${plan.id}" class="fa-icon-box">
											<i class="fa fa-edit"></i>
										</a>
									</c:if>
									<c:if test="${plan.analyseStatus == running}">
										<a href="javascript:void(0);" class="fa-icon-box fa-readonly">
											<i class="fa fa-edit"></i>
										</a>
									</c:if>

			                        <a href="javascript:;" class="fa-icon-box" onclick="getHistory(${plan.id})">
			                          <i class="fa fa-history"></i>
			                        </a>

									<c:if test="${plan.analyseStatus == unstart || plan.analyseStatus == complete}">
										<a href="${path}/audiencePlan/delete/${plan.id}" class="fa-icon-box">
											<i class="fa fa-edit"></i>
										</a>
									</c:if>
									<c:if test="${plan.analyseStatus == running}">
										<a href="javascript:void(0);" class="fa-icon-box fa-readonly">
											<i class="fa fa-edit"></i>
										</a>
									</c:if>
		                       </td>
			            	</tr>
			            </c:forEach>
				     </tbody>
				    </table>
				   </div>
				</div>
      </div>
    </div>
<script type="text/javascript">
	var oTable;
	$(function(){

	    if ("${message}"){
            //顶部消息条
            IAX_TOOL.notification("${message}","success",3000);
		}
        $(".audienceData").each(function () {
			if ($(this).text()){
			    var audience_num = parseInt($(this).text() / 1000);
                var audience_num_show = IAX_TOOL.format_to_numeric(audience_num).replace(".00", "") + " K";
                $(this).text(audience_num_show);
			}
        })

		 oTable=$('#audiencePlanList').dataTable({
				"oLanguage": {
					"sProcessing":   "处理中...",
					"sLengthMenu":   "显示 _MENU_ 项结果",
					"sZeroRecords":  "没有匹配结果",
					"sInfo":         "（共 _TOTAL_ 项）",
					"sInfoEmpty":    "（共 0 项）",
					"sInfoFiltered": "(由 _MAX_ 项结果过滤)",
					"sInfoPostFix":  "",
					"sSearch":       "寻找:",
					"sUrl":          "",
					"oPaginate": {
						"sFirst":    "&nbsp;",
						"sPrevious": "&nbsp;",
						"sNext":     "&nbsp;",
						"sLast":     "&nbsp;"
					}
				},
				  "sDom": "<'x'>t<'table_bottom'<'table_length'l><'table_pagin'p><'table_info'i>>",
				  "sPaginationType": "extStyle",
				  "bPaginate": true,
				  "iDisplayLength": 5,
	    "aLengthMenu": [15, 25, 50, 100],
				  "bLengthChange": true,
				  "bAutoWidth": false,
				  "aaSorting": [],
	    "columnDefs" : [ {
	           orderable : true,//禁用排序
	           targets : [ 0, 0 ]
	         //指定的列
	         } ]
			});
		 
	});
	function getHistory(id){
	//根据id获取对于历史信息
	var paramJson = {
	'title' : 'History',
	'tableData' : {},
	'callbackFun' : callbackFun,
	};
	paramJson.tableData = {
	"tId" : "history_table_"+id,
	"tHead" : [{'name':'Last Modified Date'},{'name':'Last Modified By'}],
	"tBody" : [ {'tdValues' : [{'name':'2017-05-11 11:11:11'},{'name':'Grace Liang'}]},
	            {'tdValues' : [{'name':'2017-05-11 11:11:11'},{'name':'Grace Liang'}]},
	            {'tdValues' : [{'name':'2017-05-11 11:11:11'},{'name':'Grace Liang'}]},
	            {'tdValues' : [{'name':'2017-05-11 11:11:11'},{'name':'Grace Liang'}]},
	            {'tdValues' : [{'name':'2017-05-11 11:11:11'},{'name':'Grace Liang'}]},
	          ]
	}
	IAX_TOOL.getAudienceHistory(paramJson);
	}
	function callbackFun(form,paramJson){
	var id = paramJson.tableData.tId;
	$('#'+id).dataTable({
	  "oLanguage": {
	    "sProcessing":   "处理中...",
	    "sLengthMenu":   "显示 _MENU_ 项结果",
	    "sZeroRecords":  "没有匹配结果",
	    "sInfo":         "（共 _TOTAL_ 项）",
	    "sInfoEmpty":    "（共 0 项）",
	    "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
	    "sInfoPostFix":  "",
	    "sSearch":       "寻找:",
	    "sUrl":          "",
	    "oPaginate": {
	      "sFirst":    "&nbsp;",
	      "sPrevious": "&nbsp;",
	      "sNext":     "&nbsp;",
	      "sLast":     "&nbsp;"
	    }
	  },
	    "sDom": "<'x'>t<'table_bottom'<'table_length'l><'table_pagin'p><'table_info'i>>",
	    "sPaginationType": "extStyle",
	    "bPaginate": true,
	    "iDisplayLength": 5,
	    "aLengthMenu": [5, 15, 25, 50],
	    "bLengthChange": true,
	    "bAutoWidth": false,
	    "aaSorting": [],
	    "columnDefs" : [ {
	           orderable : false,//禁用排序
	           targets : [ 0, 0 ]
	         //指定的列
	         } ]
	});
	}
	function deletePlan(id,content){
	var paramJson = {
	'title' : 'Confirm to delete this plan?',
	'content' : content,
	'cancel' : "Cancel",
	'save' : "Delete",
	'id' : id,
	'fn' : "delPlan('"+id+"')"
	}
	IAX_TOOL.confirmBox(paramJson);
	}
	function delPlan(id){
     		window.location.href = "${path}/audiencePlan/delete/"+id;
	}

    function startAnalysis(_this){
        var id = $(_this).parents("tr").attr("id").split("tr_")[1];
	    $.get("${path}/ajax/invokeChartApi",{audiencePlanId:id},function (data) {
	        if (data.success){
                var $tr = $(_this).parents("tr");
                $(_this).parent().html('<div style="position:relative;"><i class="fa fa-spinner fa-spin" style="font-size:18px;"></i></div>');
                $tr.find(".fa-edit").parent().addClass("fa-readonly").attr("href","javascript:void(0);");
                $tr.find(".fa-close").parent().addClass("fa-readonly").attr("href","javascript:void(0);");
	        }
        },"json");
    }
	function showGraph(_this){
	//获取折线图数据
	//生成折线图
	$(".table-graph").remove();
	//根据离右边距离判断显示
	var left = 15;
	var right = $(window).width()-$(_this).offset().left-$(window).scrollLeft();
	if(right<500){
	left=-500;
	}
	var type = $(_this).attr("data-type");
	$(_this).after('<div class="table-graph" style="left:'+left+'px"><div id= "'+type+'" style="width:100%;height:180px;"></div></div>');
	$(".table-graph").hover(function(){
	$('body').unbind('mousedown');
	},function(){
	$('body').bind('mousedown', function(){
	    $(".table-graph").hide();
	
	  });
	});
	var id = $(_this).parents("tr").attr("id").split("tr_")[1];
	$.get("${path}/ajax/getReportData",{audiencePlanId:id,type:type},function (data) {
	var period = data.dataPeriod;
	var resultData = eval('data.result.'+type);
	var date = [];
	var value = [];
	$.each(resultData,function (i,result) {
		date.push(result.date);
//		var num = parseInt(result.value);
		value.push({"value":parseInt(result.value / 1000),"textStyle":{"color":"#999","fontSize":10}});
	})
	console.log(value[0]);
	var myChart = echarts.init(document.getElementById(type));
	
	var option = {
	title : {
	  text: 'Period:  '+ period,
	  textStyle : {
	    'fontWeight':"bold",
	    'fontFamily' : "Open Sans",
	    'fontSize' : 14,
	  }
	},
	tooltip : {
	  trigger : 'axis',
	  backgroundColor : "#fff",
	  borderColor : "#dfdfdf",
	  borderWidth : 1,
	  textStyle : {
	    color : "#333",
	    fontFamily : "Open Sans"
	  },
	},
	legend : {
	  show : false
	},
	grid : {
	    left : '3%',
	    bottom : '3%',
	    top:'40',
	    containLabel : true
	  },
	xAxis : {
	  type : 'category',
	  splitLine: {
	       show: false
	   },
	   axisLine:{
	     show:false
	   },
	   axisTick:{
	     show:false
	   },
	   axisLabel: {
	    showMinLabel:false,
	    textStyle: {
	        color: '#999',
	        fontSize:10,
	    }
	  },
	  min:"dataMin",
	  max:"dataMax",  
	  boundaryGap:true,
	  data : date
	} ,
	yAxis : {
	  type : 'value',
	  splitNumber:3,
	  scale:true,
	  splitLine:{
	    show:true,
	    lineStyle:{
	      color:"#dfdfdf"
	    }
	  },
	  axisLine:{
	    show:false
	  },
	  axisTick:{
	    show:false
	  },
	  splitArea:{
	    show:false
	  },
	  axisLabel: {
	    showMinLabel:false,
	    formatter: '{value} k',
	    textStyle: {
	        color: '#999',
	        fontSize:10,
	    }

	  },
	} ,
	series : {
	  name : "test",
	  type : 'line',
	  stack : '总量',
	  symbol : 'circle',
	  symbolSize : "8",
	  showAllSymbol:true,
	  // hoverAnimation:false,
	  lineStyle : {
	    normal : {
	      color:"#ef4136",
	    }
	  },
	  areaStyle : {
	    normal : {
	      opacity:0
	    }
	  },
	  data : value,
	  tooltip:{
	    trigger:'item',
	    formatter : function(v){
	      var value = IAX_TOOL.format_to_numeric(v.value).replace(".00", "") + " K";
	      var html = "<p style='color:#999;font-size:10px'>"+v.name+"</p><p>"+value+"</p>";
	      return html;
	    }
	  }
	}
	}; 
	
	myChart.setOption(option);
    },"json");

	}



</script>
</body>
</html>
