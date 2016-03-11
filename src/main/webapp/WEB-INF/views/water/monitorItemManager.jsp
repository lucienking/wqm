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
					<label for="search_monitorItemName">监测项名称</label>
					<input id="search_monitorItemName" name="name" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorItemCode">监测项编码</label>
					<input id="search_monitorItemCode" name="code" class="easyui-textbox" style="width:120px;"/>
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
				<td colspan="3"  width="90%" >
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
			监测项编码：
			<input id="monitorItemCode" name="code" class="easyui-textbox"  style="width:120px;" />
			监测项名称：
			<input id="monitorItemName" name="name"  class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			监测项顺序：
			<input id="monitorItemSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			监测项图标：
			<input id="monitorItemIconCls" name="iconCls" value="" class="easyui-textbox" style="width:120px;"/>
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
</div>

<div id="dataDialog2"  >
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#monitorItemDatagrid').datagrid({
    url:"${ctx}/monitorItem/getMonitorItemsPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'code',title:'监测项编码',width:'10%'},
        {field:'name',title:'监测项名称',width:'10%'},
        {field:'sortNum',title:'排序',width:'5%'},
        {field:'iconCls',title:'图标',width:'5%'},
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
    	monitorItemDataDialog("监测项编辑",row);
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
	monitorItemDataDialog("监测项新增",null);		 
	// dataDialog2("监测项新增",null);  
}
function monitorItemEditData(){
	var selected = $('#monitorItemDatagrid').datagrid('getSelected');
	monitorItemDataDialog("监测项编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  monitorItem对象由DataGrid 传送 
	// dataDialog2("监测项编辑",selected);  //该方法 弹出对话框内容为另一页面，monitorItem对象由后台传送
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
	    		url:"${ctx}/monitorItem/delete",
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
	if( true){
		$.ajax({
			type: "POST",
			url:"${ctx}/monitorItem/"+saveType,
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
        height: 160,
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
	 $("#monitorItemCode").textbox('setValue',selected.code);
	 $("#monitorItemIconCls").textbox('setValue',selected.iconCls);
	 $("#monitorItemSortNum").textbox('setValue',selected.sortNum);
	 $("#monitorItemId").val(selected.id);
	 $("#monitorItemSaveType").val("update");
}
function clearMonitorItemForm(){
//	 $("#monitorItemDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#monitorItemName").textbox('setValue',"");
	 $("#monitorItemCode").textbox('setValue',"");
	 $("#monitorItemIconCls").textbox('setValue',"");
	 $("#monitorItemSortNum").textbox('setValue',"1");
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
		url:"${ctx}/monitorItem/updateStatus",
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
