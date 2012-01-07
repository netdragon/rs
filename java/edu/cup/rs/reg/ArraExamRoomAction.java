package edu.cup.rs.reg;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;

import edu.cup.rs.reg.Bmxx;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import edu.cup.rs.common.*;
import java.util.*;

public class ArraExamRoomAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(ArraExamRoomAction.class);
	public ArraExamRoomAction() {
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
            BmxxList bl;
			String num = BaseFunction.null2value(request.getParameter("room"));
			int countPerRoom = 30;
            Bmxx bmxx;
			ArrayList al;
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            try {
				countPerRoom = Integer.parseInt(num);
				bl = new BmxxList();
				dbo.update(bl.initExamRoom());
				al = dbo.getQueryList(bl.getExamAdmission(), bl);
				int roomNum = 1, j = 0;
				for(int i = 0; i < al.size(); i++) {
					j++;
					bmxx = (Bmxx)al.get(i);
					dbo.update(bl.arraRoom(bmxx.getBmxxid(), roomNum));
					if(j == countPerRoom) {
						roomNum++;
						j = 0;
					}
				}
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 安排考场。");
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
            response.sendRedirect("admin/kch.jsp");
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
