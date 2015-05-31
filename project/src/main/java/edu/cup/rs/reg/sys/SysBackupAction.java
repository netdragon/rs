package edu.cup.rs.reg.sys;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.CachedItem;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.reg.Log;
import edu.cup.rs.reg.LogsList;
import edu.cup.rs.util.ViewFormat;

public class SysBackupAction extends BaseAction {

	protected static final LogHandler logger = LogHandler
			.getInstance(SysBackupAction.class);
	private static String TEMP = "";

	public SysBackupAction() {
		super();
	}

	static {
		HashMap<String, String> hm_env = CachedItem.getEnv();

		TEMP = hm_env.get("RS_TEMP_PATH");
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		InputStream inStream = null;
		String s;
		String fName = null;
		StringBuffer s_tempFileName = new StringBuffer(TEMP);
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
			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}
			try {

				fName = ViewFormat.longDateTime_NoBlank();
				;
				Process process = Runtime.getRuntime().exec(
						"d://rs//bin//backup.bat " + fName);
				BufferedReader bufferedReader = new BufferedReader(
						new InputStreamReader(process.getInputStream()));
				while ((s = bufferedReader.readLine()) != null)
					logger.info(s);
				process.waitFor();

				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 进行了系统备份。");
				dbo.insert(logslist.insert(log));
				dbo.commit();

				s_tempFileName.append("//");
				s_tempFileName.append(fName);
				s_tempFileName.append(".tar");

				inStream = new FileInputStream(s_tempFileName.toString());
				response.reset();
				response.setContentType("application/x-tar");
				response.setHeader("Content-disposition", "filename=backup_"
						+ fName + ".tar");

				byte[] buffer = new byte[2097152];
				int i_len;
				OutputStream fileOut = response.getOutputStream();
				while ((i_len = inStream.read(buffer)) > 0)
					fileOut.write(buffer, 0, i_len);

			} catch (Exception ess) {
				dbo.rollback();
				logger.error(ess.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据访问错误！").toUTF8String());
				return;
			} finally {
				if (null != dbo)
					dbo.dispose();
				try {
					if (inStream != null)
						inStream.close();
					response.getOutputStream().close();
				} catch (Exception e) {
					logger.error(e.getMessage());
				} finally {
					File file = new File(s_tempFileName.toString());
					if (file.exists())
						file.delete();
					file = new File(TEMP + "//" + fName);
					if (file.exists())
						FileUtils.deleteDirectory(file);
				}
			}
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}
	}
}
