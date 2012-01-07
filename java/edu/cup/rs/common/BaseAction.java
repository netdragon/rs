package edu.cup.rs.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.ServletContext;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.HttpHelper;

public abstract class BaseAction extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

    protected final static LogHandler logger = LogHandler.getInstance(BaseAction.class);

    protected String USER_ROLES = "";
    
    protected String USER_ACCOUNT_STATUS = "";

    protected String USERID = "";

    protected String USERNAME = "";

    protected HttpSession session = null;

    public BaseAction() {
        super();
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
            session = request.getSession(true);
			String ipSesn = (String)session.getAttribute("clientip");
			String ip = HttpHelper.getIpAddress(request);
			String bmxxidInfo=(String)session.getAttribute("bmxxid");
			if(!ip.equals(ipSesn)) {
				logger.error(bmxxidInfo + " IP地址不匹配，非法访问!IP:" + ipSesn + "变化为新IP:" + ip);
				response.sendRedirect("/error.jsp?error=" + new UTF8String("IP地址不匹配，非法访问!IP:" + ipSesn + "变化为新IP:" + ip).toUTF8String());
				return;
			}

            USERID = (String) session.getAttribute("user_id");
			USERNAME = (String) session.getAttribute("user_name");
			
			USER_ROLES = (String) session.getAttribute("admin");
			String s_QueryString = BaseFunction.null2value(request.getQueryString());
			StringBuffer s_URL=request.getRequestURL();
			if(s_URL.length()>0){
				s_URL.append("?");
				s_URL.append(s_QueryString);
			}
			if(null==USERID || USERID.length()==0)
			{
				logger.error("没有登录!");
				response.sendRedirect("reindex.jsp?url="+s_URL);
				return;
			}
            execute(request, response);
        } catch (Exception e) {
            logger.error(e.getMessage());
            response.sendRedirect("index.jsp");
            return;
        }

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp?error=not support get");
        return;
    }


    protected abstract void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;

}

