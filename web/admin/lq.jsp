<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@ page import="edu.cup.rs.reg.sys.*"%>

<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>自主选拔录取入学考生录取</title>
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

table a{	
   color: #FF3300;
   text-decoration:underline;
   font-size:12px;
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
.iptprnt{	font-size: 12px;}
.fbcs {
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
}
.fbsty{
	background-color:#3777BC;
	color: #FFFFFF;
	padding-top: 1px;
	width:102px;
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
		document.forms[0].action = "/admit";
		document.forms[0].submit();
	}
  function adjust_admit(bmxxid){
	document.getElementById("bmxxid").value=bmxxid;
	document.forms[0].method = "post";
	document.forms[0].action = "/adjust_admit";
	document.forms[0].submit();
	hiddenDiv(bmxxid);
  }
  function search_xm(){
	document.forms[0].action = "lq.jsp";
	document.forms[0].submit();
  }
  function close_admit(bmxxid){
	hiddenDiv(bmxxid);
	document.getElementById("bmxxid").value="";
  }
  	function setPublic(){
		if(window.confirm("发布后考生马上就可以查阅到录取结果，并且将锁定录取，是否确定现在将最终录取结果发布？")){
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
  hiddenDiv=function(bmxxid){  
  	document.getElementById("linkDiv_"+bmxxid).style.display="none";
	document.getElementById("bmxxid").value="";
  }  
  
  showDiv=function(obj,bmxxid) {
	if(document.getElementById("linkDiv_"+bmxxid).style.display == "none") {
		document.getElementById("linkDiv_"+bmxxid).style.left=getPosition(obj).x+"px";   
		document.getElementById("linkDiv_"+bmxxid).style.top=getPosition(obj).y+obj.offsetHeight+"px";   
		document.getElementById("linkDiv_"+bmxxid).style.position="absolute";   
		document.getElementById("linkDiv_"+bmxxid).style.display='block';
		document.getElementById("bmxxid").value=bmxxid;
	}
	else {
		hiddenDiv(bmxxid);
	}
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
	LogHandler logger=LogHandler.getInstance("lq.jsp");
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
	
    int i_total=0,i_lq=0;
    int i_Start=1;
    int i_LPP=20;
    int i_CurrPage=1;
	int i_AllPage=0;
	int score = 0;
	String s_operate="";
	String s_isPublic = "";
	SqbklyList sqbklyList=null;
	Sqbkly sqbkly=null;
	ArrayList al_sqly=null;
	HashMap hm_sqly=new HashMap();
	try {
		SystemSettingsList ssl;
		ArrayList al_settings;
		ssl = new SystemSettingsList("isPublic_Admit");
		al_settings = dbo.getList(ssl);
		if(al_settings.size() > 0) s_isPublic = ((SystemSettings)(al_settings.get(0))).getValue();
		
		s_operate = BaseFunction.null2value(request.getParameter("operate"));
		String score_condition = request.getParameter("jzfs");
		score = (null == score_condition || score_condition.length() == 0)?0:Integer.parseInt(request.getParameter("jzfs"));
		icl = new BmxxList();
		i_total = dbo.getCount(icl.getAdmissionCount());
		i_lq = dbo.getCount(icl.getAdmitCount());

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
<form method="get" action="lq.jsp">
<table width="55%" border="0" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td align="center" valign="top"   class="STYLE2"><%=year%>年自主选拔录取考生录取</td>
  </tr>
  <tr>
    <td background="../images/zyhd_bottom.gif" height="1"></td>
  </tr>
</table><br />
<table width="90%" border="0" cellspacing="0" cellpadding="0"  align="center">
   <tr>
    <td colspan="2" height="2"></td>
  </tr>
  <tr>
  <td >
            <span class="tdfont">共有<%=i_total%>人，分<%=i_AllPage%>页。已录取<%=i_lq%>人。</span><a class="page" href="#" onclick="doSearch('first');">First</a>&nbsp;
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
            </select>&nbsp;&nbsp;&nbsp;&nbsp;<input name="Submit2" type="button"  onclick="window.open('/export_admit');"  value="导出录取结果" class="fbsty"/>
<%
	if(!("1".equals(s_isPublic))) {
%>
			&nbsp;&nbsp;<input name="fabucj" type="button" onclick="setPublic();"  value="发布录取结果" class="fbsty"/>
<%
	}
%>
  </td>
  
  <td  align="right"></td>
  </tr>
</table>
<table width="50%" border="0" cellspacing="0" cellpadding="0" align="right">
  <tr>
    <td align="right"> </td>
    <td><input name="jzfs" type="hidden" id="jzfs" value="<%=((0 == score)?"":score)%>" class="iptprnt"/></td>
  </tr>
  <tr>
    <td height="23" ></td>
    <td height="23" align="right"><span class="prtersty">输入姓名</span>&nbsp;&nbsp;<input name="qname" type="text" id="qname" value="<%=ksxm_filter%>" class="iptprnt"/>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../images/chaxun.gif" width="45" height="20" onclick="search_xm();" /></td>
  </tr>
</table>
<table width="100" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="6"></td>
  </tr>
</table>
<table width="98%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td height="20" width="3%"  align="center"><input type="checkbox" name="checkbox" onclick="sel_all(this);" value="checkbox" /></td>
    <td width="12%"  align="center"><span class="tbl_bt">准考证号</span></td>
<%
		if(orderColName.length()==0) orderColName=" zhkzhid";
		if(orderColName.indexOf("desc")>0) isDesc="";
		else isDesc=" desc";
%>
    <td width="12%"  align="center"><span class="tbl_bt">姓名</span></td>
    <td width="4%"  align="center"><span class="tbl_bt">性别</span></td>
    
	<td width="9%"  align="center" nowrap="nowrap"><span class="tbl_bt">面试分组</span></td>
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
    <td width="17%"  align="center"><span class="tbl_bt">录取操作</span></td>
	<td width="17%"  align="center"><span class="tbl_bt">录取专业</span></td>
<!--	<td width="9%"  align="center"><span class="tbl_bt"><a href="lq.jsp?order=sflq<%=isDesc%>">是否录取</a></span></td>-->
<td width="7%"  align="center" nowrap="nowrap" ><span class="tbl_bt">是否录取</span></td>
  </tr>
<%
		if(orderColName.length() > 0) icl.setOrder(orderColName);
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		icl.setStart(i_Start);
		icl.setCount(i_LPP);
		al = dbo.getQueryList(icl.getAdmitResult(score), icl);
		String shqk = "";
		String btn_yj = "";
		sqbklyList = new SqbklyList();
		al_sqly = dbo.getList(sqbklyList);
		for(int k=0; k<al_sqly.size(); k++) {
		    sqbkly = (Sqbkly) al_sqly.get(k);
		    hm_sqly.put(sqbkly.getId()+"", sqbkly.getMc());
		}
		ScoreList sl = new ScoreList();
		BkzyList zyl = new BkzyList();
		ArrayList al_score,al_zy;
		String cj_1 = "", cj_2 = "";
		Bkzy bkzy;
		String zy1 = "", zy2 = "", sfty = "", btn_tj="&nbsp;";
		for(int i = 0; i < al.size(); i++) {
			bmxx = (Bmxx) al.get(i);
			sl.setBmxxid(bmxx.getBmxxid());
			zyl.setBmxxid(bmxx.getBmxxid());
			al_zy = dbo.getList(zyl);

			al_score = dbo.getList(sl);
			if(((Bkzy)al_zy.get(0)).getTjf() == 1) {
				sfty = "服从调剂";
			}
			else {
				sfty = "不服从调剂";
			}
			if(!("1".equals(s_isPublic)))
				btn_tj = "<input name=\"btn_lq\" type=\"button\" class=\"tdinpt\" value=\"录取\" onclick=\"showDiv(this," + bmxx.getBmxxid() +")\">";
			else
				btn_tj = "&nbsp;";
%>

   <tr bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
     <td align="center" ><input type="checkbox" name="chk_bmxx" id="chk_<%=i%>" value="<%=bmxx.getBmxxid()%>" /></td>
     <td height="24"  class="tdfont"><%=bmxx.getZhkzhid()%></td>
     <td  class="tdfont"><%=bmxx.getKsxm()%></td>
     <td  class="tdfont"><%=((1 == bmxx.getKsxb()) ? "男":"女")%></td>
     
	 <td  class="tdfont"><%=hm_sqly.get(bmxx.getSqly()) %></td>
	 
<%
			for(int j=0; j<kmLen; j++) {

			    cj_1 = ((Score)al_score.get(j)).getFenshu();
%>
     <td  class="tdfont" align="center"><%=cj_1%></td>
<%
			}
%>
	 <td  class="tdfont" align="left"><%=sfty%>&nbsp;<%=btn_tj%></td>
     <td  class="tdfont" align="left"><%=bmxx.getLqzy()%>&nbsp;</td>
	 <td  class="tdfont" align="left"><%=((1 == bmxx.getSflq())?"已录取":"未录取")%>&nbsp;</td>
   </tr>
<%
		}
%>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#999999">
<tr>
  <td height="40" colspan="8" align="left" bgcolor="#FFFFFF" class="tdfont"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="2%" height="46">&nbsp;</td>
      <td width="90%" align="center">
<%
		if(!("1".equals(s_isPublic))) {
%>
	  <input type="button" name="Submit2" value="第一志愿录取" onclick="setPass(true);" style="width:102px; height:28px;"/>
	  <input type="button" name="Submit2" value="不 录 取" onclick="setPass(false);" style="width:78px; height:28px;"/>
<%
		}
%>
	  &nbsp;</td>
      <td width="8%">&nbsp;</td>
    </tr>
  </table></td>
     </tr>
</table>
<%
		ArrayList al_zszy;
		ZhshzyList zl = new ZhshzyList();

		Zhshzy zszy = null;
		boolean isIn;
		for(int i = 0; i < al.size(); i++) {
			bmxx = (Bmxx) al.get(i);
			zyl.setBmxxid(bmxx.getBmxxid());
			
			al_zy = dbo.getList(zyl);
			logger.debug(bmxx.getSqly() + "ddee");
			zl.setType(Integer.parseInt(bmxx.getSqly()));
		    al_zszy = dbo.getList(zl);
%>
<div id="linkDiv_<%=bmxx.getBmxxid()%>" style="border: 1px solid #00FF00; display:none; background-color: #FFFF99;" >
<table border="0" align="center">
<tr><td>
	<select name="lqzy_<%=bmxx.getBmxxid()%>">
<%
			for(int j = 0; j < al_zy.size(); j++) {
				bkzy = (Bkzy)al_zy.get(j);
				if(0 == bkzy.getZyid()) continue;
%>
	<option value="<%=bkzy.getZyid()%>"><%=bkzy.getZymc()%></option>
<%
			}
			
%>
	<option value="-1">________</option>
<%
			for(int j = 0; j < al_zszy.size(); j++) {
				zszy = (Zhshzy)al_zszy.get(j);
				isIn = false;
				logger.debug(al_zy.size() + ":ddee");
				for(int k = 0; k < al_zy.size(); k++) {
					bkzy = (Bkzy)al_zy.get(k);
					if(bkzy.getTjf() != 1) isIn = true;
					if(zszy.getZyid() == bkzy.getZyid()) isIn = true;
				}
				if(isIn || zszy.getZyid()==0) continue;
%>
	<option value="<%=zszy.getZyid()%>"><%=zszy.getZymc()%></option>
<%
			}
%>
</select>  
</td></tr>
<tr>
<td align="center"><input type="button" onClick="adjust_admit(<%=bmxx.getBmxxid()%>);" value="提交">&nbsp;<input type="button" onClick="close_admit(<%=bmxx.getBmxxid()%>);" value="取消">
</td></tr>
</table>
</div> 
<%
	}
%>
<input id="i_CurrPage" name="i_CurrPage" type="hidden" value="<%=i_CurrPage%>">
<input id="oper" name="operate" type="hidden" value="<%=s_operate%>">
<input id="order" name="order" type="hidden" value="">
<input id="op" name="op" type="hidden" value="">
<input id="bmxxid" name="bmxxid" type="hidden" value="-1">
 
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


