<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>招生专业维护</title>
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
.STYLE9 {
	color: #000000;
	font-size: 12px;
}
.p1{font-size:12px;color:black}

.con .km_bt a {
	color: #0066FF;
	text-decoration: none;
}
.con .km_bt a:hover {
	color: #990000;
	text-decoration: none;
}
-->
-->
</style>
<script>
	function deleteZy(value, name){
	    if(!window.confirm("您将要删除" + name + "专业，请确认。")) return;
		document.getElementById("zyid").value = value;
		document.forms[0].method = "post";
		document.forms[0].action = "/delete_zszy";
		document.forms[0].submit();
	}
	function addZy(){
		window.location.assign('zy.jsp');;
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
  <table width="534" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("zywh.jsp");
	ArrayList al;
	ZhshzyList zyList;
	Zhshzy zy;
	Sqbkly bkly;
	SqbklyList bklyList;
	ArrayList al_bkly;
	int i = 0;
	HashMap hm_sqly= new HashMap();
	HashMap hm_sqly_kelei= new HashMap();
	DBOperator dbo = new DBOperator();
	
	String userId = (String)session.getAttribute("user_id");
	if(null == userId){
           logger.error("没有登录信息！");
           response.sendRedirect("/error.jsp?error=" + new UTF8String("没有登录信息！").toUTF8String());
		return;
	}
	
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}

	try {
		bklyList = new SqbklyList();
		al_bkly = dbo.getList(bklyList);
		for(i=0; i<al_bkly.size(); i++) {
		    bkly = (Sqbkly) al_bkly.get(i);
		    hm_sqly.put(bkly.getId()+ "", bkly.getMc());
			hm_sqly_kelei.put(bkly.getId()+ "", (1==bkly.getType())?"理工":"文史");
		}
		zyList = new ZhshzyList();
		al = dbo.getList(zyList);
%>
	<br>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">招生专业维护(注：在本期报名时间内不能修改专业设置，否则会引起数据不一致。)</span></td>
  </tr>
    <tr>
    <td align="right"><input type="button" name="add" onclick="addZy()" value="增  加" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="20%" align="center" nowrap="nowrap" bgcolor="#FFFFFF" class="km_bt">类&nbsp;&nbsp;别</td>
        <td width="60%" align="center" bgcolor="#FFFFFF" class="km_bt">名&nbsp;&nbsp;称</td>
		<td width="20%" bgcolor="#FFFFFF">&nbsp;</td>
      </tr>  
  <%
		for(i=0; i<al.size(); i++) {
			zy = (Zhshzy)al.get(i);
			if(null == zy.getZymc() || 0 == zy.getZymc().length()) continue;
  %>
      <tr>
        <td width="20%" nowrap="nowrap" bgcolor="#FFFFFF" class="km_bt"><%=hm_sqly.get(zy.getType()+"")%>(<%=hm_sqly_kelei.get(zy.getType()+"")%>)</td>
        <td width="60%" bgcolor="#FFFFFF" class="km_bt"><a href="zy.jsp?zyid=<%=zy.getZyid()%>"><%=zy.getZymc()%></a> </td>
		<td width="20%" bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="button" onclick="deleteZy('<%=zy.getZyid()%>', '<%=zy.getZymc()%>')" value="删除"></td>
      </tr>
<%
		}
%>
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

</table>
<input id="zyid" name="zyid" type="hidden" value="-100">
</form>
</div>
</body>
</html>
