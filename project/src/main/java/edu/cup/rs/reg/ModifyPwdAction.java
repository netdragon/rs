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
import edu.cup.rs.util.Encoder;

public class ModifyPwdAction extends BaseAction {
	protected static final LogHandler logger = LogHandler
			.getInstance(ModifyPwdAction.class);

	public ModifyPwdAction() {
		super();
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String oldPwd = BaseFunction.null2value(request
					.getParameter("txtpwdold"));
			String password = BaseFunction.null2value(request
					.getParameter("txtpwdnew"));

			DBOperator dbo = new DBOperator();
			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {
				User user;
				ICommonList logslist;
				UserList icl = new UserList(Integer.parseInt(USERID));
				ArrayList al = dbo.getList(icl);
				if (al.size() != 1) {
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("用户不存在或密码错误！").toUTF8String());
					return;
				}
				user = (User) al.get(0);
				if (!user.getUserpwd().equals(Encoder.encrypt(oldPwd))) {
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("输入的原密码不正确！").toUTF8String());
					return;
				}
				dbo.update(icl.modifyPwd(Encoder.encrypt(password),
						Integer.parseInt(USERID)));

				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 修改密码。");
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
			response.sendRedirect("register/modisuc.html");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}