<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>用户注册--自主选拔录取网上报名系统</title>

<style type="text/css">
<!--
.doc {
	width:950px;
	margin-top: 0;
	margin-right: auto;
	margin-bottom: 0;
	margin-left: auto;
	padding-top: 0px;
	background-color:#FFFFFF;
	border: 1px solid #CCCCCC;

}
.regtit{
	
	width:950px;
	margin-top: 0;
	margin-right: auto;
	margin-bottom: 0;
	margin-left: auto;

	background-color:#108AC6;
	text-align:left;
	padding-top:2px;
	text-indent:2px;
	font-size:24px;
	color:#FFFFFF;
	font-weight:bold;
	font-family:"华文中宋";
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
.drt {
	line-height:16px;
	padding-top: 2px;
	padding-bottom: 2px;
	font-weight:bold;
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
-->	
</style>
<script>
function reg_submit() {
//check user name length
    var fm = document.forms[0];
	var user_obj=document.getElementById("txtusername");
	var user = (null == user_obj) ? "": user_obj.value;
	if(fm.txtuname.value =="") {
		//document.getElementById("error_div").innerHTML = "请输入你的用户名";
		alert("请输入你的注册用户名！");
		fm.txtuname.focus();
		return false;
	}
	if(user.length > 18 || user.length <6) {
		alert("用户名的长度不正确");
		fm.txtuname.focus();
		return;
	}

//check password is same
	var pwd_obj1=document.getElementById("pwd");
	var pwd_obj2=document.getElementById("pwdcfm");
	var pwd1 = (null == pwd_obj1) ? "" : pwd_obj1.value;
	var pwd2 = (null == pwd_obj2) ? "" : pwd_obj2.value;
	if(fm.txtpwd.value =="") {
		alert("请输入密码!");
		fm.txtpwd.focus();
		return false;
	}


//check passworkd length
	if(pwd1.length > 16 || pwd1.length <6) {
		alert("密码的长度不正确");
		fm.txtpwd.focus();
		return;
	}

	if(pwd1 != pwd2) {
		alert("请输入相同的密码！");
		fm.txtpwdconfirm.focus();
		return;
	}
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
	if(fm.authcode.value =="") {
		alert("请输入验证码！");
		fm.authcode.focus();
		return false;
	}

	document.forms[0].submit();
}
</script>
</head>

<body>
<center>
<%
	LogHandler logger=LogHandler.getInstance("userreg.jsp");
	DBOperator dbo = new DBOperator();
	String isDesc="";

	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
 	SystemSettingsList ssl;
	int i;
	ArrayList al;
	SystemSettings ss;
	String date_limit;
	ArrayList al_settings;
	String s_isPublic = "";
	
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
			response.sendRedirect("/error.jsp?error=" + new UTF8String("报名时间已过！").toUTF8String());
			return;
		}
%>
 <form action="/add_user" method="post">
 
<div class="regtit"><img src="../images/regnew.gif" width="16" height="16" />注册新用户</div>

<table width="950" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
  <tr>
    <td width="19%" align="right" class="tdlbl">用户名：<span class="emdot">*</span></td>
    <td width="81%" height="60">
    <input type="text" class="inputsty"  name="txtuname" maxlength="18" id="txtusername" value="" />
    <span class="STYLE1">（6～18个字符，包括字母、数字、下划线；字母开头，字母和数字结尾，不区分大小写）</span></td>
  </tr>
  <tr>
    <td height="60" align="right" class="tdlbl">密  码：<span class="emdot">*</span></td>
    <td height="60"><input name="txtpwd" id="pwd" type="password" class="inputsty" maxlength="16" /><span class="STYLE1">（6～16个字符（字母、数字、特殊符号）,区分大小写）</span></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">再次输入密码：<span class="emdot">*</span></td>
    <td height="60"><input name="txtpwdconfirm" id="pwdcfm" type="password" class="inputsty" maxlength="16" /></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">密码保护问题：<span class="emdot">*</span></td>
    <td height="60">    	<select name="selproblem" id="selproblem" class="selsty">
    		<option style="color:#666666" value="0">请选择密码保护问题</option>
    		<option value="您母亲的姓名是?">您母亲的姓名是?</option>
		  	<option value="您父亲的姓名是?">您父亲的姓名是?</option>
		  	<option value="您母亲的生日是?">您母亲的生日是?</option>
		  	<option value="您父亲的生日是?">您父亲的生日是?</option>
		  	<option value="您最喜爱的电影？">您最喜爱的电影?</option>
		 	<option value="您的出生地是?">您的出生地是?</option>
		  	<option value="您的小学校名是?">您的小学校名是?</option>
		  	<option value="您的中学校名是?">您的中学校名是?</option>
		  	<option value="您的大学校名是?">您的大学校名是?</option>			
		  	<option value="您手机号码的后6位？">您手机号码的后6位?</option>
    	</select><span class="STYLE1">（当忘记登录密码时，可以帮助找回密码）</span></td>
  </tr>
   <tr>
    <td align="right" class="tdlbl">密码保护问题答案：<span class="emdot">*</span></td>
    <td height="60">
    <input type="text" name="cusanswer" id="cusanswer" class="inputsty" maxlength="30" /><span class="STYLE1">（2～30个字符或汉字,字母区分大小写）</span></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">E-mail地址：</td>
    <td height="60"><input type="text" name="email" maxlength="80" id="idemail" class="inputsty" /></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">验证码：</td>
    <td height="60">
    <img id="verify_img" border=0 src=""/>
  	<a onClick="document.getElementById('verify_img').src='../get_verifyimg?gg='+Math.random();" >换一个</a>
    </td>
  </tr>
    <tr>
    <td align="right" class="tdlbl">请输入验证码：<span class="emdot">*</span></td>
    <td height="60"><input type="text" name="authcode" id="authcode" class="inputsty2" size="12" /></td>
  </tr>
  <tr>
    <td height="60" colspan="2" align="center" class="tdlbl"><input name="Submit1" type="button" value=" 提   交 " class="drt" onClick="reg_submit();"/><span style="margin-left: 5px; color: #F00" id="error_div"></span>&nbsp;&nbsp;<input type="button" name="Submit" value=" 返   回 "  class="drt" onClick="window.history.back();"/></td>
    </tr>
</table>

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
</center>
<script>
	var img = document.getElementById("verify_img");
	if(null != img) {
		img.src = "../get_verifyimg?gg="+Math.random();
	}
</script>
</body>
</html>
