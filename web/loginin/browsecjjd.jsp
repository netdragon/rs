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
<title>查看高中成绩鉴定表</title>
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
	
	font-family: "黑体";

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
.STYLEcj {font-size: 12px; color:#000000;}
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
.brfnt {font-size: 12px}

-->
</style>


</head>

<body>
<%
	LogHandler logger=LogHandler.getInstance("browseinfo.jsp");
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;
	Cjjd gzcjjd;
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	String bmxxId = BaseFunction.null2value(request.getParameter("bmxxid"));
	if(bmxxId.length() == 0) bmxxId = (String)session.getAttribute("bmxxid");
	String isHide = BaseFunction.null2value(request.getParameter("hide_pic"));
	String isPrint = BaseFunction.null2value(request.getParameter("print"));
	String adminFlag = (String)session.getAttribute("admin");
	String bmxxIdSesn = (String)session.getAttribute("bmxxid");
	if(bmxxId == null || bmxxIdSesn ==null || !bmxxId.equals(bmxxIdSesn)) {
		if(null == adminFlag || 0 == adminFlag.length() || !"1".equals(adminFlag)) {
			logger.error("没有报名信息！");
			response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名信息！").toUTF8String());
			return;
		}
	}
	try{
		if(bmxxId.length() == 0){
            logger.error("没有报名信息！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名信息！").toUTF8String());
			return;
		}
		bmxxId = (bmxxId.length() == 0) ? "-1":bmxxId;
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		logger.debug("size:"+al.size());
		if(al.size() == 0){
            logger.error("没有报名数据，请考生先填写。");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名数据，请考生先填写。").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		icl = new CjjdList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		if(al.size() == 0){
            logger.error("没有成绩鉴定数据，请考生先填写。");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有成绩鉴定数据，请考生先填写。").toUTF8String());
			return;
		}
		gzcjjd = (Cjjd)al.get(0);

	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生信息！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}

	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>
