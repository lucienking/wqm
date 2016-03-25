<%@ page contentType="text/html;charset=UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id="accordionPanelContent" class="easyui-panel" style="border:0 solid #FFFFFF;">
	<ul id= "statisticTree" class="easyui-tree" data-options="url:'/wqm/show/getStatisticTree',method:'get'"> 
	</ul>
</div>
<script>
$(function(){
	$('#statisticTree').tree({
		onClick: function(node){
			if($('#statisticTree').tree('isLeaf',node.target)){
				openTab(node,node.text);
			} 
		} 
	});  
});
function openTab(node,tabName){
	var title = node.text;
	if(title.substring(0,5)=="<span")
		title = title.substring(title.indexOf(">") + 1,title.indexOf("</"));
	var url = '/wqm'+node.attributes.url;
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
		var tab = $('#frontMainTabs').tabs('getTab',title);   
		$('#frontMainTabs').tabs('select',title);   
	}else{
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