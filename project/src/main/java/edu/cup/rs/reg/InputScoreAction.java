package edu.cup.rs.reg;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.CachedItem;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.reg.sys.Kemu;
import edu.cup.rs.reg.sys.KemuList;

public class InputScoreAction extends BaseAction {
	private static int UPLOAD_FILE_MAX_SIZE = 0;
	private static String RS_TEMP_PATH = null;
	private static final long serialVersionUID = 1L;
	protected static final LogHandler logger = LogHandler
			.getInstance(InputScoreAction.class);

	public InputScoreAction() {
		super();
	}

	static {
		HashMap<String, String> hm_env = CachedItem.getEnv();
		RS_TEMP_PATH = hm_env.get("RS_TEMP_PATH").trim();

		UPLOAD_FILE_MAX_SIZE = Integer.parseInt(hm_env
				.get("UPLOAD_FILE_MAX_SIZE"));
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String xslScore, zhkzh, xslKmName;
		Score score;
		Kemu km;
		Bmxx bmxx;
		BmxxList bl;
		KemuList kl;
		int kmid = 0, bmxxid = 0;
		InputStream is = null;
		ArrayList al;
		boolean isMultipart = false;
		if (request != null) {
			isMultipart = ServletFileUpload.isMultipartContent(request);
		}
		if (!isMultipart) {
			logger.error("No input data!");
			response.sendRedirect("error.jsp?error=0788");
			return;
		}
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

			DiskFileItemFactory factory = new DiskFileItemFactory();

			File tmpDir = new File(RS_TEMP_PATH);
			if (tmpDir.exists() && tmpDir.isDirectory() && tmpDir.canWrite()) {
				factory.setRepository(tmpDir);
			}

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(UPLOAD_FILE_MAX_SIZE);

			logger.info("Begin to parse request.");
			List items = upload.parseRequest(request);

			Iterator iter = items.iterator();
			String fieldName;
			String s_FileName;
			File uploadedFile = new File(RS_TEMP_PATH + File.separator
					+ UUID.randomUUID().toString());
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				fieldName = item.getFieldName();
				if ("scorefile".equals(fieldName)) {
					s_FileName = item.getName();
					if (null == s_FileName)
						throw new Exception("附件数据错误！");
					if (s_FileName.indexOf("\\") > -1)
						s_FileName = s_FileName.substring(s_FileName
								.lastIndexOf("\\") + 1);
					long sizeInBytes = item.getSize();
					logger.info(fieldName + ":" + s_FileName + ":"
							+ sizeInBytes);
					if (s_FileName.length() > 3) {
						try {
							item.write(uploadedFile);
						} catch (Exception e) {
							throw e;
						}
					}
					break;
				}
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

				is = new FileInputStream(uploadedFile);
				Workbook rwb = Workbook.getWorkbook(is);
				Sheet sheet = rwb.getSheet(0);

				int all_cells = sheet.getColumns();
				HashMap<String, String> hmKm = new HashMap<String, String>();

				for (int j = 8; j < all_cells; j++) {
					xslKmName = sheet.getCell(j, 1).getContents().trim();
					logger.debug(j + "科目:" + xslKmName);
					// get kmid by kemu
					kl = new KemuList();
					al = dbo.getQueryList(kl.getByKemuName(xslKmName), kl);
					if (al.size() == 1) {
						km = (Kemu) al.get(0);
						kmid = km.getKmid();
						hmKm.put(j + "", kmid + "");
					} else {
						logger.error("Can not find:" + kmid);
						response.sendRedirect("/error.jsp?error="
								+ new UTF8String("科目名称错误！").toUTF8String());
						return;
					}
				}
				ScoreList sl = new ScoreList();
				dbo.delete(sl.deleteAll());
				for (int i = 2; i < sheet.getRows(); i++) {
					zhkzh = sheet.getCell(1, i).getContents().trim();
					// get bmxxid by zhkzh
					bl = new BmxxList();
					al = dbo.getQueryList(bl.getByZhkzh(zhkzh), bl);
					if (al.size() == 1) {
						bmxx = (Bmxx) al.get(0);
						bmxxid = bmxx.getBmxxid();
					} else {
						logger.error("Can not find:" + zhkzh);
						response.sendRedirect("/error.jsp?error="
								+ new UTF8String("没有该考生或数据发生错误！")
										.toUTF8String());
						return;
					}
					for (int j = 8; j < all_cells; j++) {
						xslScore = sheet.getCell(j, i).getContents().trim();

						score = new Score();
						score.setKmid(Integer.parseInt(((String) hmKm.get(j
								+ ""))));
						score.setBmxxid(bmxxid);
						score.setFenshu(xslScore);
						score.setLrcjsj(new Date());
						dbo.insert(sl.insert(score));
					}
				}
				ICommonList logslist;
				Log log = new Log();
				logslist = new LogsList();
				log.setContent(USERNAME + " 导入考生分数。");
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
				try {
					if (null != is)
						is.close();
				} catch (Exception e) {
					logger.error(e.getStackTrace()[0].toString());
				}
			}
			response.sendRedirect("admin/lrlq.jsp");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("发生错误！").toUTF8String());
			return;
		}
	}
}
