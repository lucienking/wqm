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
<link href="${ctx}/static/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet" />
<link href="${ctx}/static/jquery-easyui/themes/default/easyui.css" type="text/css" rel="stylesheet" />
<script src="${ctx }/static/jquery-easyui/jquery.easyui.min.js"></script>
<script src="${ctx }/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>

<!-- 自定义JS,css引用 -->
<script src="${ctx }/static/js/jksb.land.common.js"></script>
<script src="${ctx }/static/js/jksb.land.validate.js"></script>
<link href="${ctx }/static/styles/default.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/static/styles/iconstyle.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/static/styles/echarts-land.css" type="text/css" rel="stylesheet" />

<script src="${ctx }/static/js/jksb.land.fileupload.js"></script>

