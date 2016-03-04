<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "monitorItemContainer">
<div id="monitorItemSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="monitorItemSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorItemName">区域名称</label>
					<input id="search_monitorItemName" name="name" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorItemCode">区域编码</label>
					<input id="search_monitorItemCode" name="code" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorItemIsLeaf">区域类型</label>
					<select id="search_monitorItemIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
						<option value="" selected="selected">--请选择--</option>
					    <option value="false">区域</option>
					    <option value="true">断面</option>
					</select>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_userName">操作员</label>
					<input id="search_userName" name="userName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="10%" align="center" style="min-width:150px">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="4"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="monitorItemSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				    <a class="easyui-linkbutton" href="#" id="monitorItemResetButton">&nbsp;重&nbsp;置&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="monitorItemSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="monitorItemDatagrid" style="width:100%;"></table>
</div>
<div id="monitorItemDataDialog"  style="display:none">
	<form id="monitorItemDataForm" style="margin:10px" >
		<input type="hidden" id="monitorItemId" name="id"  ></input>
		<input type="hidden" id="monitorItemSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			区域名称：
			<input id="monitorItemName" name="name"  class="easyui-textbox" style="width:120px;"/>
			区域状态：
			<input id="monitorItemStatus" name="monitorItemStatus" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			区域图标：
			<input id="monitorItemIconCls" name="iconCls" value="" class="easyui-textbox" style="width:120px;"/>
			区域类型：
			<select id="monitorItemIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
			    <option value="false" selected="selected">区域</option>
			    <option value="true">断面</option>
			</select>
		</div>
		<div class="line-div">
			区域顺序：
			<input id="monitorItemSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			父区域号：
			<input id="monitorItemParentId" name="parentId" style="width:120px;" />
		</div>
		<div class="line-div">
			区域链接：
			<input id="monitorItemUrl" name="monitorItemUrl" class="easyui-textbox" style="width:310px;"/>
		</div>
	</form>
</div>

<div id="monitorItem_toolbar">
	<jksb:hasAutority authorityId="007001001">
		<a href="javascript:monitorItemAddData()" id = "monitorItemAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="javascript:monitorItemEditData()" id = "monitorItemEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:monitorItemDeleData()" id = "monitorItemDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "monitorItemEnableButton" class="easyui-linkbutton" data-options="iconCls:'pic_17',plain:true,disabled:true" >启用</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "monitorItemDisableButton" class="easyui-linkbutton" data-options="iconCls:'pic_18',plain:true,disabled:true" >停用</a>
	</jksb:hasAutority>
</div>

<div id="dataDialog2"  >
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#monitorItemDatagrid').datagrid({
    url:"${ctx}/monitorItem/monitorItem/getMonitorItemsPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'name',title:'区域名称',width:'10%'},
        {field:'name',title:'区域编码',width:'10%'},
        {field:'status',title:'状态',width:'5%',formatter:function(value,rec){
        	if(value=="1")  
        		return "启用";
        	else if(value=="0")  		  
        		return "<span style='color:red'>停用</span>";
        }},
        {field:'sortNum',title:'排序',width:'5%'},
        {field:'isLeaf',title:'是否区域',width:'5%',formatter:function(value,rec){
        	if(value)  
        		return "区域";
        	else  		  
        		return "区域";
        }},
        {field:'parentId',title:'父区域',width:'5%'},
        {field:'authorId',title:'权限编码',width:'8%'},
        {field:'user',title:'操作员',width:'8%',formatter:function(value,rec){
        	if(rec.user)  
        		return rec.user.name;
        	else  		  
        		return "未知";
        }},
        {field:'createDate',title:'创建日期',width:'10%'},
        {field:'updateDate',title:'修改日期',width:'10%'}
    ]],
    queryParams:$('#monitorItemSearchConditionForm').getFormData(), 
    toolbar:"#monitorItem_toolbar",					//根据权限动态生成按钮
 /* toolbar: [{							//工具栏
    		id:'addButton',
    		text:'新增',
			iconCls: 'icon-add',
			handler: function(){addData();}
		},'-',{
			id:'editButton',
			text:'编辑',
			iconCls: 'icon-edit',
			disabled:true,
			handler: function(){editData();}
		},'-',{
			id:'deleButton',
			text:'删除',
			iconCls: 'icon-remove',
			disabled:true,
			handler: function(){deleData();}
	}], */
	onSelect: function(index,row){monitorItemSelectChange(index,row);},
	onUnselect: function(index,row){monitorItemSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	monitorItemDataDialog("区域编辑",row);
    } 
});

function monitorItemSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#monitorItemDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#monitorItemEditButton").linkbutton("enable");
		$("#monitorItemDeleButton").linkbutton("enable");
		if($('#monitorItemDatagrid').datagrid('getSelected').monitorItemStatus == '0')
			$("#monitorItemEnableButton").linkbutton("enable");
		else if($('#monitorItemDatagrid').datagrid('getSelected').monitorItemStatus == '1')
			$("#monitorItemDisableButton").linkbutton("enable");
		
	}else if(selectedNum==0 ){
		$("#monitorItemDeleButton").linkbutton("disable");
		$("#monitorItemEditButton").linkbutton("disable");
		$("#monitorItemEnableButton").linkbutton("disable");
		$("#monitorItemDisableButton").linkbutton("disable");
	}else{
		$("#monitorItemEditButton").linkbutton("disable");
		$("#monitorItemEnableButton").linkbutton("disable");
		$("#monitorItemDisableButton").linkbutton("disable");
	}
}

