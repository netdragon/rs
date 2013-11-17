<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); 
LogHandler logger=LogHandler.getInstance("sczkzh.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>生成准考证号</title>
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
.fbstyW{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:100px;
    }
.fbsty{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:88px;
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
	document.forms[0].action = "sczkzh.jsp";
	document.forms[0].submit();
  }
  function export_adm(){
	document.forms[0].method = "post";
	document.forms[0].action = "/export_adm";
	document.forms[0].submit();
  }

	function create_adm() {
		if(!window.confirm("如果已经生成过准考证号，再次生成将会覆盖原有准考证信息和考场安排，是否继续？")) return false;
		document.forms[0].method = "post";
		document.forms[0].action = '/create_adm';
		document.forms[0].submit();
	}
  	function setPublic(){
		if(window.confirm("发布后考生马上就可以查看并打印准考证，并且将锁定准考证生成功能，是否确定？")){
			document.forms[0].method = "post";
			document.forms[0].action = "/public_info";
			document.forms[0].submit();
		}
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
	
    int i_total=0;
    int i_Start=1;
    int i_LPP=20;
    int i_CurrPage=1;
	int i_AllPage=0;
	String s_operate="";
	s_operate = BaseFunction.null2value(request.getParameter("operate"));
	String s_isPublic = "";
	try{
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Admission");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getAdmissionCount());;

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
<form method="get" action="sczkzh.jsp">
<table width="55%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  align="center" valign="top"   class="STYLE2"><%=year%>年自主选拔录取考生准考证号列表</td>
  </tr>
  <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>
</table>
<table width="82%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  height="5"></td>
  </tr>
  <tr>  
  <td align="right">
<%
	if(!("1".equals(s_isPublic))) {
%>
	<input type="button" value="生成准考证号" onclick="create_adm();" class="fbstyW"/>&nbsp;&nbsp;
	<input type="button" value="发布准考证" onclick="setPublic();" class="fbsty"/>
<%
	}
%>
  <input type="button" value="导出准考证号"  onClick="window.open('/export_adm');"   class="fbstyW"/>&nbsp;&nbsp;
  </td>
  </tr>
</table>
<table width="82%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td colspan="2" height="6"></td>
  </tr>
  <tr>
  <td>
	<span class="tdfont">共有<%=i_total%>人，分<%=i_AllPage%>页，</span>
	<a class="page" href="#" onclick="doSearch('first');">First</a>&nbsp;
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
<table width="80%" border="1" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td  height="20" width="5%" align="center"><span class="STYLE7">序号</span></td>
<%
		if(orderColName.length()==0) orderColName=" kskl,convert(ksxm using gbk)";
		if(orderColName.indexOf("desc")>0) isDesc="";
		else isDesc=" desc";
%>
    <td width="16%" align="center"><span class="STYLE7"><a href="sczkzh.jsp?order=ksxm<%=isDesc%>">考生姓名</a></span></td>
    <td width="6%"  align="center"><span class="STYLE7">性别</span></td>
    <td width="17%" align="center"><span class="STYLE7">身份证号</span></td>
    <td width="17%" align="center"><span class="STYLE7">高考省份</span></td>
    <td width="21%" align="center"><span class="STYLE7">考生科类</span></td>
    <td width="18%" align="center"><span class="STYLE7">准考证号</span></td>
	
    </tr>
<%
		if(orderColName.length() > 0) icl.setOrder(orderColName);
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		icl.setStart(i_Start);
		icl.setCount(i_LPP);
		al = dbo.getQueryList(icl.getExamResult(), icl);
		String shqk = "";
		String btn_yj = "";

		BkzyList zyl = new BkzyList();
		ArrayList al_zy;

		Bkzy bkzy;
		String zy1 = "", zy2 = "";
		for(int i = 0; i < al.size(); i++) {
			bmxx = (Bmxx) al.get(i);
			zyl.setBmxxid(bmxx.getBmxxid());
			al_zy = dbo.getList(zyl);

			if(al_zy.size() == 2) {
				bkzy = (Bkzy)al_zy.get(0);
				if(bkzy.getXh() == 1) {
					zy1 = bkzy.getZymc();
					zy2 = ((Bkzy)al_zy.get(1)).getZymc();
				} else {
					zy2 = bkzy.getZymc();
					zy1 = ((Bkzy)al_zy.get(1)).getZymc();
				}
			}
%>
   <tr bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
     <td height="24"  class="tdfont"><%=(i+i_Start)%></td>
     <td  class="tdfont"><%=bmxx.getKsxm()%></td>
     <td  class="tdfont" align="center"><%=((1 == bmxx.getKsxb()) ? "男":"女")%></td>
     <td  class="tdfont"><%=bmxx.getShfzh()%></td>
     <td  class="tdfont"><%=bmxx.getJg()%></td>
     <td  class="tdfont"><%=bmxx.getKskl()%></td>
     <td  class="tdfont" align="center"> <%=bmxx.getZhkzhid()%>&nbsp;</td>

     </tr>
<%
		}
%>
</table>
<input id="i_CurrPage" name="i_CurrPage" type="hidden" value="<%=i_CurrPage%>">
<input id="oper" name="operate" type="hidden" value="<%=s_operate%>">
<input id="order" name="order" type="hidden" value="">
<input id="op" name="op" type="hidden" value="">
</form>
</div>
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
