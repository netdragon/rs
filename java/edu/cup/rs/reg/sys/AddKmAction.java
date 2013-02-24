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
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.io.File;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class AddKmAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(AddKmAction.class);
	public AddKmAction() {
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
			String kmmc = BaseFunction.null2value(request.getParameter("kmmc"));
			String lxid = BaseFunction.null2value(request.getParameter("kmlxidkey"));
            DBOperator dbo=new DBOperator();
            KemuList zl;
            if(0==kmmc.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("请输入科目名称！").toUTF8String());
                return;
            }
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }

            try {
				ArrayList al;
				SystemSettingsList ssl;
				SystemSettings ss;
				Calendar c_curr = Calendar.getInstance();
				Calendar cl = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						

				ssl = new SystemSettingsList();
				ssl.setItem("regStartDate");
				al = dbo.getList(ssl);
				if(1 == al.size()) {
					ss = (SystemSettings)al.get(0);
					if(null != ss.getValue())
						cl.setTime(sdf.parse(ss.getValue()));
				}

				ssl.setItem("regEndDate");
				al = dbo.getList(ssl);
				if(1 == al.size()) {
					ss = (SystemSettings)al.get(0);
					if(null != ss.getValue())
						c2.setTime(sdf.parse(ss.getValue()));
				}
				if(c_curr.after(cl) && c_curr.before(c2)) {
					response.sendRedirect("/error.jsp?error=" + new UTF8String("在本期报名时间内不能修改考试科目，否则会引起数据不一致!").toUTF8String());
					return;
				}
				Kemu ly = new Kemu();
				ly.setKmmc(kmmc);
				ly.setKmlxid(Integer.parseInt(lxid));

				zl = new KemuList();
				dbo.insert(zl.insert(ly));
				
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 增加了考试科目。");
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
            response.sendRedirect("admin/kemulist.jsp?kmlxid=" + lxid + "&info=" + new UTF8String("添加成功！").toUTF8String());
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

