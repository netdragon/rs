<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="../common/validate.js"></script>
<title>修改报考登记表</title>
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
	
	font-size: 22px;
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
}
.iptboxsf{
	font-size:14px;
}
-->
</style>
<script>
	var zyList_wk = new Array();
	var zyList_lk = new Array();
	var zyList_wk_id = new Array();
	var zyList_lk_id = new Array();
	function sub_chk() {
		var saved_zy, selected_zy;
		for(var i=1; i<=8; i++) {
			if((selected_zy = document.getElementById("pzhiyuan"+i)) != null){
				if((saved_zy = document.getElementById("saved_zyid"+i)) != null){
					saved_zy.value = selected_zy.value;
				}
			}
		}
		return subchk();
	}

	
</script>
</head>

<body  onload="if(document.getElementById('pkskl_1').checked) kskl_change(document.getElementById('pkskl_1')); else kskl_change(document.getElementById('pkskl_2'));">
<%
	LogHandler logger=LogHandler.getInstance("modiinfo.jsp");
	String bmxxId = (String)session.getAttribute("bmxxid");
	String userId = (String)session.getAttribute("user_id");
	if(null == userId){
           logger.error("没有登录！");
           response.sendRedirect("/error.jsp?error=" + new UTF8String("没有登录！").toUTF8String());
	   return;
	}
	if(null == bmxxId){
        	logger.error("没有报过名！");
        	response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报过名！").toUTF8String());
		return;
	}
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;
	Hjqk gzhj1,gzhj2,gzhj3;
	Hdqk shgz1,shgz2,shgz3;
	int bkzy1 = 0;
	int bkzy2 = 0;
	int bkzy3 = 0;
	int bkzy4 = 0;
	int bkzy5 = 0;
	int tjf = 0;
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	
	SystemSettingsList ssl;
	SystemSettings ss;
	String date_limit;
	String s_isPublic = "";
	ArrayList al_settings;
	ZhshzyList zyl;
	Zhshzy zy;
	Sqbkly bkly;
	SqbklyList bklyList;
	ArrayList al_bkly;
	int i;

	Calendar c_curr = Calendar.getInstance();
	Calendar cl = Calendar.getInstance();
	try {
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
			response.sendRedirect("/error.jsp?error=" + new UTF8String("报名时间已过！不能再修改报名信息了!").toUTF8String());
			return;
		}
		
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("审核结果已发布，不能修改报名信息！").toUTF8String());
			return;
		}
		bmxxId = (null == bmxxId) ? "0":bmxxId;
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		if(al.size() == 0){
            logger.error("数据错误！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
			return;
		}
		bmxx = (Bmxx) al.get(0);
		icl = new HjqkList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		if(al.size() < 3){
            logger.error("数据错误！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
			return;
		}
		gzhj1 = (Hjqk)al.get(0);
		gzhj2 = (Hjqk)al.get(1);
		gzhj3 = (Hjqk)al.get(2);
		icl = new BkzyList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		int len_zy = al.size();

		if(len_zy > 0) bkzy1 = ((Bkzy)al.get(0)).getZyid();
		if(len_zy > 1) bkzy2 = ((Bkzy)al.get(1)).getZyid();
		if(len_zy > 2) bkzy3 = ((Bkzy)al.get(2)).getZyid();

		tjf = ((Bkzy)al.get(0)).getTjf();
		
		icl = new HdqkList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		if(al.size() < 3){
            		logger.error("数据错误！");
            		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
			return;
		}
		shgz1 = (Hdqk)al.get(0);
		shgz2 = (Hdqk)al.get(1);
		shgz3 = (Hdqk)al.get(2);
		zyl = new ZhshzyList();
		al = dbo.getList(zyl);

		bklyList = new SqbklyList();
		al_bkly = dbo.getList(bklyList);
	}catch(Exception e) {
		logger.error(e.getMessage());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
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
<form action="/add_bmxx" enctype="multipart/form-data" method="post" >
<%
	try{
%>
<table width="780" border="0" align="center" cellpadding="0" cellspacing="0" class="tbl_w">
  <caption align="top">
    <span class="STYLE3">修改自主选拔录取申请表</span>
    </caption>
  <!--tr>
    <td colspan="6" align="left"  class="td2 fnt">&nbsp;重新上传照片<span class="star">﹡</span>&nbsp;&nbsp;&nbsp;&nbsp;
	  <input name="perphoto" type="file" id="perphoto" />&nbsp;&nbsp;<span class="p1">(免冠一寸彩色)</span>&nbsp;&nbsp;&nbsp;&nbsp;<img id="img_id" align="absmiddle" width="135" height="180" src="../../exportfile?uuid=<%=BaseFunction.null2value(bmxx.getKszp()) %>"/> 	  </td>
    </tr-->
    <tr>
      <td width="101" align="center"  class="td1 STYLE6">姓名<span class="star">﹡</span></td>
      <td width="185"  height="38" align="left" class="td1"><input name="pname" type="text" id="pname" value="<%=bmxx.getKsxm() %>" size="20" maxlength="100"/></td>
      <td width="58"  height="38" align="center" class="td1 STYLE6" >性别</td>
      <td width="143" align="left" class="td1"><input type="radio" <%=(1 == bmxx.getKsxb()) ? "checked":""%> name="pxb" value="1" />
        <span class="STYLE7">男</span>&nbsp;&nbsp;&nbsp;
        <input type="radio" <%=(0 == bmxx.getKsxb()) ? "checked":""%> name="pxb" value="0" />
      <span class="STYLE7">女</span></td>
      <td width="73"  height="38" align="center" class="STYLE6 td1">外语语种</td>
      <td width="218"  height="38" align="left" class="td2"><input type="radio" <%=("英语".equals(bmxx.getWyyz())) ? "checked":""%> name="pwyyz" value="英语" />
        <span class="STYLE7">英语</span>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" <%=("其它".equals(bmxx.getWyyz())) ? "checked":""%>  name="pwyyz"  value="其它" />
      <span class="STYLE7">其它</span></td>
    </tr>
  
    <tr>
      <td width="101" align="center"  class="td1 STYLE6">高考省份</td>
      <td height="38" align="left" class="td1"><select id="pjg" name="pjg">
        <option value="北京" <%=("北京".equals(bmxx.getJg())) ? "selected":""%>>北京</option> 
        <option value="天津" <%=("天津".equals(bmxx.getJg())) ? "selected":""%>>天津</option> 
        <option value="河北" <%=("河北".equals(bmxx.getJg())) ? "selected":""%>>河北</option> 
        <option value="山西" <%=("山西".equals(bmxx.getJg())) ? "selected":""%>>山西</option> 
        <option value="内蒙古" <%=("内蒙古".equals(bmxx.getJg())) ? "selected":""%>>内蒙古</option> 
        <option value="辽宁" <%=("辽宁".equals(bmxx.getJg())) ? "selected":""%>>辽宁</option> 
        <option value="吉林" <%=("吉林".equals(bmxx.getJg())) ? "selected":""%>>吉林</option> 
        <option value="黑龙江" <%=("黑龙江".equals(bmxx.getJg())) ? "selected":""%>>黑龙江</option> 
        <option value="上海" <%=("上海".equals(bmxx.getJg())) ? "selected":""%>>上海</option> 
        <option value="江苏" <%=("江苏".equals(bmxx.getJg())) ? "selected":""%>>江苏</option> 
        <option value="浙江" <%=("浙江".equals(bmxx.getJg())) ? "selected":""%>>浙江</option> 
        <option value="安徽" <%=("安徽".equals(bmxx.getJg())) ? "selected":""%>>安徽</option> 
        <option value="福建" <%=("福建".equals(bmxx.getJg())) ? "selected":""%>>福建</option> 
        <option value="江西" <%=("江西".equals(bmxx.getJg())) ? "selected":""%>>江西</option> 
        <option value="山东" <%=("山东".equals(bmxx.getJg())) ? "selected":""%>>山东</option> 
        <option value="河南" <%=("河南".equals(bmxx.getJg())) ? "selected":""%>>河南</option> 
        <option value="湖北" <%=("湖北".equals(bmxx.getJg())) ? "selected":""%>>湖北</option> 
        <option value="湖南" <%=("湖南".equals(bmxx.getJg())) ? "selected":""%>>湖南</option> 
        <option value="广东" <%=("广东".equals(bmxx.getJg())) ? "selected":""%>>广东</option> 
        <option value="广西" <%=("广西".equals(bmxx.getJg())) ? "selected":""%>>广西</option> 
        <option value="海南" <%=("海南".equals(bmxx.getJg())) ? "selected":""%>>海南</option> 
        <option value="重庆" <%=("重庆".equals(bmxx.getJg())) ? "selected":""%>>重庆</option> 
        <option value="四川" <%=("四川".equals(bmxx.getJg())) ? "selected":""%>>四川</option> 
        <option value="贵州" <%=("贵州".equals(bmxx.getJg())) ? "selected":""%>>贵州</option> 
        <option value="云南" <%=("云南".equals(bmxx.getJg())) ? "selected":""%>>云南</option> 
        <option value="西藏" <%=("西藏".equals(bmxx.getJg())) ? "selected":""%>>西藏</option> 
        <option value="陕西" <%=("陕西".equals(bmxx.getJg())) ? "selected":""%>>陕西</option> 
        <option value="甘肃" <%=("甘肃".equals(bmxx.getJg())) ? "selected":""%>>甘肃</option> 
        <option value="青海" <%=("青海".equals(bmxx.getJg())) ? "selected":""%>>青海</option> 
        <option value="宁夏" <%=("宁夏".equals(bmxx.getJg())) ? "selected":""%>>宁夏</option> 
        <option value="新疆" <%=("新疆".equals(bmxx.getJg())) ? "selected":""%>>新疆</option> 
					 </select>	 </td>
      <td align="center"  class="STYLE6 td1" >民族</td>
      <td align="left"  class="td1" ><select id="pminzu" name="pminzu"> 
      
        <option value="汉族" <%=("汉族".equals(bmxx.getMz())) ? "selected":""%>>汉族</option> 
        <option value="蒙古族" <%=("蒙古族".equals(bmxx.getMz())) ? "selected":""%>>蒙古族</option> 
        <option value="回族" <%=("回族".equals(bmxx.getMz())) ? "selected":""%>>回族</option> 
        <option value="藏族" <%=("藏族".equals(bmxx.getMz())) ? "selected":""%>>藏族</option> 
        <option value="维吾尔族" <%=("维吾尔族".equals(bmxx.getMz())) ? "selected":""%>>维吾尔族</option> 
        <option value="苗族" <%=("苗族".equals(bmxx.getMz())) ? "selected":""%>>苗族</option> 
        <option value="彝族" <%=("彝族".equals(bmxx.getMz())) ? "selected":""%>>彝族</option> 
        <option value="壮族" <%=("壮族".equals(bmxx.getMz())) ? "selected":""%>>壮族</option> 
        <option value="布依族" <%=("布依族".equals(bmxx.getMz())) ? "selected":""%>>布依族</option> 
        <option value="朝鲜族" <%=("朝鲜族".equals(bmxx.getMz())) ? "selected":""%>>朝鲜族</option> 
        <option value="满族" <%=("满族".equals(bmxx.getMz())) ? "selected":""%>>满族</option> 
        <option value="侗族" <%=("侗族".equals(bmxx.getMz())) ? "selected":""%>>侗族</option> 
        <option value="瑶族" <%=("瑶族".equals(bmxx.getMz())) ? "selected":""%>>瑶族</option> 
        <option value="白族" <%=("白族".equals(bmxx.getMz())) ? "selected":""%>>白族</option> 
        <option value="土家族" <%=("土家族".equals(bmxx.getMz())) ? "selected":""%>>土家族</option> 
        <option value="哈尼族" <%=("哈尼族".equals(bmxx.getMz())) ? "selected":""%>>哈尼族</option> 
        <option value="哈萨克族" <%=("哈萨克族".equals(bmxx.getMz())) ? "selected":""%>>哈萨克族</option> 
        <option value="傣族" <%=("傣族".equals(bmxx.getMz())) ? "selected":""%>>傣族</option> 
        <option value="黎族" <%=("黎族".equals(bmxx.getMz())) ? "selected":""%>>黎族</option> 
        <option value="傈僳族" <%=("傈僳族".equals(bmxx.getMz())) ? "selected":""%>>傈僳族</option> 
        <option value="佤族" <%=("佤族".equals(bmxx.getMz())) ? "selected":""%>>佤族</option> 
        <option value="畲族" <%=("畲族".equals(bmxx.getMz())) ? "selected":""%>>畲族</option> 
        <option value="高山族" <%=("高山族".equals(bmxx.getMz())) ? "selected":""%>>高山族</option> 
        <option value="拉祜族" <%=("拉祜族".equals(bmxx.getMz())) ? "selected":""%>>拉祜族</option> 
        <option value="水族" <%=("水族".equals(bmxx.getMz())) ? "selected":""%>>水族</option> 
        <option value="东乡族" <%=("东乡族".equals(bmxx.getMz())) ? "selected":""%>>东乡族</option> 
        <option value="纳西族" <%=("纳西族".equals(bmxx.getMz())) ? "selected":""%>>纳西族</option> 
        <option value="景颇族" <%=("景颇族".equals(bmxx.getMz())) ? "selected":""%>>景颇族</option> 
        <option value="柯尔克孜" <%=("柯尔克孜".equals(bmxx.getMz())) ? "selected":""%>>柯尔克孜</option> 
        <option value="土族" <%=("土族".equals(bmxx.getMz())) ? "selected":""%>>土族</option> 
        <option value="达斡尔族" <%=("达斡尔族".equals(bmxx.getMz())) ? "selected":""%>>达斡尔族</option> 
        <option value="仫佬族" <%=("仫佬族".equals(bmxx.getMz())) ? "selected":""%>>仫佬族</option> 
        <option value="羌族" <%=("羌族".equals(bmxx.getMz())) ? "selected":""%>>羌族</option> 
        <option value="布朗族" <%=("布朗族".equals(bmxx.getMz())) ? "selected":""%>>布朗族</option> 
        <option value="撒拉族" <%=("撒拉族".equals(bmxx.getMz())) ? "selected":""%>>撒拉族</option> 
        <option value="毛难族" <%=("毛难族".equals(bmxx.getMz())) ? "selected":""%>>毛难族</option> 
        <option value="仡佬族" <%=("仡佬族".equals(bmxx.getMz())) ? "selected":""%>>仡佬族</option> 
        <option value="锡伯族" <%=("锡伯族".equals(bmxx.getMz())) ? "selected":""%>>锡伯族</option> 
        <option value="阿昌族" <%=("阿昌族".equals(bmxx.getMz())) ? "selected":""%>>阿昌族</option> 
        <option value="普米族" <%=("普米族".equals(bmxx.getMz())) ? "selected":""%>>普米族</option> 
        <option value="塔吉克族" <%=("塔吉克族".equals(bmxx.getMz())) ? "selected":""%>>塔吉克族</option> 
        <option value="怒族" <%=("怒族".equals(bmxx.getMz())) ? "selected":""%>>怒族</option> 
        <option value="乌孜别克" <%=("乌孜别克".equals(bmxx.getMz())) ? "selected":""%>>乌孜别克</option> 
        <option value="俄罗斯族" <%=("俄罗斯族".equals(bmxx.getMz())) ? "selected":""%>>俄罗斯族</option> 
        <option value="鄂温克族" <%=("鄂温克族".equals(bmxx.getMz())) ? "selected":""%>>鄂温克族</option> 
	    <option value="崩龙族" <%=("崩龙族".equals(bmxx.getMz())) ? "selected":""%>>崩龙族</option> 
        <option value="保安族" <%=("保安族".equals(bmxx.getMz())) ? "selected":""%>>保安族</option> 
        <option value="裕固族" <%=("裕固族".equals(bmxx.getMz())) ? "selected":""%>>裕固族</option> 
        <option value="京族" <%=("京族".equals(bmxx.getMz())) ? "selected":""%>>京族</option> 
        <option value="塔塔尔族" <%=("塔塔尔族".equals(bmxx.getMz())) ? "selected":""%>>塔塔尔族</option> 
        <option value="独龙族" <%=("独龙族".equals(bmxx.getMz())) ? "selected":""%>>独龙族</option> 
        <option value="鄂伦春族" <%=("鄂伦春族".equals(bmxx.getMz())) ? "selected":""%>>鄂伦春族</option> 
        <option value="赫哲族" <%=("赫哲族".equals(bmxx.getMz())) ? "selected":""%>>赫哲族</option> 
        <option value="门巴族" <%=("门巴族".equals(bmxx.getMz())) ? "selected":""%>>门巴族</option> 
        <option value="珞巴族" <%=("珞巴族".equals(bmxx.getMz())) ? "selected":""%>>珞巴族</option> 
        <option value="基诺族" <%=("基诺族".equals(bmxx.getMz())) ? "selected":""%>>基诺族</option> 
        <option value="其他" <%=("其他".equals(bmxx.getMz())) ? "selected":""%>>其他</option>
 </select></td>
      <td align="center"  class="STYLE6 td1" >政治面貌</td>
      <td align="left"  class="td2" ><select name="pzzmm" id="pzzmm">
        
        <option value="中共党员" <%=("中共党员".equals(bmxx.getZzmm())) ? "selected":""%>>中共党员</option>
        <option value="中共预备党员" <%=("中共预备党员".equals(bmxx.getZzmm())) ? "selected":""%>>中共预备党员</option>		
        <option value="共青团员" <%=("共青团员".equals(bmxx.getZzmm())) ? "selected":""%>>共青团员</option>
        <option value="群众" <%=("群众".equals(bmxx.getZzmm())) ? "selected":""%>>群众</option>
      </select></td>
    </tr>
    
  <tr>
    <td width="101" align="center"  class="STYLE6 td1">中学名称<span class="star">﹡</span></td>
    <td height="38" colspan="3" align="left" class="STYLE6 td1">
	   <input name="pzxmc" type="text" class="iptbox" id="pzxmc" value="<%=bmxx.getZxmc() %>" size="56" maxlength="200"/></td>
    <td align="center" class="td1"><span class="STYLE6">考生科类</span></td>
    <td align="left" class="td2"><input type="radio" onchange="kskl_change(this);"  onclick="kskl_change(this);" <%=("理工".equals(bmxx.getKskl())) ? "checked":""%> id="pkskl_1" name="pkskl" value="理工" />
        <span class="STYLE7">理工</span>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" onchange="kskl_change(this);"  onclick="kskl_change(this);" <%=("文史".equals(bmxx.getKskl())) ? "checked":""%> id="pkskl_2" name="pkskl" value="文史" />
      <span class="STYLE7">文史</span></td>
  </tr>
  <tr>
    <td width="101" align="center"  class="td1 STYLE6">身份证号<span class="star">﹡</span></td>
    <td height="38" colspan="5" align="left" class="STYLE6 td2"><input name="pidcardnum" type="text" id="pidcardnum"  class="iptboxsf" size="64" maxlength="18" value="<%=bmxx.getShfzh()%>" /></td>
    </tr>
  <tr>
    <td width="101" align="center"  class="td1 STYLE6">通知书邮寄地址<span class="star">﹡</span></td>
    <td height="38" colspan="5" align="left" class="STYLE6 td2"><input name="ptxdzh" type="text" id="ptxdzh" value="<%=bmxx.getTxdz() %>" size="92" maxlength="300"/></td>
    </tr>
  <tr>
    <td width="101" align="center"  class="td1 STYLE6">邮政编码<span class="star">﹡</span></td>
    <td height="38" align="left" class="td1"><input name="pyzbm" type="text" id="pyzbm" value="<%=bmxx.getYzbm() %>" size="16" maxlength="6"/></td>
    <td align="center" class="td1 STYLE6">收信人<span class="star">﹡</span></td>
    <td align="left" class="td1"><input name="pshxr" type="text" id="pshxr" value="<%=bmxx.getShxr() %>" maxlength="100" size="16" /></td>
    <td align="center" class="td1 STYLE6">联系电话<span class="star">﹡</span></td>
    <td align="left" class="td2"><input name="pyddh" type="text" class="iptbox" id="pyddh" value="<%=bmxx.getKsshji() %>"   size="30" maxlength="100"/></td>
  </tr>
  <tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">家庭情况</td>
    </tr>
  <tr>
    <td height="38" colspan="6" align="center" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="13%" align="center" class="td1 STYLE6">父亲姓名</td>
        <td width="36%" align="left" class="td1"><input name="pfmxm" type="text" class="iptbox" id="pfmxm" value="<%=bmxx.getFmxm() %>" size="34" maxlength="100"/></td>
        <td width="10%" align="center" class="td1 STYLE6">联系电话</td>
        <td width="41%" align="left" class="td2"><input name="fmyddh" type="text" class="iptbox" id="fmyddh" value="<%=bmxx.getFmyddh() %>"  size="32" maxlength="100"/></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">父亲工作单位</td>
        <td colspan="3" align="left" class="td1"><input name="fmgzdw" type="text" class="iptbox" id="fmgzdw" value="<%=bmxx.getFmgzdw() %>"  size="100" maxlength="200"/></td> <!-- <input name="fmgzzw" type="text" class="iptbox" id="fmgzzw" value="<%=bmxx.getFmzw() %>"  size="26" maxlength="100"/>&nbsp; -->
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">母亲姓名</td>
        <td align="left" class="td1"><input name="pmmxm" type="text" class="iptbox" id="pmmxm" value="<%=bmxx.getMmxm() %>"  size="34" maxlength="100"/></td>
        <td align="center" class="td1 STYLE6">联系电话</td>
        <td align="left" class="td2"><input name="mmyddh" type="text" class="iptbox" id="mmyddh" value="<%=bmxx.getMmyddh() %>"  size="32" maxlength="100"/></td>
      </tr>
      <tr>
        <td align="center" class="td1 STYLE6">母亲工作单位</td>
        <td colspan="3" align="left" class="td1"><input name="mmgzdw" type="text" class="iptbox" id="mmgzdw" value="<%=bmxx.getMmgzdw() %>"  size="100" maxlength="200"/></td> 
      </tr>

    </table></td>
  </tr>
 <tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">面试分组</td>
    </tr>
  <tr>
    <td height="42" colspan="6" align="center" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="19%" align="center" class="td1 STYLE6">申请理由（面试分组）</td>
        <td width="81%" align="left" class="td1"><select name="psqly" id="psqly" onChange="leiBie_change(this);" onclick="leiBie_change(this);">
        <option value="qxz" selected="selected">--请选择--</option> 
      </select></td> 
      </tr>

    </table></td>
  </tr>  <tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">专业志愿</td>
  </tr>
  <tr>
    <td height="38" colspan="6" align="center" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10%" align="left" class="td1 STYLE6">第一志愿<span class="star">﹡</span></td>
        <td width="22%" align="left" class="td1"><select name="pzhiyuan1" id="pzhiyuan1"><option value="0" selected="selected">--请选择--</option></select></td>
        <td width="10%" align="left" class="td1 STYLE6">第二志愿</td>
        <td width="24%" class="td1"><select name="pzhiyuan2" id="pzhiyuan2"><option value="0" selected="selected">--请选择--</option>
</select></td>
        <td width="11%" align="left" class="td1 STYLE6">第三志愿</td>
        <td width="23%" align="left" class="td2"><select name="pzhiyuan3" id="pzhiyuan3"><option value="0" selected="selected">--请选择--</option>
</select></td>
      </tr>
      <tr>
        <td align="left" class="td1 STYLE6">是否服从调剂</td>
        <td colspan="5" align="left" class="td1"><input type="radio" <%=(1 == tjf) ? "checked": ""%> name="psftj" value="1" />
      <span class="STYLE7">是</span>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" <%=(0 == tjf) ? "checked": ""%> name="psftj" value="0" />
      <span class="STYLE7">否</span>&nbsp;</td>
        </tr>

    </table></td>
  </tr>
<tr>
    <td height="36" colspan="6" align="center"  class="td2 fnt">高中阶段获省市级以上荣誉称号和竞赛获奖情况</td>
  </tr>
<tr>
  <td height="38" colspan="6" align="center" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="18%" align="center" class="STYLE6 td1">获奖时间</td>
      <td width="34%" align="center" class="STYLE6 td1">获奖名称</td>
      <td width="12%" align="center" class="STYLE6 td1">竞赛级别</td>
      <td width="14%" align="center" class="STYLE6 td1">获奖等级</td>
      <td width="22%" align="center" class="STYLE6 td2">授奖部门</td>
    </tr>
    <tr>
    <td align="left"  class="td1" ><%
	int zh_n,zh_y;
	if(null != gzhj1.getHjsj()) {
		cl.setTime(gzhj1.getHjsj());
		zh_n = cl.get(Calendar.YEAR);
		zh_y  = cl.get(Calendar.MONTH)+1;
	} else {
		zh_n = 0;
		zh_y = 0;
	}
  %>
        <select name="pzhenian1"  class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">年</span>
        <select name="pzheyue1"  class="p1">
		<option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">月</span>	  </td>
    <td align="left"  class="td1" ><input name="phjmc1" type="text" class="iptbox" id="phjmc1"  value="<%=gzhj1.getHjmc()%>" size="34" maxlength="200" /></td>
    <td align="left"  class="td1" ><select name="pjsjb1" id="pjsjb1">
        <option value="" <%=("".equals(gzhj1.getJsjb())) ? "selected":""%>></option>
        <option value="国家级" <%=("国家级".equals(gzhj1.getJsjb())) ? "selected":""%>>国家级</option>
        <option value="省级复赛" <%=("省级复赛".equals(gzhj1.getJsjb())) ? "selected":""%>>省级复赛</option>
        <option value="省级初赛" <%=("省级初赛".equals(gzhj1.getJsjb())) ? "selected":""%>>省级初赛</option>
      </select></td>
    <td align="left"  class="td1" ><input name="phjdj1" type="text" class="iptbox" id="phjdj1" value="<%=gzhj1.getHjdj()%>" size="10" maxlength="120" /></td>
    <td align="left"  class="td2" ><input name="psjbm1" type="text" class="iptbox" id="psjbm1" value="<%=gzhj1.getSjbm()%>" maxlength="200" /></td>
    </tr>
    <tr>
<td align="left"  class="td1" ><%
	if(null != gzhj2.getHjsj()) {
		cl.setTime(gzhj2.getHjsj());
		zh_n = cl.get(Calendar.YEAR);
		zh_y = cl.get(Calendar.MONTH)+1;
	} else {
		zh_n = 0;
		zh_y = 0;
	}
  %>
        <select name="pzhenian2"  class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">年</span>
        <select name="pzheyue2"  class="p1">
		<option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">月</span>	  </td>
    <td align="left"  class="td1" ><input name="phjmc2" type="text" class="iptbox" id="phjmc2"  value="<%=gzhj2.getHjmc()%>" size="34"  maxlength="200"/></td>
    <td align="left"  class="td1" ><select name="pjsjb2" id="pjsjb2">
		<option value="" <%=("".equals(gzhj2.getJsjb())) ? "selected":""%>></option>
        <option value="国家级" <%=("国家级".equals(gzhj2.getJsjb())) ? "selected":""%>>国家级</option>
        <option value="省级复赛" <%=("省级复赛".equals(gzhj2.getJsjb())) ? "selected":""%>>省级复赛</option>
        <option value="省级初赛" <%=("省级初赛".equals(gzhj2.getJsjb())) ? "selected":""%>>省级初赛</option>
      </select></td>
    <td align="left"  class="td1" ><input name="phjdj2" type="text" class="iptbox" id="phjdj2" value="<%=gzhj2.getHjdj()%>" size="10" maxlength="120" /></td>
    <td align="left"  class="td2" ><input name="psjbm2" type="text" class="iptbox" id="psjbm2" value="<%=gzhj2.getSjbm()%>" maxlength="200" /></td>
</tr>
<tr>
<td align="left"  class="td1" ><%
	if(null != gzhj3.getHjsj()) {
		cl.setTime(gzhj3.getHjsj());
		zh_n = cl.get(Calendar.YEAR);
		zh_y = cl.get(Calendar.MONTH)+1;
	} else {
		zh_n = 0;
		zh_y = 0;
	}
  %>
        <select name="pzhenian3"  class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">年</span>
        <select name="pzheyue3"  class="p1">
		<option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(zh_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
		</select>
      <span class="STYLE7">月</span></td>
    <td align="left"  class="td1" ><input name="phjmc3" type="text" class="iptbox" id="phjmc3"  value="<%=gzhj3.getHjmc()%>" size="34" maxlength="200" /></td>
    <td align="left"  class="td1" ><select name="pjsjb3" id="pjsjb3">
		<option value="" <%=("".equals(gzhj3.getJsjb())) ? "selected":""%>></option>
        <option value="国家级" <%=("国家级".equals(gzhj3.getJsjb())) ? "selected":""%>>国家级</option>
        <option value="省级复赛" <%=("省级复赛".equals(gzhj3.getJsjb())) ? "selected":""%>>省级复赛</option>
        <option value="省级初赛" <%=("省级初赛".equals(gzhj3.getJsjb())) ? "selected":""%>>省级初赛</option>
      </select></td>
    <td align="left"  class="td1" ><input name="phjdj3" type="text" class="iptbox" id="phjdj3" value="<%=gzhj3.getHjdj()%>" size="10" maxlength="120" /></td>
    <td align="left"  class="td2" ><input name="psjbm3" type="text" class="iptbox" id="psjbm3" value="<%=gzhj3.getSjbm()%>" maxlength="200" /></td>
</tr>
  </table></td>
</tr>
<tr>
  <td height="36" colspan="6" align="center"  class="td2 fnt">参加或组织的社会工作或课外活动，受过何种奖励</td>
</tr>
<tr>
  <td height="38" colspan="6" align="center" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="18%" align="center" class="STYLE6 td1">时间</td>
      <td width="43%" align="center" class="STYLE6 td1">活动名称</td>
      <td width="39%" align="center" class="STYLE6 td2">本人在活动中的角色和贡献</td>
    </tr>
    <tr>
      <td align="left" class="td1"><%
	int bysj_n,bysj_y;
	if(null != shgz1.getHdsj()) {
		cl.setTime(shgz1.getHdsj());
		bysj_n = cl.get(Calendar.YEAR);
		bysj_y = cl.get(Calendar.MONTH)+1;
	} else {
		bysj_n = 0;
		bysj_y = 0;
	}
  %>
      <span class="STYLE7">
        <select name="phdn1" id="phdn1" class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
      </select>年</span>
      <select name="phdy1" id="phdy1" class="p1">
	  <option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
	  </select><span class="STYLE7">月</span>	  </td>
      <td align="left" class="td1"><input name="phdmc1" type="text" class="iptbox" id="phdmc1" value="<%=shgz1.getHdmc()%>" size="50" maxlength="200" /></td>
      <td align="left" class="td2"><input name="phdjs1" type="text" class="iptbox" id="phdjs1"  value="<%=shgz1.getBrjsgx()%>" size="44" maxlength="300" /></td>
    </tr>
    <tr>
<td align="left" class="td1"><%
	if(null != shgz2.getHdsj()) {
		cl.setTime(shgz2.getHdsj());
		bysj_n = cl.get(Calendar.YEAR);
		bysj_y = cl.get(Calendar.MONTH)+1;
	} else {
		bysj_n = 0;
		bysj_y = 0;
	}
  %>
      <span class="STYLE7">
        <select name="phdn2" id="phdn2" class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
      </select>年</span>
      <select name="phdy2" id="phdy2" class="p1">
	  <option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
	  </select><span class="STYLE7">月</span></td>
      <td align="left" class="td1"><input name="phdmc2" type="text" class="iptbox" id="phdmc2"  value="<%=shgz2.getHdmc()%>" size="50" maxlength="200" /></td>
      <td align="left" class="td2"><input name="phdjs2" type="text" class="iptbox" id="phdjs2" value="<%=shgz2.getBrjsgx()%>" size="44" maxlength="300" /></td>
  </tr>
    <tr>
<td align="left" class="td1"><%
	if(null != shgz3.getHdsj()) {
		cl.setTime(shgz3.getHdsj());
		bysj_n = cl.get(Calendar.YEAR);
		bysj_y = cl.get(Calendar.MONTH)+1;
	} else {
		bysj_n = 0;
		bysj_y = 0;
	}
  %>
      <span class="STYLE7">
        <select name="phdn3" id="phdn3" class="p1">
		<option value=""></option>
<%
        for(i = 1980; i <= 2022 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_n == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
      </select>年</span>
      <select name="phdy3" id="phdy3" class="p1">
	  <option value=""></option>
<%
        for(i = 1; i <= 12 ;i++) {
%>
        <option value="<%=i%>" <%=(bysj_y == i) ? "selected":""%>><%=i%></option>	
<%
        }
%>
	  </select><span class="STYLE7">月</span></td>
      <td align="left" class="td1"><input name="phdmc3" type="text" class="iptbox" id="phdmc3"  value="<%=shgz3.getHdmc()%>" size="50" maxlength="200" /></td>
      <td align="left" class="td2"><input name="phdjs3" type="text" class="iptbox" id="phdjs3"  value="<%=shgz3.getBrjsgx()%>" size="44" maxlength="300" /></td>
</tr>
  </table></td>
</tr>
    
    <tr>
      <td align="center"   class="td1 STYLE6">爱好特长</td>
      <td height="38" colspan="5" align="left"  class="STYLE6 td2"><input name="pksah" type="text" class="iptbox" id="pksah" value="<%=bmxx.getKsah()%>" size="88" maxlength="390" /></td>
    </tr>
  
 
     <tr>
      <td height="34" colspan="5"  align="left"   class="td1 fnt">本人本着诚实、严谨的态度郑重递交以上材料，如有与事实不符，一切后果自己承担。</td>
      <td align="left"  class="td2 STYLE6" >申请人签字：</td>
    </tr>

</table>

<table width="780" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#D0D0D0">
  <tr>
    <td colspan="5" bgcolor="#FFFFFF" align="center" height="40"><input name="Submit" type="button" onclick="sub_chk();" value="  提    交  " style="width:70px; height:32px;"/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Submit2" onclick="window.history.back();" value="  取    消  " style="width:70px; height:32px;"/>       </td>
  </tr>
</table>
<input type="hidden" name="saved_zyid1" id="saved_zyid1" value="<%=bkzy1%>">
<input type="hidden" name="saved_zyid2" id="saved_zyid2" value="<%=bkzy2%>">
<input type="hidden" name="saved_zyid3" id="saved_zyid3" value="<%=bkzy3%>">
<input type="hidden" name="saved_zyid4" id="saved_zyid4" value="<%=bkzy4%>">
<input type="hidden" name="saved_zyid5" id="saved_zyid5" value="<%=bkzy5%>">
<input type="hidden" name="saved_sqly" id="saved_sqly" value="<%=bmxx.getSqly()%>">

<script>
	if(document.getElementById('pkskl_1').checked) kskl_change(document.getElementById('pkskl_1')); else kskl_change(document.getElementById('pkskl_2'));
</script>
</form>
</body>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
</html>
