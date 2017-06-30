<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
    <%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
        <!--头部-->
        <div class="myheading">
            <nav class="navbar navbar-inverse">
                <div class="x-navbar">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a href="http://xmostg.optimix.asia/" class="navbar-brand" data-toggle="offcanvas">
                                <img src="http://xmostg.optimix.asia/images/logo/xmo.optimix.asia.png"
                                alt="" style="" width="120" height="50">
                            </a>
                        </div>
                        <div class="collapse navbar-collapse clearfix" id="bs-example-navbar-collapse-1">
                            <!-- Single button -->
                            <%@ include file="/WEB-INF/views/advertiser/select-list.jsp" %>
                                <div class="x-top-menu">
                                    <ul class="nav navbar-nav">

                                        <li class="">
                                            <a href="javascript:void(0);">
                                                <s:message code="common.head.iAccess" />
                                            </a>
                                        </li>
                                        <li class="selected" style="display: block;">
                                            <a href="${path}/audiencePlan">
                                                <s:message code="common.head.iAudience" />
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- Single button -->
                                <div class="x-user-main  navbar-right">
                                    <div class="x-user-con" style="max-width: 135px; background: none">
                                        <!-- <img class="x-user " src="https://git.bznx.net/assets/logo-white-ed4a8c29c69c582954818a833b737e7a.png"> -->
                                        <span class="x-user-dis">
                                            <i class="fa fa-user" style="color: #666;" aria-hidden="true">
                                            </i>
                                            &nbsp;
                                            ${sessionScope.user.name}
                                        </span>
                                        <i class="fa fa-caret-down fa-fw head_drop_down" aria-hidden="true">
                                        </i>
                                    </div>
                                    <ul class="x-user-list">
                                        <span class="nav-arrow">
                                        </span>
                                        <%--<li>--%>
                                            <%--<a href="#" class="x-user-config">--%>
                                                <%--<i class="fa fa-user-o icon_setting">--%>
                                                <%--</i>--%>
                                                <%--<s:message code="main.decorator.user.accountinfo" />--%>
                                            <%--</a>--%>
                                        <%--</li>--%>
                                        <%--<li>--%>
                                            <%--<a href="#" class="x-user-config">--%>
                                                <%--<span class="fa fa-lock icon_setting">--%>
                                                <%--</span>--%>
                                                <%--<s:message code="main.decorator.user.changepass" />--%>
                                            <%--</a>--%>
                                        <%--</li>--%>
                                        <li>
                                            <a href="${path}/login/logout" class="x-user-config">
                                                <span class="fa fa-sign-out icon_setting"></span><s:message code="main.decorator.user.logout" />
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <%--<div class="navbar-form navbar-right">--%>
                                    <%--<a href="javascript:void(0);">--%>
                                        <%--<i class="fa fa-question-circle" aria-hidden="true">--%>
                                        <%--</i>--%>
                                        <%--&nbsp;--%>
                                        <%--<s:message code="main.decorator.nav.faqs" />--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                                <div class="x-user-main navbar-right">
                                    <div class="x-user-con" style="max-width: 135px; background: none; position: relative;">
                                        <span class="fa fa-bell" style="color: #acb0bc; font-size: 24px; line-height: 32px; padding: 5px;"
                                        aria-hidden="true">
                                        </span>
                                        &nbsp;
                                        <i class="bell-tip" aria-hidden="true" style="position: absolute; top: 5px; right: 12px;">
                                            2
                                        </i>
                                    </div>
                                    <ul class="x-user-list" style="width: 350px; left: -150px;" id="notifys">
                                        <span class="nav-arrow" style="left: 50%">
                                        </span>
                                        <li>
                                           <%--  <a href="${path}/message/list" style="width: 360px; display: inline-block; font-weight: bold">
                                                <spring:message code="symphony.notification.all_message" />
                                            </a> --%>
                                        </li>
                                        <hr style="margin: 5px 0">
                                        <div style="height: 33px; text-align: center;">
                                            <label style="line-height: 33px; color: #acb0bc;">
                                                <s:message code="symphony.notification.no_unread_message" />
                                            </label>
                                        </div>
                                    </ul>
                                </div>
                        </div>
                    </div>
                </div>
            </nav>
        </div>