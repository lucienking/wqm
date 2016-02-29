<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "sysParamContainer">
<div id="sysParamSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="sysParamSearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysParamName">参数名称</label>
					<input id="search_sysParamName" name="sysParamName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysParamCode">参数编码</label>
					<input id="search_sysParamCode" name="sysParamCode" class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysParamGroup">参数值</label>
					<input id="search_sysParamGroup" name="sysParamValue" class="easyui-textbox" style="width:120px;"/>
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
				   <a class="easyui-linkbutton" href="#" id="sysParamSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="sysParamSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="sysParamDatagrid" style="width:100%;"></table>
</div>
<div id="sysParamDataDialog"  style="display:none">
	<form id="sysParamDataForm" style="margin:10px" >
		<input type="hidden" id="sysParamId" name="id"  ></input>
		<input type="hidden" id="sysParamSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			参数编码：
			<input id="sysParamCode" name="sysParamCode"  class="easyui-textbox" style="width:150px;"/>
		</div>
		<div class="line-div">
			参数名：&nbsp;
			<input id="sysParamName" name="sysParamName"  class="easyui-textbox" style="width:150px;"/>
		</div>
		<div class="line-div">
			参数值：&nbsp;
			<input id="sysParamValue" name="sysParamValue" class="easyui-textbox" style="width:150px;"/>
		</div>
	</form>
</div>

<div id="sysParamToolbar">
	<jksb:hasAutority authorityId="007002001">
		<a href="javascript:sysParamAddData()" id = "sysParamAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002003">
		<a href="javascript:sysParamEditData()" id = "sysParamEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002002">
		<a href="javascript:sysParamDeleData()" id = "sysParamDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<a href="javascript:refreshsysParamCache()" id = "sysParamDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true," >刷新缓存</a>
</div>

<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#sysParamDatagrid').datagrid({
    url:"${ctx}/sys/param/getSysParamsPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'sysParamCode',title:'参数编码',width:'16%'},
        {field:'sysParamName',title:'参数名称',width:'10%'},
        {field:'sysParamValue',title:'参数值',width:'40%'}
    ]],
    queryParams:$('#sysParamSearchConditionForm').getFormData(), 
    toolbar:"#sysParamToolbar",				 
	onSelect: function(index,row){sysParamSelectChange(index,row);},
	onUnselect: function(index,row){sysParamSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	sysParamDataDialog("系统参数编辑",row);
    }
});

function sysParamSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#sysParamDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#sysParamEditButton").linkbutton("enable");
		$("#sysParamDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#sysParamDeleButton").linkbutton("disable");
		$("#sysParamEditButton").linkbutton("disable");
	}else{
		$("#sysParamEditButton").linkbutton("disable");
	}
}

$('#sysParamSearchButton').click(function(){
	$('#sysParamDatagrid').datagrid('load',$('#sysParamSearchConditionForm').getFormData());
});

function sysParamAddData(){
	sysParamDataDialog("系统参数新增",null);		 
}
function sysParamEditData(){
	var selected = $('#sysParamDatagrid').datagrid('getSelected');
	sysParamDataDialog("系统参数编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  sysParam对象由DataGrid 传送 
}
function sysParamDeleData(){
	var selections = $('#sysParamDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/sys/param/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#sysParamDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function save(){
	var saveType =$("#sysParamSaveType").val();
	$.ajax({
		type: "POST",
		url:"${ctx}/sys/param/"+saveType,
		data:$('#sysParamDataForm').serialize(), //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#sysParamDataDialog").dialog("close");
	   		$("#sysParamDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#sysParamDataDialog").dialog("close");
		    $("#sysParamDatagrid").datagrid('reload');
	    }
	}); 
}

/**
 * 本页面内DIV Dialog
 */
function sysParamDataDialog(title,selected){
	clearsysParamForm();
	if(selected!=null)
		setsysParamFormValue(selected);
	$("#sysParamDataDialog").show(); //先显示，再弹出
    $("#sysParamDataDialog").dialog({
        title: title,
        width: 300,
        height: 180,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){save();}
		},{
			text:'取消',
			handler:function(){$("#sysParamDataDialog").dialog("close");}
		}]
    });
}

function setsysParamFormValue(selected){
	 $("#sysParamName").textbox('setValue',selected.sysParamName);
	 $("#sysParamCode").textbox('setValue',selected.sysParamCode);
	 $("#sysParamValue").textbox('setValue',selected.sysParamValue);
	 $("#sysParamId").val(selected.id);
	 $("#sysParamSaveType").val("update");
}
function clearsysParamForm(){
	// $("#sysParamDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
	 
	 $("#sysParamName").textbox('setValue',"");
	 $("#sysParamCode").textbox('setValue',"");
	 $("#sysParamGroup").textbox('setValue',"");
	 $("#sysParamValue").textbox('setValue',"");
	 $("#sysParamId").val("");
	 $("#sysParamSaveType").val("create");
}

/**
 * 设置分页
 */
var p = $('#sysParamDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});


function refreshsysParamCache(){
	$.ajax({
		url:"${ctx}/sys/param/refresh",
		type:'GET',
		success:function(data){
			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			$("#sysParamDatagrid").datagrid('reload');
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});		
}

</script>
</div>