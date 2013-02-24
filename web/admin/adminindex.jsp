<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); 
LogHandler logger=LogHandler.getInstance("adminindex.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中国石油大学（北京）自主选拔录取网上报名系统－管理员工作首页</title>
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF; font-weight: bold; font-size: 16px; }
.STYLE1 a{
       color:#FFFFFF;
       text-decoration:none;
    }
.STYLE1 a:hover{
      color:#FFFF33;
      text-decoration:underline;
}
.con{	
	width:1010px;
	border: 1px solid #FFFFFF;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
}
.STYLE3 {color: #FFFF00}
body {
	margin-top: 0px;
	background-color: #F5FFFA;
}
.STYLE6 {color: #FFFF33; font-weight: bold; font-size: 16px; }

.STYLE6 a{
color:#FFFF00;
text-decoration:underline;

}
.STYLE6 a:hover{
color:#FFFFFF;
text-decoration:none;
}
-->
</style>
</head>

<body>
<div class="con">
<table width="100%" height="133" border="0" align="center" cellpadding="0" cellspacing="0" background="../images/adlogo.gif">
  <tr>
    <td height="35">&nbsp;</td>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td height="3"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr valign="middle">
    <td>
<table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bgcolor="#417FB9" align="center"><!--bgcolor="#8484FF"-->
  <tr>
    <td height="20" align="center" valign="middle"><img src="../images/admin02.gif" width="20" height="20" align="absmiddle" /><span class="STYLE1"><a href="xxdc.jsp" target="ifrm">报名数据导出&nbsp;&nbsp;&nbsp;</a></span><span class="STYLE3">｜</span>&nbsp;<img src="../images/admin03.gif" width="22" height="21" /><span class="STYLE1"><a href="chushen.jsp" target="ifrm">报名考生审核&nbsp;&nbsp;&nbsp;</a></span><span class="STYLE3">｜</span>&nbsp;<img src="../images/admin07.gif" width="17" height="17" /><span class="STYLE1"><a href="ksxxgl.jsp" target="ifrm">&nbsp;考试信息管理&nbsp;&nbsp;&nbsp;</a></span><span class="STYLE3">｜</span>&nbsp;<img src="../images/admin05.gif" width="15" height="15" /><span class="STYLE1"><a href="cjgl.jsp" target="ifrm">考试成绩管理&nbsp;&nbsp;</a></span><span class="STYLE3">｜</span>&nbsp;<img src="../images/admin04.gif" width="19" height="17" /><span class="STYLE1"><a href="xtwh.jsp" target="ifrm">系统维护&nbsp;&nbsp;</a></span><span class="STYLE3">｜</span>&nbsp;&nbsp;<img src="../images/admin08.gif" width="15" height="15" /><span class="STYLE6"><a href="../index.jsp" target="_self">退&nbsp;&nbsp;出&nbsp;</a></span></td>
    </tr>
</table>
</td>
  </tr>
 </table>
<table width="1010" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td height="2"></td>
  </tr>
</table>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center"><iframe src="welcome.html" name="ifrm" id="ifrm" scrolling="auto" width="100%" height="482"  align="center"    marginwidth="0" marginheight="0" frameborder="0"></iframe></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</div>
</body>
</html>
