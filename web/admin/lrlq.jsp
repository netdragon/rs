<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*"%>

<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>自主选拔录取入学考试成绩录入</title>
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
.tbl_bt {color: #000000; font-weight: bold; font-size: 12px; }
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
.fbcs {
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
}
.fbstyW{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:110px;
    }
.fbsty{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:100px;
    }
.fbstys{
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
	function lryj(bmxxid) {
		alert(bmxxid);
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

	function reimport(){
		window.location.assign("/admin/importScore.jsp");
	}

  function setCause(){
	document.getElementById("linkDiv").style.display="none";
	alert(document.getElementById("bmxxid").value);
	alert(document.getElementById("yj").value);
  }
  function search_xm(){
	
	document.forms[0].action = "lrlq.jsp";
	document.forms[0].submit();
  }
	function setPublic(){
		if(window.confirm("发布后考生马上就可以查阅到笔试考试成绩，并且将锁定成绩修改，是否确定现在将考生笔试成绩发布？")){
			document.getElementById("publicFlag").value = "1";
			document.forms[0].method = "post";
			document.forms[0].action = "/public_info";
			document.forms[0].submit();
		}
	}
	function setPublicExtra(){
		if(window.confirm("发布后考生马上就可以查阅到面试考试成绩，是否确定现在将考生面试成绩发布？")){
			document.getElementById("publicFlag").value = "2";
			document.forms[0].method = "post";
			document.forms[0].action = "/public_info";
			document.forms[0].submit();
		}
	}
</script>
<script type="text/javascript">  
   hidden=function(e,o) {   
   	//if(window.navigator.userAgent.indexOf("Firefox")>0) {   
   		var x = e.pageX ;  
   		var y = e.pageY;  
   		var left = o.offsetLeft;  
   		var top = o.offsetTop;  
  		var w = o.offsetWidth;  
  		var h = o.offsetHeight;  
  
  		if(y < top || y > (h + top) || x > left + w || x<left ) {   
  			hiddenDiv();  
  		}  
  	//}  
  	if(o.contains(event.toElement ) == false){   
  		hiddenDiv();  
  	}  
  }  
  hiddenDiv=function(){  
  	document.getElementById("linkDiv").style.display="none";
	document.getElementById("yj").value="";
  }  
  
  showDiv=function(obj,bmxxid) {   
  	document.getElementById("linkDiv").style.left=getPosition(obj).x+"px";   
  	document.getElementById("linkDiv").style.top=getPosition(obj).y+obj.offsetHeight+"px";   
  	document.getElementById("linkDiv").style.position="absolute";   
  	document.getElementById("linkDiv").style.display='block';   
	document.getElementById("bmxxid").value=bmxxid;
	
  }   
  getPosition=function(el) {   
  	for (var lx=0,ly=0;el!=null;lx+=el.offsetLeft,ly+=el.offsetTop,el=el.offsetParent);   
  	return {x:lx,y:ly}   
  } 

  </script>  
</head>
<%
	String orderColName = BaseFunction.null2value(request.getParameter("order"));
	String ksxm_filter = BaseFunction.null2value(request.getParameter("qname"));
	ksxm_filter = new String(ksxm_filter.getBytes("iso8859-1"), "utf-8");
	LogHandler logger=LogHandler.getInstance("lrlq.jsp");
	ArrayList al;
	BmxxList icl;
	Bmxx bmxx;
	DBOperator dbo = new DBOperator();
	String isDesc="";
	Kemu km;
	KemuList kl = new KemuList();
	
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
	String s_isPublic = "";
	String s_isPublicExtra = "";
	
	try {
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Score");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		ssl = new SystemSettingsList("isPublic_ScoreExtra");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublicExtra = ((SystemSettings)(al_settings.get(0))).getValue();
		
		s_operate = BaseFunction.null2value(request.getParameter("operate"));
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getAdmissionCount());

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
<form method="get" action="lrlq.jsp">
<table width="55%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td align="center" valign="top"   class="STYLE2"><%=year%>年自主选拔录取入学考试成绩录入</td>
  </tr>
  <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>
</table><br />

<table width="90%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
  <td>&nbsp;
            <span class="tdfont">共<%=i_total%>人，分<%=i_AllPage%>页，</span><a class="page" href="#" onclick="doSearch('first');">First</a>&nbsp;
            <a class="page" href="#" onclick="doSearch('pre');">Pre</a>&nbsp;
           <span class="tdfont"> [<%=i_Start%>-<%=i_End%>]/<%=i_total%></span>
            <a class="page" href="#" onclick="doSearch('next');">Next</a>&nbsp;
            <a class="page" href="#" onclick="doSearch('last');">Last</a>&nbsp;
            <input name="i_start" id="i_start" type="hidden" size="2" value="<%=i_Start%>">
            <select name="lpp" class="tdfont" onchange="doSearch_lpp('');">
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
  
  <td align="right"><span class="prtersty">输入姓名</span><input name="qname" type="text" id="qname" value="<%=ksxm_filter%>" class="iptprnt"/>&nbsp;<img src="../images/chaxun.gif" width="45" height="20" align="absbottom" onclick="search_xm();" /><!--<input type="button" onclick="search_xm();" value="查询" />--></td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
	 <tr>
	 <td align="right">&nbsp;

<%
	if(!("1".equals(s_isPublic)) && !("1".equals(s_isPublicExtra))) {
%>
			&nbsp;&nbsp;<input name="fabucj" type="button" onclick="window.open('/export_exam');""  value="导出空白成绩表" class="fbstyW"/>
			&nbsp;&nbsp;<input name="fabucj" type="button" onclick="reimport();"  value="导入考生成绩" class="fbsty"/>
<%
	}
%>
<%
	if(!("1".equals(s_isPublic))) {
%>
			&nbsp;&nbsp;<input name="fabucj" type="button" onclick="setPublic();"  value="发布笔试成绩" class="fbsty"/>

<%
	} 
	if(!("1".equals(s_isPublicExtra))) {
%>
			&nbsp;&nbsp;<input name="fabucj" type="button" onclick="setPublicExtra();"  value="发布面试成绩" class="fbsty"/>
<%
	}
%>
	 </td>
     </tr>
</table>
<br />
<table width="86%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="20" width="15%"  align="center"><span class="tbl_bt">准考证号</span></td>
<%
		if(orderColName.length()==0) orderColName=" zhkzhid";
		if(orderColName.indexOf("desc")>0) isDesc="";
		else isDesc=" desc";
%>
    <td width="12%"  align="center"><span class="tbl_bt">考生姓名</span></td>
    <td width="9%"  align="center"><span class="tbl_bt">性别</span></td>
    <td width="13%"  align="center"><span class="tbl_bt">考生科类</span></td>
    <td width="18%"  align="center"><span class="tbl_bt">身份证号</span></td>
<%
		ArrayList alKm = dbo.getList(kl);
		int kmLen = alKm.size();
		for(int i=0; i<kmLen; i++) {
			km = (Kemu) alKm.get(i);
%>
    <td width="10%"  align="center"><span class="tbl_bt"><%=km.getKmmc() %></span></td>
<%
		}
%>
  </tr>
<%
		if(orderColName.length() > 0) icl.setOrder(orderColName);
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		icl.setStart(i_Start);
		icl.setCount(i_LPP);
		al = dbo.getQueryList(icl.getExamResult(), icl);
		String shqk = "";
		String btn_yj = "";
		ScoreList sl = new ScoreList();
		ArrayList al_score;
		String cj="";
		for(int i = 0; i < al.size(); i++) {
			bmxx = (Bmxx) al.get(i);
			sl.setBmxxid(bmxx.getBmxxid());
			al_score = dbo.getList(sl);

			
%>
   <tr bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
   <input type="checkbox" name="chk_bmxx_cj" checked style="display:none;" value="<%=bmxx.getBmxxid()%>" />
     <td height="24" class="tdfont"><%=bmxx.getZhkzhid()%></td>
     <td  class="tdfont"><%=bmxx.getKsxm()%></td>
     <td  class="tdfont" align="center"><%=((1 == bmxx.getKsxb()) ? "男":"女")%></td>
     <td  class="tdfont" align="center"><%=bmxx.getKskl()%></td>
     <td  class="tdfont"><%=bmxx.getShfzh()%></td>
<%
			for(int j=0; j<kmLen; j++) {
				if(j < al_score.size()) cj = ((Score)al_score.get(j)).getFenshu();
				else cj = "";
%>
     <td  class="tdfont" align="center"><%=cj%>&nbsp;</td>
<%
			}
%>
   </tr>
<%
		}
%>
</table>
</td></tr>
</table>

<input id="i_CurrPage" name="i_CurrPage" type="hidden" value="<%=i_CurrPage%>"/>
<input id="oper" name="operate" type="hidden" value="<%=s_operate%>"/>
<input id="order" name="order" type="hidden" value=""/>
<input id="op" name="op" type="hidden" value=""/>
<input id="bmxxid" name="bmxxid" type="hidden" value="-1"/>
<input id="publicFlag" name="publicFlag" type="hidden" value=""/>
</form>
</div>
<%
	}catch(Exception e) {
		logger.error(e.getStackTrace()[0].toString());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
%>
</body>
</html>