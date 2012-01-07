package edu.cup.rs.reg;


import java.io.IOException;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.UTF8String;
import java.util.ArrayList;

public class ResetPwdCheckAction extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{
	protected static final LogHandler logger=LogHandler.getInstance(ResetPwdCheckAction.class);
	
	public ResetPwdCheckAction() {
		super();
	}   	 	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
			HttpSession session=null;
			session=request.getSession(true) ;
            session.setMaxInactiveInterval(1*60);
            request.setCharacterEncoding("UTF-8");
            String question=BaseFunction.null2value(request.getParameter("selproblem"));
            String answer=BaseFunction.null2value(request.getParameter("pwdanswer"));
            String name=BaseFunction.null2value(request.getParameter("lgname"));

            DBOperator dbo=new DBOperator();
            try {
                dbo.init(true);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            try {
                User user;
                UserList icl = new UserList(name);
                ArrayList al = dbo.getList(icl);
                if(al.size()!=1) {
					response.sendRedirect("error.jsp?error="+new UTF8String("用户不存在或密码错误！").toUTF8String());
					return;
				}
                user = (User)al.get(0);
                if(!question.equals(user.getQuestion()) || !answer.equals(user.getAnswer())) { 
					response.sendRedirect("error.jsp?error=" + new UTF8String("用户不存在或输入的信息不正确，请检查后再试！").toUTF8String());
					return;
				}
				session.setAttribute( "username" , name);
            } catch (Exception ess) {
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            finally{
                if(null!=dbo) dbo.dispose();
            }
            response.sendRedirect("register/findpwdstp2.jsp");
            return;
        }
        catch(Exception e)
        {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=" + new UTF8String("发生错误！").toUTF8String());
            return;
        }
        
    }                 
 }