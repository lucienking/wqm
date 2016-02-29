<%@ page pageEncoding="UTF-8" import="java.util.ResourceBundle"%> 
<% ResourceBundle res = ResourceBundle.getBundle("application.properties"); 
   String arcgisUrl = res.getString("arcgis.service.url") ;
%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div>
<%-- <form id="meunDataForm" style="margin:10px" >
		<input type="hidden" id="menuId" name="id"  value="${menu.id }"></input>
		<input type="hidden" id="menuCreateDate" name="createDate" value="${menu.createDate }" >
		<input type="hidden" id="saveType" name ="saveType" value="${saveType }"></input>
		<div class="line-div">
			菜单名称：
			<input id="menuName" name="name" value="${menu.name }" class="easyui-textbox" style="width:120px;"/>
			菜单状态：
			<input id="menuStatus" name="menuStatus" value ="${ menu.menuStatus}" class="easyui-textbox" style="width:120px;"/> 
		</div>
		<div class="line-div">
			菜单权限：
			<input id="menuAuthorId" name="authorId" value="${menu.authorId }" class="easyui-textbox" style="width:120px;"/>
			菜单类型：
			<select id="menuIsLeaf" class="easyui-combobox"  name="isLeaf" style="width:120px;">
			    <option value="false"
			    <c:if test="${menu.isLeaf == false}">
			     selected= "true"
			    </c:if>
			    >栏目</option>
			    <option value="true"
			    <c:if test="${menu.isLeaf == true}">
			     selected= "true"
			    </c:if>
			    >菜单</option>
			</select>
		</div>
		<div class="line-div">
			菜单顺序：
			<input id="menuSortNum" name="sortNum" value="${menu.sortNum }" class="easyui-textbox" style="width:120px;"/>
			父菜单号：
			<input id="menuParentId" name="parentId" style="width:120px;" value="${menu.parentId }"/>
		</div>
		<div class="line-div">
			菜单链接：
			<input id="menuUrl" name="menuUrl" value="${menu.menuUrl }" class="easyui-textbox" style="width:310px;"/>
		</div>
	</form> --%>
	
<script type="text/javascript">
	/**
	 * 父菜单选项
	 */
	$("#menuParentId").combobox({
	    url:'${ctx}/sys/menu/getParents',
	    valueField:'id',
	    textField:'name',
	    method:'GET'
	});
	
</script>
</div>