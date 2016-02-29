<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "userContainer">
<div id="userSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="userSearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_userName">姓名</label>
					<input id="search_userName" name="userName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_identityNumber">身份证号</label>
					<input id="search_identityNumber" name="identityNumber" class="easyui-textbox" style="width:150px;"/>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_sex">性别</label>
					<select id="search_sexIsLeaf" class="easyui-combobox" name="sex" style="width:120px;">
					    <option value="" selected="selected"></option>
					    <option value="男">男</option>
					    <option value="女">女</option>
					</select>
				</td>
				<td width="22%" align="center" style="min-width:150px">
					<label for="search_nationCode">民族</label>
					<input id="search_nationCode" name="nationCode" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="12%" align="center" style="min-width:150px">
						&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="4"  width="90%" >
					&nbsp;
				</td>
				<td colspan="1" width="10%" align="left" >
				   <a class="easyui-linkbutton" href="#" id="userSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
		<div id="hhh"></div>
	</form>
</div>
<div  id="userSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="userDatagrid" style="width:100%;"></table>
</div>

  <div id="userDataDialog"  style="display:none">
	<form id="userDataForm" style="margin:10px" >
		<input type="hidden" id="userId" name="id"  ></input>
		<input type="hidden" id="userSaveType" name="saveType" value="create"></input>
		<div class="line-div">
			&nbsp;&nbsp;&nbsp;登录名：&nbsp;
			<input id="userName" name="userName"  class="easyui-textbox" style="width:130px;"/>
			姓名：&nbsp;
			<input id="name" name="name" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;民族：&nbsp;
			<input id="nationCode" name="nationCode" class="easyui-textbox" style="width:130px;"/>
			性别：&nbsp;
			<select id="sexIsLeaf" class="easyui-combobox" name="sex" style="width:120px;">
					    <option value="男" selected="selected">男</option>
					    <option value="女">女</option>
					</select>
		</div>
		<div class="line-div">
		           身份证号：&nbsp;
			<input id="identityNumber" name="identityNumber" class="easyui-textbox" style="width:130px;"/>
			生日：&nbsp;
			<input id="birthday" name="birthday" class="easyui-datebox"  style="width:120px;"/>
		</div>
		<div class="line-div">
			联系电话：&nbsp;
			<input id="phoneNumber" name="phoneNumber" class="easyui-textbox" style="width:130px;"/>
			用户状态：&nbsp;
			<input id="status" name="status" class="easyui-textbox" style="width:90px;"/> 
		</div>		
		<div class="line-div">
		          电子邮箱：&nbsp;
			<input id="email" name="email" class="easyui-textbox" style="width:260px;"/>			
		</div>
		<div class="line-div">
		用户密码：&nbsp;
			<input id="plainPassword" name="plainPassword" class="easyui-textbox" style="width:260px;"/>
		</div>
	</form>
</div>

<div id="userToolbar">
	<jksb:hasAutority authorityId="007005001">
		<a href="javascript:userAddData()" id = "userAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007005003">
		<a href="javascript:userEditData()" id = "userEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007005002">
		<a href="javascript:userDeleData()" id = "userDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
</div>

<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#userDatagrid').datagrid({
    url:"${ctx}/sys/user/getUserPage",
    method:'post',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'ID',width:'4%'},
        {field:'userName',title:'登录名',width:'6%'},
        {field:'name',title:'姓名',width:'6%'},
        {field:'sex',title:'性别',width:'5%'},
        {field:'identityNumber',title:'身份证号',width:'15%'},
        {field:'nationCode',title:'民族',width:'6%'},
        {field:'birthday',title:'生日',width:'10%'},
        {field:'email',title:'电子邮箱',width:'10%'},
        {field:'phoneNumber',title:'联系电话',width:'10%'},
        {field:'createDate',title:'注册日期',width:'10%'},
        {field:'status',title:'账号状态',width:'5%',formatter:function(value,rec){
        	if(value=="1")  
        		return "启用";
        	else if(value=="0")  		  
        		return "<span style='color:red'>停用</span>";
        }},
    ]],
    queryParams:$('#userSearchConditionForm').getFormData(), 
    toolbar:"#userToolbar",				 
	onSelect: function(index,row){userSelectChange(index,row);},
	onUnselect: function(index,row){userSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	userDataDialog("用户信息编辑",row);
    } 
});

function userSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#userDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#userEditButton").linkbutton("enable");
		$("#userDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#userDeleButton").linkbutton("disable");
		$("#userEditButton").linkbutton("disable");
	}else{
		$("#userEditButton").linkbutton("disable");
	}
}

$('#userSearchButton').click(function(){
	$('#userDatagrid').datagrid('load',$('#userSearchConditionForm').getFormData());
});

function userAddData(){
	userDataDialog("用户新增",null);		 
}
function userEditData(){
	var selected = $('#userDatagrid').datagrid('getSelected');
	userDataDialog("用户信息编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  user对象由DataGrid 传送 
}
function userDeleData(){
	var selections = $('#userDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/sys/user/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#userDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function userSave(){
	var saveType =$("#userSaveType").val();
	if((saveType=="update"&&checkNotNull('name',"姓名"))||saveType=="create"&&checkNotNull('userName',"登录名")&&checkNotNull('plainPassword',"用户密码")&&checkNotNull('name',"姓名")){
		$.ajax({
			type: "POST",
			url:"${ctx}/sys/user/"+saveType,
			data:$('#userDataForm').serialize(), //将Form 里的值序列化
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#userDataDialog").dialog("close");
		   		$("#userDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#userDataDialog").dialog("close");
			    $("#userDatagrid").datagrid('reload');
		    }
		}); 
	}		
} 

// function userSave(){
// 	var saveType =$("#userSaveType").val();
// 	if(saveType=="update"||saveType=="create"&&checkNotNull('userName',"登录名")&&checkNotNull('plainPassword',"用户密码")){
// 	 $("#hhh").text("序列化的值："+$('#userDataForm').serialize());
// 	 $("#userDataDialog").dialog("close");
// 		$("#userDatagrid").datagrid('reload');
// 	}
// }

/**
 * 本页面内DIV Dialog
 */
function userDataDialog(title,selected){
	clearUserForm();
	$("#plainPassword").textbox('enable');
	if(selected!=null){
		setUserFormValue(selected);
	    $("#plainPassword").textbox('disable');
	}
	$("#userDataDialog").show(); //先显示，再弹出
    $("#userDataDialog").dialog({
        title: title,
        width: 430,
        height: 250,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){userSave();}
		},{
			text:'取消',
			handler:function(){$("#userDataDialog").dialog("close");}
		}]
    });
}

function setUserFormValue(selected){
	 $("#userName").textbox('setValue',selected.userName);
	 $("#identityNumber").textbox('setValue',selected.identityNumber);
	 $("#name").textbox('setValue',selected.name);
	 $("#sexIsLeaf").combobox('setValue',selected.sex);
	 $("#nationCode").textbox('setValue',selected.nationCode);
	 $("#birthday").datebox('setValue',selected.birthday);
	 $("#phoneNumber").textbox('setValue',selected.phoneNumber);
	 $("#status").textbox('setValue',selected.status);
	 $("#email").textbox('setValue',selected.email);
	 $("#plainPassword").textbox('setValue',selected.plainPassword);
	 $("#userId").val(selected.id);
	 $("#userSaveType").val("update");
}
function clearUserForm(){
  // $("#userDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
	 
	 $("#userName").textbox('setValue',"");
	 $("#identityNumber").textbox('setValue',"");
	 $("#name").textbox('setValue',"");
	 $("#sexIsLeaf").combobox('setValue',"");
	 $("#nationCode").textbox('setValue',"");
	 $("#birthday").datebox('setValue',"");
	 $("#phoneNumber").textbox('setValue',"");
	 $("#status").textbox('setValue',1);
	 $("#email").textbox('setValue',"");
	 $("#plainPassword").textbox('setValue',"");
	 $("#userId").val("");
	 $("#userSaveType").val("create");
}

/**
 * 设置分页
 */
var p = $('#userDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为10
    pageList: [10,15,20]
});


</script>
</div>