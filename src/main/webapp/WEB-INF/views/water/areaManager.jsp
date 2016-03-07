<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "areaContainer">
<div id="areaSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="areaSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_areaName">区域名称</label>
					<input id="search_areaName" name="name" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_areaCode">区域编码</label>
					<input id="search_areaCode" name="code" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_areaIsLeaf">区域类型</label>
					<select id="search_areaIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
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
				   <a class="easyui-linkbutton" href="#" id="areaSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				    <a class="easyui-linkbutton" href="#" id="areaResetButton">&nbsp;重&nbsp;置&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="areaSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="areaDatagrid" style="width:100%;"></table>
</div>
<div id="areaDataDialog"  style="display:none">
	<form id="areaDataForm" style="margin:10px" >
		<input type="hidden" id="areaId" name="id"  ></input>
		<input type="hidden" id="areaSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			区域名称：
			<input id="areaName" name="name"  class="easyui-textbox" style="width:120px;"/>
			区域状态：
			<input id="areaStatus" name="areaStatus" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			区域图标：
			<input id="areaIconCls" name="iconCls" value="" class="easyui-textbox" style="width:120px;"/>
			区域类型：
			<select id="areaIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
			    <option value="false" selected="selected">区域</option>
			    <option value="true">断面</option>
			</select>
		</div>
		<div class="line-div">
			区域顺序：
			<input id="areaSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			父区域号：
			<input id="areaParentId" name="parentId" style="width:120px;" />
		</div>
		<div class="line-div">
			区域链接：
			<input id="areaUrl" name="areaUrl" class="easyui-textbox" style="width:310px;"/>
		</div>
	</form>
</div>

<div id="area_toolbar">
	<jksb:hasAutority authorityId="007001001">
		<a href="javascript:areaAddData()" id = "areaAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="javascript:areaEditData()" id = "areaEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:areaDeleData()" id = "areaDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "areaEnableButton" class="easyui-linkbutton" data-options="iconCls:'pic_17',plain:true,disabled:true" >启用</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "areaDisableButton" class="easyui-linkbutton" data-options="iconCls:'pic_18',plain:true,disabled:true" >停用</a>
	</jksb:hasAutority>
</div>

<div id="dataDialog2"  >
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#areaDatagrid').datagrid({
    url:"${ctx}/area/area/getAreasPage",
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
    queryParams:$('#areaSearchConditionForm').getFormData(), 
    toolbar:"#area_toolbar",					//根据权限动态生成按钮
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
	onSelect: function(index,row){areaSelectChange(index,row);},
	onUnselect: function(index,row){areaSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	areaDataDialog("区域编辑",row);
    } 
});

function areaSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#areaDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#areaEditButton").linkbutton("enable");
		$("#areaDeleButton").linkbutton("enable");
		if($('#areaDatagrid').datagrid('getSelected').areaStatus == '0')
			$("#areaEnableButton").linkbutton("enable");
		else if($('#areaDatagrid').datagrid('getSelected').areaStatus == '1')
			$("#areaDisableButton").linkbutton("enable");
		
	}else if(selectedNum==0 ){
		$("#areaDeleButton").linkbutton("disable");
		$("#areaEditButton").linkbutton("disable");
		$("#areaEnableButton").linkbutton("disable");
		$("#areaDisableButton").linkbutton("disable");
	}else{
		$("#areaEditButton").linkbutton("disable");
		$("#areaEnableButton").linkbutton("disable");
		$("#areaDisableButton").linkbutton("disable");
	}
}

$('#areaSearchButton').click(function(){
	$('#areaDatagrid').datagrid('load',$('#areaSearchConditionForm').getFormData());
});

