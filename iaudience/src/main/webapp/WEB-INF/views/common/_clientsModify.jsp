<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/commonTag.jsp"%>
<div class="control-group">
  <label class="control-label"><s:message code="body.industry" /></label>
  <div class="controls">
    <div class="dropdown modifylabel">
      <input name="industryId" type="hidden" value="" onchange="$(this).valid()" />
      <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <s:message code="common.select" />
        <span class="caret arrow-down"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <c:forEach var="industry" items="${industyList}" varStatus="status">
          <li data-value="${industry.id}"><a href="javascript:;">${industry.code} : ${industry.name}</a></li>
        </c:forEach>
      </ul>
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.categoryName}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.location" /></label>
  <div class="controls">
    <div class="dropdown modifylabel">
      <input name="locationId" type="hidden" value="" onchange="$(this).valid()" />
      <button class="btn  dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <s:message code="common.select" />
        <span class="caret arrow-down"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <c:forEach var="location" items="${locationList}" varStatus="status">
          <li data-value="${location.id}"><a href="javascript:;"><s:message code="location.id.${location.id}" /></a></li>
        </c:forEach>
      </ul>
    </div>
    <div class="clearfix infolabel hide"><s:message code="location.id.${iaxAdvertiserDo.locationId}" /></div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.company.name" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="companyName" value="${iaxAdvertiserDo.companyName}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.companyName}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.contact.person" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="contactName" value="${iaxAdvertiserDo.contactName}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.contactName}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.email" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="contactEmail" value="${iaxAdvertiserDo.contactEmail}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.contactEmail}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.contact.number" /></label>
  <div class="controls">
    <div class="input-append ">
      <input type="text" value="${countryNumber}" placeholder="<s:message code='body.contactNumber.countryNumber' />"
        style="width: 80px; margin-right: 10px;" class="modifylabel numeric valid" name="countryNumber"> <input type="text"
        value="${areaNumber}" placeholder="<s:message code='body.contactNumber.areaNumber' />" style="width: 80px; margin-right: 10px;"
        class="modifylabel numeric valid" name="areaNumber"> <input type="text" value="${telNumber}"
        placeholder="<s:message code='body.contactNumber.telNumber' />" style="width: 135px; margin-right: 10px;" class="modifylabel numeric valid"
        name="telNumber">
      <div class="infolabel hide" style="width: 80px; margin-right: 10px;">${countryNumber}</div>
      <div class="infolabel hide" style="width: 80px; margin-right: 10px;">${areaNumber}</div>
      <div class="infolabel hide" style="width: 135px; margin-right: 10px;">${telNumber}</div>
    </div>

    <div class="error-message hide" style="height: auto; min-height: 28px;">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.site.name" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="siteName" value="${iaxAdvertiserDo.siteName}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.siteName}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.site.url" /></label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="siteUrl" value="${iaxAdvertiserDo.siteUrl}" />
    </div>
    <div class="clearfix infolabel hide">${iaxAdvertiserDo.siteUrl}</div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<h3 class="">
  <s:message code="body.client.document" />
</h3>

