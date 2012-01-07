<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*"%>
<%@include file="../common/admin_control.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统日志</title>
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
	width:88px;
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
  function search_xm(){
	document.forms[0].action = "logslist.jsp";
	document.forms[0].submit();
  }
</script>
</head>
<%
	String ksxm_filter = BaseFunction.null2value(request.getParameter("qname"));
	ksxm_filter = new String(ksxm_filter.getBytes("iso8859-1"), "utf-8");
	LogHandler logger=LogHandler.getInstance("logslist.jsp");
	ArrayList al;
	LogsList icl;
	Log log;
	
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
	try {
		
		s_operate = BaseFunction.null2value(request.getParameter("operate"));
		icl = new LogsList();
		i_total = dbo.getCount(icl.getCount());
	

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
<div class="con">
<form method="get" action="logslist.jsp">
<table width="90%" border="0" cellspacing="0" cellpadding="0"  align="center" id="fenye">
  <tr>
    <td colspan="2" height="6"></td>
  </tr>
  <tr>
  <td>
            <span class="tdfont">共有<%=i_total%>条日志，分<%=i_AllPage%>页。</span><a class="page" href="#" onClick="doSearch('first');">First</a>&nbsp;
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
  
  <td align="right"><span class="prtersty">日志内容</span><input name="qname" type="text" id="qname" value="<%=ksxm_filter%>" class="iptprnt"/>&nbsp;<img src="../images/chaxun.gif" width="45" height="20" align="absbottom"  onClick="search_xm();" /><!--<input type="button" onclick="search_xm();" value="查询" />--></td>
  </tr>
</table><br />
<table width="96%" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="20%" align="center" ><span class="biaotou">时间</span></td>
	<td width="76%" align="center"><span class="biaotou">内容</span></td>
    </tr>
<%
		if(ksxm_filter.length() > 0) icl.setXmFilter(ksxm_filter);
		//logger.debug(ksxm_filter);
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
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	for(int i = 0; i < al.size(); i++) {
		log = (Log) al.get(i);
%>
   <tr  bgcolor="#FFFFFF" onMouseOut="this.style.backgroundColor='#FFFFFF'" onMouseOver="this.style.backgroundColor='#FFFFCC'">
     <td  class="tdfont" align="left"> <%=((null == log.getTimestamp()) ? "&nbsp;":sf.format(log.getTimestamp()))%></td>
	 <td  class="tdfont" align="left"> <%=log.getContent()%>&nbsp;</td>
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
</body>
</html>
