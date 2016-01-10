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
String info = BaseFunction.null2value(request.getParameter("info"));
String op = BaseFunction.null2value(request.getParameter("op"));
String info_show = new String(info.getBytes("iso8859-1"), "utf-8");
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
	width: 540px;
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
	border-bottom-color:#FFFFB3;
}
.STYLE2 {
	color: #FF33CC;
	font-weight: bold;
	font-size: 24px;
	font-family: "华文楷体";
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
					<td colspan="3" class="tdbl"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="44%" height="65" background="images/oktishi.gif"><img src="images/dd.gif" width="44" height="45"></td>
                        <td width="56%">&nbsp;</td>
                      </tr>
                    </table></td>
				  </tr>
				  <tr>
					<td width="10%">&nbsp;</td>
					<td width="81%" height="78"><span class="STYLE2"><%=info_show%></span></td>
					<td width="9%">&nbsp;</td>
				  </tr>
				  <tr>
					<td height="1" colspan="3"></td>
					</tr>
				  <tr>
					<td height="50" colspan="3" align="center">&nbsp;
					</td>
					</tr>
				</table>
         </div></div>
				</td>
  </tr>
</table>


</body>
</html>
