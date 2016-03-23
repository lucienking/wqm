<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#monitorDataDetail_container td.query{
		font-size:12px;
		padding:0 2px;
 		text-align:center; 
	}
	#monitorDataDetail_container .red-line-border{
		border:1px solid red;
	}
	 
	#monitorDataDetail_container td{border:none;height:30px;width:33%}
	#monitorDataDetail_container table{ border:none;}
	#monitorDataDetail_container input[type="text"]{border:0px solid #c00;color:blue;readonly:readonly;}
	#selfsupp_search_table span{color:blue;}
</style>
<div id="monitorDataDetail_container" style="width:100%;height:100%;">
	<div id="monitorDataDetailTabs" class="easyui-tabs" style="width:100%;height:100%;">
		<div title="水体基本信息" data-options="fit:true" style="padding-bottom:20px;">
		<table style="width:99%;cellspacing:0;cellpadding:0;border-collapse:collapse;" align="center"  border="0" cellspacing="0" >
			<tr>
				<td width="33%">水体名称:${water.name}</td><td width="33%">所在区域:${water.area.name} </td><td width="33%">水体面积 :</td>
			</tr>
			<tr>
				<td>监测站名称:</td><td>监测频率: </td><td>监测站点: </td>
			</tr>
			<!-- <tr>
				<td height="20px" colspan="3" style="padding-top:15px;text-align:center;"> 
					<a href="#" class="easyui-linkbutton detail_close_btn" style="width:60px;">关闭</a>
				</td>
			</tr> -->
		</table>
		</div>
		<div title="水体监测信息" style="padding-bottom:20px;" data-options="fit:true">
			<input name="monitorDate" class="easyui-datebox" style="width:120px;"/>
			<a class="easyui-linkbutton" href="#" >查询</a>
			<table style="width:99%;cellspacing:0;cellpadding:0;border-collapse:collapse;" align="center"  border="0" cellspacing="0" >
				<tr>
					<c:forEach items="${waterMonitorData}" var="data" varStatus="i"> 
							<td>${data.itemName}:${data.itemValue}</td>
						<c:if test="${(i.index+1)%3==0}">
							</tr>
							<tr>
						</c:if>
					</c:forEach>
				</tr>
			</table>
		</div>
		<div title="水体水文信息" style="padding-bottom:20px;" data-options="fit:true">
		</div>
		<div title="水体综合信息" style="padding-bottom:20px;" data-options="fit:true">
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$('#monitorDataDetail_container input').attr("readonly","readonly");
	
	$(".detail_close_btn").click(function(){
		$("#monitorDataQueryDetailInfoDialog").dialog('close');
	});
	
	$('#monitorDataDetailTabs').tabs({
        plain:true
    });
	
	$(".detail_close_btn").click(function(){
		$("#monitorDataDetailDialog").dialog('close');
	});
});
</script>
