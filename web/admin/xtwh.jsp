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
<title>自主选拔录取网上报名系统维护</title>
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

.zh {
	font-size: 12px;
	color: #FFFFFF;
	background-color: #007976;
	padding-top:2px;
  }
.zh2 {
	color: #FFFFFF;
	background-color: #B5A208;
	padding-top:2px;
}
.zh3 {
	color: #FFFFFF;
	background-color: #F79E00;	
	padding-top:2px;
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
    <td height="43" colspan="2" class="tdbline"><img src="../images/xtwhpic.gif" alt="pic" width="31" height="30" align="absmiddle" /><span class="STYLE1">系统维护</span></td>
  </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('kssjwh.jsp');" class="zh2" value="系统参数设置" />
	</td>
   </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('zywh.jsp');" class="zh2" value="招生专业设置" />
	</td>
   </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('edit_static_page.jsp');" class="zh2" value="招生简章维护" />
	</td>
   </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('fbcz.jsp');" class="zh2" value="发 布 重 置" />
	</td>
   </tr>
  <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('logslist.jsp');" class="zh2" value="系 统 日 志" />
	</td>
   </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
  <tr>
    <td height="36" align="right"><img src="../images/zkzpic2.gif" width="15" height="10" /></td>
    <td height="44">&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.location.assign('../register/modipwd.jsp');" class="zh3" value="修 改 密 码" />
	</td>
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
