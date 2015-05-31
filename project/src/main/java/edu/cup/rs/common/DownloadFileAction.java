package edu.cup.rs.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.log.LogHandler;

public class DownloadFileAction extends BaseAction {


    protected final static LogHandler logger = LogHandler.getInstance(DownloadFileAction.class);
    private static String AUNM_DATA_PATH = null;
    private static int DOWNLOAD_FILE_BUFFER_SIZE = 0;



    public DownloadFileAction() {
        super();
    }



    protected void execute(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {

            HashMap<String,String> hm_env=CachedItem.getEnv();

            AUNM_DATA_PATH = hm_env.get("AUNM_DATA_PATH");

            DOWNLOAD_FILE_BUFFER_SIZE = Integer.parseInt(hm_env.get("DOWNLOAD_FILE_BUFFER_SIZE"));

            String s_FilePath = request.getParameter("filepath");
            String s_FileName = request.getParameter("filename");
            s_FileName = new String(s_FileName.getBytes("iso8859-1"), "utf-8");
            String s_OriginalFileName = "original_" + s_FileName;
            //logger.info(s_FileName);
            response.setContentType("application/octet-stream;");
            s_FileName = URLEncoder.encode(s_FileName,"utf-8");
            s_FileName = s_FileName.replace(" ", "%20");
            response.setHeader("Content-disposition", "filename=" + s_FileName);

            byte[] b_file = new byte[DOWNLOAD_FILE_BUFFER_SIZE];
            FileInputStream fis = new FileInputStream(AUNM_DATA_PATH + s_FilePath + s_OriginalFileName);
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

