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

</head>
<body class="easyui-layout" data-options="fit: true">

<!-- header头部 -->
	<div data-options="region:'north',collapsible:false,split:false" style="height: 60px;background:url('${ctx }/static/image/background-repeater_01.png');background-repeat: repeat-x;overflow:hidden;position:relative;z-index:-5;">
		<img src="${ctx }/static/image/backimage.png" style="position:absolute;left:0px;top:0px;z-index:-4;">
		<img src="${ctx }/static/image/logo.png " style="width:80px;height:44px;position:absolute;top:10px;left:20px;z-index:-3;"/> 
		<img src="${ctx }/static/image/image-view.png" style="position:absolute;right:34em;z-index:-2;">
		<img src="${ctx }/static/image/name_03.png"	alt="sfmislogo" style="position:absolute;left:100px;top:0px;z-index:-1;"/> 
				
		<span style="float: right; font-size: 12px; padding-top: 30px; padding-right: 10px;">
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
	<div data-options="region:'south'" style="height:20px;text-align:center;font-size: 10px;color:gray;">©2015 海南农垦 copyright </div>

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