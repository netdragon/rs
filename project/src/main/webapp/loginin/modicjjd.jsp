<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改写高中成绩鉴定表</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}
input {
	height: 20px;
	color:#333444;
	font-family:"Times New Roman", Times, serif;
	font-size:12px;

}
.star {color: #FF0000}
.STYLE3 {
	
	font-size: 22px;
	font-weight: bold;
	color: #FF3300;
}
.td1a {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #333333;
}
.td1 {

	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #333333;
	border-bottom-color: #333333;
}
.td2 {

	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #333333;
}

.fnt{	font-size: 12px;
	font-weight:bold;
}
.shuoming {font-size: 14px;  color:#000000;}
.STYLE6 {font-size: 14px; color:#000000;}
.tbl_w {
	border: 1px solid #333333;
}

body{
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom:0px;
}

.p1{font-size:12px;color:black}
.iptbox{
	font-size:12px;
	color:black;
	height: 24px;
}
#textaream {
	border: 1px solid #000000;
}
.STYLE8 {
	font-family: "宋体";
	font-weight: bold;
	font-size: 18px;
}
.STYLE9 {font-size: 12px}

.tda1 {

	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #333333;
}
.tda2 {

	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #333333;
}
.sbtn {
	
	font-size: 20px;	
}
.STYLE10 {font-size: 18px; font-family: "宋体";}
-->
</style>
<script src="../common/validate.js"></script>
<script>
	function check_submit(){
		var fm = document.forms[0];
		document.forms[0].submit();
		return true;
	}
</script>
</head>

<body>
<%
	LogHandler logger=LogHandler.getInstance("enrollment.jsp");
	String bmxxId = (String)session.getAttribute("bmxxid");
	String userId = (String)session.getAttribute("user_id");
	if(null == userId){
           logger.error("没有登录信息！");
           response.sendRedirect("/error.jsp?error=" + new UTF8String("没有登录信息！").toUTF8String());
		return;
	}
	if(null == bmxxId){
        logger.error("没有报过名！");
        response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报过名！").toUTF8String());
		return;
	}
	DBOperator dbo = new DBOperator();
	String isDesc="";

	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}

	ICommonList icl;
	Bmxx bmxx;
	SystemSettingsList ssl;
	ArrayList al;
	SystemSettings ss;
	String date_limit;
	ArrayList al_settings;
	String s_isPublic = "";
	Cjjd gzcjjd;
	try {
		Calendar c_curr = Calendar.getInstance();
		Calendar cl = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	
		ssl = new SystemSettingsList();
		ssl.setItem("regStartDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue())
				cl.setTime(sdf.parse(ss.getValue()));
		}
		if(c_curr.before(cl)) {
			response.sendRedirect("/error.jsp?error=" + new UTF8String("未到报名时间！").toUTF8String());
			return;
		}
		ssl.setItem("regEndDate");
		al = dbo.getList(ssl);
		if(1 == al.size()) {
			ss = (SystemSettings)al.get(0);
			if(null != ss.getValue())
				cl.setTime(sdf.parse(ss.getValue()));
		}
		if(c_curr.after(cl)) {
			response.sendRedirect("/error.jsp?error=" + new UTF8String("报名时间已过！不能再修改报名信息了！").toUTF8String());
			return;
		}
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("审核结果已发布，不能修改报名信息！").toUTF8String());
			return;
		}
		bmxxId = (null == bmxxId) ? "0":bmxxId;
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		if(al.size() == 0){
            logger.error("没有报名数据，请先填写。");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名数据，请先填写。").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		icl = new CjjdList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		if(al.size() == 0){
            logger.error("没有成绩鉴定数据，请先填写。");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有成绩鉴定数据，请先填写。").toUTF8String());
			return;
		}
		gzcjjd = (Cjjd)al.get(0);
		
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
%>
<form action="/add_cjjd" method="post" >
<table width="990" border="0" align="center" cellpadding="0" cellspacing="0" class="tbl_w">
  <caption align="top">
    <span class="STYLE3">修改自主选拔录取高中成绩鉴定表</span>
    </caption>
  <tr>
    <td width="106" align="center" class="td1 STYLE6 STYLE9">考生姓名</td>
    <td colspan="2" class="td1 STYLE6"><%=bmxx.getKsxm() %></td>
    <td width="234" align="center" class="td1 STYLE6 STYLE9">中学名称</td>
    <td colspan="2" class="tda2 STYLE6"><%=bmxx.getZxmc() %></td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6 STYLE9">中学通信地址</td>
    <td colspan="3" class="td1"><input name="pzxdz" type="text" size="66" value="<%=gzcjjd.getZxtxdz() %>" class="STYLE6"/></td>
    <td width="119" align="center" class="td1 STYLE6 STYLE9">中学级别</td>
    <td width="216" class="tda2 STYLE6"><input type="radio" name="pzxjb" <%=("省级示范性高中".equals(gzcjjd.getZxjb())) ? "checked":""%> value="省级示范性高中">省级示范性高中<br />
                    <input type="radio" name="pzxjb" <%=("市级示范性高中".equals(gzcjjd.getZxjb())) ? "checked":""%> value="市级示范性高中">市级示范性高中<br />
	  <input type="radio" name="pzxjb" <%=("其它".equals(gzcjjd.getZxjb())) ? "checked":""%> value="其它">其它</td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6 STYLE9">邮政编码</td>
    <td width="209" class="td1 STYLE6"><input name="pzxyb" type="text" size="12" value="<%=gzcjjd.getZxybm() %>"/></td>
    <td width="104" align="center" class="td1 STYLE6 STYLE9">联系电话</td>
    <td class="td1 STYLE6"><input name="pzxdh" type="text" size="28" value="<%=gzcjjd.getZxlxdh() %>"/></td>
    <td align="center" class="td1 STYLE6 STYLE9">年级负责人</td>
    <td class="tda2 STYLE6"><input name="pzxfzr" type="text" size="14" value="<%=gzcjjd.getNjfzr() %>"/></td>
  </tr>
  
  <tr>
    <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="11%" align="center" class="td1 STYLE6">学习成绩</td>
        <td width="7%" align="center" class="td1 STYLE6">语文</td>
        <td width="6%" align="center" class="td1 STYLE6">数学</td>
        <td width="5%" align="center" class="td1 STYLE6">外语 </td>
        <td width="5%" align="center" class="td1 STYLE6">物理 </td>
        <td width="5%" align="center" class="td1 STYLE6">化学</td>
        <td width="5%" align="center" class="td1 STYLE6">生物 </td>
        <td width="5%" align="center" class="td1 STYLE6">历史</td>
        <td width="5%" align="center" class="td1 STYLE6">政治</td>
        <td width="5%" align="center" class="td1 STYLE6">地理</td>
        <td width="6%" align="center" class="td1 STYLE6">体育</td>
        <td width="7%" align="center" class="td1 STYLE6">总分</td>
        <td width="7%" align="center" class="td1 STYLE6">班级<br />名次</td>
        <td width="7%" align="center" class="td1 STYLE6">班级<br />人数</td>
        <td width="7%" align="center" class="td1 STYLE6">年级<br />名次</td>
        <td width="7%" align="center" class="tda2 STYLE6">年级<br />人数</td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高一（上）期末</td>
        <td class="td1"><input name="pgysyw" type="text" size="3" value="<%=gzcjjd.getGysyw() %>"></td>
        <td class="td1"><input name="pgyssx" type="text" size="3" value="<%=gzcjjd.getGyssx() %>"></td>
        <td class="td1"><input name="pgyswy" type="text" size="3" value="<%=gzcjjd.getGyswy() %>"></td>
        <td class="td1"><input name="pgyswl" type="text" size="3" value="<%=gzcjjd.getGyswl() %>"></td>
        <td class="td1"><input name="pgyshx" type="text" size="3" value="<%=gzcjjd.getGyshx() %>"></td>
        <td class="td1"><input name="pgyssw" type="text" size="3" value="<%=gzcjjd.getGyssw() %>"></td>
        <td class="td1"><input name="pgysls" type="text" size="3" value="<%=gzcjjd.getGysls() %>"></td>
        <td class="td1"><input name="pgyszz" type="text" size="3" value="<%=gzcjjd.getGyszz() %>"></td>
        <td class="td1"><input name="pgysdl" type="text" size="3" value="<%=gzcjjd.getGysdl() %>"></td>
        <td class="td1"><input name="pgysty" type="text" size="3" value="<%=gzcjjd.getGysty() %>"></td>
        <td class="td1"><input name="pgyszf" type="text" size="3" value="<%=gzcjjd.getGyszf() %>"></td>
        <td class="td1"><input name="pgysbjmc" type="text" size="4" value="<%=gzcjjd.getGysbjmc() %>"></td>
        <td class="td1"><input name="pgysbjrs" type="text" size="4" value="<%=gzcjjd.getGysbjrs() %>"></td>
        <td class="td1"><input name="pgysnjmc" type="text" size="4" value="<%=gzcjjd.getGysnjmc() %>"></td>
        <td class="tda2"><input name="pgysnjrs" type="text" size="4" value="<%=gzcjjd.getGysnjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高一（下）期末</td>
        <td class="td1"><input name="pgyxyw" type="text" size="3" value="<%=gzcjjd.getGyxyw() %>"></td>
        <td class="td1"><input name="pgyxsx" type="text" size="3" value="<%=gzcjjd.getGyxsx() %>"></td>
        <td class="td1"><input name="pgyxwy" type="text" size="3" value="<%=gzcjjd.getGyxwy() %>"></td>
        <td class="td1"><input name="pgyxwl" type="text" size="3" value="<%=gzcjjd.getGyxwl() %>"></td>
        <td class="td1"><input name="pgyxhx" type="text" size="3" value="<%=gzcjjd.getGyxhx() %>"></td>
        <td class="td1"><input name="pgyxsw" type="text" size="3" value="<%=gzcjjd.getGyxsw() %>"></td>
        <td class="td1"><input name="pgyxls" type="text" size="3" value="<%=gzcjjd.getGyxls() %>"></td>
        <td class="td1"><input name="pgyxzz" type="text" size="3" value="<%=gzcjjd.getGyxzz() %>"></td>
        <td class="td1"><input name="pgyxdl" type="text" size="3" value="<%=gzcjjd.getGyxdl() %>"></td>
        <td class="td1"><input name="pgyxty" type="text" size="3" value="<%=gzcjjd.getGyxty() %>"></td>
        <td class="td1"><input name="pgyxzf" type="text" size="3" value="<%=gzcjjd.getGyxzf() %>"></td>
        <td class="td1"><input name="pgyxbjmc" type="text" size="4" value="<%=gzcjjd.getGyxbjmc() %>"></td>
        <td class="td1"><input name="pgyxbjrs" type="text" size="4" value="<%=gzcjjd.getGyxbjrs() %>"></td>
        <td class="td1"><input name="pgyxnjmc" type="text" size="4" value="<%=gzcjjd.getGyxnjmc() %>"></td>
        <td class="tda2"><input name="pgyxnjrs" type="text" size="4" value="<%=gzcjjd.getGyxnjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高二（上）期末</td>
        <td class="td1"><input name="pgesyw" type="text" size="3" value="<%=gzcjjd.getGesyw() %>"></td>
        <td class="td1"><input name="pgessx" type="text" size="3" value="<%=gzcjjd.getGessx() %>"></td>
        <td class="td1"><input name="pgeswy" type="text" size="3" value="<%=gzcjjd.getGeswy() %>"></td>
        <td class="td1"><input name="pgeswl" type="text" size="3" value="<%=gzcjjd.getGeswl() %>"></td>
        <td class="td1"><input name="pgeshx" type="text" size="3" value="<%=gzcjjd.getGeshx() %>"></td>
        <td class="td1"><input name="pgessw" type="text" size="3" value="<%=gzcjjd.getGessw() %>"></td>
        <td class="td1"><input name="pgesls" type="text" size="3" value="<%=gzcjjd.getGesls() %>"></td>
        <td class="td1"><input name="pgeszz" type="text" size="3" value="<%=gzcjjd.getGeszz() %>"></td>
        <td class="td1"><input name="pgesdl" type="text" size="3" value="<%=gzcjjd.getGesdl() %>"></td>
        <td class="td1"><input name="pgesty" type="text" size="3" value="<%=gzcjjd.getGesty() %>"></td>
        <td class="td1"><input name="pgeszf" type="text" size="3" value="<%=gzcjjd.getGeszf() %>"></td>
        <td class="td1"><input name="pgesbjmc" type="text" size="4" value="<%=gzcjjd.getGesbjmc() %>"></td>
        <td class="td1"><input name="pgesbjrs" type="text" size="4" value="<%=gzcjjd.getGesbjrs() %>"></td>
        <td class="td1"><input name="pgesnjmc" type="text" size="4" value="<%=gzcjjd.getGesnjmc() %>"></td>
        <td class="tda2"><input name="pgesnjrs" type="text" size="4" value="<%=gzcjjd.getGesnjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高二（下）期末</td>
        <td class="td1"><input name="pgexyw" type="text" size="3" value="<%=gzcjjd.getGexyw() %>"></td>
        <td class="td1"><input name="pgexsx" type="text" size="3" value="<%=gzcjjd.getGexsx() %>"></td>
        <td class="td1"><input name="pgexwy" type="text" size="3" value="<%=gzcjjd.getGexwy() %>"></td>
        <td class="td1"><input name="pgexwl" type="text" size="3" value="<%=gzcjjd.getGexwl() %>"></td>
        <td class="td1"><input name="pgexhx" type="text" size="3" value="<%=gzcjjd.getGexhx() %>"></td>
        <td class="td1"><input name="pgexsw" type="text" size="3" value="<%=gzcjjd.getGexsw() %>"></td>
        <td class="td1"><input name="pgexls" type="text" size="3" value="<%=gzcjjd.getGexls() %>"></td>
        <td class="td1"><input name="pgexzz" type="text" size="3" value="<%=gzcjjd.getGexzz() %>"></td>
        <td class="td1"><input name="pgexdl" type="text" size="3" value="<%=gzcjjd.getGexdl() %>"></td>
        <td class="td1"><input name="pgexty" type="text" size="3" value="<%=gzcjjd.getGexty() %>"></td>
        <td class="td1"><input name="pgexzf" type="text" size="3" value="<%=gzcjjd.getGexzf() %>"></td>
        <td class="td1"><input name="pgexbjmc" type="text" size="4" value="<%=gzcjjd.getGexbjmc() %>"></td>
        <td class="td1"><input name="pgexbjrs" type="text" size="4" value="<%=gzcjjd.getGexbjrs() %>"></td>
        <td class="td1"><input name="pgexnjmc" type="text" size="4" value="<%=gzcjjd.getGexnjmc() %>"></td>
        <td class="tda2"><input name="pgexnjrs" type="text" size="4" value="<%=gzcjjd.getGexnjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高三（上）期末</td>
        <td class="td1"><input name="pgssyw" type="text" size="3" value="<%=gzcjjd.getGssyw() %>"></td>
        <td class="td1"><input name="pgsssx" type="text" size="3" value="<%=gzcjjd.getGsssx() %>"></td>
        <td class="td1"><input name="pgsswy" type="text" size="3" value="<%=gzcjjd.getGsswy() %>"></td>
        <td class="td1"><input name="pgsswl" type="text" size="3" value="<%=gzcjjd.getGsswl() %>"></td>
        <td class="td1"><input name="pgsshx" type="text" size="3" value="<%=gzcjjd.getGsshx() %>"></td>
        <td class="td1"><input name="pgsssw" type="text" size="3" value="<%=gzcjjd.getGsssw() %>"></td>
        <td class="td1"><input name="pgssls" type="text" size="3" value="<%=gzcjjd.getGssls() %>"></td>
        <td class="td1"><input name="pgsszz" type="text" size="3" value="<%=gzcjjd.getGsszz() %>"></td>
        <td class="td1"><input name="pgssdl" type="text" size="3" value="<%=gzcjjd.getGssdl() %>"></td>
        <td class="td1"><input name="pgssty" type="text" size="3" value="<%=gzcjjd.getGssty() %>"></td>
        <td class="td1"><input name="pgsszf" type="text" size="3" value="<%=gzcjjd.getGsszf() %>"></td>
        <td class="td1"><input name="pgssbjmc" type="text" size="4" value="<%=gzcjjd.getGssbjmc() %>"></td>
        <td class="td1"><input name="pgssbjrs" type="text" size="4" value="<%=gzcjjd.getGssbjrs() %>"></td>
        <td class="td1"><input name="pgssnjmc" type="text" size="4" value="<%=gzcjjd.getGssnjmc() %>"></td>
        <td class="tda2"><input name="pgssnjrs" type="text" size="4" value="<%=gzcjjd.getGssnjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">会考成绩</td>
        <td class="td1"><input name="phkyw" type="text" size="3" value="<%=gzcjjd.getHkyw() %>"></td>
        <td class="td1"><input name="phksx" type="text" size="3" value="<%=gzcjjd.getHksx() %>"></td>
        <td class="td1"><input name="phkwy" type="text" size="3" value="<%=gzcjjd.getHkwy() %>"></td>
        <td class="td1"><input name="phkwl" type="text" size="3" value="<%=gzcjjd.getHkwl() %>"></td>
        <td class="td1"><input name="phkhx" type="text" size="3" value="<%=gzcjjd.getHkhx() %>"></td>
        <td class="td1"><input name="phksw" type="text" size="3" value="<%=gzcjjd.getHksw() %>"></td>
        <td class="td1"><input name="phkls" type="text" size="3" value="<%=gzcjjd.getHkls() %>"></td>
        <td class="td1"><input name="phkzz" type="text" size="3" value="<%=gzcjjd.getHkzz() %>"></td>
        <td class="td1"><input name="phkdl" type="text" size="3" value="<%=gzcjjd.getHkdl() %>"></td>
        <td class="td1"><input name="phkty" type="text" size="3" value="<%=gzcjjd.getHkty() %>"></td>
        <td class="td1"><input name="phkzf" type="text" size="3" value="<%=gzcjjd.getHkzf() %>"></td>
        <td class="td1"><input name="phkbjmc" type="text" size="4" value="<%=gzcjjd.getHkbjmc() %>"></td>
        <td class="td1"><input name="phkbjrs" type="text" size="4" value="<%=gzcjjd.getHkbjrs() %>"></td>
        <td class="td1"><input name="phknjmc" type="text" size="4" value="<%=gzcjjd.getHknjmc() %>"></td>
        <td class="tda2"><input name="phknjrs" type="text" size="4" value="<%=gzcjjd.getHknjrs() %>"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">最近考试</td>
        <td class="td1"><input name="pzjyw" type="text" size="3" value="<%=gzcjjd.getZjyw() %>"></td>
        <td class="td1"><input name="pzjsx" type="text" size="3" value="<%=gzcjjd.getZjsx() %>"></td>
        <td class="td1"><input name="pzjwy" type="text" size="3" value="<%=gzcjjd.getZjwy() %>"></td>
        <td class="td1"><input name="pzjwl" type="text" size="3" value="<%=gzcjjd.getZjwl() %>"></td>
        <td class="td1"><input name="pzjhx" type="text" size="3" value="<%=gzcjjd.getZjhx() %>"></td>
        <td class="td1"><input name="pzjsw" type="text" size="3" value="<%=gzcjjd.getZjsw() %>"></td>
        <td class="td1"><input name="pzjls" type="text" size="3" value="<%=gzcjjd.getZjls() %>"></td>
        <td class="td1"><input name="pzjzz" type="text" size="3" value="<%=gzcjjd.getZjzz() %>"></td>
        <td class="td1"><input name="pzjdl" type="text" size="3" value="<%=gzcjjd.getZjdl() %>"></td>
        <td class="td1"><input name="pzjty" type="text" size="3" value="<%=gzcjjd.getZjty() %>"></td>
        <td class="td1"><input name="pzjzf" type="text" size="3" value="<%=gzcjjd.getZjzf() %>"></td>
        <td class="td1"><input name="pzjbjmc" type="text" size="4" value="<%=gzcjjd.getZjbjmc() %>"></td>
        <td class="td1"><input name="pzjbjrs" type="text" size="4" value="<%=gzcjjd.getZjbjrs() %>"></td>
        <td class="td1"><input name="pzjnjmc" type="text" size="4" value="<%=gzcjjd.getZjnjmc() %>"></td>
        <td class="tda2"><input name="pzjnjrs" type="text" size="4" value="<%=gzcjjd.getZjnjrs() %>"></td>
      </tr>
    </table></td>
    </tr>
  
  <tr>
    <td align="center" class="td1 STYLE6 STYLE9">班主任<br />综合评价</td>
    <td class="tda2" colspan="5" align="left" valign="top"><p class="STYLE9">(此栏可打印后手写)</p>
	<textarea name="bzrpj" cols="70" rows="6"  id="textaream" style="width=90%;height=80"><%=gzcjjd.getBzrpj()%></textarea>
	<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班主任（签章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日 </td>
    </tr>
  <tr>
    <td align="center" class="tda1 STYLE6 STYLE9">中学审查<br />意见</td>
    <td colspan="5" class="STYLE6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><p>&nbsp;</p>
          <p class="STYLE8">&nbsp;&nbsp;该生是我校高中(应届</span><span class="STYLE10">□</span><span class="STYLE8">&nbsp;&nbsp;往届</span><span class="STYLE10">□</span><span class="STYLE8">)毕业生，以上材料全部属实，同意报考。若有虚假，我校愿意承担后果。</p>
          <br /></td>
      </tr>
      <tr>
        <td>&nbsp;&nbsp;校长签字：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（学校公章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</td>
      </tr>
    </table></td>
    </tr>
</table>

<table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td height="8"></td></tr>
  <tr>
 
      <td height="38"  align="center"  valign="middle"><input type="button" name="Submit" value=" 提 交 " style="width:78px; height:36px;" class="sbtn" onClick="check_submit();"></td>
    </tr>
</table>
</form>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</body>
</html>
