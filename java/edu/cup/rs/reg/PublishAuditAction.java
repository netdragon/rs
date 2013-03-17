package edu.cup.rs.reg;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.reg.Bkzy;
import edu.cup.rs.reg.Bmxx;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import edu.cup.rs.common.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.io.File;
import java.util.List;
import java.util.Iterator;

public class PublishAuditAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(PublishAuditAction.class);
	public PublishAuditAction() {
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
			
			String currentPage = BaseFunction.null2value(request.getParameter("i_CurrPage"));
			String startNum = BaseFunction.null2value(request.getParameter("i_start"));
			String lpp = BaseFunction.null2value(request.getParameter("lpp"));
			String filter = BaseFunction.null2value(request.getParameter("qname"));
			String order = BaseFunction.null2value(request.getParameter("order"));
			String publicFlag = BaseFunction.null2value(request.getParameter("publicFlag"));
			StringBuffer param = new StringBuffer("i_start=");
			param.append(startNum);
			param.append("&i_CurrPage=");
			param.append(currentPage);
			param.append("&lpp=");
			param.append(lpp);
			param.append("&order=");
			param.append(order);
			param.append("&qname=");
			param.append(new UTF8String(filter).toUTF8String());
			
            DBOperator dbo=new DBOperator();
            SystemSettingsList ssl;
            String req = BaseFunction.null2value(request.getHeader("Referer"));
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }

            try {
				//logger.debug("KKK:"+req);

				ssl = new SystemSettingsList();
				if(req.indexOf("chushen.jsp") > -1) {
					dbo.update(ssl.publishAudit());
					req = "chushen.jsp";
				}
				else if(req.indexOf("lrlq.jsp") > -1) {
					dbo.update(ssl.publishScore(publicFlag));
					req = "lrlq.jsp";
				}
				else if(req.indexOf("sczkzh.jsp") > -1) {
					dbo.update(ssl.publishAdmission());
					req = "sczkzh.jsp";
				}
				else if(req.indexOf("lq.jsp") > -1) {
					dbo.update(ssl.publishAdmit());
					req = "lq.jsp";
				}
				else 
					req = "" ;

                dbo.commit();

            } catch (Exception ess) {
                dbo.rollback();
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            finally{
                if(null!=dbo) dbo.dispose();
            }
            response.sendRedirect("admin/" + req +"?"+param.toString());
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
