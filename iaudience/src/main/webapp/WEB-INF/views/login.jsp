<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/commonTag.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>login</title>
    <link rel="shortcut icon" href="/images/favicon.ico">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1,maximum-scale=1" />

    <link rel="stylesheet" type="text/css" href="${static_path}/css/google-font.css?v_time=${v_time}">
    <link rel="stylesheet" type="text/css" href="${static_path}/bootstrap/css/bootstrap.min.css?v_time=${v_time}">
    <link rel="stylesheet" type="text/css" href="${static_path}/css/bootstrap_iaccess.css?v_time=${v_time}">
    <link rel="stylesheet" type="text/css" href="${static_path}/css/font-awesome.min.css?v_time=${v_time}">
    <link rel="stylesheet" type="text/css" href="${static_path}/css/login.css?v_time=${v_time}">
    <link rel="stylesheet" type="text/css" href="${static_path}/js/jquery-validation/1.11.1/validate.css"  />

    <script type="text/javascript" src="${static_path}/js/jquery-1.7.1.min.js?v_time=${v_time}"></script>
    <script src="${static_path}/js/jquery-validation/1.14.0/dist/jquery.validate.js" type="text/javascript"></script>
    <script src="${static_path}/js/jquery-validation/1.14.0/dist/jquey.validate.override.js" type="text/javascript"></script>
    <%
        String lang = request.getLocale().getLanguage();
//        request.setAttribute("lang", lang);
        if(lang.equals("zh")){
    %>
    <script src="${static_path}/js/jquery-validation/1.14.0/dist/localization/messages_zh.js" type="text/javascript"></script>
    <%
        }
    %>
</head>
<body class="bg">
<div class="x-lang">
    <span><a href="${path}/login?locale=en" class="x-lang-en selected"></a></span>
    <span><a href="${path}/login?locale=zh" class="x-lang-zh"></a></span>
</div>

<div class="x-container">
    <div class="login-title">
        <div class="login-description">
            <img src="${static_path}/images/login/title.png" style="float:left;">
            <p>IAUDIENCE</p>
            <label>CHINA PROGRAMMATIC</label>
            <label>PREMIUM MOBILE INVENTORY</label>
            <label>ADVANCED TARGETING</label>
            <label style="font-size:12px">integrated in one platform</label>
        </div>
    </div>
    <div class="login-box clearfix">
        <div class="x-login">
            <img src="${static_path}/images/login/logo_iclick.png">
            <div class="x-logo col-xs-12">
                <span class="f-24"><s:message code="audiencePlan.login.welcome" /> <span style="color: red">IAUDIENCE</span></span>
            </div>
            <div class="x-login-warp">
                <form id="loginForm" action="${path}/login/doLogin" method="post" ><!--   -->
                    <input type="hidden" name="backurl" value=""/>
                    <div class="form-group has-feedback ">
                        <div class="input-group">
                    <span class="input-group-addon">
					            <span class="fa fa-user"></span>
                    </span>
                            <input type="text" name="username"  class='input-account form-control' placeholder="<s:message code="audiencePlan.login.emptyusername" />" value="${username}" autofocus />
                        </div>
                    </div>
                    <div class="form-group has-feedback ">
                        <div class="input-group">
                    <span class="input-group-addon">
					            <span class="fa fa-lock"></span>
                    </span>
                            <input type="password" name="password" class='input-password form-control' placeholder="<s:message code="audiencePlan.login.emptypassword" />" />
                        </div>
                    </div>
                    <%--<div class="form-group has-feedback ">--%>
                        <%--<div class="input-group code">--%>
                            <%--<input type="text"  class='input-code form-control' placeholder="请输入验证码" />--%>
                            <%--<img class="img-key" src="https://member.meizu.com/kaptcha.jpg?t=1409725454050">--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-group has-feedback">
                        <a href="javascript:void(0)" id="login_ok">
                            <input type="submit" class="btn btn-danger" value="<s:message code="audiencePlan.login.submit" />"/>
                        </a>
                        <div class="clear"></div>
                        <%--<div style="margin-top:10px;" class="text-center">--%>
                            <%--<label style="text-align:left;cursor:pointer;">--%>
                                <%--<input type="checkbox" value="1" name="remember" style="display:inline-block;">--%>
                                <%--Remember Me--%>
                            <%--</label>--%>
                        <%--</div>--%>

                        <%--<div style="margin-top:10px;" class="text-center">--%>
                            <%--<a class="x-link" href="#">无法登入您的帐户？</a>--%>
                        <%--</div>--%>
                        <c:if test="${not empty error}">
                        <label id="message" class="warning_msg">
                            <img src="${static_path}/images/login/asset_error.png" class="warning_icon">
                            <div class="warning" id="Message">${error}</div>
                        </label>
                        </c:if>
                    </div>
                </form>
            </div>

        </div>

        <div class="clearfix footer" >
            <p>Copyright © 2017 iClick Interactive Asia Limited. All Rights Reserved.</p>
        </div>
    </div>
    <div style="clear:both"></div>
</div>

</body>
<script type="text/javascript">
    $(document).ready(function() {
        $("#loginForm").validate({
            errorPlacement: function(error, element) {
                if (element.attr("name") == "jcaptchaCode") {
                    error.insertAfter("#jcaptchaCodeImg");
                }
                else if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            rules: {
                username:"required",
                password:"required",
//                jcaptchaCode:"required",
            }

        });


        <%--$(".jcaptcha-btn").click(function() {--%>
            <%--$(".jcaptcha-img").attr("src", '${pageContext.request.contextPath}/jcaptcha.jpg?'+new Date().getTime());--%>
        <%--});--%>
    });

</script>
</html>

