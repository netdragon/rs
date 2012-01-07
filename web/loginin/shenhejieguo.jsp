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
<title>查看审核结果</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}

.STYLE1 {font-size: 16px;}
.STYLE1a {font-size: 16px;}
.STYLE3a {
	font-size: 16px;
	font-weight: bold;

}
.STYLE3 {
	font-size: 16px;
	font-weight: bold;
	color: #FF3300;
}
.STYLE4 {
	color: #0033FF;
	font-size: 18px;
	font-weight: bold;
}
a {
	color: #0000FF;
}
a:hover {
	text-decoration: none;
}
p {
	text-indent: 40px;
}
-->
</style>

</head>
<%
	LogHandler logger=LogHandler.getInstance("shenhejieguo.jsp");
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
	try {
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(!("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("审核结果未发布！").toUTF8String());
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
		
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
	
%>
<body>
<%
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>

<br /><br />
<%
	try{
%>
<%	String shqk = "";
	String btn_yj = "";
	String shyj="";
	
	shyj=bmxx.getShhyj();

		
		switch(bmxx.getShhqk()) {
		case -1:
		case 0:
			shqk = "未通过";            
			break;
		case 1:
			shqk = "通过";
			break;
		}

		
%>
<table width="486" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
 <caption align="top">
   <span class="STYLE4">中国石油大学（北京）<%=year%>年自主选拔录取报名审核结果</span>
  </caption>
 <tr>
   <td bgcolor="#FFFFFF" class="STYLE1">姓名：<span class="STYLE3a"><%=bmxx.getKsxm()%></span>&nbsp;</td>
   <td bgcolor="#FFFFFF" class="STYLE1">身份证号：<span class="STYLE3a"><%=bmxx.getShfzh()%></span>&nbsp;</td>
 </tr>
<tr>
  <td height="1" colspan="2" bgcolor="#FFFFFF"></td>
</tr>
 <%if (shqk=="通过"){ %><tr>
  <td colspan="2" bgcolor="#FFFFFF" valign="middle"><p style="color: #FF0000;font-weight: bold;font-size:20px">祝贺你！你通过了中国石油大学（北京）自主选拔录取的初审！请按要求汇报名费，交过报名费的可在本报名系统打印准考证。详情请查看<a href="http://jwc.cup.edu.cn/public/zsb/tongzhi/2011/zzzskaoshitongzhi.mht">考试通知</a>。</p></td>  
  </tr>

<% if (bmxx.getSfjbmf()==1) {%><tr>
  <td height="1" colspan="2" bgcolor="#FFFFFF"></td>
</tr>
<tr>
  <td colspan="2" height="50" bgcolor="#FFFFFF" class="STYLE1a"><span style="font-weight: bold;font-size:18px">您的报名费已经收到！&nbsp;&nbsp;请按规定时间打印准考证。</span>&nbsp;</td>
 </tr><% } %>

 <% if (bmxx.getSfjbmf()==0) {%><tr>
  <td height="1" colspan="2" bgcolor="#FFFFFF"></td>
</tr>
<tr>
  <td colspan="2" height="50" bgcolor="#FFFFFF" class="STYLE1a"><span style="font-weight: bold;font-size:18px">您的交费还未确认！&nbsp;&nbsp;请稍候查询。</span>&nbsp;</td>
 </tr><% } %>
 <% } %>
<%if (shqk=="未通过"){ %><tr>
  <td colspan="2" bgcolor="#FFFFFF" valign="middle"> <p style="color: #FF0000;font-weight: bold;font-size:20px">抱歉，你没有通过自主选拔录取的初审，希望你再接再厉，并继续关注中国石油大学（北京）。</p></td>  
  </tr>

<% if (shyj.length()>0) {%><tr>
  <td colspan="2" bgcolor="#FFFFFF" class="STYLE1a">意见：<span style="font-weight: bold;font-size:18px"><%=bmxx.getShhyj()%></span>&nbsp;</td>
  </tr><% } %>
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
