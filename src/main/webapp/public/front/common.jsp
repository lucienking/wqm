<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ResourceBundle"%> 
<%
	ResourceBundle res = ResourceBundle.getBundle("application"); 
%> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link type="image/x-icon" href="${ctx}/static/images/logo.ico" rel="shortcut icon">
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<!-- easyUI -->
<link href="${ctx}/static/styles/front/basic.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/styles/front/style.css" type="text/css" rel="stylesheet" />

