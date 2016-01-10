<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>填写高中成绩鉴定表</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}
input {
	height: 20px;
	/*color:#333444;*/
	font-family:"Times New Roman", Times, serif;
	font-size:12px;

}
.star {color: #FF0000}
.STYLE3 {
	
	font-size: 16px;
	font-weight: bold;
	color: #FF3300;
}
.td1a {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #333333;
}
.td1 {

	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #333333;
	border-bottom-color: #333333;
}
.td2 {

	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #333333;
}

.fnt{	font-size: 12px;
	font-weight:bold;
}
.shuoming {font-size: 14px;  color:#000000;}
.STYLE6 {font-size: 12px; color:#000000;}
.tbl_w {
	border: 1px solid #333333;
}

body{
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom:0px;
}
.STYLE7 {font-size: 12px;color:#000000;}

.p1{font-size:12px;color:black}
.iptbox{
	font-size:12px;
	color:black;
	height: 24px;
}
.STYLE8 {
	font-family: "宋体";
	font-weight: bold;
	font-size: 18px;
}
.STYLE9 {font-size: 12px}

.tda1 {

	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #333333;
}
.tda2 {

	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #333333;
}
.sbtn {
	
	font-size: 18px;
	
}
#textaream {
	border: 1px solid #000000;
}

.STYLE10 {font-size: 18px; font-family: "宋体";}
-->
</style>
<script src="../common/validate.js"></script>
<script>
	function check_submit(){
		var fm = document.forms[0];
		document.forms[0].submit();
		return true;
	}
</script>
</head>

<body>
<%
	LogHandler logger=LogHandler.getInstance("cjjdb.jsp");
	String bmxxId = (String)session.getAttribute("bmxxid");
	String userId = (String)session.getAttribute("user_id");
	if(null == userId){
           logger.error("没有登录信息！");
           response.sendRedirect("/error.jsp?error=" + new UTF8String("没有登录信息！").toUTF8String());
		return;
	}
	if(null == bmxxId){
        logger.error("未报过名,报名请先填写自主选拔录取申请表！");
        response.sendRedirect("/error.jsp?error=" + new UTF8String("未报过名！报名请先填写自主选拔录取申请表!").toUTF8String());
		return;
	}
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
	ArrayList al, al_cjjd;
	SystemSettings ss;
	String date_limit;
	ICommonList icl;
	ArrayList al_settings;
	String s_isPublic = "";
	Bmxx bmxx;
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
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("审核结果已发布，不能再进行此操作！").toUTF8String());
			return;
		}
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		
		if(al.size() == 0){
            logger.error("数据错误！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		icl = new CjjdList(bmxx.getBmxxid());
		al_cjjd = dbo.getList(icl);
		if(al_cjjd.size() > 0){
            logger.error("已经填写成绩鉴定表，如果需要修改请使用修改菜单。");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("已经填写成绩鉴定表，如果需要修改请使用修改菜单。").toUTF8String());
			return;
		}
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
			int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>

<form action="/add_cjjd" method="post" >
<table width="992" border="0" align="center" cellpadding="0" cellspacing="0" class="tbl_w">
  <caption align="top">
    <span class="STYLE3">中国石油大学（北京）<%=year%>年自主选拔录取高中成绩鉴定表</span>
    </caption>
  <tr>
    <td width="99" align="center" class="td1 STYLE6">考生姓名</td>
    <td colspan="2" class="td1 STYLE6"><%=bmxx.getKsxm()%></td>
    <td width="199" align="center" class="td1 STYLE6">中学名称</td>
    <td colspan="2" class="tda2 STYLE6"><%=bmxx.getZxmc()%></td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6">中学通信地址<span class="star">﹡</span></td>
    <td colspan="3" class="td1 STYLE6"><input name="pzxdz" type="text" id="pzxdz" size="80" /></td>
    <td width="134" align="center" class="td1 STYLE6">中学级别<span class="star">﹡</span></td>
    <td width="248" class="tda2 STYLE6"><input type="radio" name="pzxjb" value="省级示范性高中">省级示范性高中<br />
                    <input type="radio" name="pzxjb" value="市级示范性高中">市级示范性高中<br />
	  <input name="pzxjb" type="radio" value="其它" checked>其它</td>
  </tr>
  <tr>
    <td align="center" class="td1 STYLE6">邮政编码<span class="star">﹡</span></td>
    <td width="212" class="td1 STYLE6"><input name="pzxyb" type="text" id="pzxyb" size="24" maxlength="6" /></td>
    <td width="98" align="center" class="td1 STYLE6">联系电话<span class="star">﹡</span></td>
    <td class="td1 STYLE6"><input name="pzxdh" type="text" id="pzxdh" size="30" /></td>
    <td align="center" class="td1 STYLE6">年级负责人<span class="star">﹡</span></td>
    <td class="tda2 STYLE6"><input name="pzxfzr" type="text" id="pzxfzr" size="30" maxlength="200" /></td>
  </tr>
  
  <tr>
    <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10%" align="center" class="td1 STYLE6">学习成绩</td>
        <td width="6%" align="center" class="td1 STYLE6">语文</td>
        <td width="5%" align="center" class="td1 STYLE6">数学</td>
        <td width="6%" align="center" class="td1 STYLE6">外语 </td>
        <td width="6%" align="center" class="td1 STYLE6">物理 </td>
        <td width="6%" align="center" class="td1 STYLE6">化学</td>
        <td width="6%" align="center" class="td1 STYLE6">生物 </td>
        <td width="6%" align="center" class="td1 STYLE6">历史</td>
        <td width="6%" align="center" class="td1 STYLE6">政治</td>
        <td width="6%" align="center" class="td1 STYLE6">地理</td>
        <td width="6%" align="center" class="td1 STYLE6">体育</td>
        <td width="6%" align="center" class="td1 STYLE6">总分</td>
        <td width="6%" align="center" class="td1 STYLE6">班级<br />
          名次</td>
        <td width="6%" align="center" class="td1 STYLE6">班级<br />
          人数</td>
        <td width="6%" align="center" class="td1 STYLE6">年级<br />
          名次</td>
        <td width="7%" align="center" class="tda2 STYLE6">年级<br />人数</td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高一（上）期末</td>
        <td class="td1"><input name="pgysyw" type="text" id="pgysyw" size="3"></td>
        <td class="td1"><input name="pgyssx" type="text" size="3"></td>
        <td class="td1"><input name="pgyswy" type="text" id="pgyswy" size="3"></td>
        <td class="td1"><input name="pgyswl" type="text" size="3"></td>
        <td class="td1"><input name="pgyshx" type="text" size="3"></td>
        <td class="td1"><input name="pgyssw" type="text" size="3"></td>
        <td class="td1"><input name="pgysls" type="text" size="3"></td>
        <td class="td1"><input name="pgyszz" type="text" size="3"></td>
        <td class="td1"><input name="pgysdl" type="text" size="3"></td>
        <td class="td1"><input name="pgysty" type="text" size="3"></td>
        <td class="td1"><input name="pgyszf" type="text" size="3"></td>
        <td class="td1"><input name="pgysbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pgysbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pgysnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pgysnjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高一（下）期末</td>
        <td class="td1"><input name="pgyxyw" type="text" id="pgyxyw" size="3"></td>
        <td class="td1"><input name="pgyxsx" type="text" size="3"></td>
        <td class="td1"><input name="pgyxwy" type="text" id="pgyxwy" size="3"></td>
        <td class="td1"><input name="pgyxwl" type="text" size="3"></td>
        <td class="td1"><input name="pgyxhx" type="text" size="3"></td>
        <td class="td1"><input name="pgyxsw" type="text" size="3"></td>
        <td class="td1"><input name="pgyxls" type="text" size="3"></td>
        <td class="td1"><input name="pgyxzz" type="text" size="3"></td>
        <td class="td1"><input name="pgyxdl" type="text" size="3"></td>
        <td class="td1"><input name="pgyxty" type="text" size="3"></td>
        <td class="td1"><input name="pgyxzf" type="text" size="3"></td>
        <td class="td1"><input name="pgyxbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pgyxbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pgyxnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pgyxnjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高二（上）期末</td>
        <td class="td1"><input name="pgesyw" type="text" id="pgesyw" size="3"></td>
        <td class="td1"><input name="pgessx" type="text" size="3"></td>
        <td class="td1"><input name="pgeswy" type="text" id="pgeswy" size="3"></td>
        <td class="td1"><input name="pgeswl" type="text" size="3"></td>
        <td class="td1"><input name="pgeshx" type="text" size="3"></td>
        <td class="td1"><input name="pgessw" type="text" size="3"></td>
        <td class="td1"><input name="pgesls" type="text" size="3"></td>
        <td class="td1"><input name="pgeszz" type="text" size="3"></td>
        <td class="td1"><input name="pgesdl" type="text" size="3"></td>
        <td class="td1"><input name="pgesty" type="text" size="3"></td>
        <td class="td1"><input name="pgeszf" type="text" size="3"></td>
        <td class="td1"><input name="pgesbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pgesbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pgesnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pgesnjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高二（下）期末</td>
        <td class="td1"><input name="pgexyw" type="text" id="pgexyw" size="3"></td>
        <td class="td1"><input name="pgexsx" type="text" size="3"></td>
        <td class="td1"><input name="pgexwy" type="text" id="pgexwy" size="3"></td>
        <td class="td1"><input name="pgexwl" type="text" size="3"></td>
        <td class="td1"><input name="pgexhx" type="text" size="3"></td>
        <td class="td1"><input name="pgexsw" type="text" size="3"></td>
        <td class="td1"><input name="pgexls" type="text" size="3"></td>
        <td class="td1"><input name="pgexzz" type="text" size="3"></td>
        <td class="td1"><input name="pgexdl" type="text" size="3"></td>
        <td class="td1"><input name="pgexty" type="text" size="3"></td>
        <td class="td1"><input name="pgexzf" type="text" size="3"></td>
        <td class="td1"><input name="pgexbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pgexbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pgexnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pgexnjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">高三（上）期末</td>
        <td class="td1"><input name="pgssyw" type="text" id="pgssyw" size="3"></td>
        <td class="td1"><input name="pgsssx" type="text" size="3"></td>
        <td class="td1"><input name="pgsswy" type="text" id="pgsswy" size="3"></td>
        <td class="td1"><input name="pgsswl" type="text" size="3"></td>
        <td class="td1"><input name="pgsshx" type="text" size="3"></td>
        <td class="td1"><input name="pgsssw" type="text" size="3"></td>
        <td class="td1"><input name="pgssls" type="text" size="3"></td>
        <td class="td1"><input name="pgsszz" type="text" size="3"></td>
        <td class="td1"><input name="pgssdl" type="text" size="3"></td>
        <td class="td1"><input name="pgssty" type="text" size="3"></td>
        <td class="td1"><input name="pgsszf" type="text" size="3"></td>
        <td class="td1"><input name="pgssbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pgssbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pgssnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pgssnjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">会考成绩</td>
        <td class="td1"><input name="phkyw" type="text" id="phkyw" size="3"></td>
        <td class="td1"><input name="phksx" type="text" size="3"></td>
        <td class="td1"><input name="phkwy" type="text" id="phkwy" size="3"></td>
        <td class="td1"><input name="phkwl" type="text" size="3"></td>
        <td class="td1"><input name="phkhx" type="text" size="3"></td>
        <td class="td1"><input name="phksw" type="text" size="3"></td>
        <td class="td1"><input name="phkls" type="text" size="3"></td>
        <td class="td1"><input name="phkzz" type="text" size="3"></td>
        <td class="td1"><input name="phkdl" type="text" size="3"></td>
        <td class="td1"><input name="phkty" type="text" size="3"></td>
        <td class="td1"><input name="phkzf" type="text" size="3"></td>
        <td class="td1"><input name="phkbjmc" type="text" size="4"></td>
        <td class="td1"><input name="phkbjrs" type="text" size="4"></td>
        <td class="td1"><input name="phknjmc" type="text" size="4"></td>
        <td class="tda2"><input name="phknjrs" type="text" size="4"></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">最近考试</td>
        <td class="td1"><input name="pzjyw" type="text" id="pzjyw" size="3"></td>
        <td class="td1"><input name="pzjsx" type="text" size="3"></td>
        <td class="td1"><input name="pzjwy" type="text" id="pzjwy" size="3"></td>
        <td class="td1"><input name="pzjwl" type="text" size="3"></td>
        <td class="td1"><input name="pzjhx" type="text" size="3"></td>
        <td class="td1"><input name="pzjsw" type="text" size="3"></td>
        <td class="td1"><input name="pzjls" type="text" size="3"></td>
        <td class="td1"><input name="pzjzz" type="text" size="3"></td>
        <td class="td1"><input name="pzjdl" type="text" size="3"></td>
        <td class="td1"><input name="pzjty" type="text" size="3"></td>
        <td class="td1"><input name="pzjzf" type="text" size="3"></td>
        <td class="td1"><input name="pzjbjmc" type="text" size="4"></td>
        <td class="td1"><input name="pzjbjrs" type="text" size="4"></td>
        <td class="td1"><input name="pzjnjmc" type="text" size="4"></td>
        <td class="tda2"><input name="pzjnjrs" type="text" size="4"></td>
      </tr>
    </table></td>
    </tr>
  
  <tr>
    <td align="center" class="td1 STYLE6">&nbsp;&nbsp;&nbsp;&nbsp;班主任<br />
      &nbsp;&nbsp;综合评价</td>
    <td class="tda2" colspan="5" align="left" valign="top"><p class="STYLE9">(此栏可打印后手写)</p>
	<textarea name="bzrpj" cols="70" rows="6" id="textaream" style="width=90%;height=80"></textarea>
	<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班主任（签章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日 </td>
    </tr>
  <tr>
    <td align="center" class="tda1 STYLE6">&nbsp;中学审查<br />
      &nbsp;&nbsp;&nbsp;意&nbsp;见</td>
    <td colspan="5" class="STYLE6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><p>&nbsp;</p>
          <p class="STYLE8">&nbsp;&nbsp;&nbsp;&nbsp;该生是我校高中(应届</span><span class="STYLE10">□</span><span class="STYLE8">&nbsp;&nbsp;往届</span><span class="STYLE10">□</span><span class="STYLE8">)毕业生，以上材料全部属实，同意报考。若有虚假，我校愿意承担后果。</p>
          <br /></td>
      </tr>
      <tr>
        <td>&nbsp;&nbsp;校长签字：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（学校公章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</td>
      </tr>
    </table></td>
    </tr>
</table>


<table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td height="8"></td></tr>
  <tr>
 
      <td height="41" align="center"  valign="middle"><input type="button" name="Submit" style="width:80px; height:30px;" value=" 提 交 " class="sbtn" onClick="check_submit();"></td>
    </tr>
</table>
</form>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</body>
</html>
