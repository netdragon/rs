<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>找回密码-第1步</title>
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
width:200px;

}

.tdline{
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

</head>

<body>

<br>

<form action="/reset_pwd_chk" name="form" method="post" >
<div class="fpwddoc">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" colspan="2" bgcolor="#6CA4D0" class="titsty STYLE2">&nbsp;<span class="tit1">找回密码</span> <span class="STYLE1">-></span> <span class="tit1"> 输入用户名并回答密码保护问题</span></td>
  </tr>
  <tr>
    <td width="25%" height="66" align="right" class="lblsty tdline">用户名：</td>
    <td width="75%" class="tdline"><input name="lgname" type="text" class="inpsty" /></td>
  </tr> 
  <tr>
    <td height="66" align="right" class="lblsty tdline">请回答密码保护问题：</td>
    <td class="tdline"><select name="selproblem" id="selproblem" class="selsty">
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
    	</select></td>
  </tr>  
  <tr>
    <td height="66" align="right" class="lblsty tdline">密码保护问题答案：</td>
    <td class="tdline"><input name="pwdanswer" type="text" class="inpsty"  /></td>
  </tr>  
   
  <tr>
    <td height="15" colspan="2" align="right" class="lblsty"></td>
  </tr>
  <tr>
    <td height="32" colspan="2" align="center" class="lblsty" bgcolor="#E6EFF7"><input type="submit" class="btnsty1" name="submit" value=" 下 一 步 " >&nbsp;&nbsp;&nbsp;<input type="button" class="btnsty1" onClick='javascript:history.back();' value="　返　回　" ></td>
  </tr>
</table>
</div>
</form>

</body>
</html>
