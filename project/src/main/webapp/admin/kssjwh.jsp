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
<title>系统参数设置</title>
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
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>
<br/>
<div class="con">
<br />
<form action="/update_kmsj" method="post">
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/times.gif" alt="pic" width="20" height="20" align="absmiddle" /><span class="STYLE1"><%=year%>年自主选拔录取考试时间维护</span></td>
  </tr>
  </table>

<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td height="19">
<%
	LogHandler logger=LogHandler.getInstance("lq.jsp");
	ArrayList al;
	KemulxList kl;
	Kemulx kemu;
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	kl = new KemulxList();
	al = dbo.getList(kl);
	Calendar cl = Calendar.getInstance();
	int ks_n,ks_y,ks_r;
	String sj_s, sj_f;
	String[] sj;

	SystemSettingsList ssl;
	SystemSettings ss;
	int bm_n,bm_y,bm_r;
	try {
		for(int i = 0; i<al.size(); i++) {
			kemu = (Kemulx)al.get(i);
			if(null != kemu.getKsrq()) {
				cl.setTime(kemu.getKsrq());
			}
			ks_n = cl.get(Calendar.YEAR);
			ks_y = cl.get(Calendar.MONTH)+1;
			ks_r = cl.get(Calendar.DAY_OF_MONTH);
		
%>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="22%" height="28" align="left" bgcolor="#FFFFFF"><span class="km_bt">科目名称</span></td>
        <td width="78%" align="left" bgcolor="#FFFFFF"><%=kemu.getLxmc()%>&nbsp;<input type="button" value="科目管理" onclick="window.location.assign('kemulist.jsp?kmlxid=<%=kemu.getLxid()%>');"></td>
      </tr>
      <tr>
        <td height="28" bgcolor="#FFFFFF"><span class="km_bt">考试日期</span></td>
        <td bgcolor="#FFFFFF">
		<select name="ksnian_<%=kemu.getLxid()%>" >
<%
			for(int j = 2014; j < 2020; j++) {
%>
            <option value="<%=j%>" <%=((j == ks_n) ? "selected":"")%>><%=j%></option>
<%
			}
%>
		</select>
          <span class="STYLE7 STYLE9"> 年</span>
          <select name="ksyue_<%=kemu.getLxid()%>"  class="p1">
<%
			for(int j = 1; j < 13; j++) {
%>
            <option value="<%=j%>" <%=((j == ks_y) ? "selected":"")%>><%=j%></option>
<%
			}
%>
          </select>
          <span class="STYLE9">月</span>
   <select name="ksri_<%=kemu.getLxid()%>" class="p1" >
<%
			for(int j = 1; j < 32; j++) {
%>
            <option value="<%=j%>" <%=((j == ks_r) ? "selected":"")%>><%=j%></option>
<%
			}
%>
	    </select>       
		<span class="STYLE9">日</span></td>
      </tr>
<%
			sj_s = "8";
			sj_f = "0";
			if(null != kemu.getKssj()) {
				sj = kemu.getKssj().split(":");
				if(sj.length == 2) {
					sj_s = sj[0];
					sj_f = sj[1];
				}
			}
%>
      <tr>
        <td height="28" bgcolor="#FFFFFF" class="km_bt">开始时间</td>
        <td bgcolor="#FFFFFF">
		<select name="ksdian_<%=kemu.getLxid()%>"  class="p1">
<%
			for(int j = 6; j < 24; j++) {
%>
            <option value="<%=j%>" <%=((j == Integer.parseInt(sj_s)) ? "selected":"")%>><%=j%></option>
<%
			}
%>
          </select><span class="STYLE9">点</span><select name="ksfen_<%=kemu.getLxid()%>"  class="p1">
<%
			for(int j = 0; j < 12; j++) {
				if(j<2) {
%>
            <option value="<%=(j*5)%>" <%=(((j*5) == Integer.parseInt(sj_f)) ? "selected":"")%>>0<%=(j*5)%></option>
<%
				}else{
%>
            <option value="<%=(j*5)%>" <%=(((j*5) == Integer.parseInt(sj_f)) ? "selected":"")%>><%=(j*5)%></option>
<%
				}
			}
%>
          </select><span class="STYLE9">分</span></td>
      </tr>
<%
			sj_s = "8";
			sj_f = "0";
			if(null != kemu.getJssj()) {
				sj = kemu.getJssj().split(":");
				if(sj.length == 2) {
					sj_s = sj[0];
					sj_f = sj[1];
				}
			}
%>
      <tr>
        <td height="28" bgcolor="#FFFFFF" class="km_bt">结束时间</td>
        <td bgcolor="#FFFFFF"> <select name="jsdian_<%=kemu.getLxid()%>"  class="p1">
<%
			for(int j = 6; j < 24; j++) {
%>
            <option value="<%=j%>" <%=((j == Integer.parseInt(sj_s)) ? "selected":"")%>><%=j%></option>
<%
			}
%>
          </select><span class="STYLE9">点</span><select name="jsfen_<%=kemu.getLxid()%>"  class="p1">
<%
			for(int j = 0; j < 12; j++) {
				if(j<2) {
%>
            <option value="<%=(j*5)%>" <%=(((j*5) == Integer.parseInt(sj_f)) ? "selected":"")%>>0<%=(j*5)%></option>
<%
				}else{
%>
            <option value="<%=(j*5)%>" <%=(((j*5) == Integer.parseInt(sj_f)) ? "selected":"")%>><%=(j*5)%></option>
<%
				}
			}
%>
          </select><span class="STYLE9">分</span></td>
      </tr>
    </table>
<%
		}
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
	<br>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="22%" height="38" bgcolor="#FFFFFF"><span class="km_bt">报名开始日期</span></td>
        <td width="78%" bgcolor="#FFFFFF">
		<select name="ksnian" >
<%
			for(int j = 2013; j < 2020; j++) {
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
			for(int j = 2014; j < 2020; j++) {
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
    </table>
<%
		ssl = new SystemSettingsList();
		ssl.setItem("rate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
%>
<table width="522" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="600" height="43" class="tdbline"><img src="../images/zkzpic01.gif" alt="pic" width="40" height="42" align="absmiddle" /><span class="STYLE1">设置成绩系数</span></td>
  </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td width="22%" height="33" bgcolor="#FFFFFF" class="km_bt">笔试系数：</td>
        <td width="78%" bgcolor="#FFFFFF"><input name="rate" type="text" value="<%=ss.getValue()%>" style="height:22px;" size="10"/>面试系数=1－笔试系数</td>
      </tr>
   </table>
<%
		}
%>
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
