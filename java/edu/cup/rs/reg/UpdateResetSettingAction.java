package edu.cup.rs.reg;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.reg.Bkzy;
import edu.cup.rs.reg.Bmxx;


import edu.cup.rs.common.*;
import edu.cup.rs.reg.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.File;
import java.util.List;
import java.util.Iterator;

public class UpdateResetSettingAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(UpdateResetSettingAction.class);
	public UpdateResetSettingAction() {
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
				String op = BaseFunction.null2value(request.getParameter("item"));

				ss.setItem("isPublic_Audit");
				ss.setValue(request.getParameter("radiobutton_Audit"));
				dbo.update(ssl.update(ss));
				ss.setItem("isPublic_Admission");
				ss.setValue(request.getParameter("radiobutton_Admission"));
				dbo.update(ssl.update(ss));
				ss.setItem("isPublic_Score");
				ss.setValue(request.getParameter("radiobutton_Score"));
				dbo.update(ssl.update(ss));
				ss.setItem("isPublic_Admit");
				ss.setValue(request.getParameter("radiobutton_Admit"));
				dbo.update(ssl.update(ss));

				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 重置发布标志。");
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
            response.sendRedirect("ok.jsp?op=1&info=" + new UTF8String("设置成功！").toUTF8String());
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
