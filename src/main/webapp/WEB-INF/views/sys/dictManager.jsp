<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "dictContainer">
<div id="dictSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="dictSearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_dictName">字典名称</label>
					<input id="search_dictName" name="dictName" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_dictCode">字典编码</label>
					<input id="search_dictCode" name="dictCode" class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_dictGroup">字典组别</label>
					<input id="search_dictGroup" name="dictGroup" class="easyui-textbox" style="width:120px;"/>
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
				   <a class="easyui-linkbutton" href="#" id="dictSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="dictSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="dictDatagrid" style="width:100%;"></table>
</div>
<div id="dictDataDialog"  style="display:none">
	<form id="dictDataForm" style="margin:10px" >
		<input type="hidden" id="dictId" name="id"  ></input>
		<input type="hidden" id="dictSaveType" name ="saveType" value="create"></input>
		<div class="line-div">
			字典名：&nbsp;
			<input id="dictName" name="dictName"  class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			字典值：&nbsp;
			<input id="dictValue" name="dictValue" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			字典组：&nbsp;
			<input id="dictGroup" name="dictGroup" class="easyui-textbox" style="width:120px;"/>
		</div>
		<div class="line-div">
			字典编码：
			<input id="dictCode" name="dictCode"  class="easyui-textbox" style="width:150px;"/>
		</div>
		
	</form>
</div>

<div id="dictToolbar">
	<jksb:hasAutority authorityId="007002001">
		<a href="javascript:dictAddData()" id = "dictAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >新增</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002003">
		<a href="javascript:dictEditData()" id = "dictEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007002002">
		<a href="javascript:dictDeleData()" id = "dictDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	<a href="javascript:refreshDictCache()" id = "dictDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true," >刷新缓存</a>
</div>

<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#dictDatagrid').datagrid({
    url:"${ctx}/sys/dict/getDictsPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'dictCode',title:'字典编码',width:'16%'},
        {field:'dictName',title:'字典名称',width:'10%'},
        {field:'dictValue',title:'字典值',width:'10%'},
        {field:'dictGroup',title:'字典组',width:'10%'}
    ]],
    queryParams:$('#dictSearchConditionForm').getFormData(), 
    toolbar:"#dictToolbar",				 
	onSelect: function(index,row){dictSelectChange(index,row);},
	onUnselect: function(index,row){dictSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	dictDataDialog("数据字典编辑",row);
    } 
});

function dictSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#dictDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#dictEditButton").linkbutton("enable");
		$("#dictDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#dictDeleButton").linkbutton("disable");
		$("#dictEditButton").linkbutton("disable");
	}else{
		$("#dictEditButton").linkbutton("disable");
	}
}

$('#dictSearchButton').click(function(){
	$('#dictDatagrid').datagrid('load',$('#dictSearchConditionForm').getFormData());
});

function dictAddData(){
	dictDataDialog("数据字典新增",null);		 
}
function dictEditData(){
	var selected = $('#dictDatagrid').datagrid('getSelected');
	dictDataDialog("数据字典编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  dict对象由DataGrid 传送 
}
function dictDeleData(){
	var selections = $('#dictDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/sys/dict/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#dictDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function dictSave(){
	var saveType =$("#dictSaveType").val();
	$.ajax({
		type: "POST",
		url:"${ctx}/sys/dict/"+saveType,
		data:$('#dictDataForm').serialize(), //将Form 里的值序列化
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#dictDataDialog").dialog("close");
	   		$("#dictDatagrid").datagrid('reload');
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#dictDataDialog").dialog("close");
		    $("#dictDatagrid").datagrid('reload');
	    }
	}); 
}

/**
 * 本页面内DIV Dialog
 */
function dictDataDialog(title,selected){
	clearDictForm();
	if(selected!=null)
		setDictFormValue(selected);
	$("#dictDataDialog").show(); //先显示，再弹出
    $("#dictDataDialog").dialog({
        title: title,
        width: 300,
        height: 220,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){dictSave();}
		},{
			text:'取消',
			handler:function(){$("#dictDataDialog").dialog("close");}
		}]
    });
}

function setDictFormValue(selected){
	 $("#dictName").textbox('setValue',selected.dictName);
	 $("#dictCode").textbox('setValue',selected.dictCode);
	 $("#dictGroup").textbox('setValue',selected.dictGroup);
	 $("#dictValue").textbox('setValue',selected.dictValue);
	 $("#dictId").val(selected.id);
	 $("#dictSaveType").val("update");
}
function clearDictForm(){
	// $("#dictDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
	 
	 $("#dictName").textbox('setValue',"");
	 $("#dictCode").textbox('setValue',"");
	 $("#dictGroup").textbox('setValue',"");
	 $("#dictValue").textbox('setValue',"");
	 $("#dictId").val("");
	 $("#dictSaveType").val("create");
}

/**
 * 设置分页
 */
var p = $('#dictDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
});


function refreshDictCache(){
	$.ajax({
		url:"${ctx}/sys/dict/refresh",
		type:'GET',
		success:function(data){
			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			$("#dictDatagrid").datagrid('reload');
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});		
}

</script>
</div>