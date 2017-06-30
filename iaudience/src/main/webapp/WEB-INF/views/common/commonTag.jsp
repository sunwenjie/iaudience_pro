 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
 <%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <!-- 工程路径 -->
 <c:set var="path" value="${pageContext.request.contextPath}"/>
 <!-- 静态资源路径 后续会改 -->
 <c:set var="static_path" value="${pageContext.request.contextPath}" />
 <c:set var="v_time" value="20160425" />
