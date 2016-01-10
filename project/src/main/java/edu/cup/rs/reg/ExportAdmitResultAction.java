package edu.cup.rs.reg;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.CachedItem;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.ViewFormat;

public class ExportAdmitResultAction extends BaseAction {
	protected static final LogHandler logger = LogHandler
			.getInstance(ExportAdmitResultAction.class);
	private static String TEMPLATE = "";
	private static String TEMP = "";

	public ExportAdmitResultAction() {
		super();
	}

	static {
		HashMap<String, String> hm_env = CachedItem.getEnv();
		TEMPLATE = hm_env.get("RS_HOME").trim()
				+ "\\data\\appfiles\\template\\lq_template.xls";
		TEMP = hm_env.get("RS_TEMP_PATH");
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
			StringBuffer s_tempFileName = new StringBuffer(TEMP);
			String tempName = ViewFormat.longDateTime_NoBlank();
			s_tempFileName.append("\\ks_lq_");
			s_tempFileName.append(tempName);
			s_tempFileName.append(".xls");
			saveExcel(TEMPLATE, s_tempFileName.toString());
			inStream = new FileInputStream(s_tempFileName.toString());
			response.reset();
			response.setContentType("bin");
			response.setHeader("Content-disposition", "filename=ks_lq_"
					+ tempName + ".xls");

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

	public static void saveExcel(String template, String fName)
			throws Exception {
		DBOperator dbo = new DBOperator();
		ResultSet rs = null;
		ResultSet rs_grjl = null;
		ResultSet rs_hdqk = null;
		ResultSet rs_bkzy = null, rs_lq = null, rs_cj = null;
		String bmxxid;

		int colCount_bmxx = 0, colCount_hdqk = 0, colCount_grjl = 0, tjf = 0;
		String columnName, columnValue;
		HashMap<String, String> hm = new HashMap<String, String>();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		ResultSetMetaData rsmd_bmxx = null, rsmd_hdqk = null, rsmd_grjl = null;
		Workbook workbook = null;
		WritableWorkbook copy = null;
		WritableCellFormat border;
		try {
			dbo.init(false);
		} catch (Exception e) {
			throw e;
		}

		try {
			Label label;

			workbook = Workbook.getWorkbook(new File(template));
			copy = Workbook.createWorkbook(new File(fName), workbook);
			WritableSheet sheet = copy.getSheet(0);
			rs = dbo.query("select * from zhshzy");
			while (rs.next()) {
				hm.put(rs.getString("zyid"), rs.getString("zymc") + " ");
			}
			rs = dbo.query("select a.bmxxid,zhkzhid,ksxm,ksxb,shfzh,wyyz,jg,mz,zzmm,kskl,txdz,shxr,yzbm,ksshji,ksah,c.mc as sqly,zxmc,b.zxtxdz,b.zxybm,b.zxlxdh,fmxm,fmgzdw,fmyddh,"
					+ "mmxm,mmgzdw,mmyddh,bmsj from bmxx a left join cjjd b on a.bmxxid=b.bmxxid left join sqbkly c on a.sqly=c.id where zhkzhid is not null and zhkzhid != 0 order by a.bmxxid");
			rsmd_bmxx = rs.getMetaData();
			colCount_bmxx = rsmd_bmxx.getColumnCount();
			int j = 1;
			int k;
			border = new WritableCellFormat();
			border.setBorder(Border.ALL, BorderLineStyle.THIN);
			while (rs.next()) {
				j++;
				k = 0;
				label = new Label(k, j, "" + (j - 1), border);
				sheet.addCell(label);
				k++;
				for (int i = 2; i <= colCount_bmxx; i++) {
					if ("ksxb".equals(rsmd_bmxx.getColumnName(i))) {
						columnValue = (rs.getInt(i) == 1) ? "男" : "女";
					} else if ("shhqk".equals(rsmd_bmxx.getColumnName(i))) {
						switch (rs.getInt(i)) {
						case -1:
							columnValue = "未通过";
							break;
						case 1:
							columnValue = "通过";
							break;
						default:
							columnValue = "未审";
						}
					} else if ("bmsj".equals(rsmd_bmxx.getColumnName(i))) {
						columnValue = sf.format(rs.getTimestamp(i));
					} else {
						columnValue = rs.getString(i);
					}
					columnValue = ((null == columnValue) || (columnValue
							.length() == 0)) ? " " : columnValue;
					label = new Label(k, j, columnValue, border);
					sheet.addCell(label);
					k++;
				}

				bmxxid = rs.getString("bmxxid");
				rs_grjl = dbo
						.query("select hjsj,hjmc,jsjb,hjdj,sjbm from hjqk where bmxxid="
								+ bmxxid);
				if (null == rsmd_grjl) {
					rsmd_grjl = rs_grjl.getMetaData();
					colCount_grjl = rsmd_grjl.getColumnCount();
				}
				while (rs_grjl.next()) {
					for (int i = 1; i <= colCount_grjl; i++) {
						columnValue = rs_grjl.getString(i);
						columnValue = ((null == columnValue) || (columnValue
								.length() == 0)) ? " " : columnValue;
						label = new Label(k, j, columnValue, border);
						sheet.addCell(label);
						k++;
					}
				}

				rs_hdqk = dbo
						.query("select hdsj,hdmc,brjsgx from hdqk where bmxxid="
								+ bmxxid);// 参加社会活动情况
				if (null == rsmd_hdqk) {
					rsmd_hdqk = rs_hdqk.getMetaData();
					colCount_hdqk = rsmd_hdqk.getColumnCount();
				}
				while (rs_hdqk.next()) {
					for (int i = 1; i <= colCount_hdqk; i++) {
						columnValue = rs_hdqk.getString(i);
						columnValue = ((null == columnValue) || (columnValue
								.length() == 0)) ? " " : columnValue;
						label = new Label(k, j, columnValue, border);
						sheet.addCell(label);
						k++;
					}
				}

				rs_bkzy = dbo.query("select zyid,tjf from bkzy where bmxxid="
						+ bmxxid + " order by xh");
				int zy_i = 0;
				while (rs_bkzy.next()) {
					columnValue = rs_bkzy.getString("zyid");
					label = new Label(k, j, hm.get(columnValue), border);
					sheet.addCell(label);
					k++;
					tjf = rs_bkzy.getInt("tjf");
					zy_i++;
				}
				for (int zy_index = zy_i; zy_index < 5; zy_index++) {
					label = new Label(k, j, "", border);
					sheet.addCell(label);
					k++;
				}
				if (tjf == 1)
					columnValue = "是";
				else
					columnValue = "否";
				label = new Label(k, j, columnValue, border);
				sheet.addCell(label);
				k++;

				rs_cj = dbo.query("select fenshu,kmid from score where bmxxid="
						+ bmxxid + " order by kmid");
				while (rs_cj.next()) {
					columnValue = rs_cj.getString("fenshu");
					columnValue = ((null == columnValue) || (columnValue
							.length() == 0)) ? " " : columnValue;
					label = new Label(k, j, columnValue, border);
					sheet.addCell(label);
					k++;
				}

				rs_lq = dbo.query("select sflq,lqzy from bmxx where bmxxid="
						+ bmxxid);
				while (rs_lq.next()) {
					switch (rs_lq.getInt("sflq")) {
					case 1:
						columnValue = "录取";
						break;
					default:
						columnValue = "未录取";
					}
					label = new Label(k, j, columnValue, border);
					sheet.addCell(label);
					k++;
					columnValue = rs_lq.getString("lqzy");
					columnValue = ((null == columnValue) || (columnValue
							.length() == 0)) ? " " : columnValue;
					label = new Label(k, j, columnValue, border);
					sheet.addCell(label);
					k++;
				}
			}
			copy.write();
		} catch (Exception e) {
			throw e;
		} finally {
			if (null != dbo)
				dbo.dispose();
			if (null != workbook)
				workbook.close();
			if (null != copy)
				copy.close();
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
	}
}
