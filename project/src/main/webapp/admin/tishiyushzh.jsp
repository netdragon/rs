<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统提示语设置</title>
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
.km_bt {color: #0033FF; font-size: 14px; font-weight: bold; }
.STYLE9 {
	color: #000000;
	font-size: 12px;
}
.p1{font-size:12px;color:black}
-->
</style>
</head>

<body>
<br/>
<div class="con">
<br />
<form action="/update_tishiyu" method="post">
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="43" class="tdbline"><img src="../images/times.gif" alt="pic" width="20" height="20" align="absmiddle" /><span class="STYLE1">系统提示语设置</span></td>
  </tr>
  </table>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("tishiyushzh.jsp");
	DBOperator dbo = new DBOperator();

	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	ArrayList al;
	SystemSettingsList ssl;
	SystemSettings ss;

	String auditResultYes="";
	String auditResultNo="";
	String admitResultYes="";
	String admitResultNo="";
	try {

		ssl = new SystemSettingsList();
		ssl.setItem("audit_result_yes");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				auditResultYes=ss.getValue();
		}
%>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td  height="38" bgcolor="#FFFFFF"><span class="km_bt">审核通过提示语：</span></td>
        <td bgcolor="#FFFFFF">
		<textarea  name="auditResultYes" cols="50" rows="5"><%=auditResultYes%></textarea></td>
      </tr>
<tr>
<%
		ssl.setItem("audit_result_no");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				auditResultNo=ss.getValue();
		}
%>
<td height="38" nowrap="nowrap" bgcolor="#FFFFFF"><span class="km_bt">审核未通过提示语：</span></td>
        <td bgcolor="#FFFFFF">
		<textarea name="auditResultNo" cols="50" rows="5"><%=auditResultNo%></textarea></td>

</tr>
<tr>
<%
		ssl.setItem("admit_result_yes");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				admitResultYes=ss.getValue();
		}
%>
<td height="38" bgcolor="#FFFFFF"><span class="km_bt">录取提示语：</span></td>
        <td bgcolor="#FFFFFF">
		<textarea name="admitResultYes" cols="50" rows="5"><%=admitResultYes%></textarea></td>

</tr>
<tr>
<%
		ssl.setItem("admit_result_no");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				admitResultNo=ss.getValue();
		}
%>
<td height="38" bgcolor="#FFFFFF"><span class="km_bt">未录取提示语：</span></td>
        <td bgcolor="#FFFFFF">
		<textarea name="admitResultNo" cols="50" rows="5"><%=admitResultNo%></textarea></td>

</tr>
    </table>

<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</td>
  </tr>
  <tr>
    <td height="36" align="center"><input type="submit" name="Submit" value="确 定" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
</table>
</form>
</div>
</body>
</html>
