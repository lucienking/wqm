<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/common/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div id="workbenchContainer">

	<!-- <div class="easyui-panel" style="position:relative;overflow:hidden;width:800px;height:800px">
	    <div class="easyui-draggable" data-options="onDrag:onDrag" style="width:100px;height:100px;background:#fafafa;border:1px solid #ccc;">
	    </div>
	</div> -->
<!-- 	 <script type="text/javascript">
	     function onDrag(e){
	         var d = e.data;
	         if (d.left < 0){d.left = 0;}
	         if (d.top < 0){d.top = 0;}
	         if (d.left + $(d.target).outerWidth() > $(d.parent).width()){
	             d.left = $(d.parent).width() - $(d.target).outerWidth();
	         }
	         if (d.top + $(d.target).outerHeight() > $(d.parent).height()){
	             d.top = $(d.parent).height() - $(d.target).outerHeight();
	         }
	     }
 	</script> -->
 	
</div>
