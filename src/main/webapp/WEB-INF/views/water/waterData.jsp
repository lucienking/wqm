<!DOCTYPE html>
<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>监测数据</title>
<style>
	#monitorDataSearchConditionPanel{
		font-size:12px;
	}
</style>

</head>
<body>
<div id= "monitorDataContainer">
<div id="monitorDataSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;" data-options="collapsible:true">
	<form id="monitorDataSearchConditionForm">
		<table style="width:99%;height:80px;margin-buttom:10px">
			<tr>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorDataName">区域</label>
					<input id="search_Area" name="areaCode"  class="easyui-textbox" style="width:120px;"/>
					<input id="hidden_areaCode" type="hidden" name="areaCode" value="${areaCode =='01'?'0':areaCode }"/>
					<input id="hidden_parentCode" type="hidden" name="parentCode" value="${parentCode }"/>
					<input type="hidden" name="isLeaf" value="false"/>
				</td>
				<td width="18%" align="center" style="min-width:150px">
					<label for="search_monitorDataCode">水体</label>
					<input id="search_Water" name="waterCode"  style="width:120px;" />
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
				   <a class="easyui-linkbutton" href="#" id="monitorDataSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				    <a class="easyui-linkbutton" href="#" id="monitorDataResetButton">&nbsp;重&nbsp;置&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="monitorDataSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="monitorDataDatagrid" style="width:100%;"></table>
</div>

	<form id="monitorDataDataForm" style="margin:10px" >
		<div id="monitorDataDataDialog"  style="display:none">
			<input type="hidden" id="monitorDataId" name="id"  ></input>
			<input type="hidden" id="monitorDataSaveType" name ="saveType" value="create"></input>
			<div class="line-div">
				选择区域：
				<input id="monitor_Area" name="" class="easyui-textbox" style="width:120px;"/>
				选择水体：
				<input id="monitor_Water" name="" style="width:120px;" />
				</div>
			<div id="monitorDataCreateDiv" class="line-div">
				选择监测站：
				<input id="monitor_LeafWater" name="waterCode" style="width:120px;" />
				监测时间：
				<input id="monitor_Date" name="monitorDate" value="${currentDate }" class="easyui-datebox" style="width:120px;"/>
			</div>
		</div>
		<div id="monitorDataItemDialog"  style="display:none">
		</div>
	</form>
	
<div id="monitorDataDetailDialog"  style="width:99%;height:99%;display:none;">
</div>
<div id="monitorDataToMapDialog"  style="width:99%;height:99%;display:none;">
</div>

<div id="monitorData_toolbar">
	<c:if test="${ userName==''&&userName==null}">
	<jksb:hasAutority authorityId="007001001">
		<a href="javascript:monitorDataAddData()" id = "monitorDataAddButton" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" >监测登记</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001003">
		<a href="javascript:monitorDataEditData()" id = "monitorDataEditButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true,disabled:true" >编辑</a>
	</jksb:hasAutority>
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:monitorDataDeleData()" id = "monitorDataDeleButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,disabled:true," >删除</a>
	</jksb:hasAutority>
	</c:if>
	<a href="#" id = "monitorDataDetailButton" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true,disabled:true," >详细信息</a>
	<a href="#" id = "monitorDataToMapButton" class="easyui-linkbutton" data-options="iconCls:'icon-tip',plain:true,disabled:true," >跳转地图</a>
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#monitorDataDatagrid').datagrid({
    url:"${ctx}/water/getWaterData",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'name',title:'水体名称',width:'10%'},
        {field:'area',title:'所属区域',width:'10%',formatter:function(value,rec){
        	if(rec.area)  
        		return rec.area.name;
        	else  		  
        		return "未知";
        }},
        {field:'parentName',title:'所属水体',width:'10%'},
        {field:'createDate',title:'最后监测日期',width:'10%'},
        {field:'operator',title:'水体负责人',width:'10%'},
        {field:'telephone',title:'联系方式',width:'10%'} 
    ]],
    queryParams:$('#monitorDataSearchConditionForm').getFormData(), 
    toolbar:"#monitorData_toolbar",					//根据权限动态生成按钮
	onSelect: function(index,row){monitorDataSelectChange(index,row);},
	onUnselect: function(index,row){monitorDataSelectChange(index,row);},
    onDblClickRow:function (index,row){	   //双击行事件 
    	$("#monitorDataDetailDialog").show(); //先显示，再弹出
	   	 $("#monitorDataDetailDialog").dialog({
	   		  title:'水体详细信息',
	   	      href:"${ctx}/water/waterDetail?code="+row.code,
	   	      width:500,
	   	      left:150,
	   	      top:80,
	   	      modal:true
	   	  });
    } 
});

