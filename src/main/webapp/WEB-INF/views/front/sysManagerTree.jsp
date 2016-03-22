<%@ page contentType="text/html;charset=UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="treeId" value="${treeId }" />
<div id="accordionPanelContent" class="easyui-panel" style="border:0 solid #FFFFFF;">
	<ul id= "${treeId }" class="easyui-tree"  data-options="url:'${url }',method:'get'"> 
	</ul>
</div>
<script>
$(function(){
	var treeId = "${treeId}";
	$('#'+treeId).tree({
		onClick: function(node){
			if($('#'+treeId).tree('isLeaf',node.target)){
				openTab(node);
			}else if(!$('#'+treeId).tree('isLeaf',node.target)&& node.attributes.openTab=="Y"){
				$('#'+treeId).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
				openTab(node);
			}else{
				$('#'+treeId).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
				return;
			}
		} 
	});  
});
function openTab(node){
	var title = node.text;
	if(title.substring(0,5)=="<span")
		title = title.substring(title.indexOf(">") + 1,title.indexOf("</"));
	var url = '/wqm'+node.attributes.url;
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