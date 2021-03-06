package edu.cup.rs.reg;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class UpdateCourseScheduleAction extends BaseAction {

	protected static final LogHandler logger = LogHandler
			.getInstance(UpdateCourseScheduleAction.class);

	public UpdateCourseScheduleAction() {
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
			KemulxList kl = new KemulxList();
			Kemulx kemu;
			int lxid;
			ArrayList al;

			String sj_s;
			String sj_f;

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {
				al = dbo.getList(kl);
				for (int i = 0; i < al.size(); i++) {
					kemu = (Kemulx) (al.get(i));
					lxid = kemu.getLxid();

					kemu.setKsrq(sdf.parse(request.getParameter("ksnian_"
							+ lxid)
							+ "-"
							+ request.getParameter("ksyue_" + lxid)
							+ "-"
							+ request.getParameter("ksri_" + lxid)));
					sj_s = (null == request.getParameter("ksdian_" + lxid)) ? "8"
							: request.getParameter("ksdian_" + lxid);
					sj_f = (null == request.getParameter("ksfen_" + lxid)) ? "0"
							: request.getParameter("ksfen_" + lxid);
					kemu.setKssj(sj_s + ":" + sj_f);
					sj_s = (null == request.getParameter("jsdian_" + lxid)) ? "8"
							: request.getParameter("jsdian_" + lxid);
					sj_f = (null == request.getParameter("jsfen_" + lxid)) ? "0"
							: request.getParameter("jsfen_" + lxid);
					kemu.setJssj(sj_s + ":" + sj_f);
					dbo.update(kl.update(kemu));
				}
				SystemSettingsList ssl = new SystemSettingsList();
				SystemSettings ss = new SystemSettings();
				String op = BaseFunction.null2value(request
						.getParameter("item"));
				if ("kssj".equals(op)) {
					ss.setItem("regStartDate");
					ss.setValue(request.getParameter("ksnian") + "-"
							+ request.getParameter("ksyue") + "-"
							+ request.getParameter("ksri"));
					dbo.update(ssl.update(ss));
					ss.setItem("regEndDate");
					ss.setValue(request.getParameter("jsnian") + "-"
							+ request.getParameter("jsyue") + "-"
							+ request.getParameter("jsri"));
					dbo.update(ssl.update(ss));
					ss.setItem("rate");
					ss.setValue(request.getParameter("rate"));
					dbo.update(ssl.update(ss));
				}
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 修改系统参数设置。");
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
			response.sendRedirect("ok.jsp?op=1&info="
					+ new UTF8String("设置成功！").toUTF8String());
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}
