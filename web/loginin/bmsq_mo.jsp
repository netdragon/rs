<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看自主招生报名申请－－中国石油大学（北京）</title>
<style type="text/css">
<!--

table {
	line-height: 32px;
}
.STYLE3 {color: #000000; font-weight: bold;font-size:22px
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
.kslq{	
    color: #00A200;
	font-weight: bold;
}
a {
	color: #0033FF;
}
a:hover {
	text-decoration: none;
}
-->
</style>

</head>

<body>
<br /><br />
<%
Calendar c = Calendar.getInstance();

long timestamp = c.getTimeInMillis();
%>


<table width="451"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="1" align="center"  bgcolor="#FFFFFF" class="STYLE6"></td>
  </tr>
    <tr>
    <td height="55" background="../images/sq5.gif"  bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>
<table width="451" border="0" cellspacing="2" cellpadding="0" align="center" bgcolor="#EEEEEE">
   <tr>
    <td height="3" align="center"   class="STYLE6"></td>
  </tr>
 <tr>
    <td bgcolor="#FFFFFF" width="364" height="47"  class="STYLE3">1.<a href="modiinfo.jsp?<%=timestamp%>">修改申请表</a></td>
    
  </tr>
  <tr>
    <td height="40"  bgcolor="#FFFFFF" class="STYLE3">2.<a href="modicjjd.jsp?<%=timestamp%>">修改高中成绩鉴定表</a></td>
   
  </tr>
</table>

</body>

</html>
