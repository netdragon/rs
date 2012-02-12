<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Calendar" %>
<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>修改用户注册信息</title>
<style type="text/css">
<!--
body {

	margin-left: 0px;
	margin-top: 80px;
	margin-right: 0px;
	margin-bottom: 0px;
	
}

a {
	color: #4D4DFF;
	text-decoration: none;
}
a:hover{
	color: #FF3300;
	text-decoration: underline;
}
.tdbl{
	
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #3777BC;
}
-->
</style>
</head>

<body>
<%
	Calendar c = Calendar.getInstance();
	long timestamp = c.getTimeInMillis();
%>
<table width="560" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
    <td height="32"><img src="../images/modipic.gif" width="15" height="15" /></td>
    <td><strong><a href="modipwd.jsp?<%=timestamp%>">重设密码</a></strong></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="35" height="32"><img src="../images/modipic.gif" width="15" height="15" /></td>
    <td width="380"><strong><a href="modixx.jsp?<%=timestamp%>">修改注册信息</a></strong></td>
    <td width="145">&nbsp;</td>
  </tr>
 
  <tr>
    <td height="1" colspan="3"></td>
  </tr>
  <tr>
    <td height="50" colspan="3" align="center"><a href="../index.jsp"></a></td>
  </tr>
</table>


</body>
</html>
