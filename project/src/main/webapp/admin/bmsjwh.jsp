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
<title>报名时间维护</title>
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
	color: #0033FF;
	font-weight: bold;
	font-family: "宋体";
	font-size: 18px;
}

.con table {
	border: 1px solid #DFE7EC;
}
.km_bt {color: #000000; font-size: 16px; font-weight: bold; }
.STYLE9 {
	color: #000000;
	font-size: 12px;
}
.p1{font-size:12px;color:black}
.STYLE10 {font-size: 14px}
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
<form action="/update_kssj" method="post">
<table width="498" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/bmsjwh0.png" width="34" height="34"  alt="pic"  align="absmiddle" /><span class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国石油大学（北京）<br />&nbsp;&nbsp;&nbsp;&nbsp;（<%=year%>）年自主选拔录取报名时间维护</span></td>
  </tr>
  </table>

<table width="498" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("bmsjwh.jsp");
	ArrayList al;
	SystemSettingsList ssl;
	SystemSettings ss;
	int bm_n,bm_y,bm_r;
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}

	try {
		Calendar cl = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	
		ssl = new SystemSettingsList();
		ssl.setItem("regStartDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				cl.setTime(sdf.parse(ss.getValue()));
		}
		bm_n = cl.get(Calendar.YEAR);
		bm_y = cl.get(Calendar.MONTH)+1;
		bm_r = cl.get(Calendar.DAY_OF_MONTH);
%>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="29%" height="38" bgcolor="#FFFFFF"><span class="km_bt">报名开始日期</span></td>
        <td width="71%" bgcolor="#FFFFFF">
		<select name="ksnian" >
<%
			for(int j = 2010; j < 2030; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_n) ? "selected":"")%>><%=j%></option>
<%
			}
%>
		</select>
          <span class="STYLE7 STYLE9 STYLE10"> 年</span>
          <select name="ksyue"  class="p1">
<%
			for(int j = 1; j < 13; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_y) ? "selected":"")%>><%=j%></option>
<%
			}
%>
          </select>
          <span class="STYLE9 STYLE10">月</span>
   <select name="ksri" class="p1" >
<%
			for(int j = 1; j < 32; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_r) ? "selected":"")%>><%=j%></option>
<%
			}
%>
	    </select>       
		<span class="STYLE9 STYLE10">日</span></td>
      </tr>
<tr>
<%
		cl = Calendar.getInstance();
		ssl.setItem("regEndDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				cl.setTime(sdf.parse(ss.getValue()));
		}
		bm_n = cl.get(Calendar.YEAR);
		bm_y = cl.get(Calendar.MONTH)+1;
		bm_r = cl.get(Calendar.DAY_OF_MONTH);
%>
<td height="38" bgcolor="#FFFFFF"><span class="km_bt">报名结束日期</span></td>
        <td bgcolor="#FFFFFF">
		<select name="jsnian" >
<%
			for(int j = 2010; j < 2030; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_n) ? "selected":"")%>><%=j%></option>
<%
			}
%>
		</select>
          <span class="STYLE7 STYLE9 STYLE10"> 年</span>
          <select name="jsyue"  class="p1">
<%
			for(int j = 1; j < 13; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_y) ? "selected":"")%>><%=j%></option>
<%
			}
%>
          </select>
          <span class="STYLE9 STYLE10">月</span>
   <select name="jsri" class="p1" >
<%
			for(int j = 1; j < 32; j++) {
%>
            <option value="<%=j%>" <%=((j == bm_r) ? "selected":"")%>><%=j%></option>
<%
			}
%>
	    </select>       
		<span class="STYLE9 STYLE10">日</span></td>

</tr>
    </table><br>
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
    <td align="center"><input type="submit" name="Submit" value="确 定" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subbmsj" value="取 消"  onclick="window.history.back();"/></td>
  </tr>
</table>
<input name="item" type="hidden" value="kssj">
</form>
</div>
</body>
</html>
