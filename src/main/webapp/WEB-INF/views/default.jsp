<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/public/common.jsp"%>
<html>
<head>
<title>智慧农场土地管理信息系统</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<style>
.frosted_glass{
	position:absolute;
	height:100%;
	width:600px;
	top:0px;
	left:0px;
	background-color:#fff;
	overflow:hidden;
	filter:alpha(opacity=50); 
	-moz-opacity:0.5; 
	opacity:0.5;
}
.frosted_glass #title{
	margin:25px 0px 0px 60px;
}
</style>
</head>
<body class="easyui-layout" data-options="fit: true">

<!-- header头部 -->
	<div data-options="region:'north',collapsible:false,split:false" style="height: 100px;background:url('${ctx }/static/image/backimage.png');background-position:center;background-repeat: repeat-x;overflow:hidden;position:relative;z-index:-5;">
		<div class="frosted_glass">
	        <div id="title">
		        <img src="${ctx }/static/image/sheld_icons.png" width="60" height="60"/>
		        <h1>海口市水务局水体质量监测后台管理系统</h1>
	        </div>
	    </div>
		<span style="float: right; font-size: 12px; padding-top: 80px; padding-right: 10px;">
			当前登录：${userName }
			
			<a href="#"  onclick="openIframeWindow(this)" title="修改密码" width="400" height="200" style="color: blue;">修改密码</a>
			<a href= "" style="color: blue;" htmlEscape="true" >退出登录</a>
		</span>
	</div>
	
<!-- left左部菜单栏 -->
	<div data-options="region:'west',split:false,title:'菜单栏'"	style="width: 220px;">
		<div class="easyui-panel" style="padding:5px;height:100%;border:0 solid #FFFFFF">
			<ul id= "menuTree" class="easyui-tree"  data-options="url:'${ctx }/sys/menu/getMenus',method:'get'"> 
			</ul>
		</div>
	</div>
	
<!-- center主要内容-->
	<div data-options="region:'center',border:false">
		<div id="mainTabs">
			<div id="workbench" title="工作台" style="padding: 10px">	</div>	
		</div>
		<div id="tabMenu" style="width: 120px; display: none;">
			<div data-options="name:'closeOthers'">关闭其他标签</div>
			<div data-options="name:'closeAll'">关闭所有标签</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px;text-align:center;font-size: 10px;color:gray;">©2015 海口水务 copyright </div>

<script>
/*
 * 菜单栏点击事件
 */
 var ctx = "${ctx}";
 $('#workbench').load(ctx+"/admin/index");
 $('#menuTree').tree({
	onClick: function(node){
		if($('#menuTree').tree('isLeaf',node.target)){
			var title = node.text;
			var url = '${ctx}'+node.attributes.url;
			var openType = node.attributes.openType;
			var id = url.replace(new RegExp("/","g"), "");
			$('#mainTabs').tabs({
				fit:true,
				cache:false,
				onBeforeClose:function(param){
					$('#mainButtomDiv').nextAll('div').each(function(index,elem){
						this.remove();
					});  //关闭后 清除拼接在body后的dialog
				}
				});
			var flag = $("#mainTabs").tabs('exists', title);
			if (flag) {
				$("#mainTabs").tabs('select', title);
			} else if(!flag && openType == "IFRAME" ) {
				var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:99%;height:99%;"></iframe>';  
				$('#mainTabs').tabs('add',{
					id:id,
					title:title,
					content:content,
					closable:true  
				});
			}else if(!flag && openType == "HREF" ) {
				$('#mainTabs').tabs('add',{
					id:id,
					title:title,
					href:url,
					closable:true, 
					cache:true
				});
			}
			return;
		}else{
			$('#menuTree').tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
			return;
		}
	}
});  
</script>
<div id="mainButtomDiv" ></div>
</body>
</html>