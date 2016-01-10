<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>设置考场</title>
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
	border-bottom-color: #D3D3E3;
}

.tdfont{font-size: 12px;}
.STYLE1 {
	color: #FF3300;
	font-weight: bold;
	font-family: "宋体";
	font-size: 18px;
}

.con .tbl {
	border: 1px solid #DFE7EC;
}
.zkzbbt {color: #000099; font-size: 12px; font-weight: bold; }
#fenye a{	
   color: #FF3300;
   text-decoration:underline;
   font-size:12px;
   font-weight:bold;
}
#fenye a:hover{	
   color: #FF0000;
   text-decoration:none;
   
}
.fbsty{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:86px;
    }
.kcrs {
	color: #0033FF;
	font-size: 14px;
	font-weight: bold;
}
.td_b{font-size:12px;}
-->
</style>
<script>
  function arraExamRoom(){
	document.forms[0].method = "post";
	document.forms[0].action = "/arra_room";
	document.forms[0].submit();
  }
  function export_room(){
	document.forms[0].method = "post";
	document.forms[0].action = "/export_room";
	document.forms[0].submit();
  }
</script>
</head>
<%

	LogHandler logger=LogHandler.getInstance("kch.jsp");
	ArrayList al;
	BmxxList icl;
	Bmxx bmxx;
	DBOperator dbo = new DBOperator();
	String isDesc="";
	int i_total = 0;
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	try{
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getRoomCount());
		al = dbo.getQueryList(icl.getRoomMember(), icl);
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
<br />
<div class="con">
<form method="get" action="kch.jsp">
<table width="55%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  align="center" valign="top" ><span class="STYLE1"><%=year%>年自主选拔录取考试_考场安排</span></td>
  </tr>
  <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>
</table>
<br />
<table width="644" border="0" align="center" cellpadding="0" cellspacing="0" >
<tr><td><table width="500" border="0" align="left" cellpadding="0" cellspacing="0" class="tbl">
  <tr>
    <td width="37"  align="right"><img src="../images/kchimg.gif" alt="pic" width="32" height="32" /></td>
    <td>&nbsp;<span class="kcrs">每考场的考生人数为</span>   
      <input type="text" name="room"/>
      <input type="button" onclick="arraExamRoom();" name="Submit" value="确 定" /></td>
  </tr>
   <tr>
    <td height="7" colspan="2"></td>
  </tr>
</table></td></tr>
</table>
<table width="777" border="0" cellspacing="0" cellpadding="0"  align="center" id="fenye">
  <tr>
    <td colspan="3" height="6"></td>
  </tr>
  <tr>
  <td><span class="tdfont">共有考场<%=i_total%>个</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td align="right"><!--<input name="button" type="button" class="fbsty" onclick="export_room();" value="导出考场数据"/>-->&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" height="8"></td>
  </tr>
</table>

<table width="90%" align="center"   border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td height="20" width="88" align="center"><span class="zkzbbt">考场号</span></td>
    <td align="center"><span class="zkzbbt">自准考证号－至准考证号</span></td>
  </tr>
<%
		for(int i = 0; i < al.size(); i++) {
			bmxx = (Bmxx) al.get(i);
%>
  <tr bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
    <td height="24" class="td_b"><%=bmxx.getKch()%>&nbsp;</td>
    <td class="td_b"><%=bmxx.getKsxm()%>&nbsp;</td>
  </tr>
 <%
		}
 %>
</table>
</form>
</div>
</body>
</html>
