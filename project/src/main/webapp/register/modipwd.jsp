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
<title>重新设置用户登录密码</title>

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

//check password is same
	var pwd_obj1=document.getElementById("pwdnew");
	var pwd_obj2=document.getElementById("pwdcfm");
	var pwd1 = (null == pwd_obj1) ? "" : pwd_obj1.value;
	var pwd2 = (null == pwd_obj2) ? "" : pwd_obj2.value;
	if(fm.txtpwdold.value =="") {
		alert("请输入旧密码!");
		fm.txtpwdold.focus();
		return false;
	}

	if(fm.txtpwdnew.value =="") {
		alert("请输入新密码!");
		fm.txtpwdnew.focus();
		return false;
	}

	if(pwd1.length > 16|| pwd1.length <6) {
		alert("密码的长度不正确");
		fm.txtpwdnew.focus();
		return;
	}
//check passworkd length

	if(pwd1 != pwd2) {
		alert("新密码两次输入的不相同！");
		fm.txtpwdconfirm.focus();
		return;
	}

//check email format
	document.forms[0].submit();
}
</script>
</head>

<body>

<div class="doc">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#108AC6">
  <tr><td height="25" valign="middle"><img src="../images/xgmmpic.gif" width="20" height="19" /><span class="STYLE2">修改登录密码</span></td>
  </tr>
  </table>
<form action="/modi_pwd" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
 <tr>
    <td height="60" align="right" valign="middle" class="tdlbl">旧 密  码：<span class="emdot">*</span></td>
    <td height="60" valign="middle"><input name="txtpwdold" id="pwdold" type="password" class="inputsty" maxlength="16" /></td>
  </tr>
  <tr>
    <td height="60" align="right" class="tdlbl">新 密  码：<span class="emdot">*</span></td>
    <td height="60"><input name="txtpwdnew" id="pwdnew" type="password" class="inputsty" maxlength="16" /><br /><span class="STYLE1">（6～16个字符（字母、数字、特殊符号）,区分大小写）</span></td>
  </tr>
  <tr>
    <td align="right" class="tdlbl">再次输入新密码：<span class="emdot">*</span></td>
    <td height="60"><input name="txtpwdconfirm" id="pwdcfm" type="password" class="inputsty" maxlength="16" /></td>
  </tr>
  <tr>
    <td height="60" colspan="2" align="center" class="tdlbl"><input type="button" name="Subxg" value="修 改" onclick="reg_submit();"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Subqx" value="取 消"  onclick="window.history.back();"/></td>
    </tr>
</table>

</form>
</div>

</body>
</html>
