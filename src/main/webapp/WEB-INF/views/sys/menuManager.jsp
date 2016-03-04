<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "menuContainer">
<div id="menuSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="menuSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_menuName">菜单名称</label>
					<input id="search_menuName" name="menuName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_menuIsLeaf">菜单类型</label>
					<select id="search_menuIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
						<option value="" selected="selected">--请选择--</option>
					    <option value="false">栏目</option>
					    <option value="true">菜单</option>
					</select>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_parentId">父菜单</label>
					<input id="search_parentId" name="parentId" style="width:120px;" />
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_authorId">权限编码</label>
					<input id="search_authorId" name="authorId" class="easyui-textbox" style="width:120px;"/>
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
				   <a class="easyui-linkbutton" href="#" id="menuSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="menuSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="menuDatagrid" style="width:100%;"></table>
</div>
<div id="menuDataDialog"  style="display:none">
	<form id="menuDataForm" style="margin:10px" >
		<input type="hidden" id="menuId" name="id"  ></input>
		<input type="hidden" id="menuSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			菜单名称：
			<input id="menuName" name="name"  class="easyui-textbox" style="width:120px;"/>
			菜单状态：
			<input id="menuStatus" name="menuStatus" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			菜单权限：
			<input id="menuAuthorId" name="authorId" class="easyui-textbox" style="width:120px;" data-option="required:true"/>
			菜单类型：
			<select id="menuIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
			    <option value="false" selected="selected">栏目</option>
			    <option value="true">菜单</option>
			</select>
		</div>
		<div class="line-div">
			菜单顺序：
			<input id="menuSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			父菜单号：
			<input id="menuParentId" name="parentId" style="width:120px;" />
		</div>
		<div class="line-div">
			菜单图标：
			<input id="menuIconCls" name="iconCls" value="" class="easyui-textbox" style="width:120px;"/>
			打开方式：
			<!-- <select id="menuOpenType" class="easyui-combobox" name="openType" style="width:120px;">
			    <option value="IFRAME" selected="selected">iframe方式</option>
			    <option value="HREF">href方式</option>
			</select> -->
			<jksb:diction id="menuOpenType" name="openType" groupId="MENU_OPEN_TYPE"  cssClass="easyui-combobox" style="width:120px" defaultValue="IFRAME">
				&nbsp;
			</jksb:diction>
		</div>
		<div class="line-div">
			菜单链接：
			<input id="menuUrl" name="menuUrl" class="easyui-textbox" style="width:310px;"/>
		</div>
	</form>
</div>

<div id="menu_toolbar">
	<jksb:hasAutority authorityId="007001001">
		<a href="javascript:menuAddData()" id = "menuAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="javascript:menuEditData()" id = "menuEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:menuDeleData()" id = "menuDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "menuEnableButton" class="easyui-linkbutton" data-options="iconCls:'pic_17',plain:true,disabled:true" >启用</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="#" id = "menuDisableButton" class="easyui-linkbutton" data-options="iconCls:'pic_18',plain:true,disabled:true" >停用</a>
	</jksb:hasAutority>
</div>

<div id="dataDialog2"  >
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#menuDatagrid').datagrid({
    url:"${ctx}/sys/menu/getMenusPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'name',title:'名称',width:'10%'},
        {field:'menuUrl',title:'链接',width:'16%',align:'left'},
        {field:'iconCls',title:'图标',width:'5%'},
        {field:'menuStatus',title:'状态',width:'5%',formatter:function(value,rec){
        	if(value=="1")  
        		return "启用";
        	else if(value=="0")  		  
        		return "<span style='color:red'>停用</span>";
        }},
        {field:'sortNum',title:'排序',width:'5%'},
        {field:'openType',title:'打开方式',width:'5%'},
        {field:'isLeaf',title:'是否菜单',width:'5%',formatter:function(value,rec){
        	if(value)  
        		return "菜单";
        	else  		  
        		return "栏目";
        }},
        {field:'parentId',title:'父菜单',width:'5%'},
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
    queryParams:$('#menuSearchConditionForm').getFormData(), 
    toolbar:"#menu_toolbar",					//根据权限动态生成按钮
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
	onSelect: function(index,row){menuSelectChange(index,row);},
	onUnselect: function(index,row){menuSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	menuDataDialog("菜单编辑",row);
    } 
});

function menuSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#menuDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#menuEditButton").linkbutton("enable");
		$("#menuDeleButton").linkbutton("enable");
		if($('#menuDatagrid').datagrid('getSelected').menuStatus == '0')
			$("#menuEnableButton").linkbutton("enable");
		else if($('#menuDatagrid').datagrid('getSelected').menuStatus == '1')
			$("#menuDisableButton").linkbutton("enable");
		
	}else if(selectedNum==0 ){
		$("#menuDeleButton").linkbutton("disable");
		$("#menuEditButton").linkbutton("disable");
		$("#menuEnableButton").linkbutton("disable");
		$("#menuDisableButton").linkbutton("disable");
	}else{
		$("#menuEditButton").linkbutton("disable");
		$("#menuEnableButton").linkbutton("disable");
		$("#menuDisableButton").linkbutton("disable");
	}
}

$('#menuSearchButton').click(function(){
	$('#menuDatagrid').datagrid('load',$('#menuSearchConditionForm').getFormData());
});

