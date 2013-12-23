<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/admin_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看自主选拔录取考生申请信息</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}

.STYLE1 {color: #000000;font-size: 12px;font-weight: bold;}
.STYLE3 {
	font-family: "黑体";
	font-size: 22px;

}

a {
	color: #4D4DFF;
	font-size: 14px;
	font-weight: bold;
	text-decoration: underline;
}
a:hover{
	color: #FF3300;
	text-decoration: underline;
}
.td1 {
	font-size: 12px; 
	font-weight:bold; 
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #000000;
	border-bottom-color: #000000;
}
.td2 {
	font-size: 12px; 

	border-right-width: 1px;
	border-bottom-width: 1px;
	border-right-style: solid;
	border-bottom-style: solid;
	border-right-color: #000000;
	border-bottom-color: #000000;
}
.td2a {
	font-size: 12px; 

	border-right-width: 1px;

	border-right-style: solid;

	border-right-color: #000000;

}
.td3 {
	font-size: 12px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}
.td4 {
	font-size: 12px; 	
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}
.td5 {
	font-size: 12px; 	
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
}
.td6 {
	font-size: 12px; 	
	border-left-width: 1px;
	border-left-style: solid;
	border-left-color: #000000;
}
.table_w {
	border-top-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-left-style: solid;
	border-top-color: #000000;
	border-left-color: #000000;
}
.cuti{font-weight:bold; }
.tdhj {
	line-height: 14px;
}
-->
</style>
</head>
<%
	LogHandler logger=LogHandler.getInstance("ksxx.jsp");
	HashMap<String, String> hm = new HashMap<String, String>();
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
	String s_isPublic = "";
	String sqly = "";
	ArrayList al_settings;
	SystemSettings ss;
	SystemSettingsList ssl;
	Calendar cl = Calendar.getInstance();
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	String bmxxId = BaseFunction.null2value(request.getParameter("bmxxid"));
	String isHide = BaseFunction.null2value(request.getParameter("hide_pic"));
	String isPrint = BaseFunction.null2value(request.getParameter("print"));
	try{
		if(bmxxId.length() == 0){
            logger.error("没有报名信息！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名信息！").toUTF8String());
			return;
		}
		ZhshzyList zl = new ZhshzyList();
		Zhshzy zszy;
		al = dbo.getList(zl);
		for(int i = 0; i < al.size(); i++) {
			zszy = (Zhshzy)al.get(i);
			
			hm.put(""+zszy.getZyid(), zszy.getZymc());
		}
		bmxxId = (bmxxId.length() == 0) ? "-1":bmxxId;
		int bmxxid = Integer.parseInt(bmxxId);
		icl = new BmxxList(bmxxid);
		al = dbo.getList(icl);
		logger.debug("size:"+al.size());
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
     	SqbklyList bklyList = new SqbklyList(bmxx.getSqly());
		ArrayList al_bkly = dbo.getList(bklyList);

		if(al_bkly != null && al_bkly.size() == 1)
		    sqly = ((Sqbkly)al_bkly.get(0)).getMc();

		icl = new BkzyList(bmxx.getBmxxid());
		al = dbo.getList(icl);
		int len_zy = al.size();

		if(len_zy > 0) bkzy1 = ((Bkzy)al.get(0)).getZyid();
		if(len_zy > 1) bkzy2 = ((Bkzy)al.get(1)).getZyid();
		if(len_zy > 2) bkzy3 = ((Bkzy)al.get(2)).getZyid();
		if(len_zy > 3) bkzy4 = ((Bkzy)al.get(3)).getZyid();
		if(len_zy > 4) bkzy5 = ((Bkzy)al.get(4)).getZyid();

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
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();

	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
	
%>
<body>
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>
<%
	try{
%>

<table width="651" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right"><input type="button" id="shw"  value="查看成绩鉴定表" onClick="window.open('../loginin/browsecjjd.jsp?bmxxid=<%=bmxx.getBmxxid()%>&print=0');" />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="print1"  value=" 打  印 " onClick="window.open('ksxx_prt.jsp?bmxxid=<%=bmxx.getBmxxid()%>&print=0');" />
	&nbsp;&nbsp;&nbsp;&nbsp;<input name="btnclz" type="button" value="关闭此窗口" onClick="window.close();"/>
	</td>
  </tr>
  <tr>
    <td height="3"></td>
  </tr>
</table>
<table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="40" valign="middle">&nbsp;</td>
<td  align="center"><span class="STYLE3">中国石油大学（北京）<%=year%>年自主选拔录取考生申请信息</span></td>
<td width="40" align="right" valign="middle">&nbsp;</td>
</tr>
</table>
<table width="680" border="0" align="center" cellpadding="0" cellspacing="0" class="table_w">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="80%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="12%" height="39" align="center" class="td2 cuti">姓名</td>
            <td width="28%" class="td2"><%=bmxx.getKsxm() %></td>
            <td width="7%" align="center" class="td2 cuti">性别</td>
            <td width="24%" class="td2"><%=(bmxx.getKsxb()==1) ? "男":"女" %></td>
            <td width="11%" align="center" class="td2 cuti">外语语种</td>
            <td width="18%" class="td2"><%=bmxx.getWyyz() %></td>
          </tr>
          <tr>
            <td height="38" align="center" class="td2 cuti">高考省份</td>
            <td class="td2"><%=bmxx.getJg() %></td>
            <td align="center" class="td2 cuti">民族</td>
            <td class="td2"><%=bmxx.getMz() %></td>
            <td align="center" class="td2 cuti">政治面貌</td>
            <td class="td2"><%=bmxx.getZzmm() %></td>
          </tr>
          <tr>
            <td height="39" align="center" class="td2 cuti">中学名称</td>
            <td colspan="3" class="td2"><%=bmxx.getZxmc() %></td>
            <td align="center" class="td2 cuti">考生科类</td>
            <td class="td2"><%=bmxx.getKskl() %></td>
          </tr>
          <tr>
            <td height="38" align="center" class="td2 cuti">身份证号</td>
            <td colspan="5" class="td2"><%=bmxx.getShfzh() %></td>
            </tr>
          <tr>
            <td height="38" colspan="6"><table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="18%" align="center" class="td2 cuti">通知书邮寄地址 </td>
                <td width="82%" class="td2"><%=bmxx.getTxdz() %></td>
              </tr>
            </table></td>
            </tr>
        </table></td>
        <td width="20%" align="center" valign="middle" class="td2 td5">贴照片处</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center" nowrap class="td2a cuti">邮政编码</td>
            <td nowrap class="td2a"><%=bmxx.getYzbm() %></td>
            <td align="center" nowrap class="td2a cuti">收信人</td>
            <td nowrap class="td2a"><%=bmxx.getShxr() %></td>
            <td align="center" nowrap class="td2a cuti">联系电话</td>
            <td class="td2a"><%=bmxx.getKsshji() %>&nbsp;</td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
          <td align="center"  class="td2 td5 cuti">家庭情况</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  align="center"  class="td2 cuti">家长</td>
        <td  align="center"  class="td2 cuti">姓名</td>
        <td  align="center"  class="td2 cuti" nowrap="nowrap">工作单位</td>
        <td  align="center"  class="td2 cuti">联系电话</td>
      </tr>
      <tr>
        <td align="center"  class="td2 cuti">父亲</td>
        <td  class="td2"><%=bmxx.getFmxm() %>&nbsp;</td>
        <td  class="td2"><%=bmxx.getFmgzdw() %>&nbsp;</td>
        <td  class="td2"><%=bmxx.getFmyddh() %>&nbsp;</td>
      </tr>
      <tr>
        <td align="center"  class="td2 cuti">母亲</td>
        <td  class="td2"><%=bmxx.getMmxm() %>&nbsp;</td>
        <td  class="td2"><%=bmxx.getMmgzdw() %>&nbsp;</td>
        <td  class="td2"><%=bmxx.getMmyddh() %>&nbsp;</td>
      </tr>

    </table></td>
  </tr>
<tr>
          <td align="center"  class="td2 td5 cuti">面试分组</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="19%" align="left" nowrap  class="td2 cuti">申请理由(面试分组)</td>
        <td width="81%"  class="td2"><%=sqly %>&nbsp;</td>
        </tr>

    </table></td>
  </tr>
  <tr>
    <td align="center"  class="td2 td5 cuti">专业志愿</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="34%" class="td2"><strong>第一志愿</strong>：<%=((null == hm.get(""+bkzy1))?"":hm.get(""+bkzy1))%>&nbsp;</td>
        <td width="33%" class="td2"><strong>第二志愿</strong>：<%=((null == hm.get(""+bkzy2))?"":hm.get(""+bkzy2))%>&nbsp;</td>
        <td width="33%" class="td2"><strong>第三志愿</strong>：<%=((null == hm.get(""+bkzy3))?"":hm.get(""+bkzy3))%>&nbsp;</td>
      </tr>
      <tr>
        <td class="td2"><strong>第四志愿</strong>：<%=((null == hm.get(""+bkzy4))?"":hm.get(""+bkzy4))%>&nbsp;</td>
        <td class="td2"><strong>第五志愿</strong>：<%=((null == hm.get(""+bkzy5))?"":hm.get(""+bkzy5))%>&nbsp;</td>
        <td class="td2">&nbsp;</td>
      </tr>
     
    </table></td>
  </tr>
  <tr>
          <td align="center"  class="td2 td5 cuti">高中阶段获省市级以上荣誉称号和竞赛获奖情况</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  align="center"  class="td2 cuti" nowrap="nowrap">获奖时间</td>
        <td  align="center"  class="td2 cuti"  nowrap="nowrap">获奖名称</td>
        <td  align="center"  class="td2 cuti" nowrap="nowrap">竞赛级别</td>
        <td  align="center"  class="td2 cuti" nowrap="nowrap">获奖等级</td>
        <td  align="center"  class="td2 cuti">授奖部门</td>
      </tr>
<%
	String strHdsj="";
	if(null != gzhj1.getHjsj()) {
		cl.setTime(gzhj1.getHjsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj1.getHjmc()%>&nbsp;</td>
        <td  class="td2"><%=gzhj1.getJsjb()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj1.getHjdj()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj1.getSjbm()%>&nbsp;</td>
      </tr>
<%
	strHdsj = "";
	if(null != gzhj2.getHjsj()) {
		cl.setTime(gzhj2.getHjsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj2.getHjmc()%>&nbsp;</td>
        <td  class="td2"><%=gzhj2.getJsjb()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj2.getHjdj()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj2.getSjbm()%>&nbsp;</td>
      </tr>
<%
	strHdsj = "";
	if(null != gzhj3.getHjsj()) {
		cl.setTime(gzhj3.getHjsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2a"><%=strHdsj%>&nbsp;</td>
        <td  class="td2a tdhj"><%=gzhj3.getHjmc()%>&nbsp;</td>
        <td  class="td2a"><%=gzhj3.getJsjb()%>&nbsp;</td>
        <td  class="td2a tdhj"><%=gzhj3.getHjdj()%>&nbsp;</td>
        <td  class="td2a tdhj"><%=gzhj3.getSjbm()%>&nbsp;</td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td align="center"  class="td2 td5 cuti">参加或组织的社会工作或课外活动，受过何种奖励</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  align="center" class="td2" nowrap="nowrap"><strong>&nbsp;&nbsp;时&nbsp;&nbsp;间&nbsp;&nbsp;</strong></td>
        <td  align="center" class="td2"><strong>活动名称</strong></td>
        <td  align="center" class="td2"><strong>本人在活动中的角色和贡献</strong></td>
      </tr>
<%
	strHdsj = "";
	if(null != shgz1.getHdsj()) {
		cl.setTime(shgz1.getHdsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz1.getHdmc()%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz1.getBrjsgx()%>&nbsp;</td>
      </tr>
<%
	strHdsj = "";
	if(null != shgz2.getHdsj()) {
		cl.setTime(shgz2.getHdsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz2.getHdmc()%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz2.getBrjsgx()%>&nbsp;</td>
      </tr>
<%
	strHdsj = "";
	if(null != shgz3.getHdsj()) {
		cl.setTime(shgz3.getHdsj());
		strHdsj = cl.get(Calendar.YEAR) + "-" +(cl.get(Calendar.MONTH)+1);
	}
%>
      <tr>
        <td  class="td2a"><%=strHdsj%>&nbsp;</td>
        <td class="td2a tdhj"><%=shgz3.getHdmc()%>&nbsp;</td>
        <td class="td2a tdhj"><%=shgz3.getBrjsgx()%>&nbsp;</td>
      </tr>

    </table></td>
  </tr>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10%" height="38" align="center" class="td2 td5 cuti">爱好特长</td>
          <td width="90%" class="td2 td5 tdhj"><%=bmxx.getKsah() %>&nbsp;</td>
        </tr>
      </table></td>
  </tr>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="60%" height="38" class="td2 cuti tdhj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本人本着诚实、严谨的态度郑重递交以上材料，如有与事实不符，一切后果自己承担。</td>
          <td width="40%" class="td2">申请人签字：</td>
        </tr>
      </table></td>
  </tr>
</table>
<%
		if(("0".equals(s_isPublic))) {
%>
 <table align="center"> 
   <tr>
  <form method="post" action="/del_bmxx">
    <td  align="left" bgcolor="#FFFFFF" ><input type="hidden" name="bmxxid" value="<%=bmxxId%>">&nbsp;</td>
    <td colspan="4" bgcolor="#FFFFFF" align="center" ><input name="btndel" type="button" onClick="if(window.confirm('确定删除此考生吗？删除后考生信息将不能恢复！请慎重操作！')) document.forms[0].submit();" value="删除此考生" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="btnclz" type="button" value="关闭窗口" onClick="window.close();"/></td>
	</form>
   </tr>
</table>
<%
		}
%>
</body>
<%
	}catch(Exception e) {
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
</html>
