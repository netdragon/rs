<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@ page import="edu.cup.rs.common.*"%>
<html>
<head>
<title>提示信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   

<%
String err = BaseFunction.null2value(request.getParameter("error"));
String err_show = new String(err.getBytes("iso8859-1"), "utf-8");
%>
<style type="text/css">
<!--
body {

	margin-left: 2px;
	margin-top: 80px;
	margin-right: 0px;
	margin-bottom: 0px;
	
}

.doccontainer {
	margin-left: auto;
	width: 580px;
	margin-right: auto;
	background-color:#f8f5f1;
	padding: 4px;
	border: 1px solid #eedfd0;
}
.docint {
	margin-left: auto;
	width: 100%;
	margin-right: auto;
	background-color: #FFFFFF;
	padding: 0px;
	/*border: 1px solid #3777BC;*/
}
.tdbl{
	
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #3777BC;
}
-->
</style>
</head>

<body>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><div class="doccontainer"><div class="docint">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td colspan="3" class="tdbl"><img src="images/tishipic.gif" width="200" height="65" /></td>
				  </tr>
				  <tr>
					<td width="12%">&nbsp;</td>
					<td width="87%" height="78"><font size="5" color="#FF0000"><%=err_show%></font></td>
					<td width="1%"></td>
				  </tr>
				  <tr>
					<td height="1" colspan="3"></td>
					</tr>
				  <tr>
					<td height="50" colspan="3" align="center">&nbsp;</td>
					</tr>
				</table>
         </div></div>
				</td>
  </tr>
</table>


</body>
</html>
