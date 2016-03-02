<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "waterContainer">
<div id="waterSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="waterSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_waterName">水体名称</label>
					<input id="search_waterName" name="name" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_waterCode">水体编码</label>
					<input id="search_waterCode" name="code" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_waterIsLeaf">水体类型</label>
					<select id="search_waterIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
						<option value="" selected="selected">--请选择--</option>
					    <option value="false">区域</option>
					    <option value="true">水体</option>
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
				<td colspan="5"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="waterSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="waterSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="waterDatagrid" style="width:100%;"></table>
</div>
<div id="waterDataDialog"  style="display:none">
	<form id="waterDataForm" style="margin:10px" >
		<input type="hidden" id="waterId" name="id"  ></input>
		<input type="hidden" id="waterSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			水体名称：
			<input id="waterName" name="name"  class="easyui-textbox" style="width:120px;"/>
			水体状态：
			<input id="waterStatus" name="waterStatus" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			水体权限：
			<input id="waterAuthorId" name="authorId" class="easyui-textbox" style="width:120px;" data-option="required:true"/>
			水体类型：
			<select id="waterIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
			    <option value="false" selected="selected">栏目</option>
			    <option value="true">水体</option>
			</select>
		</div>
		<div class="line-div">
			水体顺序：
			<input id="waterSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			父水体号：
			<input id="waterParentId" name="parentId" style="width:120px;" />
		</div>
		<div class="line-div">
			水体图标：
			<input id="waterIconCls" name="iconCls" value="" class="easyui-textbox" style="width:120px;"/>
			打开方式：
			<!-- <select id="waterOpenType" class="easyui-combobox" name="openType" style="width:120px;">
			    <option value="IFRAME" selected="selected">iframe方式</option>
			    <option value="HREF">href方式</option>
			</select> -->
			<jksb:diction id="waterOpenType" name="openType" groupId="MENU_OPEN_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="IFRAME">
				&nbsp;
			</jksb:diction>
		</div>
		<div class="line-div">
			水体链接：
			<input id="waterUrl" name="waterUrl" class="easyui-textbox" style="width:310px;"/>
		</div>
	</form>
</div>

<div id="water_toolbar">
	<jksb:hasAutority authorityId="007001001">
		<a href="javascript:waterAddData()" id = "waterAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="javascript:waterEditData()" id = "waterEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:waterDeleData()" id = "waterDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "waterEnableButton" class="easyui-linkbutton" data-options="iconCls:'pic_17',plain:true,disabled:true" >启用</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "waterDisableButton" class="easyui-linkbutton" data-options="iconCls:'pic_18',plain:true,disabled:true" >停用</a>
	</jksb:hasAutority>
</div>

<div id="dataDialog2"  >
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#waterDatagrid').datagrid({
    url:"${ctx}/water/water/getWatersPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'name',title:'水体名称',width:'10%'},
        {field:'name',title:'水体编码',width:'10%'},
        {field:'status',title:'状态',width:'5%',formatter:function(value,rec){
        	if(value=="1")  
        		return "启用";
        	else if(value=="0")  		  
        		return "<span style='color:red'>停用</span>";
        }},
        {field:'sortNum',title:'排序',width:'5%'},
        {field:'isLeaf',title:'是否水体',width:'5%',formatter:function(value,rec){
        	if(value)  
        		return "水体";
        	else  		  
        		return "区域";
        }},
        {field:'parentId',title:'父水体',width:'5%'},
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
    queryParams:$('#waterSearchConditionForm').getFormData(), 
    toolbar:"#water_toolbar",					//根据权限动态生成按钮
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
	onSelect: function(index,row){waterSelectChange(index,row);},
	onUnselect: function(index,row){waterSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	waterDataDialog("水体编辑",row);
    } 
});

function waterSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#waterDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#waterEditButton").linkbutton("enable");
		$("#waterDeleButton").linkbutton("enable");
		if($('#waterDatagrid').datagrid('getSelected').waterStatus == '0')
			$("#waterEnableButton").linkbutton("enable");
		else if($('#waterDatagrid').datagrid('getSelected').waterStatus == '1')
			$("#waterDisableButton").linkbutton("enable");
		
	}else if(selectedNum==0 ){
		$("#waterDeleButton").linkbutton("disable");
		$("#waterEditButton").linkbutton("disable");
		$("#waterEnableButton").linkbutton("disable");
		$("#waterDisableButton").linkbutton("disable");
	}else{
		$("#waterEditButton").linkbutton("disable");
		$("#waterEnableButton").linkbutton("disable");
		$("#waterDisableButton").linkbutton("disable");
	}
}

$('#waterSearchButton').click(function(){
	$('#waterDatagrid').datagrid('load',$('#waterSearchConditionForm').getFormData());
});

