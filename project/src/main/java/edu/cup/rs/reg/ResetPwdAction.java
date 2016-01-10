package edu.cup.rs.reg;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.Encoder;

public class ResetPwdAction extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	protected static final LogHandler logger = LogHandler
			.getInstance(ResetPwdAction.class);

	public ResetPwdAction() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = null;
			session = request.getSession(true);
			String password = BaseFunction.null2value(request
					.getParameter("passwordn"));
			String username = (String) session.getAttribute("username");
			if (null == username || username.length() == 0) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("用户不存在或密码错误！").toUTF8String());
				return;
			}
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
				UserList icl = new UserList(username);
				ArrayList al = dbo.getList(icl);
				if (al.size() != 1) {
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("用户不存在或密码错误！").toUTF8String());
					return;
				}
				user = (User) al.get(0);
				dbo.update(icl.modifyPwd(Encoder.encrypt(password),
						user.getUserid()));

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
			response.sendRedirect("register/findpwdsuc.html");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}

	}
}