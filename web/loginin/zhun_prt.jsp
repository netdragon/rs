<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*"%>
<%@include file="../common/access_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印考试准考证</title>
<style type="text/css">
<!--
.biaotou {
	color: #000000;
	font-size: 28px;
	font-weight: bold;
}
.cuti{font-weight: bold;}

.xuzhi {font-size: 24px; color: #000000; }
.tbl_a {
	color: #000000;
	font-size: 18px;
}

.tbl_b {
	color: #000000;
	font-size: 16px;
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
.STYLE1 {font-size: 12px}
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
	LogHandler logger=LogHandler.getInstance("browseinfo.jsp");
	ArrayList al;
	ICommonList icl;
	Bmxx bmxx;
	SqbklyList sqbklyList;
	Sqbkly sqbkly;
	DBOperator dbo = new DBOperator();
	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
        response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	String isPrint = BaseFunction.null2value(request.getParameter("print"));
	String s_isPublic = "";
	try {
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Admission");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		if(!("1".equals(s_isPublic))) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("准考证未生成！").toUTF8String());
			return;
		}
		String bmxxId = (String)session.getAttribute("bmxxid");
		if(null == bmxxId){
            logger.error("没有报名信息！");
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有报名信息！").toUTF8String());
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
		if(bmxx.getShhqk() != 1) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("未通过初审，没有准考证信息！").toUTF8String());
			return;
		} 
		if(bmxx.getSfjbmf() != 1) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("未交报名费，没有准考证信息！").toUTF8String());
			return;
		}
		if(bmxx.getZhkzhid() == null || bmxx.getZhkzhid().length() < 3) {
            response.sendRedirect("/error.jsp?error=" + new UTF8String("没有准考证信息！").toUTF8String());
			return;
		} 
		sqbklyList = new SqbklyList(bmxx.getSqly());
		ArrayList al_sqly = dbo.getList(sqbklyList);
		String sqly_value="";
		if(al_sqly.size()==1) 
		    sqly_value=((Sqbkly)(al_sqly.get(0))).getMc();
		KemulxList kl;
		Kemulx kemu;
		kl = new KemulxList();
		al = dbo.getList(kl);
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
 	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>
<body>
		
<table width="640" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><img src="../images/cuplogo.gif" /><br />
      <p class="biaotou"><%=year%>年自主招生考试准考证</p>    </td>
  </tr>
  <tr>
    <td height="30"></td>
  </tr>
</table>
<table width="639" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#000000">
  <tr>
    <td width="75%" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="22%" height="34" valign="top" nowrap="nowrap"  class="tbl_a">准考证号：</td>
        <td width="78%" valign="top" class="cuti tbl_a"><%=bmxx.getZhkzhid()%>&nbsp;</td>
      </tr>
      <tr>
        <td height="34" class="tbl_a">姓 　名：</td>
        <td class="tbl_a cuti"><%=bmxx.getKsxm()%>&nbsp;</td>
      </tr>
      <tr>
        <td height="34" class="tbl_a">生源地：</td>
        <td class="tbl_a cuti"><%=bmxx.getJg()%>&nbsp;</td>
      </tr>
      <tr>
        <td height="34" class="tbl_a">面试分组：</td>
        <td class="tbl_a cuti"><%=sqly_value%>&nbsp;</td>
      </tr>
      <tr>
        <td height="34" nowrap="nowrap"  class="tbl_a">身份证号：</td>
        <td class="cuti tbl_a"><%=bmxx.getShfzh()%>&nbsp;</td>
      </tr>
     <tr>
        <td height="34" nowrap="nowrap"  class="tbl_a">考试时间：</td>
<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		String rq = "";
		if(0 < al.size()) {
			kemu = (Kemulx)al.get(0);
			rq = sdf.format(kemu.getKsrq());
		}
%>
        <td class="cuti tbl_a" colspan="2"><%=rq%></td>
      </tr>
