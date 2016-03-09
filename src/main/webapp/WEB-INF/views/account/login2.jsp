<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@include file="/public/common.jsp"%>
<title>网站管理员登陆</title>
<style type="text/css">
.login_top_bg {
	background-image: url(${ctx}/static/image/login/login-top-bg.gif);
	background-repeat: repeat-x;
}
.body {
	background-color: #EEF2FB;
	left: 0px;
	top: 0px;
	right: 0px;
	bottom: 0px;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #1D3647;
}

.login-buttom-bg {
	background-image: url(${ctx}/static/image/login/login-buttom-bg.gif);
	background-repeat: repeat-x;
}
.login-buttom-txt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #ABCAD3;
	text-decoration: none;
	line-height: 20px;
}
.login_txt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	color: #333333;
}
.Submit {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #629DAE;
	text-decoration: none;
	background-image: url(${ctx}/static/image/login/Submit_bg.gif);
	background-repeat: repeat-x;
}
.login_bg {
	background-image: url(${ctx}/static/image/login/login_bg.jpg);
	background-repeat: repeat-x;
}
.login_bg2 {
	background-image: url(${ctx}/static/image/login/login-content-bg.gif);
	background-repeat: no-repeat;
	background-position: right;
}

.admin_txt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #FFFFFF;
	text-decoration: none;
	height: 38px;
	width: 100%;
	position: 固定;
	line-height: 38px;
}
.login_txt_bt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	line-height: 25px;
	color: #666666;
	font-weight: bold;
}
.admin_topbg {
	background-image: url(${ctx}/static/image/login/top-right.gif);
	background-repeat: repeat-x;
}
.txt_bt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	text-decoration: none;
}
.left_topbg {
	background-image: url(${ctx}/static/image/login/content-bg.gif);
	background-repeat: repeat-x;
}
.admin_toptxt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #4A8091;
	height: 18px;
	width: 100%;
	overflow: hidden;
	position: 固定;
}

.left_bt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #395a7b;
}
.left_bt2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #333333;
}
.titlebt {
	font-size: 12px;
	line-height: 26px;
	font-weight: bold;
	color: #000000;
	background-image: url(${ctx}/static/image/login/top_bt.jpg);
	background-repeat: no-repeat;
	display: block;
	text-indent: 15px;
	padding-top: 5px;
}

.left_txt {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	color: #666666;
}
.left_txt2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	color: #000000;
}
.nowtable {
	background-color: #e1e5ee;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-top-color: #bfc4ca;
	border-right-color: #bfc4ca;
	border-bottom-color: #bfc4ca;
	border-left-color: #bfc4ca;
}
.left_txt3 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	color: #003366;
	text-decoration: none;
}



.left_ts {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FF6600;
}
.line_table {
	border: 1px solid #CCCCCC;
}
.sec1 {
	CURSOR: hand;
	COLOR: #000000;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	border: 1px solid #B5D0D9;
	background-image: url(${ctx}/static/image/login/right_smbg.jpg);
	background-repeat: repeat-x;
}
.sec2 {
	FONT-WEIGHT: bold;
	CURSOR: hand;
	COLOR: #000000;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 25px;
	background-color: #e2e7ed;
	border: 1px solid #e2e7ed;
}
.main_tab {
	COLOR: #000000;
	BACKGROUND-COLOR: #e2e7ed;
	border: 1px solid #e2e7ed;
}
.MM a {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #666666;
	background-image: url(${ctx}/static/image/login/menu_bg.gif);
	background-repeat: no-repeat;
	list-style-type: none;
	list-style-image: none;
}
a:link {
	font-size: 12px;
	line-height: 25px;
	color: #333333;
	text-decoration: none;
}
a:hover {
	font-size: 12px;
	line-height: 25px;
	color: #666666;
	text-decoration: none;
}
a:visited {
	font-size: 12px;
	line-height: 25px;
	color: #333333;
	text-decoration: none;
}


.MM a:link {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	line-height: 26px;
	color: #666666;
	background-image: url(${ctx}/static/image/login/menu_bg.gif);
	background-repeat: no-repeat;
	list-style-type: none;
	list-style-image: none;
}

</style>


<body>
<table width="100%" height="166" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10%" valign="top"><table width="100%" height="42" border="0" cellpadding="0" cellspacing="0" class="login_top_bg">
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><table width="100%" height="532" border="0" cellpadding="0" cellspacing="0" class="login_bg">
      <tr>
        <td width="49%" align="right">&nbsp;</td>
        <td width="1%" >&nbsp;</td>
        <td width="50%" valign="bottom"><table width="100%" height="59" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="4%">&nbsp;</td>
              <td width="96%" height="38"><span class="login_txt_bt">登陆后台管理</span></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td height="21"><table cellSpacing="0" cellPadding="0" width="100%" border="0" id="table211" height="328">
                  <tr>
                    <td height="164" colspan="2" align="middle">
                    <form id="loginForm" action="${ctx}/login" method="post" class="form-horizontal">
                        <table cellSpacing="0" cellPadding="0" width="100%" border="0" height="143" id="table212">
                          <tr>
                            <td width="13%" height="38" class="top_hui_text"><span class="login_txt">管理员：&nbsp;&nbsp; </span></td>
                            <td height="38" colspan="2" class="top_hui_text">
								<input type="text" id="username" name="username"  value="${username}" class="editbox4 required"/>
							</td>
                          </tr>
                          <tr>
                            <td width="13%" height="35" class="top_hui_text"><span class="login_txt"> 密 码： &nbsp;&nbsp; </span></td>
                            <td height="35" colspan="2" class="top_hui_text">
								<input type="password" id="password" name="password" class="editbox4 required"/>
                              <img src="${ctx}/static/image/login/luck.gif" width="19" height="18"> </td>
                          </tr>
                          <tr>
                            <td width="13%" height="35" ><span class="login_txt">验证码：</span></td>
                            <td height="35" colspan="2" class="top_hui_text"><input class=wenbenkuang name=verifycode type=text value="" maxLength=4 size=10>
                              </td>
                          </tr>
                          <%
						String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
						if(error != null){
						%>
							<div class="alert alert-error input-medium controls">
								<button class="close" data-dismiss="alert">×</button>登录失败，请重试.
							</div>
						<%
						}
						%>
                          <tr>
                            <td height="35" >&nbsp;</td>
                            <td width="20%" height="35" ><input name="Submit" type="submit" class="button" id="Submit" value="登 陆"> </td>
                            <td width="67%"><input name="cs" type="button" class="button" id="cs" value="取 消"></td>
                          </tr>
                        </table>
                        <br>
                    </form></td>
                  </tr>
                  <tr>
                    <td width="433" height="164" align="right" valign="bottom"><img src="${ctx}/static/image/login/login-wel.gif" width="242" height="138"></td>
                    <td width="57" align="right" valign="bottom">&nbsp;</td>
                  </tr>
              </table></td>
            </tr>
          </table>
          </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="20%">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="login-buttom-bg">
	      <tr>
	        <td align="center"><span class="login-buttom-txt">Copyright &copy; 2009-2010 www.865171.cn</span></td>
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</body>
