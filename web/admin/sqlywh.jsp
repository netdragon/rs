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
<title>申请理由维护</title>
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
-->
</style>
<script>
	function deleteLy(name){
	    if(!window.confirm("您将要删除'" + name + "'申请理由，请确认。")) return;
		document.getElementById("mc").value = name;
		document.forms[0].method = "post";
		document.forms[0].action = "/delete_sqbkly";
		document.forms[0].submit();
	}
	function addsqbkly(){
		window.location.assign('sqly.jsp');;
	}
</script>
</head>

<body>

<br/>
<div class="con">
<br />
<form action="" method="post">
  <table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("sqlywh.jsp");
	ArrayList al;
	SqbklyList sqbklyList;
	Sqbkly sqbkly;
	SystemSettingsList ssl;
	SystemSettings ss;
	int i = 0;
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
		Calendar c_curr = Calendar.getInstance();
		Calendar cl = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				

		ssl = new SystemSettingsList();
		ssl.setItem("regStartDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue())
				cl.setTime(sdf.parse(ss.getValue()));
		}

		ssl.setItem("regEndDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue())
				c2.setTime(sdf.parse(ss.getValue()));
		}
		if(c_curr.after(cl) && c_curr.before(c2)) {
			response.sendRedirect("/error.jsp?error=" + new UTF8String("在本期报名时间内不能修改申请理由，否则会引起数据不一致!").toUTF8String());
			return;
		}
		sqbklyList = new SqbklyList();
		al = dbo.getList(sqbklyList);
%>
	<br>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">申请理由维护(注：在本期报名时间内不能修改申请理由设置，否则会引起数据不一致。)</span></td>
  </tr>
    <tr>
    <td align="right"><input type="button" name="add" onclick="addsqbkly()" value="增  加" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="80%" align="center" bgcolor="#FFFFFF" class="km_bt">名&nbsp;&nbsp;称</td>
		<td width="20%" bgcolor="#FFFFFF">&nbsp;</td>
      </tr>  
  <%
		for(i=0; i<al.size(); i++) {
			sqbkly = (Sqbkly)al.get(i);
			if(null == sqbkly.getMc() || 0 == sqbkly.getMc().length()) continue;
  %>
      <tr>
        <td width="80%" bgcolor="#FFFFFF" class="km_bt"><a href="sqly.jsp?mc=<%=sqbkly.getMc()%>"><%=sqbkly.getMc()%></a> </td>
		<td width="20%" bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="button" onclick="deleteLy('<%=sqbkly.getMc()%>', '<%=sqbkly.getMc()%>')" value="删除"></td>
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
<input id="mc" name="mc" type="hidden" value="">
</form>
</div>
</body>
</html>
