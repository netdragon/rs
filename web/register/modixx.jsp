<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/access_control.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>修改用户注册信息</title>

<style type="text/css">
<!--
.doc {
	width:670px;
	margin-top: 0;
	margin-right: auto;
	margin-bottom: 0;
	margin-left: auto;
	padding-top: 0px;
	background-color:#FFFFFF;
	border: 1px solid #CCCCCC;

}


.tdlbl {
	font-size:14px;

}
.emdot{ color:#F50A4A; font-size:14px; line-height:30px}
.inputsty{
    height:24px; font-size:14px;
	width:270px;
	padding-left:2px;
}
.inputsty2{
    height:24px; font-size:14px;

	padding-left:2px;
}
.selsty{ width:270px; font-size:14px;}

.STYLE1 {
	color: #333333;
	font-size: 12px;
}

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color:#FAFAFA;

}
.STYLE2 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 18px;
}
-->	
</style>
<script>
function reg_submit() {
//check user name length
    var fm = document.forms[0];


//check answer length
	var an_obj=document.getElementById("cusanswer");
	var an = (null == an_obj) ? "": an_obj.value;
	if(fm.selproblem.value =="0") {
		alert("请选择密码保护问题！");
		fm.selproblem.focus();
		return false;
	}

	if(an.length > 30 || an.length <2) {
		alert("密码保护答案的长度不正确");
		fm.cusanswer.focus();
		return;
	}
//check email format
//	var mail_obj=document.getElementById("idemail");
//	var mail = (null == mail_obj) ? "": mail_obj.value;
//	var re = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
//	if (!re.test(mail)) {
//		alert("邮件格式错误");
//		fm.email.focus();
//		return;
//	}

	document.forms[0].submit();
}
</script>
</head>

<body>
<%
	LogHandler logger=LogHandler.getInstance("chushen.jsp");
	DBOperator dbo=new DBOperator();
	User user = null;
	try {
		dbo.init(true);
	} catch (Exception e2) {
		logger.error(e2.getMessage());
		response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	try {
		UserList icl = new UserList(Integer.parseInt(USERID));
		ArrayList al = dbo.getList(icl);
		if(al.size()!=1) {
			response.sendRedirect("error.jsp?error="+new UTF8String("用户不存在或密码错误！").toUTF8String());
			return;
		}
		user = (User)al.get(0);
	} catch (Exception ess) {
		logger.error(ess.getMessage());
		response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	finally{
		if(null!=dbo) dbo.dispose();
	}
%>
<div class="doc">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#108AC6">
  <tr><td height="25" valign="middle"><img src="../images/xgxxpic.gif" width="20" height="21" /><span class="STYLE2">修改用户注册信息</span></td>
  </tr>
  </table>
 
<form action="/modi_reg" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
   <tr>
    <td align="right" class="tdlbl">密码保护问题：<span class="emdot">*</span></td>
    <td height="60">    	
	<select name="selproblem" id="selproblem" class="selsty">
    		<option style="color:#666666" value="0">请选择密码保护问题</option>
    		<option value="您母亲的姓名是?" <%=(("您母亲的姓名是?".equals(user.getQuestion()))? "selected":"")%>>您母亲的姓名是?</option>
		  	<option value="您父亲的姓名是?" <%=(("您父亲的姓名是?".equals(user.getQuestion()))? "selected":"")%>>您父亲的姓名是?</option>
		  	<option value="您母亲的生日是?" <%=(("您母亲的生日是?".equals(user.getQuestion()))? "selected":"")%>>您母亲的生日是?</option>
		  	<option value="您父亲的生日是?" <%=(("您父亲的生日是?".equals(user.getQuestion()))? "selected":"")%>>您父亲的生日是?</option>
		  	<option value="您最喜爱的电影?" <%=(("您最喜爱的电影?".equals(user.getQuestion()))? "selected":"")%>>您最喜爱的电影?</option>
		 	<option value="您的出生地是?" <%=(("您的出生地是?".equals(user.getQuestion()))? "selected":"")%>>您的出生地是?</option>
		  	<option value="您的小学校名是?" <%=(("您的小学校名是?".equals(user.getQuestion()))? "selected":"")%>>您的小学校名是?</option>
		  	<option value="您的中学校名是?" <%=(("您的中学校名是?".equals(user.getQuestion()))? "selected":"")%>>您的中学校名是?</option>
		  	<option value="您的大学校名是?" <%=(("您的大学校名是?".equals(user.getQuestion()))? "selected":"")%>>您的大学校名是?</option>			
		  	<option value="您手机号码的后6位?" <%=(("您手机号码的后6位?".equals(user.getQuestion()))? "selected":"")%>>您手机号码的后6位?</option>
    	</select></td>
  </tr>
   <tr>
    <td align="right" valign="middle" class="tdlbl">密码保护问题答案：<span class="emdot">*</span></td>
    <td height="60" valign="middle">
    <input type="text" name="cusanswer" id="cusanswer" class="inputsty" maxlength="30" value="<%=user.getAnswer()%>" />
	<br /><span class="STYLE1">（2～30个字符或汉字,字母区分大小写）</span></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">E-mail地址：</td>
    <td height="60"><input type="text" name="email" maxlength="80" id="idemail" class="inputsty" value="<%=user.getEmail()%>"/></td>
  </tr>
  <tr>
    <td height="60" colspan="2" align="center" class="tdlbl"><input type="button" name="Subxg" value="修 改" onclick="reg_submit();"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subqx" value="取 消"  onclick="window.history.back();"/></td>
    </tr>
</table>

</form>
</div>

</body>
</html>
