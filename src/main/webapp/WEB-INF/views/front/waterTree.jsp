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
	var tabName = "${tabName}";
	$('#'+treeId).tree({
		onClick: function(node){
			if($('#'+treeId).tree('isLeaf',node.target)){
				openTab(node,tabName);
			}else if(!$('#'+treeId).tree('isLeaf',node.target)&& node.attributes.openTab=="Y"){
				$('#'+treeId).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
				openTab(node,tabName);
			}else{
				$('#'+treeId).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
				return;
			}
		},
		onLoadSuccess:function(node,data){  
            $('#'+treeId+" li:eq(0)").find("div").addClass("tree-node-selected");  
            var n = $('#'+treeId).tree("getSelected"); 
            $('#'+treeId+" li:eq(0)").find("div").removeClass("tree-node-selected");  
            if(n!=null){  
            	$('#'+treeId).tree('expand', n.target);
            	$(".tabs-title").each(function(index, obj) {
                  var tab = $(this).text();
                  if(tab!="首页") $("#frontMainTabs").tabs('close', tab);
             	 });
            	openTab(n,tabName);
            }  
        }  
	});  
});
function openTab(node,tabName){
	var title = tabName;
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
		var tab = $('#frontMainTabs').tabs('getTab',title);   
		tab.panel('refresh', url);
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