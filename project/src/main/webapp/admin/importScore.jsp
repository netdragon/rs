<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导入考生成绩</title>
</head>
<body>
<%
	LogHandler logger=LogHandler.getInstance("enrollment.jsp");
	DBOperator dbo = new DBOperator();
	SystemSettingsList ssl;
	ArrayList al_settings;
	String s_isPublic = "";
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	try {
		ssl = new SystemSettingsList("isPublic_Score");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("考试成绩已发布，不能导入考试成绩！").toUTF8String());
			return;
		}
		ssl = new SystemSettingsList("isPublic_ScoreExtra");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		else s_isPublic = "";
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("考试成绩已发布，不能导入考试成绩！").toUTF8String());
			return;
		}
%>
<form action="/input_score" enctype="multipart/form-data" method="post" >
<input name="scorefile" type="file" id="scorefile" />&nbsp;&nbsp;<span class="p1"></span>
<input value="提交" type="submit"/>
</form>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</body>
</html>
