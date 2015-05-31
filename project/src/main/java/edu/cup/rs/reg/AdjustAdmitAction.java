package edu.cup.rs.reg;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class AdjustAdmitAction extends BaseAction {

	protected static final LogHandler logger = LogHandler
			.getInstance(AdjustAdmitAction.class);

	public AdjustAdmitAction() {
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
			String s_Zyid = BaseFunction.null2value(request
					.getParameter("lqzy_" + bmxxid));

			String currentPage = BaseFunction.null2value(request
					.getParameter("i_CurrPage"));
			String startNum = BaseFunction.null2value(request
					.getParameter("i_start"));
			String lpp = BaseFunction.null2value(request.getParameter("lpp"));
			String filter = BaseFunction.null2value(request
					.getParameter("qname"));
			String order = BaseFunction.null2value(request
					.getParameter("order"));
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

			DBOperator dbo = new DBOperator();
			BmxxList bl;

			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {
				bl = new BmxxList();
				int zyid = Integer.parseInt(s_Zyid);
				dbo.update(bl.setAdjustAdmit(bmxxid, zyid));
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 调剂录取考生。");
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
			response.sendRedirect("admin/lq.jsp?" + param.toString());
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}
