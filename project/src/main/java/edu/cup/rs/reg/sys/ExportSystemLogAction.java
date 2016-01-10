package edu.cup.rs.reg.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.CachedItem;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.ViewFormat;

public class ExportSystemLogAction extends BaseAction {
	protected static final LogHandler logger = LogHandler
			.getInstance(ExportSystemLogAction.class);

	private static String ROOT = "";

	public ExportSystemLogAction() {
		super();
	}

	static {
		HashMap<String, String> hm_env = CachedItem.getEnv();
		ROOT = hm_env.get("RS_HOME");
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		InputStream inStream = null;
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
			StringBuffer s_tempFileName = new StringBuffer(ROOT);
			String tempName = ViewFormat.longDateTime_NoBlank();
			s_tempFileName.append("//data//log//rs.log");
			inStream = new FileInputStream(s_tempFileName.toString());
			response.reset();
			response.setContentType("bin");
			response.setHeader("Content-disposition", "filename=rs_" + tempName
					+ ".log");

			byte[] buffer = new byte[2097152];
			int i_len;
			OutputStream fileOut = response.getOutputStream();
			while ((i_len = inStream.read(buffer)) > 0)
				fileOut.write(buffer, 0, i_len);
			inStream.close();
			File file = new File(s_tempFileName.toString());
			if (file.exists())
				file.delete();
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error=0000");
			return;
		} finally {
			try {
				if (inStream != null)
					inStream.close();
				response.getOutputStream().close();
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		}
		return;
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
	}
}