$('#monitorItemSearchButton').click(function(){
	$('#monitorItemDatagrid').datagrid('load',$('#monitorItemSearchConditionForm').getFormData());
});

function monitorItemAddData(){
	monitorItemDataDialog("区域新增",null);		 
	// dataDialog2("区域新增",null);  
}
function monitorItemEditData(){
	var selected = $('#monitorItemDatagrid').datagrid('getSelected');
	monitorItemDataDialog("区域编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  monitorItem对象由DataGrid 传送 
	// dataDialog2("区域编辑",selected);  //该方法 弹出对话框内容为另一页面，monitorItem对象由后台传送
}
function monitorItemDeleData(){
	var selections = $('#monitorItemDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/monitorItem/monitorItem/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#monitorItemDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function monitorItemSave(){
	var saveType =$("#monitorItemSaveType").val();
	if(checkNotNull('monitorItemName',"区域名称")&&checkNotNull('monitorItemAuthorId',"区域权限")){
		$.ajax({
			type: "POST",
			url:"${ctx}/monitorItem/monitorItem/"+saveType,
			data:$('#monitorItemDataForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#monitorItemDataDialog").dialog("close");
		   		$("#monitorItemDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#monitorItemDataDialog").dialog("close");
			    $("#monitorItemDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

/**
 * 本页面内DIV Dialog
 */
function monitorItemDataDialog(title,selected){
	clearMonitorItemForm();
	if(selected!=null)
		setMonitorItemFormValue(selected);
	$("#monitorItemDataDialog").show(); //先显示，再弹出
    $("#monitorItemDataDialog").dialog({
        title: title,
        width: 450,
        height: 250,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){monitorItemSave();}
		},{
			text:'取消',
			handler:function(){$("#monitorItemDataDialog").dialog("close");}
		}]
    });
}

function setMonitorItemFormValue(selected){
	 $("#monitorItemName").textbox('setValue',selected.name);
	 $("#monitorItemStatus").textbox('setValue',selected.monitorItemStatus);
	 $("#monitorItemUrl").textbox('setValue',selected.monitorItemUrl);
	 $("#monitorItemUrl").textbox('readonly',true);
	 $("#monitorItemIconCls").textbox('setValue',selected.iconCls);
	 $("#monitorItemOpenType").combobox('setValue',selected.openType);
	 $("#monitorItemIsLeaf").combobox('setValue',(selected.isLeaf).toString());
	 $('#monitorItemParentId').combobox('reload'); 
 	 $('#monitorItemParentId').combobox('setValue', selected.parentId );
	 $("#monitorItemSortNum").textbox('setValue',selected.sortNum);
	 $("#monitorItemAuthorId").textbox('setValue',selected.authorId);
	 $("#monitorItemId").val(selected.id);
	 $("#monitorItemSaveType").val("update");
}
function clearMonitorItemForm(){
//	 $("#monitorItemDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#monitorItemName").textbox('setValue',"");
	 $("#monitorItemStatus").textbox('setValue',"");
	 $("#monitorItemUrl").textbox('setValue',"/");
//	 $("#monitorItemOpenType").combobox('setValue',"HREF");
	 $("#monitorItemIconCls").textbox('setValue',"");
	 $("#monitorItemIsLeaf").combobox('setValue',"false");
	 $('#monitorItemParentId').combobox('reload'); 
	 $('#monitorItemParentId').combobox('setValue', '0');
	 $("#monitorItemSortNum").textbox('setValue',"1");
	 $("#monitorItemAuthorId").textbox('setValue',"");
	 $("#monitorItemId").val("");
	 $("#monitorItemSaveType").val("create"); 
}

/**
 * 设置分页
 */
var p = $('#monitorItemDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
 * 父区域选项
 */
$("#monitorItemParentId").combobox({
    url:'${ctx}/monitorItem/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

$("#search_parentId").combobox({
    url:'${ctx}/monitorItem/monitorItem/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});


// /*
//  * 必填项检测
//  主要检测区域名称及权限
//  */
// function requiredCheck(){
// 	if($('#monitorItemName').val()==""){
// 		$.messager.alert("出错！","请填写区域名称",'error',focusMonitorItemName);
// 	}else if($('#monitorItemAuthorId').val()==""){
// 		$.messager.alert("出错！","请填写区域权限",'error',focusMonitorItemAuthor);
// 		$('#monitorItemAuthorId').focus();
// 	}else{
// 		return true;
// 	}
// }
// /*
//  * 获取区域名称焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusMonitorItemName=function(){
// 	$('#monitorItemName').textbox().next('span').find('input').focus();
// }
// /*
//  * 获取区域权限焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusMonitorItemAuthor=function(){
// 	$('#monitorItemAuthorId').textbox().next('span').find('input').focus();
// }
var checkNotNull=function(ID,idName){
	var refId=$('#'+ID);
	if(refId.val()==""){
		$.messager.alert("出错！","请填写"+idName,'error',function(r){
			refId.textbox().next('span').find('input').focus();
		});
		return false;
	}else{
		return true;
	}
};

$("#monitorItemEnableButton").click(function(){
	 monitorItemEnableDisable("1");
});
$("#monitorItemDisableButton").click(function(){
	 monitorItemEnableDisable("0");
});
function monitorItemEnableDisable(status){
	var selected = $('#monitorItemDatagrid').datagrid('getSelected');
	$.ajax({
		type: "GET",
		url:"${ctx}/monitorItem/monitorItem/updateStatus",
		data:{"id":selected.id,"monitorItemStatus":status},  
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   		$("#monitorItemDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#monitorItemDatagrid").datagrid('reload');
	    }
	}); 	
}
</script>
</div>
