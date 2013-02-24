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
<title>考试科目</title>
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
	function addNew(){
	    var mc = document.getElementById("kmidkey").value;
		if(mc == null || mc.length == 0){
			document.forms[0].action = "/add_kemu";
		} else {
			document.forms[0].action = "/update_kemu";
		}
		document.forms[0].method = "post";
		
		document.forms[0].submit();
	}
</script>
</head>

<body>
<%
	LogHandler logger=LogHandler.getInstance("kemu.jsp");
	ArrayList al;
	KemuList kmList;
	Kemu km;
	String kmmc = "";

	DBOperator dbo = new DBOperator();
	String kmid = request.getParameter("kmid");
	String kmlxid = request.getParameter("kmlxid");
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

%>
<br/>
<div class="con">
<br />
<form action="" method="post">
  <table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%

	try {
		if(kmid != null) {
			kmList = new KemuList(Integer.parseInt(kmid));
			al = dbo.getList(kmList);
			if(al.size() == 1) {
				km = (Kemu)al.get(0);
				kmmc = km.getKmmc();
			}
		} else {
			kmmc = "";
			kmid = "";
		}
%>
	<br>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">考试科目</span></td>
  </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">

      <tr>
        <td width="30%" bgcolor="#FFFFFF" class="km_bt">科目名称</td>
        <td width="70%" bgcolor="#FFFFFF" class="km_bt"><input size="20" maxlength="20" id="kmmc" name="kmmc" value="<%=kmmc%>"></td>
      </tr>  
   </table>
	</td>
  </tr>
  <tr>
    <td height="36" align="center"><input type="button" name="add" onclick="addNew()" value="确  定" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
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
<input id="kmidkey" name="kmidkey" type="hidden" value="<%=kmid%>">
<input id="kmlxidkey" name="kmlxidkey" type="hidden" value="<%=kmlxid%>">

</form>
</div>
</body>
</html>
