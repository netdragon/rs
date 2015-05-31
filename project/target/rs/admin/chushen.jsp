<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>自主选拔录取报名考生初审</title>
<style type="text/css">
<!--
.tdfont{font-size: 12px;}
.xmsty a{
		font-size:12px;
		color:#3333FF;
		font-weight:bold;
		text-decoration:none;
     }
.xmsty a:hover{	
		color:#C51200;
		font-weight:bold;
		text-decoration:underline;
     }
.table_bt {
	color: #3E3EFF;
	font-size: 20px;
	font-family: "华文楷体";
	font-weight: bold;

}
.biaotou {color: #000000; font-weight: bold; font-size: 12px; }
.biaotou a{color: #000000; font-weight: bold; font-size: 12px; }
.biaotou a:hover{color: #FF0000; font-weight: bold; font-size: 12px; }

#fenye a{	
   color: #FF3300;
   text-decoration:underline;
   font-size:12px;
   font-weight:bold;
}
#fenye a:hover{	
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

.prtersty {
	color: #000051;
	font-size: 12px;
	font-weight: bold;
}
.iptprnt{font-size: 12px;}

.fbsty {
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:96px;
    }
.tdinpt {font-size: 10px;}
#ejiaA1 {
width: 550px;
border-top: #E3E3E3 1px solid;
border-left: #E3E3E3 1px solid;
}
#ejiaA1 td,#ejiaA1 th {

font-size:12px;

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
    function order_by(order) {
        document.getElementById("order").value=order;
		document.getElementById("oper").value="";
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
		document.forms[0].action = "/setaudit";
		document.forms[0].submit();
	}
	function setPublic(){
		if(window.confirm("发布后考生将可以查阅到审核结果，是否确定现在将审核结果发布？")){
			document.forms[0].method = "post";
			document.forms[0].action = "/public_info";
			document.forms[0].submit();
		}
	}

  function setCause(){
	document.getElementById("linkDiv").style.display="none";
	document.forms[0].method = "post";
	document.forms[0].action = "/set_audit_advice";
	document.forms[0].submit();
  }
  function closeCause(){
	document.getElementById("linkDiv").style.display="none";
	document.getElementById("yj").value="";
	document.getElementById("bmxxid").value="";
  }
  function search_xm(){
	document.forms[0].action = "chushen.jsp";
	document.forms[0].submit();
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
	LogHandler logger=LogHandler.getInstance("chushen.jsp");
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
	
    int i_total=0, i_unAudit=0;
    int i_Start=1;
    int i_LPP=20;
    int i_CurrPage=1;
	int i_AllPage=0;
	String s_operate="";
	String s_isPublic = "";
	try {
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Audit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		
		s_operate = BaseFunction.null2value(request.getParameter("operate"));
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getCount());
		i_unAudit = dbo.getCount(icl.getUnauditedCount());

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
<form method="get" action="chushen.jsp">
<table width="45%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td   align="center"   class="table_bt"><%=year%>年自主选拔录取报名考生审核</td>
  </tr>
    <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>

</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  height="5"></td>
  </tr>
  <tr>  
  <td align="right">
<%
	if(!("1".equals(s_isPublic))) {
%>
  <input type="button" value="发布审核结果" onClick="setPublic();" class="fbsty"/>
<%
	}
%>
  &nbsp;&nbsp;<input type="button" value="导出审核结果" onClick="window.open('/export_audit');" class="fbsty"/></td>
  </tr>
</table>
<table width="99%" border="0" cellspacing="0" cellpadding="0"  align="center" id="fenye">
  <tr>
    <td colspan="2" height="6"></td>
  </tr>
  <tr>
  <td>
            <span class="tdfont">报名人数共有<%=i_total%>人，分<%=i_AllPage%>页，其中已审<%=(i_total - i_unAudit)%>人，未审<%=i_unAudit%>人。</span><a class="page" href="#" onClick="doSearch('first');">First</a>&nbsp;
            <a class="page" href="#" onClick="doSearch('pre');">Pre</a>&nbsp;
           <span class="tdfont"> [<%=i_Start%>-<%=i_End%>]/<%=i_total%></span>
            <a class="page" href="#" onClick="doSearch('next');">Next</a>&nbsp;
            <a class="page" href="#" onClick="doSearch('last');">Last</a>&nbsp;
            <input name="i_start" id="i_start" type="hidden" size="2" value="<%=i_Start%>">
            <select name="lpp" style="font-size: 12px;"  onchange="doSearch_lpp('');">
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
  
  <td align="right"><span class="prtersty">输入考生姓名</span><input name="qname" type="text" id="qname" value="<%=ksxm_filter%>" class="iptprnt"/>&nbsp;<img src="../images/chaxun.gif" width="45" height="20" align="absbottom"  onClick="search_xm();" /><!--<input type="button" onclick="search_xm();" value="查询" />--></td>
  </tr>
</table><br />
<table width="97%" border="1" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td  align="center" nowrap ><input type="checkbox" name="checkbox" onClick="sel_all(this);" value="checkbox" /></td>
    <td  align="center" nowrap ><span class="biaotou">序号</span></td>
<%
	if(orderColName.indexOf("desc")>0) isDesc="";
	else isDesc=" desc";
%>
    <td  align="center" nowrap><span class="biaotou"><a href="#" onClick="order_by('jg<%=isDesc%>, ksxm<%=isDesc%>');">考生姓名</a></span></td>
    <td  align="center" nowrap ><span class="biaotou">性别</span></td>
    <td  align="center" nowrap><span class="biaotou">高考省份</span></td>
    <td  align="center" nowrap><span class="biaotou">中学名称</span></td>
    <td  align="center" nowrap><span class="biaotou">考生科类</span></td>
    <td  align="center" nowrap ><span class="biaotou">初审状态</span></td>
	<td  align="center"><span class="biaotou">初审意见</span></td>
    </tr>
<%

		if(orderColName.length() > 0) icl.setOrder(orderColName);
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		icl.setStart(i_Start);
		icl.setCount(i_LPP);
		al = dbo.getList(icl);
	}catch(Exception e) {
		logger.error(e.getMessage());
		response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
		return;
	}finally {
		if(null != dbo) dbo.dispose();
	}
	String shqk = "";
	String btn_yj = "";
	for(int i = 0; i < al.size(); i++) {
		bmxx = (Bmxx) al.get(i);
		switch(bmxx.getShhqk()) {
		case -1:
			shqk = "未通过";
			if(!("1".equals(s_isPublic)))
				btn_yj = "<input name=\"btn_yj\" type=\"button\" class=\"tdinpt\" value=\"录入意见\" onclick=\"showDiv(this," + bmxx.getBmxxid() +")\">";
			else
				btn_yj = "";
			break;
		case 0:
			shqk = "未审";
			btn_yj = "";
			break;
		case 1:
			shqk = "通过";
			btn_yj = "";
			break;
		}
%>
   <tr  bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
     <td align="center" ><input type="checkbox" name="chk_bmxx" id="chk_<%=i%>" value="<%=bmxx.getBmxxid()%>" /></td>
     <td height="24"  class="tdfont"><%=(i+i_Start)%></td>
     <td ><span class="xmsty"><a href="ksxx.jsp?bmxxid=<%=bmxx.getBmxxid()%>" target="_blank"><%=bmxx.getKsxm()%></a></span></td>
     <td class="tdfont" align="center"><%=((1 == bmxx.getKsxb()) ? "男":"女")%></td>
     <td  class="tdfont"><%=bmxx.getJg()%></td>
     <td  class="tdfont"><%=bmxx.getZxmc()%></td>
     <td  class="tdfont"><%=bmxx.getKskl()%></td>
     <td  class="tdfont" align="center"><%=shqk%><%=btn_yj%></td>
     <td  class="tdfont" align="center"><%=bmxx.getShhyj()%>&nbsp;</td>
     </tr>
<%
	}
%>
</table>

<table width="96%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#999999">
<tr>
  <td height="40" colspan="8" align="left" bgcolor="#FFFFFF" class="tdfont"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="2%" height="40">&nbsp;</td>
      <td width="90%" align="center">
<%
	if(!("1".equals(s_isPublic))) {
%>
	  <input type="button" value="通 过" onClick="setPass(true);" style="width:74px; height:28px;"/>&nbsp;&nbsp;
	  <input type="button" name="Submit" value="不通过" onClick="setPass(false);" style="width:74px; height:28px;"/>
<%
	}
%>  
	  &nbsp;&nbsp; </td>
      <td width="8%">&nbsp;</td>
    </tr>
  </table></td>
     </tr>
</table>
<div id="linkDiv" style="border: 1px solid #00FF00; display:none; background-color: #FFFF99;" >
<table border="0" align="center">
<tr><td>
	<textarea style="width:170;height:120;" id="yj" name="yj"></textarea>  
</td></tr>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onClick="setCause();" value="提交">&nbsp;&nbsp;<input type="button" onClick="closeCause();" value="取消">
</td></tr>
</table>
</div>  
<input id="i_CurrPage" name="i_CurrPage" type="hidden" value="<%=i_CurrPage%>">
<input id="oper" name="operate" type="hidden" value="<%=s_operate%>">
<input id="order" name="order" type="hidden" value="<%=orderColName%>">
<input id="op" name="op" type="hidden" value="">
<input id="bmxxid" name="bmxxid" type="hidden" value="-1">
</form>
</div>
</body>
</html>
