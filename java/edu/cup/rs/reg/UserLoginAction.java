package edu.cup.rs.reg;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.cup.rs.log.LogHandler;
import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.util.Encoder;
import edu.cup.rs.util.HttpHelper;

public class UserLoginAction extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{
	protected static final LogHandler logger=LogHandler.getInstance(UserLoginAction.class);
    private String s_SrcUrl="";

	public UserLoginAction() {
		super();
	}   	 	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
			HttpSession session=request.getSession(true);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");

            s_SrcUrl=request.getParameter("src_url");

            response.setContentType("image/jpeg");
            response.setHeader("Pragma","No-cache");
            response.setHeader("Cache-Control","no-cache");
            response.setDateHeader("Expires", 0);

            String userName = BaseFunction.null2value(request.getParameter("txtname"));
            String userPwd = BaseFunction.null2value(request.getParameter("txtpwd"));
            if(0==userName.length())
            {
                response.sendRedirect("error.jsp?error=" + new UTF8String("请输入正确的用户名！").toUTF8String());
                return;
            }
            String rand = (String)session.getAttribute("rand");
            String input = BaseFunction.null2value(request.getParameter("authcode"));
            
            if(!input.equals(rand)){
            	logger.error("验证码不正确！");
            	response.sendRedirect("error.jsp?error=" + new UTF8String("验证码不正确！").toUTF8String());
                return;
            }
            
            DBOperator dbo=new DBOperator();
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
			int isAdmin = 0;
            try {
            	User user;
                ICommonList icl = new UserList(userName);
                ArrayList al = dbo.getList(icl);
                if(al.size()!=1) throw new Exception("用户不存在或密码错误！");
                user = (User)al.get(0);
				
                if(!(Encoder.encrypt(userPwd)).equals(user.getUserpwd())){
                	throw new Exception("用户不存在或密码错误！");
                }
				isAdmin = user.getAdmin();
                session.setAttribute("user_id" , ""+user.getUserid());
				session.setAttribute("user_name" , userName);
				session.setAttribute("admin" , ""+isAdmin);
                icl = new BmxxList(""+user.getUserid());
                al = dbo.getList(icl);
                if(al.size()==1) {
                	Bmxx bmxx = (Bmxx)al.get(0);
                	session.setAttribute("bmxxid" , new String(""+bmxx.getBmxxid()));
                }
				else{
					session.setAttribute("bmxxid" , null);
				}
				String ip = HttpHelper.getIpAddress(request);
				session.setAttribute("clientip", ip);
				Log log = new Log();
				icl = new LogsList();
				log.setContent(userName + " 登录系统, IP:" + ip);
				dbo.insert(icl.insert(log));
				dbo.commit();
            } catch (Exception ess) {
				dbo.rollback();
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("用户不存在或密码错误！").toUTF8String());
                return;
            }
            finally{
                if(null!=dbo) dbo.dispose();
            }
			if(null!=s_SrcUrl && s_SrcUrl.length()>0){
				response.sendRedirect(s_SrcUrl);
			}
			else{
				if(isAdmin == 1)
					response.sendRedirect("admin/adminindex.jsp");
				else
					response.sendRedirect("loginin/stumain.jsp");
			}
            return;
        }
        catch(Exception e)
        {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=" + new UTF8String("用户不存在或密码错误！").toUTF8String());
            return;
        }
        
    }                 
 }