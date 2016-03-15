<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/public/common.jsp"%>
<html>
<head>
<title>海口市水务局水体质量监测系统</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link type="text/css" href="${ctx }/static/styles/front/header_footer.css" rel="Stylesheet" />
<link rel="stylesheet" href="${ctx }/static/arcgisApi/3.16compact/dijit/themes/claro/claro.css">
<link rel="stylesheet" href="${ctx }/static/arcgisApi/3.16compact/esri/css/esri.css">
<link type="text/css" href="${ctx }/static/styles/front/map.css" rel="Stylesheet" />
</head>
<body class='claro'>
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
        	<div  class="easyui-panel" style="width:99%;height:30%;margin:2px 1px 1px 3px;border-radius: 7px;">
        		<div style="width:99%;text-align:center;margin-top:2px;"><b>统计信息</b></div> 
        		<div style="width:95%;margin-top:10px;;margin-left:5px;">
        			治理状况： 
        			<select id="waterIsManaged" class="easyui-combobox" name="isManaged" style="width:100px">
					    <option value="" selected="selected">-请选择-</option>
					    <option value="N">未治理</option>
					    <option value="Y">已治理</option>
					    <option value="M">治理中</option>
					</select>
				</div>
				<div style="width:95%;margin-top:5px;;margin-left:5px;">
					<label for="search_userName">筛选条件： </label>
					<input id="search_userName" name="userName" class="easyui-textbox" style="width:100px;"/>
				</div>
				<div style="width:95%;margin-top:5px;;margin-left:5px;">
					<label for="search_userName">筛选条件： </label>
					<input id="search_userName" name="userName" class="easyui-textbox" style="width:100px;"/>
				</div>
				<div style="width:95%;margin-top:5px;;margin-left:5px;">
					<label for="search_userName">筛选条件： </label>
					<input id="search_userName" name="userName" class="easyui-textbox" style="width:100px;"/>
				
				</div>
				<div style="width:99%;margin-top:10px;text-align:center;">
					 <a class="easyui-linkbutton" href="#" id="monitorDataStautsQuery">&nbsp;查&nbsp;询&nbsp;</a>
				</div>
        	</div>
        	<div  class="easyui-panel" style="width:99%;height:68%;margin:2px 1px 10px 3px;border-radius: 7px;">
        		<div style="width:99%;text-align:center;margin-top:2px;"><b>详细信息</b></div> 
        	</div>
        </div>
        <div data-options="region:'west'" style="width:250px;">
        	<div class="easyui-panel" style="padding:5px;height:100%;border:0 solid #FFFFFF">
				<ul id= "indexTree" class="easyui-tree"  data-options="url:'${ctx }/show/getWaterTree',method:'get'"> 
				</ul>
			</div>
        </div>
        <div data-options="region:'center',iconCls:'icon-ok'" style="padding:5px;">
        	<div id="navToolbar" data-dojo-type="dijit/Toolbar">
        	</div>
        	<div id="map">
        		<div id="homeButton"></div>
			</div>
			<div id="info">
				<div id="legend"></div>
			</div>
        </div>
    </div>
    <script src="${ctx }/static/arcgisApi/3.16compact/init.js"></script>
	<script src="${ctx }/static/js/map/monitoring_points.js"></script>
	<script>
/*
 * 菜单栏点击事件
 */
/*  var ctx = "${ctx}";
 $('#indexTree').tree({
	onClick: function(node){
		if($('#indexTree').tree('isLeaf',node.target)){
			
			alert("调用地图");
			return;
		}else{
			$('#indexTree').tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
			return;
		}
	}
}); 
  */
</script>
</body>
</html>
