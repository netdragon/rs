<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看录取结果</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}
.STYLE3 {color: #000000; font-weight: bold;font-size:18px
}
.STYLE4 {
	color: #0000FF;font-weight: bold;
}
.STYLE5 {color: #FF0000;font-weight: bold;}
.STYLE6 {
	color: #0033FF;
	font-size: 18px;
	font-weight: bold;
}
.STYLE7 {
	color: #330033;
	font-size: 16px;
}
.kslq{	
    color: #00A200;
	font-weight: bold;
}
p {
	text-indent: 40px;
}
-->
</style>

</head>
<%
	LogHandler logger=LogHandler.getInstance("luqu.jsp");
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;

	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	String s_isPublic = "";
	SystemSettingsList ssl;
	ArrayList al_settings;
	SystemSettings ss;
	String admitResultYes="&nbsp;";
	String admitResultNo="&nbsp;";

	try {

		ssl = new SystemSettingsList("isPublic_Admit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(!("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("录取结果未发布！").toUTF8String());
			return;
		}
		String bmxxId = (String)session.getAttribute("bmxxid");
		if(null == bmxxId){
            logger.error("没有报名信息！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名信息！").toUTF8String());
			return;
		}
		bmxxId = (null == bmxxId) ? "0":bmxxId;
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		if(al.size() == 0){
            logger.error("数据错误！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		if(bmxx.getShhqk() != 1) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("未通过初审，没有录取信息！").toUTF8String());
			return;
		} 
		

		ssl = new SystemSettingsList();
		ssl.setItem("admit_result_yes");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				admitResultYes=ss.getValue();
		}
		ssl = new SystemSettingsList();
		ssl.setItem("admit_result_no");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue() && ss.getValue().length() > 0)
				admitResultNo=ss.getValue();
		}
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
	
%>
<body>
<br /><br />
<%
	try{
%>
<%	
	String shqk = "";
	switch(bmxx.getSflq()) {
	case 1:
		shqk = "已录取";
		break;
	default:
		shqk = "未录取";
	}

	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>

<table width="520" border="0" cellspacing="2" cellpadding="0" align="center" bgcolor="#EEEEEE">

  <caption align="top">
    <span class="STYLE6">中国石油大学（北京）<%=year%>年自主选拔录取结果</span>
  </caption>
    <tr>
    <td  bgcolor="#FFFFFF"><span class="STYLE7">&nbsp;姓名：<span style="font-weight: bold"><%=bmxx.getKsxm()%></span></span>&nbsp;</td>
    <td  bgcolor="#FFFFFF" nowrap="nowrap"><span class="STYLE7">&nbsp;准考证号：<span style="font-weight: bold"><%=bmxx.getZhkzhid()%></span></span></td>
  </tr>
 <%if (shqk=="已录取"){ %>
  <tr>
    <td bgcolor="#FFFFFF"   colspan="2" valign="middle"><p style="color: #FF0000;font-weight: bold;font-size:20px"><%=admitResultYes%></p></td>
  </tr>
  <tr>
    <td height="40"  colspan="2" bgcolor="#FFFFFF" class="STYLE3">&nbsp;录取专业:&nbsp;&nbsp;&nbsp;&nbsp;<%=bmxx.getLqzy()%>&nbsp;</td>
  </tr>
<% } %>
<%if (shqk=="未录取"){ %>
  <tr>
    <td bgcolor="#FFFFFF"   colspan="2"  valign="middle"><p style="color: #FF0000;font-weight: bold;font-size:20px"><%=admitResultNo%></p></td>
  </tr>
<% } %>
</table>

</body>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
</html>
