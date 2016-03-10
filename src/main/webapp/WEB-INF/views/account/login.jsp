<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="/public/common.jsp"%>
<title>网站管理员登陆</title>
<link rel="stylesheet" href="${ctx }/static/styles/back/login.css"/>
<body>
<div id="background_plain">
	<div class="middle_bg">
		<div class="middle_bg_pic"></div>
<!-- 		登录框 -->
		<div class="login_container">
			<div class="form_container">
				<div class='from_title'>水质监测后台管理系统</div>
				<div class="from_content">
					<form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal">
						<div class="inner_frame">
							<div class="input_frame">
								<div class="input_icon">
									<img src="${ctx}/static/image/login/username_icon.png">
								</div>
								<div class="input_text">用户名：&nbsp;</div>
								<div class="input_input">
									<input type="text" id="username" name="username" class="editbox4 required" value="${username}"/>
								</div>
							</div>
							
							<div class="input_frame">
								<div class="input_icon">
									<img src="${ctx}/static/image/login/password_icon.png">
								</div>
								<div class="input_text">密 码：&nbsp;</div>
								<div class="input_input">
									<input type="password" id="password" name="password" class="editbox4 required" value="${password}"/>
								</div>
							</div>
							
							<div class="input_frame">
								<div class="input_icon">
									<img src="${ctx}/static/image/login/empty_icon.png">
								</div>
								<div class="input_text">验证码：&nbsp;</div>
								<div class="input_input">
									<input type="text" id="verifycode" name="verifycode" class="editbox4 required" width="120"/>
								</div>
							</div>
							<%
								String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
								if(error != null){
								%>
									<div class="error_prompt">
										×登录失败，请重试
									</div>
								<%
								}
							%>
							
							<div class="input_frame">
								<div class="input_icon">
									<img src="${ctx}/static/image/login/empty_icon.png">
								</div>
								<input class="buttons" type="submit" value="登  录"/>
								<input class="buttons" type="reset" value="重  置"/>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		
	</div>
</div>
</body>
