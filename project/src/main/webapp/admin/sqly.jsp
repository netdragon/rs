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
<title>面试分组</title>
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
	function addLy(){
	    var id = document.getElementById("original_id").value;
		if(id == null || id.length == 0){
			document.forms[0].action = "/add_sqbkly";
		} else {
			document.forms[0].action = "/update_sqbkly";
		}
		document.forms[0].method = "post";
		
		document.forms[0].submit();
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
	LogHandler logger=LogHandler.getInstance("sqly.jsp");
	String id_para = BaseFunction.null2value(request.getParameter("id"));
	String mc_para = BaseFunction.null2value(request.getParameter("mc"));
	String type_para = BaseFunction.null2value(request.getParameter("type"));
	String mc = new String(mc_para.getBytes("iso8859-1"), "utf-8");
	try {
%>
	<br>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">面试分组</span></td>
  </tr>
  </table>

  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="28%" height="40" bgcolor="#FFFFFF" class="km_bt">科&nbsp;类</td>
        <td width="72%" bgcolor="#FFFFFF" class="km_bt">
		<input type="radio" id="zytype" name="zytype"  <%=("0".equals(type_para)) ? "checked":""%> value="0" />文史&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="zytype" type="radio" id="zytype" value="1"  <%=("1".equals(type_para)) ? "checked":""%> />
		理工
		</td>
      </tr> 
      <tr>
        <td width="28%" height="40" bgcolor="#FFFFFF" class="km_bt">面试分组</td>
        <td width="72%" bgcolor="#FFFFFF" class="km_bt"><input size="20" maxlength="20" id="mc" name="mc" value="<%=mc%>"></td>
      </tr>  
   </table>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
	</td>
  </tr>
  <tr>
    <td height="36" align="center"><input type="button" name="add" onclick="addLy()" value="确  定" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subkssj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
</table>
<input id="original_id" name="original_id" type="hidden" value="<%=id_para%>">
</form>
</div>
</body>
</html>
