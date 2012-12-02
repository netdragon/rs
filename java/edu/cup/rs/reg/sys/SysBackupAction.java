package edu.cup.rs.reg.sys;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.common.*;
import edu.cup.rs.util.*;


public class SysBackupAction extends BaseAction
{

	protected static final LogHandler logger=LogHandler.getInstance(SysBackupAction.class);
	private static String TEMP = "";
	public SysBackupAction() {
		super();
	}
    static {
        HashMap<String,String> hm_env=CachedItem.getEnv();
        
		TEMP = hm_env.get("RS_TEMP_PATH");
    }
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		InputStream inStream = null;
        try{
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


            try {
				String s;  
				String fName = ViewFormat.longDateTime_NoBlank();;
				Process process = Runtime.getRuntime().exec("d://rs//bin//backup.bat " + fName);  
				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));  
				while((s=bufferedReader.readLine()) != null)  
				System.out.println(s);  
				process.waitFor();
				
				StringBuffer s_tempFileName=new StringBuffer(TEMP);
				s_tempFileName.append("//");
				s_tempFileName.append(fName);
				s_tempFileName.append(".tar");
			
				inStream=new FileInputStream(s_tempFileName.toString());
				response.reset();
				response.setContentType("bin");
				response.setHeader("Content-disposition","filename=backup_"+fName+".tar");

				byte[] buffer = new byte[2097152]; 
				int i_len; 
				OutputStream fileOut=response.getOutputStream();
				while((i_len=inStream.read(buffer))>0) 
					fileOut.write(buffer,0,i_len); 
				inStream.close();
				File file = new File(s_tempFileName.toString());
				if(file.exists()) file.delete();
            } catch (Exception ess) {
                logger.error(ess.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据访问错误！").toUTF8String());
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
        } catch(Exception e)
        {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=" + new UTF8String("发生错误！").toUTF8String());
            return;
        }

    }
 }

