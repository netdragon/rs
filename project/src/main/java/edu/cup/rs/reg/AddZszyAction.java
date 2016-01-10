package edu.cup.rs.reg;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class AddZszyAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected static final LogHandler logger = LogHandler
			.getInstance(AddZszyAction.class);

	public AddZszyAction() {
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
			String zymc = BaseFunction.null2value(request.getParameter("zymc"));
			String zytype = BaseFunction.null2value(request
					.getParameter("zytype"));

			DBOperator dbo = new DBOperator();
			ZhshzyList zl;
			if (0 == zymc.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("请输入专业名称！").toUTF8String());
				return;
			}
			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {
				SystemSettingsList ssl;
				SystemSettings ss;
				ArrayList al;
				Calendar c_curr = Calendar.getInstance();
				Calendar cl = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				ssl = new SystemSettingsList();
				ssl.setItem("regStartDate");
				al = dbo.getList(ssl);
				if (1 == al.size()) {
					ss = (SystemSettings) al.get(0);
					if (null != ss.getValue())
						cl.setTime(sdf.parse(ss.getValue()));
				}

				ssl.setItem("regEndDate");
				al = dbo.getList(ssl);
				if (1 == al.size()) {
					ss = (SystemSettings) al.get(0);
					if (null != ss.getValue())
						c2.setTime(sdf.parse(ss.getValue()));
				}
				if (c_curr.after(cl) && c_curr.before(c2)) {
					response.sendRedirect("/error.jsp?error="
							+ new UTF8String("在本期报名时间内不能修改专业设置，否则会引起数据不一致!")
									.toUTF8String());
					return;
				}
				Zhshzy zy = new Zhshzy();
				zy.setZymc(zymc);
				zy.setType(Integer.parseInt(zytype));
				zl = new ZhshzyList();
				dbo.insert(zl.insert(zy));

				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 增加了招生专业。");
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
			response.sendRedirect("admin/zywh.jsp?info="
					+ new UTF8String("删除成功！").toUTF8String());
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}
