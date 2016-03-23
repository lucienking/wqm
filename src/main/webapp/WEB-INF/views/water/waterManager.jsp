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
					     <option value="false">水体</option>
			   			 <option value="true">监测站</option>
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
				   <a class="easyui-linkbutton" href="#" id="waterSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				    <a class="easyui-linkbutton" href="#" id="waterResetButton">&nbsp;重&nbsp;置&nbsp;</a>
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
			水体编码：
			<input id="waterCode" name="code" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			水体顺序：
			<input id="waterSortNum" name="sortNum" value="1" class="easyui-textbox" style="width:120px;"/>
			水体类型：
			<select id="waterIsLeaf" class="easyui-combobox" name="isLeaf" style="width:120px;">
			    <option value="false" selected="selected">水体</option>
			    <option value="true">监测站</option>
			</select>
		</div>
		<div class="line-div">
			所属区域：
			<input id="belong_area" name="areaCode" class="easyui-textbox" style="width:120px;"/>
			父水体号：
			<input id="waterParentId" name="parentCode" style="width:120px;" />
		</div>
		<div class="line-div">
			水体状态：
			<select id="waterIsManaged" class="easyui-combobox" name="isManaged" style="width:120px;">
			    <option value="N" selected="selected">未治理</option>
			    <option value="Y">已治理</option>
			</select>
			水体图标：
			<input id="waterIconCls" name="iconCls" value="1" class="easyui-textbox" style="width:120px;"/>
		</div>
	</form>
</div>

<form id="waterMonitorItemForm" style="margin:10px" >
	<div id="waterMonitorItemDialog"  style="display:none;">
		<ul id="waterMonitorItemTree"></ul>
	</div>
</form>

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
	<jksb:hasAutority authorityId="007001002">
		<a href="javascript:waterMonitorItem()" id = "waterMonitorItemButton" class="easyui-linkbutton" data-options="iconCls:'pic_18',plain:true,disabled:true," >设置监测项</a>
	</jksb:hasAutority>
</div>

<script type="text/javascript">
/**
 *  datagrid 初始化 
 */
