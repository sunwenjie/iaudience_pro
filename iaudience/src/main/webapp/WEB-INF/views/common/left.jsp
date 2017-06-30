<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<div class="x-sidebar" id="x-sidebar">
    <ul class="x-menu">
        <li  class="selected">
            <a href="${path}/audiencePlan">
                <i class="fa fa-users" aria-hidden="true"></i>
                <span class="x-m8"> <s:message code="common.menu.left.audiencePlans" /></span>
            </a>
        </li>

        <li  class="">
            <a href="${path}/audienceAnalysis/marketAnalysis">
                <i class="fa fa-bar-chart" aria-hidden="true"></i>
                <span class="x-m8"><s:message code="common.menu.left.audienceAnalysis" /></span>
                <i class="fa fa-caret-down fa-fw" aria-hidden="true"></i>
            </a>
            <ul class="sub-menu">
                <li class="">
                    <a href="${path}/audienceAnalysis/marketAnalysis"><span class="x-m8"><s:message code="common.menu.left.market" /></span></a>
                </li>
                <li class="active">
                    <a href="${path}/audienceAnalysis/brandAnalysis"><span class="x-m8"><s:message code="common.menu.left.myBrand" /></span></a>

                </li>
            </ul>
        </li>
    </ul>
    <ul class="x-menu-lang-select">
        <li>
            <a href="javascript:void(0);" onclick="change_lang('zh');">
                <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                <span class="x-m8">简体中文</span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);" onclick="change_lang('en');">
                <i class="fa fa-cog fa-globe" aria-hidden="true" style="visibility:hidden;"></i>
                <span class="x-m8">language English</span>
            </a>
        </li>
    </ul>
    <ul class="x-menu-lang">

        <li>
            <a href="javascript:;">
                <i class="fa fa-cog fa-globe" aria-hidden="true"></i>
                <span class="x-m8"><s:message code="common.language"/></span>
            </a>
        </li>
    </ul>
</div>
<script type="text/javascript">
    $(function () {
        locale = "${pageContext.response.locale}";
        locale = locale.split("_")[0];
        $(".x-lang-" + locale).addClass("selected");

        var url = window.location.href;
        if (url.indexOf("?") > -1) {
            url = url.split("?")[0];
        }
        var paramsArr = url.split("/");

        $(".x-menu>li>a").each(function () {
            if ($(this).attr("href").indexOf(paramsArr[3] + "/" + paramsArr[4] + "/") > 0) {
                $(this).parent().addClass("selected");
            } else {
                $(this).parent().removeClass("selected");
            }
        });

        /*   if ("
        ${notificationSuccess}" != "") {
         SSP.notification("
        ${notificationSuccess}", "success");
         }
         if ("
        ${notificationInfo}" != "") {
         SSP.notification("
        ${notificationInfo}", "info");
         }
         if ("
        ${notificationError}" != "") {
         SSP.notification("
        ${notificationError}", "error");
         }
         if ("
        ${notificationWarning}" != "") {
         SSP.notification("
        ${notificationWarning}", "warning");
         } */
    });


    function change_lang(type) {
        var url = window.location.href;
        var paramsArr = [];
        var locHref = "";
        if (url.indexOf("?") > -1) {
            var urlArr = url.split("?");
            var locale = 0;
            paramsArr = urlArr[1].split("&");

            for (var i = 0; i < paramsArr.length; i++) {
                if (paramsArr[i].indexOf("locale") > -1) {
                    paramsArr[i] = "locale=" + type;
                    locale = 1;
                }
            }
            (locale == 0) ? (locHref = url + "&locale=" + type) : (locHref = urlArr[0] + "?" + paramsArr.join("&"));
        } else {
            locHref = url + "?locale=" + type;
        }
        window.location = locHref;
    }
</script>

        