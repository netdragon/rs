<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/access_control.jsp"%>
<%
	String userName = BaseFunction.null2value(session.getAttribute("user_name"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户成功登录</title>
<style type="text/css">
<!--
body{
/*	background-color:#F1F1F1;*/
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;

}
.doccontainer{
	width:1008px;
	margin-right: auto;
	margin-left: auto;
    border: 1px solid #8080FF;


}
.doccontainerw{
	width:1010px;
	margin-right: auto;
	margin-left: auto;
    
    border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #8080FF;
	border-left-width: 1px;
	border-left-style: solid;
	border-left-color: #8080FF;
}

.doccontainerm{
	width:1010px;
	margin-right: auto;
	margin-left: auto;
    border: 1px solid #8080FF;
}
.docmain_left{
	float:left;
	width:16%;
	padding-left:0px;
	padding-bottom:0px;
	padding-top:10px;
	
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #CCCCCC;
	border-left-width: 1px;
	border-left-style: solid;
	border-left-color: #8080FF;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #8080FF;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #8080FF;	
    height:1498px;

}

.at1{	background-color:#B0C4DE;}
.at1 td{
	font-size:14px;
	font-weight:bold;
}

.at1 td a{
	color:#113089;
	text-decoration:none;
}
.at1 td a:hover{
	color:#FF6600;
	text-decoration:underline;
	background-color:#FFFFFF;
}


.docmain_right{
	float:right;
	width:83%;
	padding-left:0px;
	padding-bottom:5px;
	padding-top:0px;
	
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #8080FF;	
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #8080FF;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #8080FF;		
	height:1500px;


}
#printsty a{
color:#FF6600;
}
#printsty a:hover{
color:#FF0000;
text-decoration:none;
background-color:#FFFFFF;

}

#exitsty a{
color:#FF0000;
text-decoration:underline;
}
#exitsty a:hover{
color:#FF6600;
text-decoration:underline;
background-color:#FFFFFF;

}

#modisty a{
color:#8B93ED;
text-decoration:none;
}
#modisty a:hover{
color:#FF6600;
text-decoration:underline;
background-color:#FFFFFF;

}
.STYLE5 {font-size: 12px; color: #FF6600;font-weight: bold;background-color:#FCFCFC;}
.STYLE6 {color: #666666}
.styjf{font-size:16px;color: #FF0000;}
-->
</style>

</head>

<body>

<div class="doccontainer">
<div class="doccontainerw">
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0"> 
  <tr>
    <td width="75%"  height="25" class="STYLE5">&nbsp;&nbsp;&nbsp;&nbsp;欢迎&nbsp;<%=userName%>&nbsp;登录</td>
  <td width="25%"  height="25" align="right" class="STYLE5">
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
int month = c.get(Calendar.MONTH) +1;
int day = c.get(Calendar.DAY_OF_MONTH);
long timestamp = c.getTimeInMillis();
%>
		<span id="floatleft"><span class="STYLE6">今天是：<%=year%>年<%=month%>月<%=day%>日&nbsp;&nbsp;&nbsp;</span></td>
   </tr>
 </table>
<table width="100%" height="133" border="0" align="center" cellpadding="0" cellspacing="0" background="../images/adlogo.gif">
  <tr>
    <td height="35">&nbsp;</td>
  </tr>
</table>
</div>
</div>


<div class="doccontainerw">

<table width="100%" height="28"  border="0" align="center" cellpadding="0" cellspacing="0" class="at1"> 
   <tr>
    <td height="4" colspan="20"></td>
  </tr>
  <tr>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="attention.jsp?<%=timestamp%>" target="ifr">报名须知</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="bmsq.jsp?<%=timestamp%>" target="ifr">填写报名表</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="bmsq_br.jsp?<%=timestamp%>" target="ifr">查看报名表</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="bmsq_mo.jsp?<%=timestamp%>" target="ifr">修改报名表</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="shenhejieguo.jsp?<%=timestamp%>" target="ifr">初审结果查询</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="zhun.jsp?<%=timestamp%>" target="ifr">打印准考证</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>    
	<td><a href="chengji.jsp?<%=timestamp%>" target="ifr">考试成绩查询</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="chengji_lq.jsp?<%=timestamp%>" target="ifr">录取结果</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="../register/modireg.jsp?<%=timestamp%>" target="ifr">修改注册信息</a></td>
    <td align="right"><img src="../images/loginitem.gif" width="10" height="10" /></td>
    <td><a href="../index.jsp?<%=timestamp%>" target="_self">退&nbsp;出</a></td>
  </tr>
 </table>
</div>
<div class="doccontainerm">

<iframe src="welcome.html" name="ifr" id="ifr" scrolling="auto" width="100%"  height="482" marginwidth="0" marginheight="0" frameborder="0" align="center">
</iframe>
</div>
</body>
</html>
