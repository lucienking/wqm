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
      	<div id="module_div" class="module_div">
      		<div class="mo_div">
       		<div class="module_info" ><a href="#" onclick="moduleOnclick('waterEnviromentAccordion')">水环境</a></div>
       		<div class="module_info" id="module_index"><a href="#" onclick="moduleOnclick('waterResourceAccordion')">水资源</a></div>
       		<div class="module_info"><a href="#">供排水</a></div>
       		<div class="module_info"><a href="#">水文</a></div>
       		<div class="module_info"><a href="#">水利普查</a></div>
       		<div class="module_info"><a href="#">工程项目</a></div>
       		<div class="module_info"><a href="#">规划管理</a></div>
       		<div class="module_info"><a href="#">地图管理</a></div>
      		</div>
      	</div>
      	<div class="logout_div">
      		<div class="re_div">
       		<div class="login_info">当前登录：${userName }
       			<input id="currentUserName" type="hidden" name="currentUserName" value="${userName }"/>
       		</div>
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
     	<div  id="westRegionAccordion" style="width:100%;">
     	</div>
     </div> 
     <div data-options="region:'center',iconCls:'icon-ok',border:false" >
     	 <div id="frontMainTabs">
			<div id="frontMainTab" title="首页" style="padding: 10px"></div>	
		 </div>
     </div>
 </div>
<script>
$(function(){
	 var ctx = "${ctx}";
	 $('#frontMainTabs').tabs({
		 border:false,
		 url:"${ctx}/admin/index"
	 });
	 $('#westRegionAccordion').accordion({
		    animate:false,
		    onSelect:function(title,index){
				if(title=="系统管理"&&$("#currentUserName").val()=="") {
					//window.location.href = "${ctx}/";
					//window.location.href = "${ctx}/login";
				}
			}
	 });
	 $("#module_index a").click();
});
function moduleOnclick(id){
	
	var array = "";  
	if(id == "waterEnviromentAccordion"){
		array = {'污水处理厂进出水':"",'市政污水提升泵站污水':"",'s水网动力工程地表水':"/wqm/show/getWaterTree?type=data%26showLeaf=Y",'饮用水源地':"",'自来水厂出水':"",'供水管网点':"",'中型水库':"",'主要河流':""};
	}else{
		array = {'水体信息':"",'s监测信息':"/wqm/show/getWaterTree?type=data%26showLeaf=N",'统计分析':"/wqm/show/statisticTree",'预警管理':"",'电子地图':"/wqm/show/getWaterTree?type=map%26showLeaf=Y",'系统管理':"/wqm/sys/menu/getMenus"};
	}
	closeAll();
	removeAllAccordion();
	var i = 0;
	$.each(array,function(name,value){
		var selected = false;
		if(name.substring(0,1)== 's'){
			name = name.substring(1);
			selected = true;
		}
		$('#westRegionAccordion').accordion('add', {
			title: name,
			href:"${ctx}/show/accordionPanelContent?treeId="+id+i+"&url="+value+"&tabName="+name,
			selected: selected
		});
		i++;
	});
}


function removeAllAccordion(){
	$(".panel-title").each(function(index, obj) {
		 var panel = $(this).text();
		 $('#westRegionAccordion').accordion("remove",panel);
	});
}

function closeAll() {
    $(".tabs-title").each(function(index, obj) {
          //获取所有可关闭的选项卡
        var tab = $(this).text();
        if(tab!="首页") $("#frontMainTabs").tabs('close', tab);
    });
}
function openTab(node){
	var title = node.text;
	var url = '${ctx}'+node.attributes.url;
	var openType = node.attributes.openType;
	var id = url.replace(new RegExp("/","g"), "");
	$('#frontMainTabs').tabs({
		fit:true,
		cache:false,
		onBeforeClose:function(param){
			$('#mainButtomDiv').nextAll('div').each(function(frontIndex,elem){
				this.remove();
			});  //关闭后 清除拼接在body后的dialog
		}
	});
	var flag = $("#frontMainTabs").tabs('exists', title);
	if (flag) {
		$("#frontMainTabs").tabs('select', title);
	}else if(!flag && openType == "HREF" ) {
		$('#frontMainTabs').tabs('add',{
			id:id,
			title:title,
			href:url,
			closable:true, 
			cache:true
		});
	} else{
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';  
		$('#frontMainTabs').tabs('add',{
			id:id,
			title:title,
			content:content,
			closable:true  
		});
	}
	return;
}
</script>
</body>
</html>
