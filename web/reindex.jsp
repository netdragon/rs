<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@page import="edu.cup.rs.common.*"%>
<%@page import="java.util.*"%>
<%
	session.setAttribute("user_id" , null);
	session.setAttribute("bmxxid" , null);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache"/>   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0"/>   
<title>自主招生网上报名系统－中国石油大学(北京)</title>
<style type="text/css">
<!--
body {

	margin-left: 0px;
	margin-top: 1px;
	margin-right: 0px;
	margin-bottom: 0px;
	
}


a {
	color: #6c8799; text-decoration: none; 
}
a:hover {
	color: #ff6600
}
#floatleft {
	float: left; color:#06588A;font-size:12px;
}

.doccontainer {
	margin-left: auto;
	width: 960px;
	margin-right: auto;
	/*border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #00547D;*/
	padding-left:0px;
	padding-right:0px;
	
}
.docmain_left{
	
	font-size: 12px;
	width:60%;
	border: 2px solid #CCC0DB;
	margin-left: auto;
	margin-right: auto;
}
.tdyhdl{/*用户登录标题单元格样式background-color:#4671AA;*/
    background-color:#FCFCFC;	
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #CCCCCC;
	color:#0000F7;/*4671AA;*/
	font-size:24px;
	font-weight:bold;
	padding-left:20px;
	padding-top:10px;
	padding-bottom:10px;
	font-family:"楷体_gb2312";

}
.docmain_leftlogin{ /*登录表单样式*/
	width:100%;
	font-size:16px;
	/*ABC0DB;*/
	padding-left:0px;
	height:290px;
}
.lb{font-size:16px;float:left;line-height:32px;margin-right:3px}
.ipt_s{
	font-size:16px;
	color:#333444;
	font-family: "Times New Roman", Times, serif;
	font-weight:bold;
	border:1px solid #737373;
	height:25px;
	background-color:#FBFBFB;
	padding-top: 3px;
	padding-right: 0px;
	padding-bottom: 2px;
	padding-left: 0px;
}

.ipt-b{
	height:31px;
	color:#373737;
	font-size:12px;
	font-weight:bold
}
.style1{font-size:12px;}
#pid a {
	color: #ff6600;
	font-weight:bold;
	text-decoration:underline;
}
#pid a:hover {
	color: #ff0000;
	text-decoration:none;
}

-->

</style>

<script>
function login() {
	//check user name length
    var fm = document.forms[0];
	var user_obj=document.getElementById("txtnameid");
	var user = (null == user_obj) ? "": user_obj.value;
	if(fm.txtname.value =="") {
		document.getElementById("error_div").innerHTML = "请输入你的用户名";
		fm.txtname.focus();
		return false;
	}
       if(user.length > 18 || user.length <6) {
		alert("用户名的长度不正确");
		return;
	}


	if( fm.txtpwd.value.length =="") {
		document.getElementById("error_div").innerHTML = "请输入你的密码";
		fm.txtpwd.focus();
		return false;
	}

//check password
	var pwd_obj1=document.getElementById("txtpwdid");
	var pwd1 = (null == pwd_obj1) ? "" : pwd_obj1.value;

//check passworkd length
	if(pwd1.length > 18 || pwd1.length <6) {
		alert("密码的长度不正确");
		return;
	}
//check answer length
	var an_obj=document.getElementById("authcodeid");
	var an = (null == an_obj) ? "": an_obj.value;
	if(fm.authcode.value =="") {
		document.getElementById("error_div").innerHTML = "请输入验证码";
		fm.authcode.focus();
		return false;
	}
	if(an.length != 4) {
		alert("验证码长度不正确");
		return;
	}
	document.forms[0].submit();
}

</script>
</head>

<body>
<p>&nbsp;</p>
<!-- 主要内容区 -->
	    <div class="docmain_left">
	  		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
    				<td class="tdyhdl"><img src="images/register.gif" width="19" height="18" align="absmiddle"/>&nbsp;页面超时或用户未登录，请重新登录</td>
                </tr>
		       <tr>
                <td class="docmain_leftlogin">
				<form action="/check_user" method="post">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
						    <td width="11%">&nbsp;</td>
							<td width="23%" height="43"><label class="lb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</label></td>
							<td width="66%"><input  name="txtname"  id="txtnameid" type="text" size="26" class="ipt_s" maxlength="18" /></td>
						  </tr>
						  <tr>
						    <td>&nbsp;</td>
							<td height="43"><label class="lb">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
							<td><input name="txtpwd" id="txtpwdid" type="password" class="ipt_s" size="26" maxlength="16"/></td>
						  </tr>
						  <tr>
						    <td>&nbsp;</td>
							<td height="43"><label class="lb">验&nbsp;&nbsp;证&nbsp;&nbsp;码：</label></td>
							<td><img id="verify_img" border=0 src="">
							  <a onClick="document.getElementById('verify_img').src='../get_verifyimg?gg='+Math.random();">换一个</a>
							</td>
						  </tr>
						  <tr>
						    <td>&nbsp;</td>
							<td height="43"><label class="lb">输入验证码：</label></td>
							<td>
							<input  id="authcodeid" name="authcode" type="text" size="16" class="ipt_s"  maxlength="4"/>
							</td>
						        
						  </tr>
						  <tr>
							<td height="47" colspan="3" align="center">
							<input type="button" onclick="login();" class="ipt-b" value=" 登　录 " /><span style="margin-left: 5px; color: #F00" id="error_div"></span>&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="" type="reset" value=" 重   置 "  class="ipt-b" /></td>
						  </tr>
						</table>
<%
    String s_URL=BaseFunction.null2value(request.getParameter("url"));
%>
			<input type="hidden" name="src_url" value="<%=s_URL%>">
				  </form> 							       
			   <br />          
			</td>
			 </tr>
			<tr>
    		<td height="6"></td>
            </tr>
	</table>	
  </div>

<!-- END 主要内容区 -->	

 

<script>
	var img = document.getElementById("verify_img");
	if(null != img) {
		img.src = "../get_verifyimg?gg="+Math.random();
	}
</script>

</body>
</html>