<%
		for(int i = 0; i<al.size(); i++) {
			kemu = (Kemulx)al.get(i);
%>
          <tr>
		  <td height="34" class="tbl_a">&nbsp;</td>
<%
			String kssj_s = "8";
			String kssj_f = "00";
			String jssj_s = "8";
			String jssj_f = "00";
			String[] sj;
			if(null != kemu.getJssj()) {
				sj = kemu.getKssj().split(":");
				if(sj.length == 2) {
					kssj_s = sj[0];
					kssj_f = sj[1];
				}
				else {
					response.sendRedirect("/error.jsp?error=" + new UTF8String("数据发生错误！").toUTF8String());
					return;
				}
				if(kssj_f.length() == 1) kssj_f = "0"+kssj_f;
				sj = kemu.getJssj().split(":");
				if(sj.length == 2) {
					jssj_s = sj[0];
					jssj_f = sj[1];
				}
				else {
					response.sendRedirect("/error.jsp?error=" + new UTF8String("数据发生错误！").toUTF8String());
					return;
				}
				if(jssj_f.length() == 1) jssj_f = "0"+jssj_f;
			}
%>
			<td class="cuti tbl_a"><%=kemu.getLxmc()%>&nbsp;<%=kssj_s%>:<%=kssj_f%>－<%=jssj_s%>:<%=jssj_f%></td>
		</tr>
<%
		}
%>
      <tr>
        <td height="34" nowrap="nowrap"  class="tbl_a">考试地点：</td>
        <td class="cuti tbl_a">北京市昌平区中国石油大学（北京）</td>
      </tr>
    </table></td>
    <td   align="center" valign="middle" bgcolor="#FFFFFF"　valign="top"><span class="STYLE1">贴与报名表<br />
    同一底版照片</span></td>
  </tr>
  <tr>
    <td colspan="2" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
        <td height="7" colspan="2" ></td>
      </tr>
      <tr>
        <td height="32" colspan="2" align="center" class="xuzhi">笔试须知：</td>
      </tr>
       <tr>
        <td height="7" colspan="2" ></td>
      </tr>

      <tr>
        <td width="5%" align="right" valign="top"  class="tbl_b">1、</td>
        <td width="95%"  class="tbl_b">遵守考场纪律，服从工作人员管理，违者按有关规定处理并取消考试资格；</td>
      </tr>
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>

      <tr>
        <td align="right" valign="top"  class="tbl_b">2、</td>
        <td  class="tbl_b">凭准考证及有效身份证参加考试，对号入座，并将证件放在桌角备查；</td>
      </tr>
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>

      <tr>
        <td align="right" valign="top"  class="tbl_b">3、</td>
        <td  class="tbl_b">提前10分钟入场，迟到15分钟以上者取消考试资格，开考30分钟后方可交卷离开考场，交卷后的考生不得在考场周围停留或互相交谈；</td>
      </tr>
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>
      <tr>
        <td align="right" valign="top"  class="tbl_b">4、</td>
        <td  class="tbl_b">进入考场只准携带必要的文具（笔、橡皮、尺子、简易计算器）禁止携带任何书籍、资料，以及手机、小灵通、BP机等通讯设备；</td>
      </tr>
       <tr>
        <td height="3" colspan="2" ></td>
      </tr>
      <tr>
        <td align="right" valign="top"  class="tbl_b">5、</td>
        <td  class="tbl_b">禁止与他人合用计算器，禁止使用具有存储功能的计算工具等（商务通），禁止交头接耳、传递纸条、夹带、冒名顶替等违纪行为；</td>
      </tr>
        <tr>
        <td height="4" colspan="2" ></td>
      </tr>
     <tr>
        <td align="right" valign="top"  class="tbl_b">6、</td>
        <td  class="tbl_b">所有答案必须写在答题纸上，试卷与答题纸及草稿纸一律不得带出考场；</td>
      </tr>
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>
      <tr>
        <td align="right" valign="top"  class="tbl_b">7、</td>
        <td  class="tbl_b">考生必须按时交卷，否则视为违纪试卷，按作废处理，考试结束时，待监考老师收卷后方可离开考场；</td>
      </tr >
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>
      <tr>
        <td align="right" valign="top"  class="tbl_b">8、</td>
        <td  class="tbl_b">考试过程中，无特殊情况，考生不得离开考场，若离开考场按交卷处理。</td>
      </tr>
       <tr>
        <td height="4" colspan="2" ></td>
      </tr>
      <tr>
        <td align="right" valign="top" class="tbl_b">&nbsp;</td>
        <td class="tbl_b">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="639" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="7" align="center"></td>
  </tr>
  <tr>
    <td height="30"><strong>注：本准考证待报到当天由中国石油大学（北京）本科招生办审核、盖章后生效。</strong></td>
  </tr>
</table>

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