<div class="control-group">
  <label class="control-label"><s:message code="body.organization.code.certificate" /> <span class="glyphicon glyphicon-question-sign"
    aria-hidden="true" data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.organization.code.certificate' />"></span> </label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="organizationCodeCertificate" value="${organizationCode}" />
    </div>
    <div class="clearfix infolabel hide">${organizationCode}</div>
    <div class="clearfix">
      <div class="label-input">
        <c:choose>
          <c:when test="${organizationPath == null}">
            <div class="uploadDiv">
              <button id="upload" class="btn btn-default">
                <s:message code="body.certificate.upload" />
              </button>
              <input type="file" class="fileStyle" id="organization" name="organization" style="width: 133px;" />
            </div>
          </c:when>
          <c:otherwise>
            <div class="uploadDiv">
              <button id="uploadOrg" class="btn btn-default">
                <s:message code="body.certificate.reupload" />
              </button>
              <input type="file" class="fileStyle" id="organization" name="organization" style="width: 146px;" />
            </div>

            <div style="display: none">
              <input name="organization-realPath" value="${organizationPath}" type="hidden" /><img src="${path}${organizationUrl}">
            </div>
            <a class="btn btn-default" title="<s:message code='body.organization.code.certificate' />" tabindex="0" role="button"
              data-toggle="popover" data-trigger="click"
              style="padding: 0 15px; vertical-align: top; line-height: 30px; min-height: 28px; height: 28px;"> <s:message
                code="body.certificate.see" />
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.certificate.icp" /> <span class="glyphicon glyphicon-question-sign" aria-hidden="true"
    data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.certificate.icp' />"></span> </label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="icpCertificate" value="${ICPCode}" />
    </div>
    <div class="clearfix infolabel hide">${ICPCode}</div>
    <div class="clearfix">
      <div class="label-input">
        <c:choose>
          <c:when test="${ICPPath == null}">
            <div class="uploadDiv">
              <button id="upload" class="btn btn-default">
                <s:message code="body.certificate.upload" />
              </button>
              <input type="file" class="fileStyle" id="icp" name="icp" style="width: 133px;" />
            </div>
          </c:when>
          <c:otherwise>
            <div class="uploadDiv">
              <button id="uploadIcp" class="btn btn-default">
                <s:message code="body.certificate.reupload" />
              </button>
              <input type="file" class="fileStyle" id="icp" name="icp" style="width: 146px;" />
            </div>

            <div style="display: none">
              <input name="icp-realPath" value="${ICPPath}" type="hidden" /><img src="${path}${ICPUrl}">
            </div>
            <a class="btn btn-default" title="<s:message code='body.certificate.icp' />" tabindex="0" role="button" data-toggle="popover"
              data-trigger="click" style="padding: 0 15px; vertical-align: top; line-height: 30px; min-height: 28px; height: 28px;"> <s:message
                code="body.certificate.see" />
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.bussiness.license" /> <span class="glyphicon glyphicon-question-sign" aria-hidden="true"
    data-toggle="tooltip" data-placement="right" title="<s:message code='form.tip.bussiness.license' />"></span> </label>
  <div class="controls">
    <div class="clearfix modifylabel">
      <input type="text" name="businessLicence" value="${businessCode}" />
    </div>
    <div class="clearfix infolabel hide">${businessCode}</div>
    <div class="clearfix">
      <div class="label-input">
        <c:choose>
          <c:when test="${businessPath == null}">
            <div class="uploadDiv">
              <button id="upload" class="btn btn-default">
                <s:message code="body.certificate.upload" />
              </button>
              <input type="file" class="fileStyle" id="bussLicense" name="bussLicense" style="width: 133px;" />
            </div>
          </c:when>
          <c:otherwise>
            <div class="uploadDiv">
              <button id="uploadIcp" class="btn btn-default">
                <s:message code="body.certificate.reupload" />
              </button>
              <input type="file" class="fileStyle" id="bussLicense" name=bussLicense style="width: 146px;" />
            </div>

            <div style="display: none">
              <input name="bussLicense-realPath" value="${businessPath}" type="hidden" /><img src="${path}${businessUrl}">
            </div>
            <a class="btn btn-default" title="<s:message code='body.bussiness.license' />" tabindex="0" role="button" data-toggle="popover"
              data-trigger="click" style="padding: 0 15px; vertical-align: top; line-height: 30px; min-height: 28px; height: 28px;"> <s:message
                code="body.certificate.see" />
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group" style="padding-top: 0">
  <div class="controls">

    <div class="clearfix">
      <div class="label-input">
        <s:message code="body.expiry.date" />
        <jsp:useBean id="todayDate" class="java.util.Date" />
        <sec:authentication property="principal.iaxUserDo.timeZone" var="timeZone"/>
        <fmt:formatDate value="${iaxAdvertiserDo.blexpiryDate}" pattern="YYYY-MM-dd" var="blExpDate" />
        <fmt:formatDate value="${todayDate}" pattern="YYYY-MM-dd" var="today" timeZone="${timeZone}"/>
        <c:if test="${blExpDate lt today}">
          <span data-toggle="tooltip" data-placement="right"
            title="<s:message code="body.business.license.expired" />"> <i
            class="icon-status-ad-context glyphicon glyphicon-exclamation-sign" style="color: #ef4136;top:2px;"></i>
          </span>
        </c:if>
      </div>
    </div>
    <div class="clearfix modifylabel">
      <div class="date-range" style="width: 380px;">
        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <input type="text" id="expiryDay" name="blexpiryDateString"
          placeholder="<s:message code='body.time.empty' />" value="${blexpiryDateString}" class="form-control date-range-input" style="width: 345px;" />
        <span class="caret arrow-calendar"></span>
        <div class="error-message hide">
          <span class="glyphicon glyphicon-alert"></span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
    <div class="clearfix infolabel hide">${blexpiryDateString}</div>

  </div>
