<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>找回密码-第2步</title>
<style type="text/css">
<!--
.titsty{font-size:14px;color:#000000;}
.lblsty{font-size:14px;color:black;line-height:150%}
.btnsty1{
    font-size:14px;
    color:#000000;
}
.tit1{
color:#FFFFFF;
font-weight:bold;
    font-size:16px;
}
.STYLE1 {color: #FFFFFF}
.mmsty {
	color: #333333;
	font-size: 12px;
}
.fpwddoc{
	width: 620px;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	border: 1px solid #DDDAFE;
}
.inpsty{
height:25px;
width:340px;
}
.tdbline{
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #EEEEEE;
}
.STYLE2 {
	font-family: "宋体";
	font-size: 16;
}
-->
</style>
<script>
function mod_submit() {
//check user name length
    var fm = document.forms[0];

//check password is same
	var pwd_obj1=document.getElementById("pwdnew");
	var pwd_obj2=document.getElementById("pwdcfm");
	var pwd1 = (null == pwd_obj1) ? "" : pwd_obj1.value;
	var pwd2 = (null == pwd_obj2) ? "" : pwd_obj2.value;


	if(fm.passwordn.value =="") {
		alert("请输入新密码!");
		fm.passwordn.focus();
		return false;
	}

	if(pwd1.length > 16 || pwd1.length <6) {
		alert("密码的长度不正确");
		fm.passwordn.focus();
		return;
	}
//check passworkd length

	if(pwd1 != pwd2) {
		alert("新密码两次输入的不相同！");
		fm.cfmpassowrd.focus();
		return;
	}

//check email format
	document.forms[0].submit();
}
</script>
</head>

<body>

<br>

<form action="/reset_pwd" name="form" method="post">
<div class="fpwddoc">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td height="35" colspan="2" bgcolor="#6CA4D0" class="titsty STYLE2">&nbsp;<span class="tit1">找回密码</span> <span class="STYLE1">-></span> <span class="tit1"> 输入新密码</span></td>
  </tr>
    <tr>
    <td height="15" colspan="2" align="right" class="lblsty"></td>
  </tr>  
   <tr>
    <td height="50" align="right" class="lblsty tdbline">新　密　码：</td>
    <td class="tdbline"><input type="password" name="passwordn" id="pwdnew" maxlength="16"  class="inpsty"  size="44" /><br /><span class="mmsty">（6～16个字符（字母、数字、特殊符号）,区分大小写）</span></td>
  </tr>  
  <tr>
    <td height="50" align="right" class="lblsty">再次输入新密码：</td>
    <td><input type="password" name="cfmpassowrd" id="pwdcfm" maxlength="16"  class="inpsty"  size="44"  /></td>
  </tr>  

  <tr>
    <td height="15" colspan="2"></td>
  </tr>
  <tr>
    <td height="32" colspan="2" align="center" class="lblsty" bgcolor="#E6EFF7"><input type="button" class="btnsty1"  name="submitx" value="　完　成　"  onClick="mod_submit();">
    &nbsp;&nbsp;&nbsp;<input type="button" class="btnsty1" onClick='javascript:history.back();' value="　返　回　" ></td>
  </tr>
</table>
</div>
</form>

</body>
</html>
