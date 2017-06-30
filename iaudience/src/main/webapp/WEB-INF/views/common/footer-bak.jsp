<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="i" uri="http://iax.optimix.asia/jsp/jstl/timezone"%>

<jsp:useBean id="now" class="java.util.Date" />
<sec:authentication property="principal.iaxUserDo.timeZone" var="timeZone"/>
<fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy" var="year" timeZone="${timeZone}"/>

<div class="clearfooter"></div>
<div class="myfooter">
  <label class="x-footer"> Copyright &copy; ${year} <a style="color:#c0c3cc;text-decoration:underline;" href="http://www.i-click.com/" target="_blank">iClick Interactive Asia Limited</a>. All Rights Reserved.
    <!--
	  <span>
      | <a target="_blank" href="/zh-cn/admin/send_file_upload_release_notes"><s:message code="footer.pleaseNote" /></a>
    </span>
	  <span>
      | <a target="_blank" href="/templates/xmo_help.pdf" onclick="_xmoIstag1();"><s:message code="footer.helpCenter" /></a>
    </span>
	  <span>
      | <a href="/zh-cn/privacy_policy"><s:message code="footer.privacy" /></a>
    </span>
	  -->
  </label>
  <label class="x-footer">
    iAX v<s:message code="footer.iax.version" /> (<s:message code="footer.suggest" /> Internet Explorer 8.0+, Chrome 8.0+, Firefox 3.5+, Safari 1.0+, Opera V11+)
  </label>
  <label class="x-footer">
    <s:message code="footer.time.zone.current" />: <i:displayTimeZone timeZoneId="${timeZone}"/>
  </label>
</div>