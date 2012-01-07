<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="edu.cup.rs.common.*"%>
<%@page import="edu.cup.rs.log.*"%>
<%@page import="edu.cup.rs.util.HttpHelper"%>

<%
	LogHandler loggerBase=LogHandler.getInstance("access_control.jsp");
    String USERID=(String)session.getAttribute("user_id");
	String ipSesn = (String)session.getAttribute("clientip");
	String ip = HttpHelper.getIpAddress(request);
	String bmxxidInfo=(String)session.getAttribute("bmxxid");
	if(!ip.equals(ipSesn)) {
		loggerBase.error(bmxxidInfo + " IP地址不匹配，非法访问!IP:" + ipSesn + "变化为新IP:" + ip);
		response.sendRedirect("/error.jsp?error=" + new UTF8String("IP地址不匹配，非法访问!IP:" + ipSesn + "变化为新IP:" + ip).toUTF8String());
		return;
	}

    String s_QueryString = BaseFunction.null2value(request.getQueryString());
    StringBuffer s_URL=request.getRequestURL();
    if(s_URL.length()>0){
        s_URL.append("?");
        s_URL.append(s_QueryString);
    }
    if(null==USERID || USERID.length()==0)
    {
		if(s_URL.indexOf("adminindex") > -1 || s_URL.indexOf("stumain") > -1) {
			response.sendRedirect("../index.jsp");
		}
		else{
			response.sendRedirect("../reindex.jsp?url="+s_URL);
        }
        return;
    }
%>
