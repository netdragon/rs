package edu.cup.rs.common;

import java.io.IOException;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.net.URLEncoder;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.log.LogHandler;

public class ExportFileAction extends BaseAction {

    protected final static LogHandler logger = LogHandler.getInstance(ExportFileAction.class);
    private static int DOWNLOAD_FILE_BUFFER_SIZE = 1000000;
    private HashMap<String,String> hm_env=null;

    public ExportFileAction() {
        super();
    }
    public void init(ServletConfig config)throws ServletException
    { 
        try {
            hm_env=CachedItem.getEnv();
            DOWNLOAD_FILE_BUFFER_SIZE = Integer.parseInt(hm_env.get("DOWNLOAD_FILE_BUFFER_SIZE"));

        }
        catch(Exception e){
            logger.error("init:"+e.getMessage());
        }
    }


    protected void execute(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
            
        try {

            
            String s_FileName = request.getParameter("uuid");
            
            AttachFileService afs=new AttachFileService();
            
            AttachFile attachFile=afs.getFile(s_FileName);
            
            response.setHeader("Content-disposition", "filename=" + attachFile.getName());

            byte[] b_file = new byte[DOWNLOAD_FILE_BUFFER_SIZE];
            FileInputStream fis = new FileInputStream(attachFile.getPath()+"/"+attachFile.getUUID());
            int len = 0;
            OutputStream fileOut=response.getOutputStream();
            while ((len = fis.read(b_file)) > 0)
                fileOut.write(b_file, 0, len);

            fis.close();
            fileOut.close();
            return;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=0001");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        super.doPost(request, response);
    }
}

