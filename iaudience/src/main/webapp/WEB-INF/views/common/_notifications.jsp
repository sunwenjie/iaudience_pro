<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${static_path}/css/calendar/calendar.css?v_time=${v_time}">
<script type="text/javascript" src="${static_path}/js/jquery.dataTables.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/bootstrap/js/bootstrap.min.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/fnPagingInfo.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/extjs.js?v_time=${v_time}"></script>
<script type="text/javascript" src="${static_path}/js/calendar.js?v_time=${v_time}"></script>
<style>
#client_list_processing, #initLoad {
  position: absolute;
  background: #f6f6f6;
  opacity: 0.9;
  top: 0;
  left: 0;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  min-height: 200px;
  line-height: 200px;
  font-size: 20px;
  color: #e83829;
  text-align: center;
  z-index: 1000;
}

#initLoad {
  height: 200px;
  top: 141px;
  width: calc(100% - 40px);
  margin: 0 20px;
}
</style>
</head>
<!-- Page title -->
<div class="page_title">
  <div id="breadcrumb" class="row">
    <!-- Top left headings and links -->
    <div class="client-row"></div>
  </div>

  <div class="row">
    <div class="client-row">
      <h1>
          <s:message code="menu.desc.notification.setting"/>
      </h1>
    </div>
  </div>
</div>

<!-- table -->
<div class="tab-content" id="myTabContent">
  <div class="tab-pane fade in active" id="tab-performance">
    <div class="table_white">
      <table id="client_list" class="table table-bordered table-condensed" cellspacing="0"  style="min-width:100%;max-width:200%">
        <thead>
          <tr>
            <th width="150"><s:message code="notification.time.title"/></th>
            <th><s:message code="notification.message.title"/></th>
            <th id="th-status"><s:message code="notification.status.title"/></th>
          </tr>
        </thead>
      </table>
    </div>
    <div id="initLoad"><s:message code="common.loading"/></div>
  </div>
</div>

<script type="text/javascript">
$(function(){
	var message = "${message}";
	if(message!=""){
		SSP.notification(message,"success");
	}
  
	var oTable=$('#client_list').dataTable({
	"oLanguage": {"sUrl": "${path}/js/i18n/dataTables."+locale+".txt"},
    "sDom": "<'table_process'>rt<'table_bottom'<'table_pagin'p><'table_info'i>>",
    "sPaginationType": "extStyle",
    "bPaginate": true,
    "iDisplayLength": 20,
    "bLengthChange": true,
    "bAutoWidth": false,
    "aaSorting": [],
    "columnDefs":[{
		orderable:true,//禁用排序
		targets:[]   //指定的列
    }],
	"processing": true,
    "serverSide": true,
    "ajax" : {
		async: true,
		type: "GET",
		url: "${path}/${role}/accounts/ajaxNotifications"
    },
    
    "fnInitComplete": function(oSettings, json) {
       $("#initLoad").remove();
    },
    "fnRowCallback" : function(nRow, aData, iDisplayIndex) {
        var thStatusIndex = $("#th-status").index();
        var $tdElement = $("td:eq(" + thStatusIndex + ")", nRow);
        $tdElement.attr("style", "text-align:left !important;width:100px;");
        $tdElement.addClass("table-edit");
      },
    "fnDrawCallback": function(oSettings) {
        // redraw the paging element:
        $obj = $.fn.dataTable.ext.pager["extStyle"];
        $obj.fnInit(oSettings, $("#client_list_paginate"), function(oSettings) {
          $.fn.dataTable.ext.internal._fnDraw(oSettings);
        });
      },
});
	
  //code for show/hide table columns
  $('input:checkbox.toggle-vis').change(function(e) {
    e.preventDefault();
    var colNum = $(this).attr('value');
    oTable.fnSetColumnVis(colNum, $(this).is(':checked'));
  });
  $('body').on('click', function(e) {
    if (!$('.dropdown-stop').is(e.target) 
        && $('.dropdown-stop').has(e.target).length === 0 
        && $('.dropdown-stop.open').has(e.target).length === 0
    ) {
        $('.dropdown-stop').removeClass('open');
    }
  });
  $('.dropdown-stop .dropdown-toggle').on('click', function(event) {
    $(this).parent().toggleClass('open');
  });
});


function changeSta(thi, id, status) {
  var url = "${path}/${role}/accounts/unReadNotification";
  var param = {
    'read' : '<s:message code="notification.status.read" />',
    'unRead' : '<s:message code="notification.status.unread" />'
  };
  $.ajax({
    type : "POST",
    url : url,
    dataType : "json",
    data : {
      'id' : id,
      'status' : status
    },
    beforeSend : function() {
      $('[type="button"]').attr("disabled", true);
    },
    success : function(data) {
      if (data.result == "success") {
        SSP.notification("<s:message code='form.notification.update.success' />", data.result);
        $(thi).parents("td").find("a:first").text(param[status]);
        loadNotifyCount();
      } else {
        SSP.notification(data.message, data.result);
      }
    },
    error : function(data) {
      SSP.notification("<s:message code='form.error.service' />", "error");
    },
    complete : function(msg) {
      $('[type="button"]').attr("disabled", false);
    }
  });
}
</script>