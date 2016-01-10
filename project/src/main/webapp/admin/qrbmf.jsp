<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); 
LogHandler logger=LogHandler.getInstance("qrbmf.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>确认考生交报名费情况</title>
<style type="text/css">
<!--
.STYLE1 {
	color: #36006C;
	font-size: 12px;
}
.tdfont{font-size: 12px;}
.STYLE2 {
	color: #3E3EFF;
	font-size: 20px;
	font-family: "华文楷体";
	font-weight: bold;

}
.STYLE7 {color: #000000; font-weight: bold; font-size: 12px; }
.STYLE7 a{color: #000000; font-weight: bold; font-size: 12px; }
.STYLE7 a:hover{color: #FF0000; font-weight: bold; font-size: 12px; }
.STYLE8 {font-size: 14px}
table a{	
   color: #FF3300;
   text-decoration:underline;
   font-size:14px;
   font-weight:bold;
}
table a:hover{	
   color: #FF0000;
   text-decoration:none;
   
}
.con{
	width:980px;
	height:970px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
/*	border-top-width: 2px;
	border-right-width: 2px;
	border-bottom-width: 2px;
	border-left-width: 2px;
	border-top-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-left-style: solid;
	border-top-color: #CCCCCC;
	border-right-color: #CCCCCC;
	border-bottom-color: #CCCCCC;
	border-left-color: #CCCCCC;*/
	}
.STYLE10 {color: #0000FF; font-weight: bold; font-size: 14px; }
.prtersty {
	color: #000051;
	font-size: 12px;
	font-weight: bold;
}
.iptprnt{	font-size: 12px;
}

#form1 select {
	font-size: 12px;
}
-->
</style>
<script>
	function sel_all(sel) {
		var obj;
		for(var i = 0; i<=1000; i++) {
			obj = document.getElementById("chk_"+i);
			if(null == obj) break;
			if(sel.checked){
				obj.checked = true;
			}
			else {
				obj.checked = false;
			}
		}
	}

    function doSearch(method){
        document.getElementById("oper").value=method;
        document.forms[0].submit();
    }
    function doSearch_lpp(method){
		document.getElementById("i_CurrPage").value=1;
		document.getElementById("i_start").value=1;
        document.getElementById("oper").value=method;
        document.forms[0].submit();
    }
	function setPass(pass){
		if(pass) document.getElementById("op").value = "1";
		else document.getElementById("op").value = "0";
		document.forms[0].method = "post";
		document.forms[0].action = "../../setfee";
		document.forms[0].submit();
	}

  function search_xm(){
	document.forms[0].action = "qrbmf.jsp";
	document.forms[0].submit();
  }
</script>

</head>
<%
	String orderColName = BaseFunction.null2value(request.getParameter("order"));
	String ksxm_filter = BaseFunction.null2value(request.getParameter("qname"));
	ksxm_filter = new String(ksxm_filter.getBytes("iso8859-1"), "utf-8");
	
	ArrayList al;
	BmxxList icl;
	Bmxx bmxx;
	DBOperator dbo = new DBOperator();
	String isDesc="";

	try{
		dbo.init(false);
	}catch(Exception e){
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
		return;
	}
	
	int i_total=0, i_unConfirm=0;
	int i_Start=1;
	int i_LPP=20;
	int i_CurrPage=1;
	int i_AllPage=0;
	String s_operate="";
	String s_isPublic = "";
	try{
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Admission");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		s_operate = BaseFunction.null2value(request.getParameter("operate"));
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getAuditCount());
		i_unConfirm = dbo.getCount(icl.getUnconfirmedCount());
		String s_LPP=request.getParameter("lpp");
		if(null!=s_LPP){
			i_LPP=Integer.parseInt(s_LPP);
		}
		String s_CurrPage=request.getParameter("i_CurrPage");
		if(null!=s_CurrPage){
			i_CurrPage=Integer.parseInt(s_CurrPage);
		}
		//String s_Start=request.getParameter("i_start");
	// value needs validate in page
	/*
		if(null!=s_Start){
			i_Start=Integer.parseInt(s_Start);
		}
	*/		
		if(i_total/i_LPP != 0)
			i_AllPage = i_total/i_LPP +1;
		else{
			if(i_total == 0)
				i_AllPage = 0;
			else
				i_AllPage = 1;
		}
	//count start,end and current page number
		if(null!=s_operate){
			
			if("first".equals(s_operate)){
				//i_Start=1;
				i_CurrPage=1;
			}
			else{
				if("pre".equals(s_operate) && i_CurrPage>1) {
					//i_Start=i_Start-i_LPP;
					i_CurrPage--;
				}
				else{
					if("next".equals(s_operate) && i_CurrPage<=(i_total/i_LPP)){
						//i_Start=i_Start+i_LPP;
						i_CurrPage++;
					}
					else{
						if("last".equals(s_operate)){
							//if(i_total>i_LPP) i_Start=i_total-i_LPP+1;
							//else i_Start=1;
							i_CurrPage=i_AllPage;
						}
					}
				}
			}
		}
		else s_operate="";
		i_Start = (i_CurrPage - 1) * i_LPP + 1;
		int i_End;
		if(i_CurrPage>(i_total/i_LPP) || i_total<=i_LPP) i_End=i_total;
		else{
			i_End=i_Start+i_LPP-1;
		}

%>
<body>
<%
Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH)+1;
	year = (11 > month) ? year : (year + 1);
%>
<div class="con">
<form method="get" action="qrbmf.jsp">
<table width="55%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td align="center" valign="top"   class="STYLE2"><%=year%>年自主选拔录取申请考生交报名费确认</td>
  </tr>
  <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>

</table>
<br />
<table width="95%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
  <td>
            <span class="tdfont">共有<%=i_total%>人，分<%=i_AllPage%>页，其中已交费<%=(i_total - i_unConfirm)%>人，未交<%=i_unConfirm%>费人。</span><a class="page" href="#" onclick="doSearch('first');">First</a>&nbsp;
            <a class="page" href="#" onclick="doSearch('pre');">Pre</a>&nbsp;
           <span class="tdfont"> [<%=i_Start%>-<%=i_End%>]/<%=i_total%></span>
            <a class="page" href="#" onclick="doSearch('next');">Next</a>&nbsp;
            <a class="page" href="#" onclick="doSearch('last');">Last</a>&nbsp;
            <input name="i_start" id="i_start" type="hidden" size="2" value="<%=i_Start%>">
            <select name="lpp" style="font-size: 12px;" onchange="doSearch_lpp('');">
<%
            String s_20="";
            String s_50="";
            String s_100="";

            switch(i_LPP){
            case 20:
                s_20="selected";
                break;
            case 50:
                s_50="selected";
                break;
            case 100:
                s_100="selected";
                break;
            }
%>
                <option value="20" <%=s_20%>>20</option>
                <option value="50" <%=s_50%>>50</option>
                <option value="100" <%=s_100%>>100</option>
            </select>
  </td>
  
  <td align="right"><span class="prtersty">输入考生姓名</span><input name="qname" type="text" id="qname" value="<%=ksxm_filter%>" class="iptprnt"/>&nbsp;<img src="../images/chaxun.gif" width="45" height="20" align="absbottom" onclick="search_xm();"/><!--<input type="button" onclick="search_xm();" value="查询" >/--></td>
  </tr>
</table><br />
<table width="88%" border="1" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td nowrap="nowrap" align="center"><input type="checkbox" name="checkbox" onclick="sel_all(this);" value="checkbox" /></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">序号</span></td>
<%
	if(orderColName.indexOf("desc")>0) isDesc="";
	else isDesc=" desc";
%>
    <td nowrap="nowrap" align="center"><span class="STYLE7">考生姓名</span></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">性别</span></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">身份证号</span></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">高考省份</span></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">中学名称</span></td>
    <td nowrap="nowrap" align="center"><span class="STYLE7">考生科类</span></td>
    <td nowrap="nowrap" align="center" ><span class="STYLE7">是否交费</span></td>
	
    </tr>
<%
		if(orderColName.length() > 0) icl.setOrder(orderColName);
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		icl.setStart(i_Start);
		icl.setCount(i_LPP);
		al = dbo.getQueryList(icl.getAuditResult(), icl);
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
	String shqk = "";

	for(int i = 0; i < al.size(); i++) {
		bmxx = (Bmxx) al.get(i);
		switch(bmxx.getSfjbmf()) {
		case 0:
			shqk = "未交费";
			break;
		case 1:
			shqk = "已交费";
			break;
		}
%>
   <tr bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
     <td align="center"><input type="checkbox" name="chk_bmxx" id="chk_<%=i%>" value="<%=bmxx.getBmxxid()%>" /></td>
     <td height="24"  class="tdfont"><%=(i+i_Start)%></td>
     <td  class="tdfont"><%=bmxx.getKsxm()%></td>
     <td  class="tdfont" align="center"><%=((1 == bmxx.getKsxb()) ? "男":"女")%></td>
     <td  class="tdfont"><%=bmxx.getShfzh()%></td>
     <td  class="tdfont"><%=bmxx.getJg()%></td>
     <td  class="tdfont"><%=bmxx.getZxmc()%></td>
     <td  class="tdfont"><%=bmxx.getKskl()%></td>
     <td  class="tdfont" align="center"> <%=shqk%></td>

     </tr>
<%
	}
%>
</table>
<%
	if(!("1".equals(s_isPublic))) {
%>
<table width="84%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#999999">
<tr>
  <td height="40" colspan="8" align="left" bgcolor="#FFFFFF" class="tdfont">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="2%" height="40">&nbsp;</td>
				  <td width="50%" align="center"><input type="button" value="交 费" onclick="setPass(true);" style="width:74px; height:28px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="button" name="Submit" value="未交费" onclick="setPass(false);" style="width:74px; height:28px;"/></td>
				  <td width="8%">&nbsp;</td>
				</tr>
		  </table>
	</td>
   </tr>
</table>
<%
	}
%>
<input id="i_CurrPage" name="i_CurrPage" type="hidden" value="<%=i_CurrPage%>">
<input id="oper" name="operate" type="hidden" value="<%=s_operate%>">
<input id="order" name="order" type="hidden" value="">
<input id="op" name="op" type="hidden" value="">
</form>
</div>
</body>
</html>
