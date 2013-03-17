<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="edu.cup.rs.common.*"%>
<%@page import="edu.cup.rs.log.*"%>
<%  
	String USERID=(String)session.getAttribute("user_id");
	String ADMIN=(String)session.getAttribute("admin");
    String s_QueryString = BaseFunction.null2value(request.getQueryString());
    StringBuffer s_URL=request.getRequestURL();
    if(s_URL.length()>0){
        s_URL.append("?");
        s_URL.append(s_QueryString);
    }
    if(null==USERID || USERID.length()==0 || null == ADMIN || 0 == ADMIN.length() || !"1".equals(ADMIN))
    {
		if(s_URL.indexOf("adminindex") > -1 || s_URL.indexOf("stumain") > -1) {
			response.sendRedirect("../index.jsp");
			return;
		}
		else{
			response.sendRedirect("../reindex.jsp?url="+s_URL);
			return;
        }
    }
%>
