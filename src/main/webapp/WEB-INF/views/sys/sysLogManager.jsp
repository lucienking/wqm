<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id= "sysLogContainer">
<div id="sysLogSearchConditionPanel" title="查询条件" class="easyui-panel" style="width:100%;padding-top:10px;">
	<form id="sysLogSearchConditionForm">
		<table style="width:99%;height:99%;margin-buttom:10px">
			<tr>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysLogName">操作账号</label>
					<input id="search_sysLogName" name="operateAccount" class="easyui-textbox" style="width:120px;"/>
				</td>
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysLogCode">操作模块</label>
					<input id="search_sysLogCode" name=operateModule class="easyui-textbox" style="width:120px;"/>
				</td>
				
				<td width="30%" align="center" style="min-width:150px">
					<label for="search_sysLogGroup">操作内容</label>
					<input id="search_sysLogGroup" name="operateContent" class="easyui-textbox" style="width:120px;"/>
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
				   <a class="easyui-linkbutton" href="#" id="sysLogSearchButton">&nbsp;查&nbsp;询&nbsp;</a>
				</td>
			</tr>
		</table>
	</form>
</div>
<div  id="sysLogSearchResultPanel" title="查询结果" class="easyui-panel" style="width:100%;">
	<table id="sysLogDatagrid" style="width:100%;"></table>
</div>

<div id="sysLogToolbar">
</div>

<script type="text/javascript">

/**
 *  datagrid 初始化 
 */
$('#sysLogDatagrid').datagrid({
    url:"${ctx}/sys/log/getSysLog",
    method:'get',
    pagination:true,
    columns:[[
        {field:'id',title:'编号',width:'5%',sortable:true},
        {field:'operateAccount',title:'操作账号',width:'10%'},
        {field:'operateModule',title:'操作模块',width:'10%'},
        {field:'operateContent',title:'操作内容',width:'30%'},
        {field:'operateIp',title:'操作IP',width:'10%'},
        {field:'operateBrowser',title:'操作客户端',width:'10%'},
        {field:'operateDate',title:'操作时间',width:'10%'} 
    ]],
    queryParams:$('#sysLogSearchConditionForm').getFormData(), 
    toolbar:"#sysLogToolbar" 
});

$('#sysLogSearchButton').click(function(){
	$('#sysLogDatagrid').datagrid('load',$('#sysLogSearchConditionForm').getFormData());
}); 

/**
 * 设置分页
 */
var p = $('#sysLogDatagrid').datagrid('getPager'); 
$(p).pagination({ 
    pageSize: 10,			//每页显示的记录条数，默认为15 
    pageList: [10,15,20]
}); 

</script>
</div>