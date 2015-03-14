package edu.cup.rs.reg;

import java.util.*;
import javax.servlet.ServletException;
import java.io.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.text.*;
import edu.cup.rs.common.*;
import edu.cup.rs.log.*;
import edu.cup.rs.reg.sys.*;
import edu.cup.rs.util.*;
import jxl.*; 
import jxl.write.*; 

public class ExportExamResultAction extends BaseAction{
    protected static final LogHandler logger=LogHandler.getInstance(ExportExamResultAction.class);
	private static String TEMPLATE = "";
	private static String TEMP = "";
    public ExportExamResultAction() {
        super();
    }
    static {
        HashMap<String,String> hm_env=CachedItem.getEnv();
        TEMPLATE = hm_env.get("RS_HOME").trim() + "\\data\\appfiles\\template\\chengji_template.xls";
		TEMP = hm_env.get("RS_TEMP_PATH");
    }
    protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		InputStream inStream = null;
		 try {
    		if(null == USERID){
                logger.error("没有登录!");
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请先登录!").toUTF8String());
    			return;
    		}
			if(!"1".equals(USER_ROLES)) {
                logger.error("您不是管理员，没有权限进入!");
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请先以管理员登录!").toUTF8String());
    			return;
    		}
			StringBuffer s_tempFileName=new StringBuffer(TEMP);
			String tempName = ViewFormat.longDateTime_NoBlank();
			s_tempFileName.append("\\ks_chengji_");
			s_tempFileName.append(tempName);
			s_tempFileName.append(".xls");
			saveExcel(TEMPLATE, s_tempFileName.toString()) ;
            inStream=new FileInputStream(s_tempFileName.toString());
			response.reset();
			response.setContentType("bin");
			response.setHeader("Content-disposition","filename=ks_chengji_"+tempName+".xls");

			byte[] buffer = new byte[2097152]; 
			int i_len; 
			OutputStream fileOut=response.getOutputStream();
			while((i_len=inStream.read(buffer))>0) 
				fileOut.write(buffer,0,i_len);
			inStream.close();
			File file = new File(s_tempFileName.toString());
			if(file.exists()) file.delete();
		}catch(Exception e){
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error=0000");
			return;
		}finally {
			try{
				if(inStream!=null)inStream.close();
				response.getOutputStream().close();                     
			}catch(Exception e){     
				logger.error(e.getMessage());
			}
		}
		return;
    }
	public static void saveExcel(String template, String fName) throws Exception{
		DBOperator dbo=new DBOperator();
		ResultSet rs=null;
		ResultSet rs_grjl=null;
		ResultSet rs_hdqk=null;
		ResultSet rs_bkzy=null, rs_cj=null;
		String bmxxid;
		String zongfen;
		int colCount_bmxx = 0, colCount_grjl = 0, colCount_hdqk =0, tjf = 0;
		String columnName, columnValue;
		HashMap<String, String> hm = new HashMap<String, String>();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		ResultSetMetaData rsmd_bmxx = null, rsmd_hdqk =null, rsmd_grjl = null;
		Workbook workbook = null;
		WritableWorkbook copy = null;
		WritableCellFormat border;
		try{
			dbo.init(false);
		} catch (Exception e) {
			throw e;
		}

       try{
			Kemu km;
			KemuList kl = new KemuList();
			ArrayList alKm = dbo.getList(kl);
			int kmLen = alKm.size();
			Label label;
			zongfen = "0";
			workbook = Workbook.getWorkbook(new File(template)); 
			copy = Workbook.createWorkbook(new File(fName), workbook); 
			WritableSheet sheet = copy.getSheet(0);
			rs = dbo.query("select * from zhshzy");
			while(rs.next()) {
				hm.put(rs.getString("zyid"), rs.getString("zymc")+" ");
			}
			rs = dbo.query("select bmxxid,zhkzhid,ksxm,ksxb,shfzh,jg,kskl,zxmc " +
			" from bmxx where zhkzhid is not null and zhkzhid != 0 order by zhkzhid");
			rsmd_bmxx = rs.getMetaData();
			colCount_bmxx = rsmd_bmxx.getColumnCount();
			int j = 1;
			int k;
			border = new WritableCellFormat();
			border.setBorder(Border.ALL, BorderLineStyle.THIN); 

			for (int i = 0; i < kmLen; i++){
				km = (Kemu) alKm.get(i);
				columnValue = km.getKmmc();
				columnValue = ((null == columnValue) || (columnValue.length() == 0)) ? " " : columnValue;
				label = new Label(8+i, 1, columnValue, border); 
				sheet.addCell(label);
			}

            while (rs.next()){
				j++;
				k = 0;
				label = new Label(k, j, ""+(j-1), border); 
				sheet.addCell(label);
				k++;
				for (int i = 2; i <= colCount_bmxx; i++){
					if("ksxb".equals(rsmd_bmxx.getColumnName(i))) {
						columnValue = (rs.getInt(i) == 1) ? "男" : "女";
					}
					else if("shhqk".equals(rsmd_bmxx.getColumnName(i))) {
						switch(rs.getInt(i)) {
						case -1:
							columnValue = "未通过";
							break;
						case 1:
							columnValue = "通过";
							break;
						default:
							columnValue = "未审";
						}
					}
					else if("bmsj".equals(rsmd_bmxx.getColumnName(i))) {
						columnValue = sf.format(rs.getTimestamp(i));
					}
					else {
						columnValue = rs.getString(i);
					}

					columnValue = ((null == columnValue) || (columnValue.length() == 0)) ? " " : columnValue;
					label = new Label(k, j, columnValue, border); 
					sheet.addCell(label);
					k++;

                }
            }
			copy.write(); 
        }
        catch(Exception e){
            throw e;
        }
		finally{
			if(null != dbo) dbo.dispose();
			if(null != workbook) workbook.close();
			if(null != copy) copy.close(); 
		}
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doPost(request,response);
    }
 }