<%
	try{
%>
<table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
	<input type="button" id="print1"  value="打印" onClick="window.open('../admin/pcjjd.jsp?bmxxid=<%=bmxx.getBmxxid()%>&print=0&hide_pic=1');" />
	&nbsp;&nbsp;</td>
  </tr>
</table>
<table width="649" border="0" align="center" cellpadding="0" cellspacing="0" class="tbl_w">
  <caption align="top">
    <span class="STYLE3">中国石油大学（北京）<%=year%>年自主选拔录取高中成绩鉴定表</span>
    </caption>
  <tr>
    <td  colspan="6" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="11%" align="center" class="td1 STYLE6">考生姓名</td>
    <td width="22%" class="td1 STYLE6"><%=bmxx.getKsxm() %></td>
    <td width="11%" align="center" class="td1 STYLE6">中学名称</td>
    <td width="56%" class="tda2 STYLE6"><%=bmxx.getZxmc() %></td>
  </tr>
</table>
</td>
  </tr>
  <tr>
   <td  colspan="6" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td  width="13%" nowrap="nowrap" align="center" class="td1 STYLE6">中学通信地址</td>
    <td  width="62%" class="td1 STYLE6"><%=gzcjjd.getZxtxdz() %></td>
    <td  width="11%" nowrap="nowrap" align="center" class="td1 STYLE6">中学级别</td>
    <td  width="14%" nowrap="nowrap" class="tda2 STYLE6"><%=gzcjjd.getZxjb() %></td>
  </tr>
  <tr>
    <td colspan="4"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  nowrap="nowrap" align="center" class="td1 STYLE6">邮政编码</td>
        <td  nowrap="nowrap" class="td1 STYLE6"><%=gzcjjd.getZxybm() %></td>
        <td  nowrap="nowrap" align="center" class="td1 STYLE6">联系电话</td>
        <td  class="td1 STYLE6"><%=gzcjjd.getZxlxdh() %></td>
        <td  nowrap="nowrap" align="center" class="td1 STYLE6">年级负责人</td>
        <td  nowrap="nowrap" class="tda2 STYLE6"><%=gzcjjd.getNjfzr() %></td>
      </tr>
    </table></td>
    </tr>
</table></td>
  </tr>
<!--  <tr>
    <td width="98" align="center" class="td1 STYLE6">考生姓名</td>
    <td colspan="2" class="td1 STYLE6"><%=bmxx.getKsxm() %></td>
    <td width="181" align="center" class="td1 STYLE6">中学名称</td>
    <td colspan="2" class="tda2 STYLE6"><%=bmxx.getZxmc() %></td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6">中学通信地址</td>
    <td colspan="3" class="td1 STYLE6"><%=gzcjjd.getZxtxdz() %></td>
    <td width="94" align="center" class="td1 STYLE6">中学级别</td>
    <td width="163" class="tda2 STYLE6"><%=gzcjjd.getZxjb() %></td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6">邮政编码</td>
    <td width="162" class="td1 STYLE6"><%=gzcjjd.getZxybm() %></td>
    <td width="80" align="center" class="td1 STYLE6">联系电话</td>
    <td class="td1 STYLE6"><%=gzcjjd.getZxlxdh() %></td>
    <td align="center" class="td1 STYLE6">年级负责人</td>
    <td class="tda2 STYLE6"><%=gzcjjd.getNjfzr() %></td>
  </tr>
 --> 
  <tr>
    <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="14%" align="center" class="td1 STYLEcj">学习成绩</td>
        <td width="5%" align="center" class="td1 STYLEcj">语文</td>
        <td width="5%" align="center" class="td1 STYLEcj">数学</td>
        <td width="5%" align="center" class="td1 STYLEcj">外语 </td>
        <td width="5%" align="center" class="td1 STYLEcj">物理 </td>
        <td width="5%" align="center" class="td1 STYLEcj">化学</td>
        <td width="5%" align="center" class="td1 STYLEcj">生物 </td>
        <td width="5%" align="center" class="td1 STYLEcj">历史</td>
        <td width="5%" align="center" class="td1 STYLEcj">政治</td>
        <td width="5%" align="center" class="td1 STYLEcj">地理</td>
        <td width="6%" align="center" class="td1 STYLEcj">体育</td>
        <td width="6%" align="center" class="td1 STYLEcj">总分</td>
        <td width="6%" align="center" class="td1 STYLEcj">班级<br />名次</td>
        <td width="6%" align="center" class="td1 STYLEcj">班级<br />人数</td>
        <td width="6%" align="center" class="td1 STYLEcj">年级<br />名次</td>
        <td width="6%" align="center" class="tda2 STYLEcj">年级<br />人数</td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">高一（上）期末</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGysyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyssx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyswy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyswl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyshx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyssw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGysls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyszz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGysdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGysty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyszf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGysbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGysbjmc()!=0) {%> <%=gzcjjd.getGysbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGysbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGysbjrs()!=0) {%> <%=gzcjjd.getGysbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGysnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGysnjmc()!=0) {%> <%=gzcjjd.getGysnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getGysnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGysnjrs()!=0) {%> <%=gzcjjd.getGysnjrs() %><% } %></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">高一（下）期末</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxsx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxwy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxwl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxhx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxsw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxzz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGyxzf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGyxbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGyxbjmc()!=0) {%> <%=gzcjjd.getGyxbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGyxbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGyxbjrs()!=0) {%> <%=gzcjjd.getGyxbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGyxnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGyxnjmc()!=0) {%> <%=gzcjjd.getGyxnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getGyxnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGyxnjrs()!=0) {%> <%=gzcjjd.getGyxnjrs() %><% } %></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">高二（上）期末</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGesyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGessx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGeswy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGeswl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGeshx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGessw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGesls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGeszz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGesdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGesty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGeszf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGesbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGesbjmc()!=0) {%> <%=gzcjjd.getGesbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGesbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGesbjrs()!=0) {%> <%=gzcjjd.getGesbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGesnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGesnjmc()!=0) {%> <%=gzcjjd.getGesnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getGesnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGesnjrs()!=0) {%> <%=gzcjjd.getGesnjrs() %><% } %></td
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">高二（下）期末</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexsx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexwy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexwl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexhx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexsw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexzz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGexzf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGexbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGexbjmc()!=0) {%> <%=gzcjjd.getGexbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGexbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGexbjrs()!=0) {%> <%=gzcjjd.getGexbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGexnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGexnjmc()!=0) {%> <%=gzcjjd.getGexnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getGexnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGexnjrs()!=0) {%> <%=gzcjjd.getGexnjrs() %><% } %></td
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">高三（上）期末</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGssyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsssx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsswy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsswl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsshx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsssw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGssls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsszz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGssdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGssty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getGsszf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGssbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGssbjmc()!=0) {%> <%=gzcjjd.getGssbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGssbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGssbjrs()!=0) {%> <%=gzcjjd.getGssbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getGssnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGssnjmc()!=0) {%> <%=gzcjjd.getGssnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getGssnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getGssnjrs()!=0) {%> <%=gzcjjd.getGssnjrs() %><% } %></td
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">会考成绩</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHksx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkwy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkwl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkhx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHksw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkzz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getHkzf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getHkbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getHkbjmc()!=0) {%> <%=gzcjjd.getHkbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getHkbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getHkbjrs()!=0) {%> <%=gzcjjd.getHkbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getHknjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getHknjmc()!=0) {%> <%=gzcjjd.getHknjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getHknjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getHknjrs()!=0) {%> <%=gzcjjd.getHknjrs() %><% } %></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLEcj">最近考试</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjyw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjsx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjwy() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjwl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjhx() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjsw() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjls() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjzz() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjdl() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjty() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%=gzcjjd.getZjzf() %>&nbsp;</td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getZjbjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getZjbjmc()!=0) {%> <%=gzcjjd.getZjbjmc() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getZjbjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getZjbjrs()!=0) {%> <%=gzcjjd.getZjbjrs() %><% } %></td>
        <td align="center" class="td1 brfnt"><%if (gzcjjd.getZjnjmc()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getZjnjmc()!=0) {%> <%=gzcjjd.getZjnjmc() %><% } %></td>
        <td align="center" class="tda2 brfnt"><%if (gzcjjd.getZjnjrs()==0) {%>&nbsp; <% } %> <%if (gzcjjd.getZjnjrs()!=0) {%> <%=gzcjjd.getZjnjrs() %><% } %></td>
      </tr>
    </table></td>
    </tr>
  
  <tr>
    <td width="57" align="center" class="td1 STYLE6">班主任<br />综合评价</td>
        <td class="tda2" colspan="5" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="6"><p class="STYLE9">(此栏可打印后手写)</p><textarea name="bzrpj" readonly style="overflow-y:hidden;border:0px; width=100%;height=100%; line-height:150%;overflow:hidden;border-width:0px;"><%=gzcjjd.getBzrpj()%></textarea><br /></td>
            </tr>
			<tr>
              <td colspan="6">&nbsp;</td>
            </tr>
			<tr>
              <td colspan="6">&nbsp;</td>
            </tr>
            <tr>
              <td width="7%">&nbsp;</td>
              <td width="41%">班主任（签章）</td>
              <td width="14%">&nbsp;</td>
              <td width="13%">年</td>
              <td width="13%">月</td>
              <td width="13%">日</td>
            </tr>
          </table></td>
  </tr>
  <tr>
    <td width="57" align="center" class="tda1 STYLE6">中学审查意见</td>
    <td colspan="5" class="STYLE6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
        <td colspan="8" valign="top">&nbsp;</td>
      </tr>
	  <tr>
        <td colspan="8" valign="top"><p class="STYLE8">&nbsp;&nbsp;&nbsp;&nbsp;该生是我校高中应届毕业生，以上材料全部属实，同意报考。若有虚假，我校愿意承担后果。</p></td>
      </tr>
      <tr>
        <td colspan="8"  valign="top">&nbsp;</td>
      </tr>
      <tr>
        <td width="34%">&nbsp;&nbsp;校长签字：</td>
        <td width="35%">（学校公章）</td>
        <td width="2%">&nbsp;</td>
        <td width="8%">年</td>
        <td width="2%">&nbsp;</td>
        <td width="8%">月</td>
        <td width="3%">&nbsp;</td>
        <td width="7%">日</td>
      </tr>
    </table></td>
    </tr>
</table>

<table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td height="8"></td></tr>
  
</table>
</form>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
</body>
</html>
