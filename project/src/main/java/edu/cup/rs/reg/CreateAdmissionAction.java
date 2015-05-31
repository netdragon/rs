package edu.cup.rs.reg;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class CreateAdmissionAction extends BaseAction {

	protected static final LogHandler logger = LogHandler
			.getInstance(CreateAdmissionAction.class);

	public CreateAdmissionAction() {
		super();
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			if (null == USERID) {
				logger.error("没有登录!");
				response.sendRedirect("/error.jsp?error="
						+ new UTF8String("请先登录!").toUTF8String());
				return;
			}
			if (!"1".equals(USER_ROLES)) {
				logger.error("您不是管理员，没有权限进入!");
				response.sendRedirect("/error.jsp?error="
						+ new UTF8String("请先以管理员登录!").toUTF8String());
				return;
			}
			DBOperator dbo = new DBOperator();
			BmxxList bl;
			Bmxx bmxx;
			ArrayList al;
			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}
			String admNum;
			Calendar c = Calendar.getInstance();
			try {
				bl = new BmxxList();
				dbo.update(bl.initAdmission());
				al = dbo.getQueryList(bl.getAdmissionKs(), bl);
				int index_w = 1, index_l = 1;
				for (int i = 0; i < al.size(); i++) {
					bmxx = (Bmxx) al.get(i);
					if ("理工".equals(bmxx.getKskl())) {
						admNum = AdmissionNumberCreater.getNumber(index_l);
						index_l++;
						admNum = c.get(Calendar.YEAR) + "05" + admNum;
					} else {
						admNum = AdmissionNumberCreater.getNumber(index_w);
						index_w++;
						admNum = c.get(Calendar.YEAR) + "02" + admNum;
					}
					dbo.update(bl.createAdmission(bmxx.getBmxxid(), admNum));
				}
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 生成准考证。");
				dbo.insert(logslist.insert(log));
				dbo.commit();
			} catch (Exception ess) {
				dbo.rollback();
				logger.error(ess.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			} finally {
				if (null != dbo)
					dbo.dispose();
			}
			response.sendRedirect("admin/sczkzh.jsp");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}
