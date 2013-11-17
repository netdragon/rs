package edu.cup.rs.reg.sys;

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
import edu.cup.rs.reg.*;

import java.util.Calendar;
import java.util.HashMap;
import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class UpdateTishiyuAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(UpdateTishiyuAction.class);
	public UpdateTishiyuAction() {
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
			
			String auditResultYes = BaseFunction.null2value(request.getParameter("auditResultYes"));
			String auditResultNo = BaseFunction.null2value(request.getParameter("auditResultNo"));
			String admitResultYes = BaseFunction.null2value(request.getParameter("admitResultYes"));
			String admitResultNo = BaseFunction.null2value(request.getParameter("admitResultNo"));

            DBOperator dbo=new DBOperator();

            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }

            try {
				SystemSettingsList ssl = new SystemSettingsList();
				SystemSettings ss = new SystemSettings();

				ss.setItem("audit_result_yes");
				ss.setValue(auditResultYes);
				dbo.update(ssl.update(ss));
				ss.setItem("audit_result_no");
				ss.setValue(auditResultNo);
				dbo.update(ssl.update(ss));
				ss.setItem("admit_result_yes");
				ss.setValue(admitResultYes);
				dbo.update(ssl.update(ss));
				ss.setItem("admit_result_no");
				ss.setValue(admitResultNo);
				dbo.update(ssl.update(ss));
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 设置系统提示语");
				dbo.insert(logslist.insert(log));
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
			response.sendRedirect("ok.jsp?info=" + new UTF8String("系统提示语设置成功！").toUTF8String());
            
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

