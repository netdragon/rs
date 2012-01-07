<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>自主选拔录取成绩管理</title>
<style type="text/css">
<!--
.con{
	width:980px;
	height:970px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	border-top-width: 2px;
	border-right-width: 2px;
	border-bottom-width: 2px;
	border-left-width: 2px;
	border-top-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-left-style: solid;
	border-top-color: #CCCCCC;
	border-right-color: #CCCCCC;
	border-bottom-color: #CCCCCC;
	border-left-color: #CCCCCC;
	}
.con .tdbline {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #E3E3E3;
}
 input{
 width:90px;
 height:30px;}

.STYLE1 {
	color: #FF3300;
	font-weight: bold;
	font-family: "宋体";
	font-size: 18px;
}
.dx {
	background-color: #FF3300;
	color: #FFFFFF;
}
.zh {
	font-size: 12px;
	color: #FFFFFF;	
	padding-top:2px;
	background-color: #007976;
}
.zh2 {
	color: #FFFFFF;	
	padding-top:2px;
	background-color: #B5A208;
}
.zh3 {
	color: #FFFFFF;	
	padding-top:2px;
	background-color: #F79E00;
}
.con table {
	border: 1px solid #DFE7EC;
}
-->
</style>
</head>

<body>
<br/>
<div class="con">
<br />
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="43" colspan="2" class="tdbline"><img src="../images/chspic2.gif" alt="pic" width="32" height="32" align="absmiddle" /><span class="STYLE1">自主选拔录取入学考试成绩管理</span></td>
  </tr>
  <tr>
    <td width="37" height="44" align="right"><a href="qrbmf.jsp"><img src="../images/zkzpic2.gif" width="15" height="10" border="0" /></a></td>
    <td width="563">&nbsp;&nbsp;<input name="Submit" type="button" class="zh2" onclick="window.location.assign('lrlq.jsp');" value="成绩录入" /></td>
  </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
   <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('lq.jsp');" class="zh2" value="考生录取" /></td>
   </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
   <tr>
    <td height="19" colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
</div>
</body>
</html>
