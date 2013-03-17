package edu.cup.rs.reg.sys;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.common.*;
import edu.cup.rs.reg.*;
import edu.cup.rs.util.*;
import org.apache.commons.io.*;

public class SysInitializeAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(SysInitializeAction.class);

	public SysInitializeAction() {
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
				dbo.execute("delete from hjqk");
				dbo.execute("delete from attach_file");
				dbo.execute("delete from bkzy");
				dbo.execute("delete from hdqk");
				dbo.execute("delete from cjjd");
				dbo.execute("delete from score");
				dbo.execute("delete from bmxx");
				dbo.execute("delete from user where username<>'administrator'");
				dbo.execute("update system_settings set value='0' where item='isPublic_Admission'");
				dbo.execute("update system_settings set value='0' where item='isPublic_Admit'");
				dbo.execute("update system_settings set value='0' where item='isPublic_Audit'");
				dbo.execute("update system_settings set value='0' where item='isPublic_Score'");
				dbo.execute("update system_settings set value='0' where item='isPublic_ScoreExtra'");
				
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 进行了系统初始化。");
				dbo.insert(logslist.insert(log));
				dbo.commit();
            } catch (Exception ess) {
			    dbo.rollback();
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据访问错误！").toUTF8String());
                return;
			}finally {
				if(null!=dbo) dbo.dispose();
			}
			response.sendRedirect("ok.jsp?info=" + new UTF8String("系统初始化成功！").toUTF8String());
            return;
        } catch(Exception e)
        {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=" + new UTF8String("发生错误！").toUTF8String());
            return;
        }

    }
 }

