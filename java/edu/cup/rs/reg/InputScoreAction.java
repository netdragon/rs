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
import java.util.ArrayList;
import java.util.Iterator;

public class InputScoreAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(InputScoreAction.class);
	public InputScoreAction() {
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
			String[] sa_bmxx={""};
			if(null!=request.getParameterValues("chk_bmxx_cj")) sa_bmxx=request.getParameterValues("chk_bmxx_cj");
			else {
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请选择对象!").toUTF8String());
    			return;
			}
			String currentPage = BaseFunction.null2value(request.getParameter("i_CurrPage"));
			String startNum = BaseFunction.null2value(request.getParameter("i_start"));
			String lpp = BaseFunction.null2value(request.getParameter("lpp"));
			String filter = BaseFunction.null2value(request.getParameter("qname"));
			String order = BaseFunction.null2value(request.getParameter("order"));
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
            ScoreList sl;
			Score score;
			SystemSettingsList ssl;
			SystemSettings ss;
			//TODO: dynamic Course
			String cj_1; // id:1
			String cj_2; // id:2
			float i_cj_1, i_cj_2;
			ArrayList al;
			float rate = 0.7f;
			BmxxList bl = new BmxxList();
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }

            try {
				ssl = new SystemSettingsList();
				ssl.setItem("rate");
				al = dbo.getList(ssl);
				if(1 == al.size()) {
					ss = (SystemSettings)al.get(0);
					rate = Float.parseFloat(ss.getValue());
				}
				sl = new ScoreList();
				score = new Score();

				for(int i=0;i<sa_bmxx.length;i++)
				{
					score.setBmxxid(Integer.parseInt(sa_bmxx[i]));
					cj_1 = (null == request.getParameter("cj1_"+sa_bmxx[i]))?"0":request.getParameter("cj1_"+sa_bmxx[i]);
					cj_2 = (null == request.getParameter("cj2_"+sa_bmxx[i]))?"0":request.getParameter("cj2_"+sa_bmxx[i]);
					score.setKmid(1);
					i_cj_1 = Float.parseFloat(cj_1);
					i_cj_2 = Float.parseFloat(cj_2);
					logger.debug(""+i_cj_1);
					logger.debug(""+i_cj_2);
					score.setFenshu(i_cj_1);
					dbo.delete(sl.delete(score));
					dbo.insert(sl.insert(score));
					score.setKmid(2);
					score.setFenshu(i_cj_2);
					dbo.update(bl.setSumScore(sa_bmxx[i], i_cj_1*rate+i_cj_2*(1.0f-rate)));
					dbo.insert(sl.insert(score));
				}
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 修改考生分数。");
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
            response.sendRedirect("admin/lrlq.jsp?"+param.toString());
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
