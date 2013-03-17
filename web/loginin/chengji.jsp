<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*"%>

<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看考试成绩</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}
.STYLE3 {color: #FFFFFF; font-weight: bold;font-size:18px
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
	font-size: 14px;
}


-->
</style>

</head>
<%

	LogHandler logger=LogHandler.getInstance("chengji.jsp");
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;
	boolean isPublicScoreExtra = false;
	boolean isPublicScore = false;

	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	String s_isPublic = "";
	String cj = "", cjName = "";
	SystemSettingsList ssl;
	ArrayList al_settings;
	ArrayList al_score;
	Kemu km;
	KemuList kl = new KemuList(); 
	HashMap<String, String> hmScore = null;

	try {
		hmScore = new HashMap<String, String>();
		ArrayList alKm = dbo.getList(kl);
		int kmLen = alKm.size();
		for(int i=0; i<kmLen; i++) {
			km = (Kemu) alKm.get(i);
			hmScore.put(km.getKmid() +"",km.getKmmc());
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
		ssl = new SystemSettingsList("isPublic_ScoreExtra");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) 
			s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		else 
			s_isPublic = "";

		if("1".equals(s_isPublic)) {
			isPublicScoreExtra = true;
		}
		ssl = new SystemSettingsList("isPublic_Score");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) 
			s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		else 
			s_isPublic = "";

		if("1".equals(s_isPublic)) {
			isPublicScore = true;
		}
		if(!isPublicScore && !isPublicScoreExtra) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("考试成绩未发布！").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		if(bmxx.getShhqk() != 1) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("未通过初审，没有成绩信息！").toUTF8String());
			return;
		} 

		
%>
<body>
<br /><br />
<%
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);		
%>

<table width="478" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td colspan="2" align="center"  bgcolor="#FFFFFF" class="STYLE6">中国石油大学（北京）<%=year%>年自主选拔录取入学考试成绩</td>
  </tr>
    <tr>
    <td width="175"  bgcolor="#FFFFFF"><span class="STYLE7">姓名：<%=bmxx.getKsxm()%></span></td>
    <td width="222"  bgcolor="#FFFFFF"><span class="STYLE7">准考证号：<%=bmxx.getZhkzhid()%></span></td>
  </tr>
</table>
<table width="478" border="0" cellspacing="2" cellpadding="0" align="center" bgcolor="#EEEEEE">
  <tr bgcolor="#3E3EFF">
    <td width="162" height="40" bgcolor="#3777BC"  class="STYLE3">课&nbsp;&nbsp;程</td>
    <td width="160" align="right" bgcolor="#3777BC" class="STYLE3">成&nbsp;&nbsp;&nbsp;&nbsp;绩</td>
  </tr>
<%
ScoreList sl = new ScoreList();

sl.setBmxxid(bmxxid);

al_score = dbo.getList(sl);
for(int i=0; i< al_score.size(); i++) {
	Score sc = (Score)al_score.get(i);
	cj = sc.getFenshu();
	cjName = hmScore.get(sc.getKmid()+"");
	if(!isPublicScore && cjName.indexOf("笔试") > -1) continue;
	if(!isPublicScoreExtra && "面试".equals(cjName)) continue;
%>
  <tr height="30">
    <td height="32" bgcolor="#FFFFFF"><%=cjName %></td>
    <td bgcolor="#FFFFFF" align="right"><%=cj%></td>
  </tr>
<%
}
%>
</table>

</body>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</html>