$('#waterDatagrid').datagrid({
    url:"${ctx}/water/getWatersPage",
    method:'get',
    pagination:true,
    columns:[[
        {checkbox:true,field:'',title:'' },
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'name',title:'水体名称',width:'10%'},
        {field:'code',title:'水体编码',width:'10%'},
        {field:'area',title:'所属区域',width:'10%',formatter:function(value,rec){
        	if(rec.area)  
        		return rec.area.name;
        	else  		  
        		return "未知";
        }},
        {field:'sortNum',title:'排序',width:'5%'},
        {field:'isLeaf',title:'是否水体',width:'5%',formatter:function(value,rec){
        	if(value)  
        		return "监测站";
        	else  		  
        		return "水体";
        }},
        {field:'isLeaf',title:'水体状态',width:'5%',formatter:function(value,rec){
        	if(value=='Y')  
        		return "已治理";
        	else  		  
        		return "未治理";
        }},
        {field:'parentCode',title:'父水体',width:'5%'},
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
		$("#waterMonitorItemButton").linkbutton("enable");
		$("#waterDeleButton").linkbutton("enable");
	}else if(selectedNum==0 ){
		$("#waterDeleButton").linkbutton("disable");
		$("#waterEditButton").linkbutton("disable");
		$("#waterEnableButton").linkbutton("disable");
		$("#waterDisableButton").linkbutton("disable");
		$("#waterMonitorItemButton").linkbutton("disable");
	}else{
		$("#waterMonitorItemButton").linkbutton("disable");
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
}
function waterEditData(){
	var selected = $('#waterDatagrid').datagrid('getSelected');
	waterDataDialog("水体编辑",selected);      //该方法 弹出圣诞框内容为页面DIV  water对象由DataGrid 传送 
}
function waterMonitorItem(){
	var selected = $('#waterDatagrid').datagrid('getSelected');
	waterMonitorItemDialog("设置监测项",selected);
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
	    		url:"${ctx}/water/delete",
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
	if(checkNotNull('waterName',"水体名称")&&checkNotNull('waterCode',"水体编码")){
		$.ajax({
			type: "POST",
			url:"${ctx}/water/"+saveType,
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

function monitorItemSave(id){
	var nodes = $('#waterMonitorItemTree').tree('getChecked');//获取:checked的结点.
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].id !=''){
			if (s != '') s += ',';
			s += nodes[i].id; 
		}
	}
 	$.ajax({
		type: "POST",
		url:"${ctx}/water/saveMonitorItem",
		data:{'itemList':s,'id':id},  
		asyn:false,
	    error: function(jqXHR, textStatus, errorMsg) {
	    	$.messager.alert('操作结果',""+jqXHR.responseText);
	   	 	$("#waterMonitorItemDialog").dialog("close");
	    },
	    success: function(data) {
	    	$.messager.alert('操作结果',"<div style='text-align:center;width:100%;'>"+data.message+"</div>");
		    $("#waterMonitorItemDialog").dialog("close");
	    }
	});  
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
        height: 230,
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

/**
 * 监测项编辑
 */
function waterMonitorItemDialog(title,selected){
	/* if(selected!=null)
		setWaterFormValue(selected); */
	$.ajax({
        url:"${ctx}/water/getWaterMonitorItemList",
        dataType:"json",
        data:{"id":selected.id},
        async:true,
        cascadeCheck:false,
        success:function(data){
        	var root = $('#waterMonitorItemTree').tree('getRoot');  
			$("#waterMonitorItemTree").tree('uncheck',root.target); 
            $(data).each(function(i, obj){
                var n = $("#waterMonitorItemTree").tree('find',obj.code);
                if(n){
                    $("#waterMonitorItemTree").tree('check',n.target);
                } 
            });
        },
        error:function(){alert("发送请求失败");}
    });
	$("#waterMonitorItemDialog").show(); //先显示，再弹出
    $("#waterMonitorItemDialog").dialog({
    	title:'监测项',
        width: 240,
        height:460,
        modal:false,
        buttons:[{
			text:'保存',
			handler:function(){monitorItemSave(selected.id);}
		},{
			text:'取消',
			handler:function(){$("#waterMonitorItemDialog").dialog("close");}
		}]
    });
}

/**
 * 监测项树
 */
$('#waterMonitorItemTree').tree({
	url: '${ctx}/monitorItem/getMonitorItemsTree', 
	method:"GET",
	checkbox:true 
});


function setWaterFormValue(selected){
	 $("#waterName").textbox('setValue',selected.name);
	 $("#waterCode").textbox('setValue',selected.code);
 	 $('#waterIsLeaf').combobox('reload'); 
	 $('#waterIsLeaf').combobox('setValue',(selected.isLeaf).toString() );
	 $('#belong_area').combotree('reload'); 
	 $('#belong_area').combotree('setValue', selected.area.code );
	 var url = ctx+"/water/getWaterByAreaCode?areaCode="+selected.area.code;
	 $('#waterParentId').combobox('reload',url); 
 	 $('#waterParentId').combobox('setValue', selected.parentCode );
	 $("#waterSortNum").textbox('setValue',selected.sortNum);
	 $("#waterIconCls").textbox('setValue',selected.iconCls);
	 $("#waterId").val(selected.id);
	 $("#waterSaveType").val("update");
}
function clearWaterForm(){
	 $("#waterName").textbox('setValue',"");
	 $("#waterCode").textbox('setValue',"");
 	 $('#waterIsLeaf').combobox('reload'); 
	 $('#waterParentId').combobox('reload'); 
	 $('#belong_area').combotree('clear'); 
	 $("#waterSortNum").textbox('setValue',"");
	 $("#waterIconCls").textbox('setValue',"");
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
$("#belong_area").combotree({
    url:'${ctx}/area/getAreasTree',
    valueField:'id',
    textField:'name',
    method:'GET',
 	onSelect:function(value){
   		$('#waterParentId').combobox('clear'); 
   		var url = ctx+"/water/getWaterByAreaCode?areaCode="+value.id;
   		$('#waterParentId').combobox('reload',url); 
   	} 
});
$("#waterParentId").combobox({
    url:'${ctx}/water/getWaterByAreaCode',
    valueField:'code',
    textField:'name',
    method:'GET'
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
		url:"${ctx}/water/updateStatus",
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
