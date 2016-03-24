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
	#waterInfoTable td{border:1px solid #95B8E7;}
	#baseInfoTable td{border:1px solid #95B8E7;}
</style>
<div id="monitorDataDetail_container" style="width:100%;height:100%;">
	<div id="monitorDataDetailTabs" class="easyui-tabs" style="width:100%;height:100%;">
		<div title="水体基本信息" data-options="fit:true" style="padding-bottom:20px;border:none;">
		<table id="baseInfoTable" style="width:99%;cellspacing:0;cellpadding:0;border-collapse:collapse;" align="center"  border="0" cellspacing="0" >
			<tr>
				<td width="33%">水体名称:${water.name}</td><td width="33%">所在区域:${water.area.name} </td><td width="33%">水体面积 :</td>
			</tr>
			<tr>
				<td>平均水深:</td><td>周边乡镇 :</td><td>周边人口:</td>
			</tr>
			<tr>
				<td>水体负责人:</td><td>联系方式 :</td><td>水质类别:  </td>
			</tr>
			<tr>
				<td>水体性质:</td><td>监测站点个数:</td><td>&nbsp;</td>
			</tr>
		</table>
		</div>
		<div title="水体水文信息" style="padding-bottom:20px;" data-options="fit:true">
			<table id="waterInfoTable" style="width:99%;cellspacing:0;cellpadding:0;border-collapse:collapse;" align="center"  border="0" cellspacing="0" >
				<tr>
					<td>当前水位:</td><td>预警水位:</td><td>历史最大水位:</td>
				</tr>
				<tr>
					<td>历史最低水位:</td><td>涨潮面积 :</td><td>低潮面积:  </td>
				</tr>
				<tr>
					<td>填报人:</td><td>联系方式:</td><td>&nbsp;</td>
				</tr>
			</table>
		</div>
		<div title="水体综合信息" style="padding-bottom:20px;" data-options="fit:true">
			图片、监控视频、文字资料
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
