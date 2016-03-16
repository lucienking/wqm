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
	 
	#monitorDataDetail_container td{border:solid black; border-width:1px 0px 0px 1px;}
	#monitorDataDetail_container table{ border:none;}
	#monitorDataDetail_container input[type="text"]{border:0px solid #c00;color:blue;readonly:readonly;}
	#selfsupp_search_table span{color:blue;}
</style>
<script type="text/javascript">
$(function(){
	$('#monitorDataDetail_container input').attr("readonly","readonly");
	
	$("input[name='personStatus']").each(function(){
		var num = parseInt($("#sf"+$(this).val()).html());
		$("#sf"+$(this).val()).html(num+1);
	});
	
	/*
	 * 关闭
	 */
	$(".detail_close_btn").click(function(){
		$("#monitorDataQueryDetailInfoDialog").dialog('close');
	});
	
	var totalNum = "${totalNum}";
	
	$(".addColspan").each(function(){
		var colspan = parseInt($(this).attr("colspan"));
		var add = totalNum -7;
		if(add>0)
			$(this).attr("colspan",colspan+add);
	});
});
</script>

<div id="monitorDataDetail_container" style="width:99%;height:99%;">
<div  class="easyui-tabs" style="width:99%;height:auto;">
<div title="详细信息" data-options="fit:true" style="padding-bottom:20px;">
</div>
<div title="家庭用地信息" style="padding-bottom:20px;" data-options="fit:true">
</div>
</div>
</div>

