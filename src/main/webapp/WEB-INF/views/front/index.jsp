<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/public/common.jsp"%>
<html>
<head>
<title>水质监测系统</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link type="text/css" href="static/styles/front/header_footer.css" rel="Stylesheet" />
<link rel="stylesheet" href="http://jsapi.thinkgis.cn/dijit/themes/nihilo/nihilo.css">
<link rel="stylesheet" href="http://jsapi.thinkgis.cn/esri/css/esri.css">
<link type="text/css" href="static/styles/front/map.css" rel="Stylesheet" />
</head>
<body>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'north'" style="height:100px">
        	<div id="north">
	        	<div class="frosted_glass">
	        		<div id="title"><h1>海口市水务局水体质量监测系统</h1></div>
	        	</div>
	        	<div class="logout_div">
	        		<div class="re_div">
		        		<div class="login_info">当前登录：${userName }</div>
		        		<div class="login_info"><a href="#">退出登录</a></div>
		        		<div class="login_info"><a href="#">修改密码</a></div>
	        		</div>
	        	</div>
        	</div>
        </div>
        <div data-options="region:'south'" style="height:30px;text-align:center;font-size: 10px;color:gray;">
        	©2015 海口市龙华区水务局 copyright
        </div>
        <div data-options="region:'east'" style="width:210px;">
        	
        </div>
        <div data-options="region:'west'" style="width:250px;">
        	
        </div>
        <div data-options="region:'center',iconCls:'icon-ok'" style="padding:5px">
        	<div id="map">
			</div>
			<div id="info">
				<div id="legend"></div>
			</div>
        </div>
    </div>
 	<script src="http://jsapi.thinkgis.cn/init.js"></script>
	<script src="static/js/map/monitoring_points.js"></script>
</body>
</html>
