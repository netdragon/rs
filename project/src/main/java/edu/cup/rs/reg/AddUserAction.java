package edu.cup.rs.reg;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.cup.rs.common.BaseFunction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.Encoder;

public class AddUserAction extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	protected HttpSession session = null;
	protected static final LogHandler logger = LogHandler
			.getInstance(AddUserAction.class);

	public AddUserAction() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			String userName = BaseFunction.null2value(request
					.getParameter("txtuname"));

			if (0 == userName.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("请输入用户名！").toUTF8String());
				return;
			}
			session = request.getSession(true);
			String rand = (String) session.getAttribute("rand");
			String input = request.getParameter("authcode");

			if (!input.equals(rand)) {
				logger.error("验证码不正确！");
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("验证码不正确！").toUTF8String());
				return;
			}
			String password = BaseFunction.null2value(request
					.getParameter("txtpwd"));
			String question = BaseFunction.null2value(request
					.getParameter("selproblem"));
			String answer = BaseFunction.null2value(request
					.getParameter("cusanswer"));
			String email = BaseFunction.null2value(request
					.getParameter("email"));
			String regIp = request.getRemoteAddr();
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
				User user = new User();
				user.setUsername(userName);
				user.setUserpwd(Encoder.encrypt(password));
				user.setRegIp(regIp);
				user.setQuestion(question);
				user.setAnswer(answer);
				user.setEmail(email);
				UserList ul = new UserList();
				dbo.insert(ul.insert(user));
				dbo.commit();
			} catch (Exception ess) {
				dbo.rollback();
				logger.error(ess.getMessage());
				if (ess.getMessage().indexOf("uplicate") > 0)
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("此用户名已经被注册，请使用其他的用户名注册！")
									.toUTF8String());
				else
					response.sendRedirect("error.jsp?error="
							+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			} finally {
				if (null != dbo)
					dbo.dispose();
			}
			response.sendRedirect("register/userregsuc.html");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("用户注册时发生错误！").toUTF8String());
			return;
		}

	}
}