function areaAddData(){
	areaDataDialog("区域新增",null);		 
	// dataDialog2("区域新增",null);  
}
function areaEditData(){
	var selected = $('#areaDatagrid').datagrid('getSelected');
	areaDataDialog("区域编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  area对象由DataGrid 传送 
	// dataDialog2("区域编辑",selected);  //该方法 弹出对话框内容为另一页面，area对象由后台传送
}
function areaDeleData(){
	var selections = $('#areaDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/area/area/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#areaDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function areaSave(){
	var saveType =$("#areaSaveType").val();
	if(checkNotNull('areaName',"区域名称")&&checkNotNull('areaAuthorId',"区域权限")){
		$.ajax({
			type: "POST",
			url:"${ctx}/area/area/"+saveType,
			data:$('#areaDataForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#areaDataDialog").dialog("close");
		   		$("#areaDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#areaDataDialog").dialog("close");
			    $("#areaDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

/**
 * 本页面内DIV Dialog
 */
function areaDataDialog(title,selected){
	clearAreaForm();
	if(selected!=null)
		setAreaFormValue(selected);
	$("#areaDataDialog").show(); //先显示，再弹出
    $("#areaDataDialog").dialog({
        title: title,
        width: 450,
        height: 250,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){areaSave();}
		},{
			text:'取消',
			handler:function(){$("#areaDataDialog").dialog("close");}
		}]
    });
}

function setAreaFormValue(selected){
	 $("#areaName").textbox('setValue',selected.name);
	 $("#areaStatus").textbox('setValue',selected.areaStatus);
	 $("#areaUrl").textbox('setValue',selected.areaUrl);
	 $("#areaUrl").textbox('readonly',true);
	 $("#areaIconCls").textbox('setValue',selected.iconCls);
	 $("#areaOpenType").combobox('setValue',selected.openType);
	 $("#areaIsLeaf").combobox('setValue',(selected.isLeaf).toString());
	 $('#areaParentId').combobox('reload'); 
 	 $('#areaParentId').combobox('setValue', selected.parentId );
	 $("#areaSortNum").textbox('setValue',selected.sortNum);
	 $("#areaAuthorId").textbox('setValue',selected.authorId);
	 $("#areaId").val(selected.id);
	 $("#areaSaveType").val("update");
}
function clearAreaForm(){
//	 $("#areaDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#areaName").textbox('setValue',"");
	 $("#areaStatus").textbox('setValue',"");
	 $("#areaUrl").textbox('setValue',"/");
//	 $("#areaOpenType").combobox('setValue',"HREF");
	 $("#areaIconCls").textbox('setValue',"");
	 $("#areaIsLeaf").combobox('setValue',"false");
	 $('#areaParentId').combobox('reload'); 
	 $('#areaParentId').combobox('setValue', '0');
	 $("#areaSortNum").textbox('setValue',"1");
	 $("#areaAuthorId").textbox('setValue',"");
	 $("#areaId").val("");
	 $("#areaSaveType").val("create"); 
}

/**
 * 设置分页
 */
var p = $('#areaDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
 * 父区域选项
 */
$("#areaParentId").combobox({
    url:'${ctx}/area/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

$("#search_parentId").combobox({
    url:'${ctx}/area/area/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});


// /*
//  * 必填项检测
//  主要检测区域名称及权限
//  */
// function requiredCheck(){
// 	if($('#areaName').val()==""){
// 		$.messager.alert("出错！","请填写区域名称",'error',focusAreaName);
// 	}else if($('#areaAuthorId').val()==""){
// 		$.messager.alert("出错！","请填写区域权限",'error',focusAreaAuthor);
// 		$('#areaAuthorId').focus();
// 	}else{
// 		return true;
// 	}
// }
// /*
//  * 获取区域名称焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusAreaName=function(){
// 	$('#areaName').textbox().next('span').find('input').focus();
// }
// /*
//  * 获取区域权限焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusAreaAuthor=function(){
// 	$('#areaAuthorId').textbox().next('span').find('input').focus();
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

$("#areaEnableButton").click(function(){
	 areaEnableDisable("1");
});
$("#areaDisableButton").click(function(){
	 areaEnableDisable("0");
});
function areaEnableDisable(status){
	var selected = $('#areaDatagrid').datagrid('getSelected');
	$.ajax({
		type: "GET",
		url:"${ctx}/area/area/updateStatus",
		data:{"id":selected.id,"areaStatus":status},  
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   		$("#areaDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#areaDatagrid").datagrid('reload');
	    }
	}); 	
}
</script>
</div>
