<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>填写报考登记表</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}
input {
	height: 20px;
	color:#333444;
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

.tdax {


	border-bottom-width: 1px;

	border-bottom-style: solid;

	border-bottom-color: #333333;
}

.tdjc {

	border-right-width: 1px;
	border-bottom-width: 2px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #333333;
	border-bottom-color: #333333;
}

.td2jc {


	border-bottom-width: 2px;

	border-bottom-style: solid;

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
.shuoming {font-size: 12px; font-weight:bold; color:#00004F;}
.STYLE6 {font-size: 12px; color:#000099;}
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
.sbtn {
	
	font-size: 18px;
	
}

-->
</style>
<script src="../common/validate.js"></script>
<script>
	function check_submit(){	
         
       
		var fm = document.forms[0];
		if(fm.psqly.value =="qxz") {
			alert("申请理由没有选择！");
                     fm.psqly.focus();
			return false;
		}
	
		return subchk();
	}
	
</script>
</head>
<body onLoad="if(document.getElementById('pkskl_1').checked) kskl_change(document.getElementById('pkskl_1')); else kskl_change(document.getElementById('pkskl_2'));">
<%
	LogHandler logger=LogHandler.getInstance("enrollment.jsp");
	String bmxxId = (String)session.getAttribute("bmxxid");
	String userId = (String)session.getAttribute("user_id");
	if(null == userId){
           logger.error("没有登录信息！");
           response.sendRedirect("/error.jsp?error=" + new UTF8String("没有登录信息！").toUTF8String());
		return;
	}
	if(null != bmxxId){
        logger.error("已经报过名了！"+bmxxId);
        response.sendRedirect("/error.jsp?error=" + new UTF8String("已经报过名了！").toUTF8String());
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
	ZhshzyList zyl;
	Sqbkly bkly;
	SqbklyList bklyList;
	ArrayList al_bkly;
	Zhshzy zy;
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
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("审核结果已发布，不能修改报名信息！").toUTF8String());
			return;
		}
		ssl = new SystemSettingsList("isPublic_Admission");
		al_settings = dbo.getList(ssl);
		s_isPublic = "";
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("准考证已发布，不能修改报名信息！").toUTF8String());
			return;
		}
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
	    year = (11 > month) ? year : (year + 1);
		zyl = new ZhshzyList();
		al = dbo.getList(zyl);
		bklyList = new SqbklyList();
		al_bkly = dbo.getList(bklyList);
%>
<script>

<%
        int ksLeibie = 0;
		
		for(i=0; i<al_bkly.size(); i++) {
			bkly = (Sqbkly)al_bkly.get(i);
			ksLeibie = bkly.getType();

%>
    var leiBie = new Object();
	if(null == lyList_<%=ksLeibie%>)
	   var lyList_<%=ksLeibie%> = new Array();
	leiBie.id = <%=bkly.getId()%>;
	leiBie.mc = "<%=bkly.getMc()%>";
	lyList_<%=ksLeibie%>[lyList_<%=ksLeibie%>.length] = leiBie;
<%
		}
%>
<%
        int zyLeibie = 0;
		for(i=0; i<al.size(); i++) {
			zy = (Zhshzy)al.get(i);
			zyLeibie = zy.getType();

%>
    var zy = new Object();
	if(null == zyList_<%=zyLeibie%>)
	   var zyList_<%=zyLeibie%> = new Array();
	zy.id = <%=zy.getZyid()%>;
	zy.mc = "<%=zy.getZymc()%>";
	zyList_<%=zyLeibie%>[zyList_<%=zyLeibie%>.length] = zy;
<%
		}
%>

</script>
<table width="780" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#D0D0D0">
   <tr>
    <td align="left" bgcolor="#FFFFFF" class="shuoming">注：1.请认真、如实的、尽可能完整地填写下面的报名表。&nbsp;&nbsp;2.表中带<span class="star">﹡</span>的项为必填（选）项</td>
  </tr>
</table>

<form action="/add_bmxx" enctype="multipart/form-data" method="post" >
<table width="780" border="0" align="center" cellpadding="0" cellspacing="0" class="tbl_w">
  <caption align="top">
    <span class="STYLE3">中国石油大学（北京）<%=year%>年自主选拔录取申请表</span>
    </caption>
	<!--
  <tr>
    <td colspan="6" align="left"  class="tdax fnt">&nbsp;&nbsp;上传照片<span class="star">﹡</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input name="perphoto" type="file" id="perphoto" />&nbsp;&nbsp;<span class="p1">(免冠一寸彩色)</span>	  </td>
    </tr -->
    <tr>
      <td width="104" align="center"  class="td1 STYLE6">姓名<span class="star">﹡</span></td>
      <td width="181"  height="38" align="left" class="td1"><input name="pname" type="text" class="iptbox" id="pname"  size="24" maxlength="100"/></td>
      <td width="55"  height="38" align="center" class="td1 STYLE6" >性别<span class="star">﹡</span></td>
      <td width="147" align="left" class="td1"><input type="radio" name="pxb" value="1" checked="checked"/>
			      <span class="STYLE7">男</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="pxb" value="0" />
      <span class="STYLE7">女</span>	  </td>
      <td width="69"  height="38" align="center" class="STYLE6 td1">外语语种<span class="star">﹡</span></td>
      <td width="222"  height="38" align="left" class="td2"><input type="radio" name="pwyyz" value="英语" checked="checked"/><span class="STYLE7">英语</span>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="pwyyz" value="其它" /><span class="STYLE7">其它</span>	  </td>
    </tr>
  
    <tr>
<td width="104" align="center"  class="td1 STYLE6" nowrap="nowrap"
>高考省份<span class="star">﹡</span></td>
      <td height="38" align="left" class="td1"><select id="pjg" name="pjg">
					  <option value="北京"  selected>北京</option>
					  <option value="天津">天津</option>
					  <option value="河北">河北</option>
					  <option value="山西">山西</option>
					  <option value="内蒙古">内蒙古</option>
					  <option value="辽宁">辽宁</option>
					  <option value="吉林">吉林</option>
					  <option value="黑龙江">黑龙江</option>
					  <option value="上海">上海</option>
					  <option value="江苏">江苏</option>
					  <option value="浙江">浙江</option>
					  <option value="安徽">安徽</option>
					  <option value="福建">福建</option>
					  <option value="江西">江西</option>
					  <option value="山东">山东</option>
					  <option value="河南">河南</option>
					  <option value="湖北">湖北</option>
					  <option value="湖南">湖南</option>
					  <option value="广东">广东</option>
					  <option value="广西">广西</option>
					  <option value="海南">海南</option>
					  <option value="重庆">重庆</option>
					  <option value="四川">四川</option>
					  <option value="贵州">贵州</option>
					  <option value="云南">云南</option>
					  <option value="西藏">西藏</option>
					  <option value="陕西">陕西</option>
					  <option value="甘肃">甘肃</option>
					  <option value="青海">青海</option>
					  <option value="宁夏">宁夏</option>
					  <option value="新疆">新疆</option>
					 </select>	 </td>
      <td align="center"  class="STYLE6 td1" >民族<span class="star">﹡</span></td>
      <td align="left"  class="td1" ><select id="pminzu" name="pminzu">
				  <option value="汉族"  selected>汉族</option>
				  <option value="蒙古族">蒙古族</option>
				  <option value="回族">回族</option>
				  <option value="藏族">藏族</option>
				  <option value="维吾尔族">维吾尔族</option>
				  <option value="苗族">苗族</option>
				  <option value="彝族">彝族</option>
				  <option value="壮族">壮族</option>
				  <option value="布依族">布依族</option>
				  <option value="朝鲜族">朝鲜族</option>
				  <option value="满族">满族</option>
				  <option value="侗族">侗族</option>
				  <option value="瑶族">瑶族</option>
				  <option value="白族">白族</option>
				  <option value="土家族">土家族</option>
				  <option value="哈尼族">哈尼族</option>
				  <option value="哈萨克族">哈萨克族</option>
				  <option value="傣族">傣族</option>
				  <option value="黎族">黎族</option>
				  <option value="傈僳族">傈僳族</option>
				  <option value="佤族">佤族</option>
				  <option value="畲族">畲族</option>
				  <option value="高山族">高山族</option>
				  <option value="拉祜族">拉祜族</option>
				  <option value="水族">水族</option>
				  <option value="东乡族">东乡族</option>
				  <option value="纳西族">纳西族</option>
				  <option value="景颇族">景颇族</option>
				  <option value="柯尔克孜">柯尔克孜</option>
				  <option value="土族">土族</option>
				  <option value="达斡尔族">达斡尔族</option>
				  <option value="仫佬族">仫佬族</option>
				  <option value="羌族">羌族</option>
				  <option value="布朗族">布朗族</option>
				  <option value="撒拉族">撒拉族</option>
				  <option value="毛难族">毛难族</option>
				  <option value="仡佬族">仡佬族</option>
				  <option value="锡伯族">锡伯族</option>
				  <option value="阿昌族">阿昌族</option>
				  <option value="普米族">普米族</option>
				  <option value="塔吉克族">塔吉克族</option>
				  <option value="怒族">怒族</option>
				  <option value="乌孜别克">乌孜别克</option>
				  <option value="俄罗斯族">俄罗斯族</option>
				  <option value="鄂温克族">鄂温克族</option>
				  <option value="崩龙族">崩龙族</option>
				  <option value="保安族">保安族</option>
				  <option value="裕固族">裕固族</option>
				  <option value="京族">京族</option>
				  <option value="塔塔尔族">塔塔尔族</option>
				  <option value="独龙族">独龙族</option>
				   <option value="鄂伦春族">鄂伦春族</option>
				  <option value="赫哲族">赫哲族</option>
				  <option value="门巴族">门巴族</option>
				  <option value="珞巴族">珞巴族</option>
				  <option value="基诺族">基诺族</option>
				  <option value="其他">其他</option>
				</select>	</td>
      <td align="center"  class="STYLE6 td1" >政治面貌<span class="star">﹡</span></td>
      <td align="left"  class="td2" ><select name="pzzmm" id="pzzmm">
					  <option value="中共党员" >中共党员</option>
					  <option value="中共预备党员">中共预备党员</option>
					  <option value="共青团员" selected>共青团员</option>
					  <option value="群众">群众</option>
					</select>	</td>
    </tr>
    
  <tr>
    <td width="104" align="center"  class="STYLE6 td1" nowrap="nowrap"
>中学名称<span class="star">﹡</span></td>
    <td height="38" colspan="3" align="left" class="STYLE6 td1"><input name="pzxmc" type="text" class="iptbox" id="pzxmc"  size="56" maxlength="200"/></td>
    <td align="center" class="td1"><span class="STYLE6">考生科类<span class="star">﹡</span></span></td>
    <td align="left" class="td2"><input type="radio" onChange="kskl_change(this);" onClick="kskl_change(this);" id="pkskl_1" name="pkskl" value="理工" checked="checked"/>
      <span class="STYLE7">理工</span>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" onChange="kskl_change(this);" onClick="kskl_change(this);" id="pkskl_2" name="pkskl" value="文史" />
      <span class="STYLE7">文史</span></td>
  </tr>
  <tr>
    <td width="104" align="center"  class="td1 STYLE6" nowrap="nowrap"
>身份证号<span class="star">﹡</span></td>
    <td height="38" colspan="5" align="left" class="STYLE6 tdax"><input class="iptbox" name="pidcardnum" type="text" id="pidcardnum" size="66" maxlength="18" /></td>
    </tr>
  <tr>
    <td width="104" align="center"  class="td1 STYLE6" nowrap="nowrap"
>通知书邮寄地址<span class="star">﹡</span></td>
    <td height="38" colspan="5" align="left" class="STYLE6 tdax"><input name="ptxdzh" type="text" class="iptbox" id="ptxdzh"   size="88" maxlength="300"/></td>
    </tr>
  <tr>
    <td width="104" align="center"  class="tdjc STYLE6" nowrap="nowrap"
>邮政编码<span class="star">﹡</span></td>
    <td height="38" align="left" class="tdjc"><input name="pyzbm" type="text" class="iptbox" id="pyzbm"   size="16" maxlength="8"/></td>
    <td align="center" class="tdjc STYLE6">收信人<span class="star">﹡</span></td>
    <td align="left" class="tdjc"><input name="pshxr" type="text" class="iptbox" id="pshxr"   size="16" maxlength="100"/></td>
    <td align="center" class="tdjc STYLE6">联系电话<span class="star">﹡</span></td>
    <td align="left" class="td2jc"><input name="pyddh" type="text" class="iptbox" id="pyddh"   size="22" maxlength="100"/></td>
  </tr>
  <tr>
    <td height="36" colspan="6" align="center"  class="tdax fnt">家庭情况</td>
    </tr>
  <tr>
    <td height="38" colspan="6" align="center"  class="td2 fnt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="13%" align="center" class="td1 STYLE6">父亲姓名</td>
        <td width="27%" class="td1"><input name="pfmxm" type="text" class="iptbox" id="pfmxm"  size="24" maxlength="100"/></td>
        <td width="12%" align="center" class="td1 STYLE6">联系电话</td>
        <td width="48%" class="td2"><input name="fmyddh" type="text" class="iptbox" id="fmyddh"  size="30" maxlength="100"/></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">父亲工作单位</td>
        <td colspan="3" class="td1"><input name="fmgzdw" type="text" class="iptbox" id="fmgzdw"  size="86" maxlength="200"/>
        &nbsp;<input name="fmgzzw" type="text" class="iptbox" id="fmgzzw"  size="8" value="fzw" style="display:none"/></td>
        </tr>
      <tr>
        <td align="center" class="td1 STYLE6">母亲姓名</td>
        <td class="td1"><input name="pmmxm" type="text" class="iptbox" id="pmmxm"  size="24" maxlength="100"/></td>
        <td align="center" class="td1 STYLE6">联系电话</td>
        <td class="td2"><input name="mmyddh" type="text" class="iptbox" id="mmyddh"  size="30" maxlength="100"/></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">母亲工作单位</td>
        <td colspan="3" class="td1"><input name="mmgzdw" type="text" class="iptbox" id="mmgzdw"  size="86" maxlength="200"/>
        &nbsp;<input name="mmgzzw" type="text" class="iptbox" id="mmgzzw"  size="8" value="mzw" style="display:none"/></td>
        </tr>

    </table></td>
  </tr>
   <tr>
    <td height="36" colspan="6" align="center"  class="tdax fnt">面试分组</td>
    </tr>
  <tr>
    <td height="38" colspan="6" align="center"  class="td2 fnt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="13%" align="center" class="td1 STYLE6">申请理由<span class="star">﹡</span> <br>
      （面试分组）</td>
        <td width="87%" class="td1" align="left"><select name="psqly" id="psqly" onChange="leiBie_change(this);" onclick="leiBie_change(this);">
        <option value="qxz" selected="selected">--请选择--</option> 
      </select></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">专业志愿</td>
  </tr>
  <tr>
    <td height="38" colspan="6" align="center"  class="td2 fnt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="11%" align="center" class="td1 STYLE6">第一志愿<span class="star">﹡</span></td>
        <td width="22%" class="td1"><select name="pzhiyuan1" id="pzhiyuan1"> <option value="0" selected="selected">--请选择--</option> 
      </select></td>
        <td width="11%" align="center" class="td1 STYLE6">第二志愿</td>
        <td width="22%" class="td1"><select name="pzhiyuan2" id="pzhiyuan2"> <option value="0" selected="selected">--请选择--</option> 
      </select></td>
        <td width="12%" align="center" class="td1 STYLE6">第三志愿</td>
        <td width="22%" class="td2"><select name="pzhiyuan3" id="pzhiyuan3"> <option value="0" selected="selected">--请选择--</option> 
      </select></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">是否服从调剂</td>
        <td colspan="5" class="td1"><input type="radio" name="psftj" value="1"  checked="checked"/>
        <span class="STYLE7">是</span>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="psftj" value="0" />
        <span class="STYLE7">否</span></td>
        </tr>
    </table></td>
  </tr>
<tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">高中阶段获省市级以上荣誉称号和竞赛获奖情况</td>
  </tr>
<tr>
  <td height="38" colspan="6" align="center"  class="td2 fnt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20%" align="center" class="STYLE6 td1">获奖时间</td>
      <td width="30%" align="center" class="STYLE6 td1">获奖名称</td>
      <td width="13%" align="center" class="STYLE6 td1">竞赛级别</td>
      <td width="13%" align="center" class="STYLE6 td1">获奖等级</td>
      <td width="24%" align="center" class="STYLE6 td2">授奖部门</td>
    </tr>
    <tr>
    <td  class="td1" ><select name="pzhenian1"  class="p1">
          <option value="" selected="selected"> </option>	
          
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990">1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007" >2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="pzheyue1"  class="p1">
          <option value="" selected="selected"> </option>	

          <option value="01" >1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>
        
      <span class="STYLE7">月</span></td>
    <td  class="td1" ><input name="phjmc1" type="text" class="iptbox"  size="30" maxlength="200" /></td>
    <td  class="td1" ><select name="pjsjb1" id="pjsjb1">
         <option value="" selected="selected"></option>
        <option value="国家级">国家级</option>
        <option value="省级复赛">省级复赛</option>
        <option value="省级初赛">省级初赛</option>
      </select></td>
    <td  class="td1" ><input name="phjdj1" type="text" class="iptbox"  size="11" maxlength="120" /></td>
    <td  class="td2" ><input name="psjbm1" type="text" class="iptbox"  size="25" maxlength="200" /></td>
    </tr>
    <tr>
<td  class="td1" ><select name="pzhenian2"  class="p1">
          <option value="" selected="selected"></option>	
          
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990" >1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007" >2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="pzheyue2"  class="p1">
          <option value="" selected="selected"></option>	

          <option value="01">1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>        
      <span class="STYLE7">月</span></td>
    <td  class="td1" ><input name="phjmc2" type="text" class="iptbox"  size="30" maxlength="200" /></td>
    <td  class="td1" ><select name="pjsjb2" id="pjsjb2">
         <option value="" selected="selected"></option>
        <option value="国家级">国家级</option>
        <option value="省级复赛">省级复赛</option>
        <option value="省级初赛">省级初赛</option>
      </select></td>
    <td  class="td1" ><input name="phjdj2" type="text" class="iptbox"  size="11" maxlength="120" /></td>
    <td  class="td2" ><input name="psjbm2" type="text" class="iptbox"  size="25" maxlength="200" /></td>    
</tr>
<tr>
<td  class="td1" ><select name="pzhenian3"  class="p1">
            <option value="" selected="selected"></option>	
        
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990">1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007" >2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="pzheyue3"  class="p1">
          <option value="" selected="selected"></option>	

          <option value="01">1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>
        
      <span class="STYLE7">月</span></td>
    <td  class="td1" ><input name="phjmc3" type="text" class="iptbox"  size="30" maxlength="200" /></td>
    <td  class="td1" ><select name="pjsjb3" id="pjsjb3">
        <option value="" selected="selected"></option>
        <option value="国家级">国家级</option>
        <option value="省级复赛">省级复赛</option>
        <option value="省级初赛">省级初赛</option>
      </select></td>
    <td  class="td1" ><input name="phjdj3" type="text" class="iptbox"  size="11" maxlength="120" /></td>
    <td  class="td2" ><input name="psjbm3" type="text" class="iptbox"  size="25" maxlength="200" /></td>
</tr>
  </table></td>
</tr>
<tr>
  <td height="36" colspan="6" align="center"  class="td2 fnt">参加或组织的社会工作或课外活动，受过何种奖励</td>
</tr>
<tr>
  <td height="38" colspan="6" align="center"  class="td2 fnt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20%" align="center" class="STYLE6 td1">时间</td>
      <td width="40%" align="center" class="STYLE6 td1">活动名称</td>
      <td width="40%" align="center" class="STYLE6 td2">本人在活动中的角色和贡献</td>
    </tr>
    <tr>
      <td class="td1"><select name="phdn1"  class="p1">
          <option value=""  selected="selected"></option>	
          
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990" >1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007">2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="phdy1"  class="p1">
          <option value=""  selected="selected"></option>	

          <option value="01" >1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>
        
      <span class="STYLE7">月</span></td>
      <td class="td1"><input name="phdmc1" type="text" class="iptbox"  size="46" maxlength="200" /></td>
      <td class="td2"><input name="phdjs1" type="text" class="iptbox"  size="46" maxlength="300" /></td>
    </tr>
    <tr>
<td class="td1"><select name="phdn2"  class="p1">
          <option value=""  selected="selected"></option>	
          
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990" >1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007"  >2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="phdy2"  class="p1">
          <option value=""  selected="selected"></option>	
          <option value="01" >1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>
        
      <span class="STYLE7">月</span></td>
      <td class="td1"><input name="phdmc2" type="text" class="iptbox"  size="46" maxlength="200" /></td>
      <td class="td2"><input name="phdjs2" type="text" class="iptbox"  size="46" maxlength="300" /></td>
  </tr>
    <tr>
<td class="td1"><select name="phdn3"  class="p1">
           <option value=""  selected="selected"></option>	
         
          <option value="1980" >1980</option>	
          
          <option value="1981" >1981</option>	
          
          <option value="1982" >1982</option>	
          
          <option value="1983" >1983</option>	
          
          <option value="1984" >1984</option>	
          
          <option value="1985" >1985</option>	
          
          <option value="1986" >1986</option>	
          
          <option value="1987" >1987</option>	
          
          <option value="1988" >1988</option>	
          
          <option value="1989" >1989</option>	
          
          <option value="1990" >1990</option>	
          
          <option value="1991" >1991</option>	
          
          <option value="1992" >1992</option>	
          
          <option value="1993" >1993</option>	
          
          <option value="1994" >1994</option>	
          
          <option value="1995" >1995</option>	
          
          <option value="1996" >1996</option>	
          
          <option value="1997" >1997</option>	
          
          <option value="1998" >1998</option>	
          
          <option value="1999" >1999</option>	
          
          <option value="2000" >2000</option>	
          
          <option value="2001" >2001</option>	
          
          <option value="2002" >2002</option>	
          
          <option value="2003" >2003</option>	
          
          <option value="2004" >2004</option>	
          
          <option value="2005" >2005</option>	
          
          <option value="2006" >2006</option>	
          
          <option value="2007"  >2007</option>	
          
          <option value="2008" >2008</option>	
          
          <option value="2009" >2009</option>	
          
          <option value="2010" >2010</option>	
          
          <option value="2011" >2011</option>	
          
          <option value="2012" >2012</option>	
          
          <option value="2013" >2013</option>	
          
          <option value="2014" >2014</option>	
          
          <option value="2015" >2015</option>	
          
          <option value="2016" >2016</option>	
          
          <option value="2017" >2017</option>	
          
          <option value="2018" >2018</option>	
          
          <option value="2019" >2019</option>	
          
          <option value="2020" >2020</option>	
          
          <option value="2021" >2021</option>	
          
          <option value="2022" >2022</option>	
        </select>
        <span class="STYLE7">年</span>
        <select name="phdy3"  class="p1">
           <option value=""  selected="selected"></option>	
         <option value="01" >1</option>	
          <option value="02" >2</option>
          <option value="03" >3</option>
          <option value="04" >4</option>
          <option value="05" >5</option>
          <option value="06" >6</option>
          <option value="07" >7</option>
          <option value="08" >8</option>
          <option value="09" >9</option>
          <option value="10" >10</option>
          <option value="11" >11</option>
          <option value="12" >12</option>      
        </select>
        
      <span class="STYLE7">月</span></td>
      <td class="td1"><input name="phdmc3" type="text" class="iptbox"  size="46" maxlength="200" /></td>
      <td class="td2"><input name="phdjs3" type="text" class="iptbox"  size="46" maxlength="300" /></td>
</tr>
  </table></td>
</tr>
    
    <tr>
      <td align="center"   class="td1 STYLE6" nowrap="nowrap"
>爱好特长</td>
      <td height="40" colspan="5" align="left"  class="STYLE6 td2"><input name="pksah" type="text" class="iptbox"  size="100" maxlength="390" /></td>
    </tr>

     <tr>
      <td colspan="5"  height="40" align="left"   class="td1 fnt">本人本着诚实、严谨的态度郑重递交以上材料，如有与事实不符，一切后果自己承担。</td>
      <td align="left"  class="td2 STYLE6" >申请人签字：</td>
    </tr>

  <tr>
 
      <td height="42"  colspan="6"  align="center"  valign="middle"><input type="button" name="Submit" value="  提    交  " class="sbtn" style="width:118px; height:32px;" onClick="check_submit();"></td>
    </tr>
</table>
<script>
	if(document.getElementById('pkskl_1').checked) kskl_change(document.getElementById('pkskl_1')); else kskl_change(document.getElementById('pkskl_2'));
</script>
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
