package edu.cup.rs.reg;

import java.io.IOException;
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

public class DeleteBmxxAction extends BaseAction {

	protected static final LogHandler logger = LogHandler
			.getInstance(DeleteBmxxAction.class);

	public DeleteBmxxAction() {
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
			String bmxxid = BaseFunction.null2value(request
					.getParameter("bmxxid"));
			if (bmxxid.length() == 0) {
				response.sendRedirect("/error.jsp?error="
						+ new UTF8String("请选择对象!").toUTF8String());
				return;
			}

			DBOperator dbo = new DBOperator();
			BmxxList bl;
			String s_isPublic = "";
			ArrayList al_settings;
			SystemSettings ss;
			SystemSettingsList ssl;

			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {
				ssl = new SystemSettingsList("isPublic_Audit");
				al_settings = dbo.getList(ssl);
				if (al_settings.size() > 0)
					s_isPublic = ((SystemSettings) (al_settings.get(0)))
							.getValue();
				if (("1".equals(s_isPublic))) {
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("审核结果已发布，不能修改报名信息！")
									.toUTF8String());
					return;
				}
				bl = new BmxxList();
				dbo.update(bl.delete_hjqk(bmxxid));
				dbo.update(bl.delete_hdqk(bmxxid));
				dbo.update(bl.delete_bkzy(bmxxid));
				dbo.update(bl.delete_cjjd(bmxxid));
				dbo.update(bl.delete(bmxxid));

				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 删除考生信息。");
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
			response.sendRedirect("ok.jsp?info="
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
