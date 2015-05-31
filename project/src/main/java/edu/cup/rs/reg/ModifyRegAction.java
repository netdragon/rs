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

public class ModifyRegAction extends BaseAction {
	protected static final LogHandler logger = LogHandler
			.getInstance(ModifyRegAction.class);

	public ModifyRegAction() {
		super();
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String question = BaseFunction.null2value(request
					.getParameter("selproblem"));
			String answer = BaseFunction.null2value(request
					.getParameter("cusanswer"));
			String email = BaseFunction.null2value(request
					.getParameter("email"));

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
				user.setEmail(email);
				user.setAnswer(answer);
				user.setQuestion(question);
				dbo.update(icl.modifyReg(user));
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 修改注册信息。");
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