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
<title>发布重置</title>
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
</head>

<body>
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
%>
<br/>
<div class="con">
<br />
<form action="/update_fbcz" method="post">
  <table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("lq.jsp");
	ArrayList al;

	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}

	Calendar cl = Calendar.getInstance();
	int ks_n,ks_y,ks_r;
	String sj_s, sj_f;
	String[] sj;

	SystemSettingsList ssl;
	SystemSettings ss;
    boolean isPublic_Admission = false;
	boolean isPublic_Admit = false;
	boolean isPublic_Audit = false;
	boolean isPublic_Score = false;
	try {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ssl = new SystemSettingsList();
		ssl.setItem("isPublic_Admission");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			isPublic_Admission = ("1".equals(ss.getValue()));
		}
		ssl = new SystemSettingsList();
		ssl.setItem("isPublic_Admit");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			isPublic_Admit = ("1".equals(ss.getValue()));
		}
		ssl = new SystemSettingsList();
		ssl.setItem("isPublic_Audit");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			isPublic_Audit = ("1".equals(ss.getValue()));
		}
		ssl = new SystemSettingsList();
		ssl.setItem("isPublic_Score");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			isPublic_Score = ("1".equals(ss.getValue()));
		}
%>
	<br>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">发布重置</span></td>
  </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">审核结果发布：</td>
        <td width="67%" bgcolor="#FFFFFF"><input type="checkbox" <%=(isPublic_Audit?"checked":"")%> name="radiobutton_Audit" value="1" /></td>
      </tr>
	  <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">准考证发布：</td>
        <td width="67%" bgcolor="#FFFFFF"><input type="checkbox" <%=(isPublic_Admission?"checked":"")%> name="radiobutton_Admission" value="1" /></td>
      </tr>
	  <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">成绩发布：</td>
        <td width="67%" bgcolor="#FFFFFF"><input type="checkbox" <%=(isPublic_Score?"checked":"")%> name="radiobutton_Score" value="1" /></td>
      </tr>
	  <tr>
        <td width="33%" height="33" bgcolor="#FFFFFF" class="km_bt">录取结果发布：</td>
        <td width="67%" bgcolor="#FFFFFF"><input type="checkbox" <%=(isPublic_Admit?"checked":"")%> name="radiobutton_Admit" value="1" /></td>
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
<input name="item" type="hidden" value="kssj">
</form>
</div>
</body>
</html>
