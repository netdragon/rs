﻿<%@ page contentType="text/html; charset=utf-8"%>
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
<title>设置成绩系数</title>
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


.STYLE1 {
	color: #FF3300;
	font-weight: bold;
	font-family: "宋体";
	font-size: 18px;
}

.con table {
	border: 1px solid #DFE7EC;
}
.km_bt {color: #0033FF; font-size: 16px; font-weight: bold; }
.STYLE2 {
	font-size: 12px;
	font-weight: bold;
}

-->
</style>
</head>

<body>
<br />
<div class="con">
<br />
<form action="" method="get">
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">设置成绩系数</span></td>
  </tr>
  </table>
  <br />
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19"><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">笔试系数：</td>
        <td width="67%" bgcolor="#FFFFFF"><input name="textfield" type="text" style="height:22px;" size="30"/></td>
      </tr>
      <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">面试系数：</td>
        <td width="67%" bgcolor="#FFFFFF"><input name="textfield" type="text" style="height:22px;" size="30"/></td>
      </tr>
    </table></td>
  </tr>

  <tr>
    <td height="33" align="center"><input type="button" name="Submit" value="修 改" /> 　
      <input type="submit" name="Submit2" value="取 消" />　
      </td>
  </tr>
</table>
</form>
</div>
</body>
</html>
