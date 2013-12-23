<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专业信息</title>
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
.p1{font-size:12px;color:black}
.STYLE11 {font-size: 12}
.con .km_bt {
	font-size: 12px;
}
-->
</style>
<script>
	function addZy(){
	    var currentZyid = document.getElementById("zyid").value;
		if(currentZyid == null || currentZyid.length == 0){
			document.forms[0].action = "/add_zszy";
		} else {
			document.forms[0].action = "/update_zszy";
		}
		document.forms[0].method = "post";
		
		document.forms[0].submit();
	}
</script>
</head>

<body>
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
%>
<br/>
<div class="con">
<br />
<form action="" method="post">
  <table width="654" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td width="652" height="19">
<%
	LogHandler logger=LogHandler.getInstance("zy.jsp");
	String zyid = BaseFunction.null2value(request.getParameter("zyid"));
	String zymc = "";
	int zytype = 0;
	ArrayList al;
	ZhshzyList zyList;
	Zhshzy zy = null;
	int i = 0;
	DBOperator dbo = null;
	Sqbkly bkly;
	SqbklyList bklyList;
	ArrayList al_bkly = new ArrayList();

	dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	try{
		bklyList = new SqbklyList();
		al_bkly = dbo.getList(bklyList);
		if(null != zyid && zyid.length() > 0) {
			zyList = new ZhshzyList(zyid);
			al = dbo.getList(zyList);
			zy = (Zhshzy)al.get(0);
			zymc = zy.getZymc();
			zytype = zy.getType();
		}
	}catch(Exception e){
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有找到招生专业信息！").toUTF8String());
		return;
	}
	try {

%>
	<br>
<table width="654" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="587" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">招生专业信息</span></td>
  </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="13%" height="40" bgcolor="#FFFFFF" class="km_bt">类别</td>
        <td width="87%" bgcolor="#FFFFFF" class="km_bt">
<%
			for(i=0; i<al_bkly.size(); i++) {
				bkly = (Sqbkly) al_bkly.get(i);

%>
		<input type="radio" id="zytype" name="zytype"  <%=(bkly.getId() == zytype) ? "checked":""%> value="<%=bkly.getId()%>" />
        <span class="STYLE7 STYLE11"><%=bkly.getMc()%></span>&nbsp;&nbsp;
<%
			}
%>	  
	  </td>
      </tr>
      <tr>
        <td width="13%" height="40" bgcolor="#FFFFFF" class="km_bt">名称</td>
        <td width="87%" bgcolor="#FFFFFF" class="km_bt"><input size="20" maxlength="20" id="zymc" name="zymc" value="<%=zymc%>"></td>
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
    <td height="36" align="center"><input type="button" name="add" onclick="addZy()" value="确  定" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
</table>
<input id="zyid" name="zyid" type="hidden" value="<%=zyid%>">
</form>
</div>
</body>
</html>
