<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印自主选拔录取申请表</title>
<style type="text/css">
<!--
table {
	line-height: 32px;
}

.STYLE1 {color: #000000;font-size: 12px;font-weight: bold;}
.STYLE3 {
	font-family: "黑体";
	font-size: 24px;	
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

.tdpdi {
	
	padding-left: 10px;
}
.tdhj {
	line-height: 14px;
}
-->
</style>
<script>
<!--
function printIt(n){
	try{
		if(n==1){
			window.print();
		}else{
			document.all.WebBrowser.ExecWB(n,1);
		}
	}
	catch(e){}
}
-->
</script>
</head>
<%
	LogHandler logger=LogHandler.getInstance("ksxx.jsp");

	HashMap<String, String> hm = new HashMap<String, String>();
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;
	Hjqk gzhj1,gzhj2,gzhj3;
	Hdqk shgz1,shgz2,shgz3;
	int tjf = 0;
	int bkzy1 = 0;
	int bkzy2 = 0;
	int bkzy3 = 0;
	int bkzy4 = 0;
	int bkzy5 = 0;
	String sqly = "";
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
	String adminFlag = (String)session.getAttribute("admin");
	String bmxxIdSesn = (String)session.getAttribute("bmxxid");
	if(!bmxxId.equals(bmxxIdSesn)) {
		if(null == adminFlag || 0 == adminFlag.length() || !"1".equals(adminFlag)) {
			logger.error("无权访问些数据！");
			response.sendRedirect("/error.jsp?error=" + new UTF8String("无权访问此数据！").toUTF8String());
			return;
		}
	}
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

	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}

	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);

	try{
		if(!"1".equals(isPrint)) {
%>
<body>
<!--<table width="651" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
	<input type="button" id="print2"  value="关闭" onClick="window.close();" />&nbsp;&nbsp;&nbsp;
	<input type="button" id="print1"  value="打印预览" onClick="set_print(2);" />&nbsp;&nbsp;&nbsp;
	<input type="button" id="print1"  value="直接打印" onClick="set_print(3);" />&nbsp;&nbsp;&nbsp;
	</td>
  </tr>
</table>-->
<%
		} 
%>

<table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="40" >&nbsp;</td>
<td  align="center"><span class="STYLE3">中国石油大学（北京）<%=year%>年自主选拔录取申请表</span></td>
<td width="40" >&nbsp;</td>
</tr>
</table>
<table width="649" border="0" align="center" cellpadding="0" cellspacing="0" class="table_w">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="82%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="12%" align="center" class="td2 cuti">姓名</td>
            <td width="28%" class="td2"><%=bmxx.getKsxm() %></td>
            <td width="7%" align="center" class="td2 cuti">性别</td>
            <td width="24%" class="td2"><%=(bmxx.getKsxb()==1) ? "男":"女" %></td>
            <td width="11%" align="center" class="td2 cuti">外语语种</td>
            <td width="18%" class="td2"><%=bmxx.getWyyz() %></td>
          </tr>
          <tr>
            <td align="center" class="td2 cuti">高考省份</td>
            <td class="td2"><%=bmxx.getJg() %></td>
            <td align="center" class="td2 cuti">民族</td>
            <td class="td2"><%=bmxx.getMz() %></td>
            <td align="center" class="td2 cuti">政治面貌</td>
            <td class="td2"><%=bmxx.getZzmm() %></td>
          </tr>
          <tr>
            <td align="center" class="td2 cuti">中学名称</td>
            <td colspan="3" class="td2"><%=bmxx.getZxmc() %></td>
            <td align="center" class="td2 cuti">考生科类</td>
            <td class="td2"><%=bmxx.getKskl() %></td>
          </tr>
          <tr>
            <td align="center" class="td2 cuti">身份证号</td>
            <td colspan="5" class="td2"><%=bmxx.getShfzh() %></td>
            </tr>
          <tr>
            <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="18%" align="center" class="td2 cuti">通知书邮寄地址 </td>
                <td width="82%" class="td2"><%=bmxx.getTxdz() %></td>
              </tr>
            </table></td>
            </tr>
        </table></td>
        <td width="18%" align="center" class="td2 td5"> <p align="center">（免冠一寸彩色） <br />学校盖骑缝章</p>          </td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center" nowrap class="td2 cuti">邮政编码</td>
            <td nowrap class="td2"><%=bmxx.getYzbm() %></td>
            <td align="center" nowrap class="td2 cuti">收信人</td>
            <td nowrap class="td2"><%=bmxx.getShxr() %></td>
            <td align="center" nowrap class="td2 cuti">联系电话</td>
            <td class="td2"><%=bmxx.getKsshji() %>&nbsp;</td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
          <td height="9" align="center"  class="td2 td5 cuti">家庭情况</td>
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
          <td height="9" align="center"  class="td2 td5 cuti">面试分组</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
 
      <tr>
        <td width="20%" align="left"  class="td2 cuti">申请理由(面试分组)</td>
        <td width="80%"  class="td2"><%=sqly %>&nbsp;</td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center"  class="td2 td5 cuti">专业志愿</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  width="34%" class="td2"><strong>第一志愿</strong>：<%=((null == hm.get(""+bkzy1))?"":hm.get(""+bkzy1))%>&nbsp;</td>
        <td  width="33%" class="td2"><strong>第二志愿</strong>：<%=((null == hm.get(""+bkzy2))?"":hm.get(""+bkzy2))%>&nbsp;</td>
        <td  width="33%" class="td2"><strong>第三志愿</strong>：<%=((null == hm.get(""+bkzy3))?"":hm.get(""+bkzy3))%>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3" class="td2"><strong>是否服从调剂</strong>：<%=(tjf == 1) ? "是":"否" %>&nbsp;</td>
        </tr>

    </table></td>
  </tr>
  <tr>
          <td align="center"  class="td2 td5 cuti">高中阶段获省市级以上荣誉称号和竞赛获奖情况</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td   align="center" class="td2 cuti" nowrap="nowrap">获奖时间</td>
        <td   align="center" class="td2 cuti" nowrap="nowrap">获奖名称</td>
        <td   align="center" class="td2 cuti" nowrap="nowrap">竞赛级别</td>
        <td   align="center" class="td2 cuti" nowrap="nowrap">获奖等级</td>
        <td   align="center" class="td2 cuti">授奖部门</td>
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
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj3.getHjmc()%>&nbsp;</td>
        <td  class="td2"><%=gzhj3.getJsjb()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj3.getHjdj()%>&nbsp;</td>
        <td  class="td2 tdhj"><%=gzhj3.getSjbm()%>&nbsp;</td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td align="center"  class="td2 td5 cuti">参加或组织的社会工作或课外活动，受过何种奖励</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td  align="center" class="td2" nowrap="nowrap"><strong>&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;间&nbsp;&nbsp;&nbsp;</strong></td>
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
        <td  class="td2"><%=strHdsj%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz3.getHdmc()%>&nbsp;</td>
        <td class="td2 tdhj"><%=shgz3.getBrjsgx()%>&nbsp;</td>
      </tr>

    </table></td>
  </tr>

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10%" align="center" class="td2 td5 cuti">爱好特长</td>
          <td width="90%" class="td2 td5 tdhj"><%=bmxx.getKsah() %>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
 
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="64%" height="38" class="td2 cuti tdpdi tdhj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本人本着诚实、严谨的态度郑重递交以上材料，如有与事实不符，一切后果自己承担。</td>
          <td width="36%" class="td2">&nbsp;&nbsp;申请人签字：</td>
        </tr>
      </table></td>
  </tr>

</table>

<%
		
	}catch(Exception e) {
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据错误！").toUTF8String());
		return;
	}
%>
</body>
</html>