function monitorDataSelectChange(index,row){ 		// 选择行事件 通用。
	var selectedNum = $('#monitorDataDatagrid').datagrid('getSelections').length;
	if(selectedNum==1){
		$("#monitorDataEditButton").linkbutton("enable");
		$("#monitorDataDeleButton").linkbutton("enable");
		$("#monitorDataDetailButton").linkbutton("enable");
		$("#monitorDataToMapButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#monitorDataDeleButton").linkbutton("disable");
		$("#monitorDataEditButton").linkbutton("disable");
		$("#monitorDataDetailButton").linkbutton("disable");
		$("#monitorDataToMapButton").linkbutton("disable");
		$("#monitorDataDisableButton").linkbutton("disable");
	}else{
		$("#monitorDataEditButton").linkbutton("disable");
		$("#monitorDataDetailButton").linkbutton("disable");
		$("#monitorDataDisableButton").linkbutton("disable");
		$("#monitorDataToMapButton").linkbutton("disable");
	}
}

$('#monitorDataSearchButton').click(function(){
	$('#monitorDataDatagrid').datagrid('load',$('#monitorDataSearchConditionForm').getFormData());
});

function monitorDataAddData(){
	monitorDataDataDialog("监测数据登记",null);		 
	// dataDialog2("监测数据新增",null);  
}
function monitorDataEditData(){
	var selected = $('#monitorDataDatagrid').datagrid('getSelected');
	monitorDataDataDialog("监测数据编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  monitorData对象由DataGrid 传送 
	// dataDialog2("监测数据编辑",selected);  //该方法 弹出对话框内容为另一页面，monitorData对象由后台传送
}
function monitorDataDeleData(){
	var selections = $('#monitorDataDatagrid').datagrid('getSelections');
	var num = selections.length;
	$.messager.confirm('删除确认','确定删除这 '+num+' 项吗?',function(r){
	    if (r){
	    	var ids = "";
	    	for(sele in selections){
	    		ids += selections[sele].id;
	    		if(sele<(num-1)) ids += ",";
	    	}
	    	$.ajax({
	    		url:"${ctx}/monitorData/delete",
	    		type:'GET',
	    		data: { 'ids': ids },  
	    		success:function(data){
	    			$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
	    			$("#monitorDataDatagrid").datagrid('reload');
	    		},
	    		error:function(XMLHttpRequest, textStatus, errorThrown){
	    			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
	    		}
	    	});
	    }
	});
}
function monitorDataSave(){
	if(true){
		$.ajax({
			type: "POST",
			url:"${ctx}/monitorData/saveMonitorData",
			data:{"itemData":fomatterPamFromItemForm()
				,"waterCode":$("#monitor_LeafWater").combobox("getValue")
				,"waterName":$("#monitor_LeafWater").combobox("getText")
				,"monitor_Date":$("#monitor_Date").textbox("getValue")},  
			asyn:false,
		    error: function(jqXHR, textStatus, errorMsg) {
		    	$.messager.alert('操作结果',""+jqXHR.responseText);
		   	 	$("#monitorDataDataDialog").dialog("close");
		   		$("#monitorDataDatagrid").datagrid('reload');
		    },
		    success: function(data) {
		    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
			    $("#monitorDataDataDialog").dialog("close");
			    $("#monitorDataDatagrid").datagrid('reload');
		    }
		}); 	
	}
}

/**
 * 本页面内DIV Dialog
 */
function monitorDataDataDialog(title,selected){
	clearMonitorDataForm();
	if(selected!=null)
		setMonitorDataFormValue(selected);
	$("#monitorDataDataDialog").show(); //先显示，再弹出
    $("#monitorDataDataDialog").dialog({
        title: title,
        width: 450,
        height: 160,
        modal:true,
        buttons:[{
			text:'下一步',
			handler:function(){
				$("#monitorDataDataDialog").dialog("close");
				monitorDataItemDialog();
			}
		}]
    });
}

/**
 * 监测项填写
 */
 function monitorDataItemDialog(){
 	$.ajax({
		url:"${ctx}/water/getWaterMonitorItemByCode",
		type:'GET',
		data: { 'code': $("#monitor_LeafWater").combobox("getValue") },  
		success:function(data){
			var html = '';
			html +="<table style='width:99%;height:80px;margin-buttom:10px'><tr>";
			 $(data).each(function(i, obj){
				html += "<td>"+obj.name +"<input type='text' name='_itemValue' value='0' class='easyui-textbox' style='width:60px;'/>";
				html += "<input type='hidden' name='_itemName' value='"+obj.name+"' />";
				html += "<input type='hidden' name='_itemCode' value='"+obj.code+"' />";
				html += "</td>";
				if((i+1)%3 == 0){
					html+="</tr><tr>";
			 	}
			});
			html +="</tr></table>";
			$("#monitorDataItemDialog").html(html);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
		}
	});
	$("#monitorDataItemDialog").show(); //先显示，再弹出
    $("#monitorDataItemDialog").dialog({
        title: '监测数据填写',
        width: 450,
        modal:true,
        buttons:[{
			text:'保存',
			handler:function(){monitorDataSave();}
		},{
			text:'取消',
			handler:function(){$("#monitorDataItemDialog").dialog("close");}
		}]
    });
	}

function setMonitorDataFormValue(selected){
	 $("#monitorDataName").textbox('setValue',selected.name);
	 $("#monitorDataCode").textbox('setValue',selected.code);
	 $("#monitorDataIconCls").textbox('setValue',selected.iconCls);
	 $("#monitorDataSortNum").textbox('setValue',selected.sortNum);
	 $("#monitorDataId").val(selected.id);
	 $("#monitorDataSaveType").val("update");
}
function clearMonitorDataForm(){
//	 $("#monitorDataDataForm")[0].reset();       //此为调用DOM 的方法来reset,手动reset如下
 	 $("#monitorDataName").textbox('setValue',"");
	 $("#monitorDataCode").textbox('setValue',"");
	 $("#monitorDataIconCls").textbox('setValue',"");
	 $("#monitorDataSortNum").textbox('setValue',"1");
	 $("#monitorDataId").val("");
	 $("#monitorDataSaveType").val("create"); 
}

/**
 * 设置分页
 */
var p = $('#monitorDataDatagrid').datagrid('getPager'); 
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

$("#monitor_Area").combobox({
    url:'${ctx}/area/getParents',
    valueField:'code',
    textField:'name',
    method:'GET',
   	onSelect:function(value){
   		$('#monitor_Water').combobox('clear'); 
   		var url = '${ctx}/water/getWaterByAreaCode?areaCode='+value.code;
   		$('#monitor_Water').combobox('reload', url); 
   		$('#monitor_LeafWater').combobox('clear');
   		var url = '${ctx}/water/getWatersByParent?code=';
   		$('#monitor_LeafWater').combobox('reload', url); 
   	}
});
$("#monitor_Water").combobox({
    url:'${ctx}/water/getWaterByAreaCode',
    valueField:'code',
    textField:'name',
    method:'GET',
 	onSelect:function(value){
   		$('#monitor_LeafWater').combobox('clear'); 
   		var url = '${ctx}/water/getWatersByParent?code='+value.code;
   		$('#monitor_LeafWater').combobox('reload', url); 
   	}
});
$("#monitor_LeafWater").combobox({
    url:'${ctx}/water/getWatersByParent',
    valueField:'code',
    textField:'name',
    method:'GET'
});

 
/**
 * 详细信息展示
 */
 $("#monitorDataDetailButton").click(function(){
	 var code = $("#monitorDataDatagrid").datagrid("getSelected").code;
	 
	 $("#monitorDataDetailDialog").show(); //先显示，再弹出
	 $("#monitorDataDetailDialog").dialog({
		  title:'水体详细信息',
	      href:"${ctx}/water/waterDetail?code="+code,
	      width:500,
	      left:150,
	      top:80,
	      modal:true
	  });
 });
 
 /**
  * 地图展示
  */
  $("#monitorDataToMapButton").click(function(){
 	 var code = $("#monitorDataDatagrid").datagrid("getSelected").code;
 	 var name ="电子地图";
 	 var url = "${ctx}/show/waterMap?waterId=w"+code+"&&isLeaf=true";
 	var flag = parent.$("#frontMainTabs").tabs('exists', name);
	if (flag) {
		parent.$("#frontMainTabs").tabs('select', name);
	} else{
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';  
		parent.$('#frontMainTabs').tabs('add',{
			id:"elecMapTab",
			title:name,
			content:content,
			closable:true  
		});
	}
  });
 
  $("#search_Area").combobox({
	    url:'${ctx}/area/getParents',
	    valueField:'code',
	    textField:'name',
	    method:'GET',
	   	onSelect:function(value){
	   		$('#search_Water').combobox('clear'); 
	   		var url = '${ctx}/water/getWaterByAreaCode?areaCode='+value.code;
	   		$('#search_Water').combobox('reload', url); 
	   		$('#search_LeafWater').combobox('clear');
	   		var url = '${ctx}/water/getWatersByParent?code=';
	   		$('#search_LeafWater').combobox('reload', url); 
	   	} 
	});
	$("#search_Water").combobox({
	    url:'${ctx}/water/getWaterByAreaCode',
	    valueField:'code',
	    textField:'name',
	    method:'GET',
	 	onSelect:function(value){
	   		$('#search_LeafWater').combobox('clear'); 
	   		var url = '${ctx}/water/getWatersByParent?code='+value.code;
	   		$('#search_LeafWater').combobox('reload', url); 
	   	} 
	});
	$("#search_LeafWater").combobox({
	    url:'${ctx}/water/getWatersByParent',
	    valueField:'code',
	    textField:'name',
	    method:'GET'
	});
 $(function(){
	 var parentCode = "0";
	 var areaCode  = "01";
	 if($("#hidden_parentCode").val() != ""&&$("#hidden_parentCode").val() != undefined) 
	 	 parentCode = $("#hidden_parentCode").val();
	 if($("#hidden_areaCode").val() != ""&&$("#hidden_areaCode").val() != undefined&&$("#hidden_areaCode").val() != "0") 
	 	 areaCode = $("#hidden_areaCode").val();
	 $("#search_Area").combobox("setValue",areaCode);
	 $("#search_Water").combobox("setValue",parentCode);
 })
</script>
</div>
</body>