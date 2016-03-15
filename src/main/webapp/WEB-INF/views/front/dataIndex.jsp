<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/public/common.jsp"%>
<html>
<head>
<title>海口市智慧水务管理平台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link type="text/css" href="${ctx }/static/styles/front/header_footer.css" rel="Stylesheet" />
</head>
<body>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'north'" style="height:100px">
        	<div id="north">
	        	<div class="frosted_glass">
	        		<div id="title"><h1>海口市智慧水务管理平台</h1></div>
	        	</div>
	        	<div class="module_div">
	        		<div class="mo_div">
		        		<div class="module_info"><a href="#">水资源</a></div>
		        		<div class="module_info"><a href="#">水环境</a></div>
		        		<div class="module_info"><a href="#">供排水管理</a></div>
		        		<div class="module_info"><a href="#">水文</a></div>
		        		<div class="module_info"><a href="#">水利普查</a></div>
		        		<div class="module_info"><a href="#">工程项目</a></div>
		        		<div class="module_info"><a href="#">规划管理</a></div>
		        		<div class="module_info"><a href="#">地图管理</a></div>
	        		</div>
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
        <div data-options="region:'west'" style="width:250px;">
        	<div class="easyui-panel" style="padding:5px;height:100%;border:0 solid #FFFFFF">
				<ul id= "indexTree" class="easyui-tree"  data-options="url:'${ctx }/show/getWaterTree',method:'get'"> 
				</ul>
			</div>
        </div>
        <div data-options="region:'center',iconCls:'icon-ok',border:false" style="padding:5px;">
        	 <div id="mainTabs">
				<div id="monitorDataTab" title="监测数据" style="padding: 10px">	</div>	
			</div>
        </div>
    </div>
<script>
var ctx = "${ctx}";
$('#monitorDataTab').load(ctx+"/monitorData/monitorDataManager");


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