function waterAddData(){
	waterDataDialog("水体新增",null);		 
	// dataDialog2("水体新增",null);  
}
function waterEditData(){
	var selected = $('#waterDatagrid').datagrid('getSelected');
	waterDataDialog("水体编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  water对象由DataGrid 传送 
	// dataDialog2("水体编辑",selected);  //该方法 弹出对话框内容为另一页面，water对象由后台传送
}
function waterDeleData(){
	var selections = $('#waterDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/water/water/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#waterDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function waterSave(){
	var saveType =$("#waterSaveType").val();
	if(checkNotNull('waterName',"水体名称")&&checkNotNull('waterAuthorId',"水体权限")){
		$.ajax({
			type: "POST",
			url:"${ctx}/water/water/"+saveType,
			data:$('#waterDataForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#waterDataDialog").dialog("close");
		   		$("#waterDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#waterDataDialog").dialog("close");
			    $("#waterDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

/**
 * 本页面内DIV Dialog
 */
function waterDataDialog(title,selected){
	clearWaterForm();
	if(selected!=null)
		setWaterFormValue(selected);
	$("#waterDataDialog").show(); //先显示，再弹出
    $("#waterDataDialog").dialog({
        title: title,
        width: 450,
        height: 250,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){waterSave();}
		},{
			text:'取消',
			handler:function(){$("#waterDataDialog").dialog("close");}
		}]
    });
}

function setWaterFormValue(selected){
	 $("#waterName").textbox('setValue',selected.name);
	 $("#waterStatus").textbox('setValue',selected.waterStatus);
	 $("#waterUrl").textbox('setValue',selected.waterUrl);
	 $("#waterUrl").textbox('readonly',true);
	 $("#waterIconCls").textbox('setValue',selected.iconCls);
	 $("#waterOpenType").combobox('setValue',selected.openType);
	 $("#waterIsLeaf").combobox('setValue',(selected.isLeaf).toString());
	 $('#waterParentId').combobox('reload'); 
 	 $('#waterParentId').combobox('setValue', selected.parentId );
	 $("#waterSortNum").textbox('setValue',selected.sortNum);
	 $("#waterAuthorId").textbox('setValue',selected.authorId);
	 $("#waterId").val(selected.id);
	 $("#waterSaveType").val("update");
}
function clearWaterForm(){
//	 $("#waterDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#waterName").textbox('setValue',"");
	 $("#waterStatus").textbox('setValue',"");
	 $("#waterUrl").textbox('setValue',"/");
//	 $("#waterOpenType").combobox('setValue',"HREF");
	 $("#waterIconCls").textbox('setValue',"");
	 $("#waterIsLeaf").combobox('setValue',"false");
	 $('#waterParentId').combobox('reload'); 
	 $('#waterParentId').combobox('setValue', '0');
	 $("#waterSortNum").textbox('setValue',"1");
	 $("#waterAuthorId").textbox('setValue',"");
	 $("#waterId").val("");
	 $("#waterSaveType").val("create"); 
}

/**
 * 设置分页
 */
var p = $('#waterDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
 * 父水体选项
 */
$("#waterParentId").combobox({
    url:'${ctx}/water/water/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

$("#search_parentId").combobox({
    url:'${ctx}/water/water/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

/**
 * 水体类型为栏目时 水体链接默认为"/" 不允许更改 
 */
$("#waterIsLeaf").combobox({
    onChange: function (n,o) { 
    	if(n == 'false') {
    		$("#waterUrl").textbox('setValue',"/");
    		$("#waterUrl").textbox("readonly",true); 
    	}else{
    		$("#waterUrl").textbox("readonly",false); 
    	}
    }
});

// /*
//  * 必填项检测
//  主要检测水体名称及权限
//  */
// function requiredCheck(){
// 	if($('#waterName').val()==""){
// 		$.messager.alert("出错！","请填写水体名称",'error',focusWaterName);
// 	}else if($('#waterAuthorId').val()==""){
// 		$.messager.alert("出错！","请填写水体权限",'error',focusWaterAuthor);
// 		$('#waterAuthorId').focus();
// 	}else{
// 		return true;
// 	}
// }
// /*
//  * 获取水体名称焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusWaterName=function(){
// 	$('#waterName').textbox().next('span').find('input').focus();
// }
// /*
//  * 获取水体权限焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusWaterAuthor=function(){
// 	$('#waterAuthorId').textbox().next('span').find('input').focus();
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

$("#waterEnableButton").click(function(){
	 waterEnableDisable("1");
});
$("#waterDisableButton").click(function(){
	 waterEnableDisable("0");
});
function waterEnableDisable(status){
	var selected = $('#waterDatagrid').datagrid('getSelected');
	$.ajax({
		type: "GET",
		url:"${ctx}/water/water/updateStatus",
		data:{"id":selected.id,"waterStatus":status},  
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   		$("#waterDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#waterDatagrid").datagrid('reload');
	    }
	}); 	
}
</script>
</div>
