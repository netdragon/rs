package edu.cup.rs.reg;

import java.io.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.common.*;


public class SaveStaticPageAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(SaveStaticPageAction.class);
	public SaveStaticPageAction() {
		super();
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
    		if(null == USERID){
                logger.error("没有登录!");
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请先登录!").toUTF8String());
    			return;
    		}
			if(!"1".equals(USER_ROLES)) {
                logger.error("您不是管理员，没有权限进入!");
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请先以管理员登录!").toUTF8String());
    			return;
    		}
			String content = BaseFunction.null2value(request.getParameter("content"));
			String edit_file = BaseFunction.null2value(request.getParameter("edit_file"));
			OutputStreamWriter out = null;
            try {
				if(0 < edit_file.length()) {
					String root = request.getRealPath("/");
					out = new OutputStreamWriter(new FileOutputStream(root + "/admin/" + edit_file),"UTF-8");
					out.write("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /></head><body>\n");
					out.write(content);
					out.write("\n</body></html>");
					out.flush();
				}
            } catch (Exception ess) {
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            finally{
                if(null!=out) out.close();
            }
            response.sendRedirect("admin/edit_static_page.jsp?curr_file="+edit_file);
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