function menuAddData(){
	menuDataDialog("菜单新增",null);		 
	// dataDialog2("菜单新增",null);  
}
function menuEditData(){
	var selected = $('#menuDatagrid').datagrid('getSelected');
	menuDataDialog("菜单编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  menu对象由DataGrid 传送 
	// dataDialog2("菜单编辑",selected);  //该方法 弹出对话框内容为另一页面，menu对象由后台传送
}
function menuDeleData(){
	var selections = $('#menuDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/sys/menu/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#menuDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function menuSave(){
	var saveType =$("#menuSaveType").val();
	if(checkNotNull('menuName',"菜单名称")&&checkNotNull('menuAuthorId',"菜单权限")){
		$.ajax({
			type: "POST",
			url:"${ctx}/sys/menu/"+saveType,
			data:$('#menuDataForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#menuDataDialog").dialog("close");
		   		$("#menuDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#menuDataDialog").dialog("close");
			    $("#menuDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

/**
 * 本页面内DIV Dialog
 */
function menuDataDialog(title,selected){
	clearMenuForm();
	if(selected!=null)
		setMenuFormValue(selected);
	$("#menuDataDialog").show(); //先显示，再弹出
    $("#menuDataDialog").dialog({
        title: title,
        width: 450,
        height: 250,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){menuSave();}
		},{
			text:'取消',
			handler:function(){$("#menuDataDialog").dialog("close");}
		}]
    });
}

/**
 * 外部页面 Dialog
 */
 function dataDialog2(title,selected){
	var id = null;
	alert(selected.id);
	if(selected!=null)
		id = selected.id;
	$("#dataDialog2").dialog({
        title: title,
        width: 450,
        height: 220,
        modal:true,
        href: '${ctx}/sys/menu/menuEdit?id='+id,
        buttons:[{
			text:'保存',
			handler:function(){menuSave();}
		},{
			text:'取消',
			handler:function(){$("#dataDialog2").dialog("close");}
		}]
    });
}

function setMenuFormValue(selected){
	 $("#menuName").textbox('setValue',selected.name);
	 $("#menuStatus").textbox('setValue',selected.menuStatus);
	 $("#menuUrl").textbox('setValue',selected.menuUrl);
	 $("#menuUrl").textbox('readonly',true);
	 $("#menuIconCls").textbox('setValue',selected.iconCls);
	 $("#menuOpenType").combobox('setValue',selected.openType);
	 $("#menuIsLeaf").combobox('setValue',(selected.isLeaf).toString());
	 $('#menuParentId').combobox('reload'); 
 	 $('#menuParentId').combobox('setValue', selected.parentId );
	 $("#menuSortNum").textbox('setValue',selected.sortNum);
	 $("#menuAuthorId").textbox('setValue',selected.authorId);
	 $("#menuId").val(selected.id);
	 $("#menuSaveType").val("update");
}
function clearMenuForm(){
//	 $("#menuDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#menuName").textbox('setValue',"");
	 $("#menuStatus").textbox('setValue',"");
	 $("#menuUrl").textbox('setValue',"/");
//	 $("#menuOpenType").combobox('setValue',"HREF");
	 $("#menuIconCls").textbox('setValue',"");
	 $("#menuIsLeaf").combobox('setValue',"false");
	 $('#menuParentId').combobox('reload'); 
	 $('#menuParentId').combobox('setValue', '0');
	 $("#menuSortNum").textbox('setValue',"1");
	 $("#menuAuthorId").textbox('setValue',"");
	 $("#menuId").val("");
	 $("#menuSaveType").val("create"); 
}

/**
 * 设置分页
 */
var p = $('#menuDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});

/**
 * 父菜单选项
 */
$("#menuParentId").combobox({
    url:'${ctx}/sys/menu/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

$("#search_parentId").combobox({
    url:'${ctx}/sys/menu/getParents',
    valueField:'id',
    textField:'name',
    method:'GET'
});

/**
 * 菜单类型为栏目时 菜单链接默认为"/" 不允许更改 
 */
$("#menuIsLeaf").combobox({
    onChange: function (n,o) { 
    	if(n == 'false') {
    		$("#menuUrl").textbox('setValue',"/");
    		$("#menuUrl").textbox("readonly",true); 
    	}else{
    		$("#menuUrl").textbox("readonly",false); 
    	}
    }
});

// /*
//  * 必填项检测
//  主要检测菜单名称及权限
//  */
// function requiredCheck(){
// 	if($('#menuName').val()==""){
// 		$.messager.alert("出错！","请填写菜单名称",'error',focusMenuName);
// 	}else if($('#menuAuthorId').val()==""){
// 		$.messager.alert("出错！","请填写菜单权限",'error',focusMenuAuthor);
// 		$('#menuAuthorId').focus();
// 	}else{
// 		return true;
// 	}
// }
// /*
//  * 获取菜单名称焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusMenuName=function(){
// 	$('#menuName').textbox().next('span').find('input').focus();
// }
// /*
//  * 获取菜单权限焦点函数，easyUI中的input需要深入几层才可以获取真正的input
//  */
// var focusMenuAuthor=function(){
// 	$('#menuAuthorId').textbox().next('span').find('input').focus();
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

$("#menuEnableButton").click(function(){
	 menuEnableDisable("1");
});
$("#menuDisableButton").click(function(){
	 menuEnableDisable("0");
});
function menuEnableDisable(status){
	var selected = $('#menuDatagrid').datagrid('getSelected');
	$.ajax({
		type: "GET",
		url:"${ctx}/sys/menu/updateStatus",
		data:{"id":selected.id,"menuStatus":status},  
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   		$("#menuDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#menuDatagrid").datagrid('reload');
	    }
	}); 	
}
</script>
</div>
