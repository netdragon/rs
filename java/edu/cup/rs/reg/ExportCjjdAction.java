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
import edu.cup.rs.util.*;
import jxl.*; 
import jxl.write.*; 

public class ExportCjjdAction extends BaseAction{
    protected static final LogHandler logger=LogHandler.getInstance(ExportCjjdAction.class);
	private static String TEMPLATE = "";
	private static String TEMP = "";
    public ExportCjjdAction() {
        super();
    }
    static {
        HashMap<String,String> hm_env=CachedItem.getEnv();
        TEMPLATE = hm_env.get("RS_HOME").trim() + "\\data\\appfiles\\template\\cjjd_template.xls";
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
			s_tempFileName.append("\\ksbmxx_");
			s_tempFileName.append(tempName);
			s_tempFileName.append(".xls");
			saveExcel(TEMPLATE, s_tempFileName.toString()) ;
            inStream=new FileInputStream(s_tempFileName.toString());
			response.reset();
			response.setContentType("bin");
			response.setHeader("Content-disposition","filename=cjjd"+tempName+".xls");

			byte[] buffer = new byte[2097152]; 
			int i_len; 
			OutputStream fileOut=response.getOutputStream();
			while((i_len=inStream.read(buffer))>0) 
				fileOut.write(buffer,0,i_len); 
			inStream.close();
			File file = new File(s_tempFileName.toString());
			if(file.exists()){
				file.delete();
			}
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
		String bmxxid;
		ArrayList al;
		int colCount_bmxx = 0;
		String columnName, columnValue;
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		ResultSetMetaData rsmd_bmxx = null;
		Workbook workbook = null;
		WritableWorkbook copy = null;
		WritableCellFormat border;
		try{
			dbo.init(false);
		} catch (Exception e) {
			throw e;
		}

       try{
			Label label;
			workbook = Workbook.getWorkbook(new File(template)); 
			copy = Workbook.createWorkbook(new File(fName), workbook); 
			WritableSheet sheet = copy.getSheet(0);
			rs = dbo.query("select ksxm,zxmc,zxtxdz,zxjb,zxybm,zxlxdh,njfzr,gysyw,gyssx,gyswy,gyswl,gyshx,gyssw,gysls,gyszz,gysdl,gysty,gyszf," +
				"gysbjmc,gysbjrs,gysnjmc,gysnjrs,gyxyw, gyxsx,gyxwy,gyxwl,gyxhx,gyxsw,gyxls,gyxzz,gyxdl,gyxty,gyxzf,gyxbjmc,gyxbjrs," +
				"gyxnjmc,gyxnjrs, gesyw, gessx,geswy,geswl,geshx,gessw,gesls,geszz,gesdl,gesty,geszf,gesbjmc,gesbjrs,gesnjmc," + 
				"gesnjrs,gexyw, gexsx,gexwy,gexwl,gexhx,gexsw,gexls,gexzz,gexdl,gexty,gexzf,gexbjmc,gexbjrs,gexnjmc,gexnjrs," +  
				"gssyw, gsssx,gsswy,gsswl,gsshx,gsssw,gssls,gsszz,gssdl,gssty,gsszf,gssbjmc,gssbjrs,gssnjmc,gssnjrs," +
				"hkyw, hksx,hkwy,hkwl,hkhx,hksw,hkls,hkzz,hkdl,hkty,hkzf,hkbjmc,hkbjrs,hknjmc,hknjrs," +
				"zjyw, zjsx,zjwy,zjwl,zjhx,zjsw,zjls,zjzz,zjdl,zjty,zjzf,zjbjmc,zjbjrs,zjnjmc,zjnjrs " +
				"from bmxx a, cjjd b where a.bmxxid=b.bmxxid order by a.bmxxid");
			rsmd_bmxx = rs.getMetaData();
			colCount_bmxx = rsmd_bmxx.getColumnCount();
			int j = 1;
			int k;
			border = new WritableCellFormat();
			border.setBorder(Border.ALL, BorderLineStyle.THIN); 
            while (rs.next()){
				j++;
				k = 0;
				label = new Label(k, j, ""+(j-1), border); 
				sheet.addCell(label);
				k++;
				for (int i = 1; i <= colCount_bmxx; i++){
					columnValue = rs.getString(i);
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
