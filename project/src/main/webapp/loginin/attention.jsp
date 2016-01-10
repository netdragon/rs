<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中国石油大学（北京）自主选拔录取报名须知</title>
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
	Random rd = new Random();
%>
<table width="560" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30" height="32"><img src="../images/attentionpic.gif" width="18" height="12" /></td>
    <td width="385"><strong><a href="../admin/jianzhang.html?random=<%=rd.nextInt()%>">招生简章</a></strong></td>
    <td width="145">&nbsp;</td>
  </tr>
  <tr>
    <td height="32"><img src="../images/attentionpic.gif" width="18" height="12" /></td>
    <td><strong><a href="../admin/bmlch.html?random=<%=rd.nextInt()%>">报名流程</a></strong></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="32"><img src="../images/attentionpic.gif" width="18" height="12" /></td>
    <td><strong><a href="../admin/bmzysx.html?random=<%=rd.nextInt()%>">报名注意事项</a></strong></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="1" colspan="3"></td>
  </tr>

</table>

</body>
</html>