</div>

<div class="control-group">
  <label class="control-label"><s:message code="body.status" /></label>
  <div class="controls">
    <div class="dropdown modifylabel">
      <input name="status" type="hidden" value="ACTIVE" />
      <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <s:message code="body.status.active" />
        <span class="caret arrow-down"></span>
      </button>
      <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
        <li data-value="ACTIVE"><a href="javascript:;"><s:message code="body.status.active" /></a></li>
        <li data-value="SUSPENDED"><a href="javascript:;"><s:message code="body.status.suspended" /></a></li>
      </ul>
    </div>
    <div class="clearfix infolabel hide" id="statusLabel">
      <s:message code="body.status.${fn:toLowerCase(iaxAdvertiserDo.status)}" />
    </div>
    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<div class="control-group">
  <label class="control-label"><s:message code="body.notes" /></label>
  <div class="controls">
    <textarea class="input-xlarge span4 modifylabel" name="descr" value="${iaxAdvertiserDo.descr}" style="width: 360px !important;" rows="5" cols="20">${iaxAdvertiserDo.descr}</textarea>
    <textarea class="input-xlarge span4 infolabel hide" disabled name="notes" style="width: 370px !important;" rows="5" cols="20">${iaxAdvertiserDo.descr}</textarea>

    <div class="error-message hide">
      <span class="glyphicon glyphicon-alert"></span>
      <div class="clearfix"></div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $(function() {
    var role = $("form").attr("ref");

    // width of file chooser is different for each locale. default is en.
    if (locale == "zh") {
      $("[type=file]").each(function() {
        if ($(this).width() == 133) {
          $(this).width(81);
        } else if ($(this).width() == 146) {
          $(this).width(105);
        }
      })
    }
    
    $('[data-toggle="popover"]').each(function() {
      var html = $(this).prev().html();
      $(this).popover({
        html : true,
        content : html
      });
    })
    initCalendar("expiryDay");
    $("form").validate({
      rules : {
    	"userId" : {
    		required : true
    	},
        "name" : {
          required : true
        },
        "dspName" : {
          required : true
        },
        "industryId" : {
          required : true
        },
        "locationId" : {
          required : true
        },
        "companyName" : {
          required : true
        },
        "contactName" : {
          required : true
        },
        "contactEmail" : {
          required : true,
          email : true
        },
        "countryNumber" : {
          required : true,
          digits : true
        },
        "areaNumber" : {
          required : true,
          digits : true
        },
        "telNumber" : {
          required : true,
          digits : true
        },
        "siteName" : {
          required : true
        },
        "siteUrl" : {
          required : true,
          url : true
        },
        "organizationCodeCertificate" : {
          required : true
        },
        "icpCertificate" : {
          required : true
        },
        "businessLicence" : {
          required : true
        },
        "blexpiryDateString" : {
          required : true
        },
        "descr" : {
          required : true
        }

      },
      errorPlacement : function(error, element) {
        element.parents(".controls").find(".error-message")
            .removeClass("hide");
        error.appendTo(element.parents(".controls").find(
            ".error-message").find(".clearfix"));
      },
      messages : {
        "userId" : {
          required : "<s:message code='form.error.dsp.empty' />"
        },
        "name" : {
          required : "<s:message code='form.error.client.name.empty' />"
        },
        "dspName" : {
          required : "<s:message code='form.error.dsp.empty' />"
        },
        "industryId" : {
          required : "<s:message code='form.error.industry.empty' />"
        },
        "locationId" : {
          required : "<s:message code='form.error.location.empty' />"
        },
        "companyName" : {
          required : "<s:message code='form.error.company.name.empty' />"
        },
        "contactName" : {
          required : "<s:message code='form.error.contact.person.empty' />"
        },
        "contactEmail" : {
          required : "<s:message code='form.error.contact.email.empty' />",
          email : "<s:message code='form.error.contact.email.valid' />"
        },
        "countryNumber" : {
          required : "<s:message code='form.error.countryNumber.empty' />",
          digits : "<s:message code='form.error.digits' />"
        },
        "areaNumber" : {
          required : "<s:message code='form.error.areaNumber.empty' />",
          digits : "<s:message code='form.error.digits' />"
        },
        "telNumber" : {
          required : "<s:message code='form.error.telNumber.empty' />",
          digits : "<s:message code='form.error.digits' />"
        },
        "siteName" : {
          required : "<s:message code='form.error.site.name.empty' />"
        },
        "siteUrl" : {
          required : "<s:message code='form.error.site.url.empty' />",
          url : "<s:message code='form.error.url.invalid' />"
        },
        "organizationCodeCertificate" : {
          required : "<s:message code='form.error.organization.code.certificate.empty' />"
        },
        "icpCertificate" : {
          required : "<s:message code='form.error.icp.certificate.empty' />"
        },
        "businessLicence" : {
          required : "<s:message code='form.error.business.licence.empty' />"
        },
        "blexpiryDateString" : {
          required : "<s:message code='form.error.expiryDay.empty' />"
        },
        "descr" : {
          required : "<s:message code='form.error.notes.empty' />"
        }

      },
      success : function(label) {
        if ($(label).siblings("label").length == 0
            || $(label).siblings("label").text() == "") {
          $(label).parents(".error-message").addClass("hide");
        }
      },
      submitHandler : function(form) { //通过之后回调
        $('[type="button"]').attr("disabled", true);
        form.submit();
      },
      invalidHandler : function(form, validator) { //不通过回调 
        $("label.error").each(
            function() {
              $(this).html().length
                  && $(this).parents(".error-message").removeClass(
                      "hide");
            })
        return false;
      }
    });
    
    // dsp验证    
    jQuery.validator.addMethod("dsp", function(value, element) {
      var length = value.replace(/\s/g, "").length;
      var isExist = $(element).length > 0;
      if (isExist) {
        return length > 0;
      } else {
        return true;
      }
    }, "<s:message code='form.error.dsp.empty' />");

    $("[name='countryNumber'],[name='areaNumber'],[name='telNumber']").on("keyup", function() {
      var _this = this;
      $(_this).parent().next().addClass("hide");
      var inputs = $(_this).parent().find("input").map(function() {
        $(this).valid();
        return $(this).val().replace(/\s/g, "");
      }).get();
      for (var i = 0; i < inputs.length; i++) {
        if (!(/^[0-9]*$/g).test(inputs[i]) || inputs[i] == "") {
          $(_this).parent().next().removeClass("hide");
          break;
        }
      }
    });

    $("[type=file]").each(function() {
      var id = $(this).attr("id");
      var name = $(this).attr("name");
      var docName = $(this).parents(".control-group").children("label.control-label").text();
      new AjaxUpload("#" + id, {
        action : '${path}/upload/ajaxUploadPic',
        autoSubmit : true,
        name : name,
        responseType : "json",
        onChange : function(file, extension) {
        },
        onSubmit : function(file, extension) {
          if ((extension && /^(rar|zip|pdf|pdfx|txt|csv|xls|xlsx|doc|docx|RAR|ZIP|PDF|PDFX|TXT|CSV|XLS|XLSX|DOC|DOCX)$/
              .test(extension))) {
            //$("#" + id).parent().find("label").remove();
            //$("#" + id).parent().append('<label style="color:red;display:inline"><s:message code="form.certificate.uploaded.extension.error" /></label');
            SSP.notification(docName + ': <s:message code="form.certificate.uploaded.extension.error"/>', "error");
            return false;
          }
          var userId = 0;
          if ($("[name='userId']").length) {
            userId = $("[name='userId']").val();
          }
          this.setData({
            'filedata' : name,
            'file' : file,
            'fileNameExtension' : extension,
            'userId' : userId
          });
        },
        onComplete : function(file, response) {
          if (response.realPath && response.filePath) {
            var path = response.realPath;
            var url = response.filePath;
            getFile($("#" + id), path, url);
          } else {
            //$("#" + id).parent().find("label").remove();
            //$("#" + id).parent().append('<label style="color:red;display:inline"><s:message code="form.certificate.uploaded.fail" /></label');
            SSP.notification(docName + ': <s:message code="form.certificate.uploaded.fail"/>', "error");
          }
        }
      });
    });

    if ('${iaxAdvertiserDo.userId}' != '') {
      $("[name='userId']").parent().find(
          "[data-value='${iaxAdvertiserDo.userId}']").trigger("click");
    }
    if ('${iaxAdvertiserDo.industryId}' != '') {
      $("[name='industryId']").parent().find(
          "[data-value='${iaxAdvertiserDo.industryId}']").trigger("click");
    }
    if ('${iaxAdvertiserDo.locationId}' != '') {
      $("[name='locationId']").parent().find(
          "[data-value='${iaxAdvertiserDo.locationId}']").trigger("click");
    }
    if ('${iaxAdvertiserDo.status}' != '') {
      $("[name='status']").parent().find(
          "[data-value='${iaxAdvertiserDo.status}']").trigger("click");
      $("[name='status']").parent().next().text(
          $("[name='status']").attr("title"));
      if (role != "admin") {
        if ('${iaxAdvertiserDo.status}' == "SUSPENDED") {
          $("#statusLabel").text($("[name='status']").attr("title"));
          $("#statusLabel").prev().hide();
          $("#statusLabel").prev().removeClass("modifylabel");
          $("#statusLabel").removeClass("hide");
          $("#statusLabel").removeClass("infolabel");
        }
      }
    }
    if (role != "admin") {
      $("[name='status']").parent().find("[data-value='SUSPENDED']").remove();
    }
  });
  
  function initCalendar(id) {
    var locale = "${pageContext.response.locale}";
    locale = locale.split('_')[0];
    new xmoCalendar({
      inputId : '#' + id,
      // lang : 'EN',
      lang : locale, //"zh" "en"
      type : "OnlySelectDate",
      initTime : $("#" + id).val(),
      //  menu:["last_7_days","last_30_days","this_week","this_month","this_yeah","last_week","last_month","last_3_month"],
      submitCallback : function() {
        //update_days_remaining(id);
      },
    })
  }
  
  function getFile(thi, path, url) {
    // button widths are different depending on locale...
    var width = 105;
    if (locale == "en") {
      width = 146;
    }
    
    if ($(thi).parents(".label-input").find("a").length == 0) {
      $(thi).prev().text('<s:message code="body.certificate.reupload" />');
      $(thi).width(width);
    } else {
      $(thi).parents(".label-input").find("a").remove(); // remove view link
      $(thi).parents(".label-input").find("div:last").remove(); // remove view popover
    }
    var name = $(thi).attr("id") + "-realPath";
    var docName = $(thi).parents(".control-group").children("label.control-label").text();
    
    // create view link and view popover:
    var img = $('<div style="display:none"><input name="'+name+'" value="'+path+'" type="hidden" /><img src="${path}'+url+'" ></div>');
    $(thi).parents(".label-input").append(img);
    $(thi).parents(".label-input").append('<a class="btn btn-default" title="' + docName + '" tabindex="0" role="button" data-toggle="popover"'
      + 'data-trigger="click" style="padding:0 15px;vertical-align:top;line-height:30px;min-height:28px;height:28px;"><s:message code="body.certificate.see"/></a>');
    
    $('[data-toggle="popover"]', $(thi).parents(".label-input")).popover({
      html : true,
      title : docName,
      delay : {
        "show" : 500,
        "hide" : 100
      },
      content : $(img).html()
    });

    $(thi).parent().find("label").remove();
    
    // Display success message:
    SSP.notification(docName + ': <s:message code="form.certificate.uploaded.success"/>', "success");
  }
</script>