package edu.cup.rs.reg;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import edu.cup.rs.common.AttachFile;
import edu.cup.rs.common.AttachFileService;
import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.CachedItem;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class AddBmxxAction extends BaseAction
{
	private static String RS_HOME=null;
    private final static String APP_ATTACH_FILE_PATH="/data/appfiles/files/attach_files";
    private static int UPLOAD_FILE_MAX_SIZE = 0;
    private static int UPLOAD_MEMERY_FILE_SIZE=0;
    private static String RS_TEMP_PATH=null;
	protected static final LogHandler logger=LogHandler.getInstance(AddBmxxAction.class);
	public AddBmxxAction() {
		super();
	}
	static {
        HashMap<String,String> hm_env=CachedItem.getEnv();
        RS_HOME = hm_env.get("RS_HOME").trim();
        RS_TEMP_PATH=hm_env.get("RS_TEMP_PATH").trim();

        UPLOAD_FILE_MAX_SIZE=Integer.parseInt(hm_env.get("UPLOAD_FILE_MAX_SIZE"));
        UPLOAD_MEMERY_FILE_SIZE=Integer.parseInt(hm_env.get("UPLOAD_MEMERY_FILE_SIZE"));
	}

	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
    		String userId = (String)session.getAttribute("user_id");
    		if(null == userId){
                logger.error("没有登录!");
                response.sendRedirect("/error.jsp?error=" + new UTF8String("请先登录!").toUTF8String());
    			return;
    		}
			String bmxxId = (String)session.getAttribute("bmxxid");

            boolean isMultipart=false;
            if(request != null){
                isMultipart = ServletFileUpload.isMultipartContent(request);
            }
            if(!isMultipart){
                logger.error("No input data!");
                response.sendRedirect("error.jsp?error=0788");
                return;
            }
			/*
			
			*/
            String ksShfzh = "";
            String ksName = "";
            String ksXb= "";
			String ksWyyz= "";   //外语语种            
			String ksJg= "";
            String zzmm = "";
            String mz = "";		
            String ksZxmc= "";  //中学名称
            String ksKl= "";  //考生科类			
        	String ksTxdzh =  "";
        	String ksYzbm =  "";
        	String ksShxr =  "";
			String ksYddh = "";
			
        	String ksFmname = "";
        	String ksFmdw = "";
        	String ksFmzw = "";
        	String ksFmShji =  "";
        	String ksMmname = "";
        	String ksMmdw = "";
        	String ksMmzw = "";
        	String ksMmShji =  "";     
   			
            String pzhiyuan1 = "";
            String pzhiyuan2 = "";
            String pzhiyuan3 = "";
            String pzhiyuan4 = "";
            String pzhiyuan5 = "";
            String pzhiyuan6 = "";
            String pzhiyuan7 = "";
            String pzhiyuan8 = "";
            String ksSftj= "";
            String ksAhtc= "";  //    考生爱好特长			
            String ksSqly= "";  //   申请理由
			

 
            String ksJlzy1= "";
            String ksJlzm1= "";
            String ksJlmc1= "";  //获奖名称
            String ksJljb1= "";  //竞赛级别
            String ksJldj1= "";  //获奖等级
            String ksJlbm1= "";  //授奖部门
			
            String ksJlzy2= "";
            String ksJlzm2= "";
            String ksJlmc2= "";  
            String ksJljb2= "";  
            String ksJldj2= "";  
            String ksJlbm2= "";  
			
            String ksJlzy3= "";
            String ksJlzm3= "";
            String ksJlmc3= "";  
            String ksJljb3= "";  
            String ksJldj3= "";  
            String ksJlbm3= "";  

            String ksShzy1= "";
            String ksShzm1= "";
            String ksShmc1= "";  //参加的社会活动名称
            String ksShjs1= "";  //本人在活动中的角色

            String ksShzy2= "";
            String ksShzm2= "";
            String ksShmc2= "";  
            String ksShjs2= "";  

            String ksShzy3= "";
            String ksShzm3= "";
            String ksShmc3= "";  
            String ksShjs3= "";  
			


            String s_imgID = "";
			boolean hasPhoto = false;
			String fieldName;
			AttachFileService afs = null;
			String s_FileName;
			
            DiskFileItemFactory factory = new DiskFileItemFactory();

            File tmpDir = new File(RS_TEMP_PATH);
            if (tmpDir.exists() && tmpDir.isDirectory() && tmpDir.canWrite()) {
                factory.setRepository(tmpDir);
            }

            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(UPLOAD_FILE_MAX_SIZE);

//          Parse the request
            logger.info("Begin to parse request.");
            List items = upload.parseRequest(request);
            logger.info("Parse request successfully.");

            Iterator iter = items.iterator();

            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (item.isFormField()) {
                	if("pidcardnum".equals(item.getFieldName())) ksShfzh = item.getString("UTF-8");
                	
                	if("pname".equals(item.getFieldName())) ksName = item.getString("UTF-8");
                	if("pxb".equals(item.getFieldName())) ksXb = item.getString("UTF-8");
                	if("pwyyz".equals(item.getFieldName())) ksWyyz = item.getString("UTF-8");
                	if("pjg".equals(item.getFieldName())) ksJg = item.getString("UTF-8");
                	if("pminzu".equals(item.getFieldName())) mz = item.getString("UTF-8");
                	if("pzzmm".equals(item.getFieldName())) zzmm = item.getString("UTF-8");
                	if("psqly".equals(item.getFieldName())) ksSqly = item.getString("UTF-8");
					
                	if("pzxmc".equals(item.getFieldName())) ksZxmc = item.getString("UTF-8");
                	if("pkskl".equals(item.getFieldName())) ksKl = item.getString("UTF-8");					
                	if("ptxdzh".equals(item.getFieldName())) ksTxdzh = item.getString("UTF-8");
                	if("pyzbm".equals(item.getFieldName())) ksYzbm = item.getString("UTF-8");
                	if("pshxr".equals(item.getFieldName())) ksShxr = item.getString("UTF-8");
                	if("pyddh".equals(item.getFieldName())) ksYddh = item.getString("UTF-8");
					
                	if("pfmxm".equals(item.getFieldName())) ksFmname = item.getString("UTF-8");					
                	if("fmgzdw".equals(item.getFieldName())) ksFmdw = item.getString("UTF-8");
                	if("fmgzzw".equals(item.getFieldName())) ksFmzw = item.getString("UTF-8");					
                	if("fmyddh".equals(item.getFieldName())) ksFmShji = item.getString("UTF-8");
					if("pmmxm".equals(item.getFieldName())) ksMmname = item.getString("UTF-8");					
                	if("mmgzdw".equals(item.getFieldName())) ksMmdw = item.getString("UTF-8");
                	if("mmgzzw".equals(item.getFieldName())) ksMmzw = item.getString("UTF-8");
                	if("mmyddh".equals(item.getFieldName())) ksMmShji = item.getString("UTF-8");

                	if("pzhiyuan1".equals(item.getFieldName())) pzhiyuan1 = item.getString("UTF-8");
                	if("pzhiyuan2".equals(item.getFieldName())) pzhiyuan2 = item.getString("UTF-8");					
                	if("pzhiyuan3".equals(item.getFieldName())) pzhiyuan3 = item.getString("UTF-8");
                	if("pzhiyuan4".equals(item.getFieldName())) pzhiyuan4 = item.getString("UTF-8");
                	if("pzhiyuan5".equals(item.getFieldName())) pzhiyuan5 = item.getString("UTF-8");
                	if("pzhiyuan6".equals(item.getFieldName())) pzhiyuan6 = item.getString("UTF-8");
                	if("pzhiyuan7".equals(item.getFieldName())) pzhiyuan7 = item.getString("UTF-8");
                	if("pzhiyuan8".equals(item.getFieldName())) pzhiyuan8 = item.getString("UTF-8");
                	if("psftj".equals(item.getFieldName())) ksSftj = item.getString("UTF-8");
					
                	if("pksah".equals(item.getFieldName())) ksAhtc = item.getString("UTF-8");

					
                	if("pzhenian1".equals(item.getFieldName())) ksJlzy1 = item.getString("UTF-8");
                	if("pzheyue1".equals(item.getFieldName())) ksJlzm1 = item.getString("UTF-8");					
                	if("phjmc1".equals(item.getFieldName())) ksJlmc1 = item.getString("UTF-8");
                	if("pjsjb1".equals(item.getFieldName())) ksJljb1 = item.getString("UTF-8");
                 	if("phjdj1".equals(item.getFieldName())) ksJldj1 = item.getString("UTF-8");
                	if("psjbm1".equals(item.getFieldName())) ksJlbm1 = item.getString("UTF-8");	

                	if("pzhenian2".equals(item.getFieldName())) ksJlzy2 = item.getString("UTF-8");
                	if("pzheyue2".equals(item.getFieldName())) ksJlzm2 = item.getString("UTF-8");					
                	if("phjmc2".equals(item.getFieldName())) ksJlmc2 = item.getString("UTF-8");
                	if("pjsjb2".equals(item.getFieldName())) ksJljb2 = item.getString("UTF-8");
                 	if("phjdj2".equals(item.getFieldName())) ksJldj2 = item.getString("UTF-8");
                	if("psjbm2".equals(item.getFieldName())) ksJlbm2 = item.getString("UTF-8");	

                	if("pzhenian3".equals(item.getFieldName())) ksJlzy3 = item.getString("UTF-8");
                	if("pzheyue3".equals(item.getFieldName())) ksJlzm3 = item.getString("UTF-8");					
                	if("phjmc3".equals(item.getFieldName())) ksJlmc3 = item.getString("UTF-8");
                	if("pjsjb3".equals(item.getFieldName())) ksJljb3 = item.getString("UTF-8");
                 	if("phjdj3".equals(item.getFieldName())) ksJldj3 = item.getString("UTF-8");
                	if("psjbm3".equals(item.getFieldName())) ksJlbm3 = item.getString("UTF-8");	
					

                	if("phdn1".equals(item.getFieldName())) ksShzy1 = item.getString("UTF-8");
                	if("phdy1".equals(item.getFieldName())) ksShzm1 = item.getString("UTF-8");
                	if("phdmc1".equals(item.getFieldName())) ksShmc1 = item.getString("UTF-8");
                	if("phdjs1".equals(item.getFieldName())) ksShjs1 = item.getString("UTF-8");
                	if("phdn2".equals(item.getFieldName())) ksShzy2 = item.getString("UTF-8");
                	if("phdy2".equals(item.getFieldName())) ksShzm2 = item.getString("UTF-8");
                	if("phdmc2".equals(item.getFieldName())) ksShmc2 = item.getString("UTF-8");
                	if("phdjs2".equals(item.getFieldName())) ksShjs2 = item.getString("UTF-8");                	
					if("phdn3".equals(item.getFieldName())) ksShzy3 = item.getString("UTF-8");
                	if("phdy3".equals(item.getFieldName())) ksShzm3 = item.getString("UTF-8");
                	if("phdmc3".equals(item.getFieldName())) ksShmc3 = item.getString("UTF-8");
                	if("phdjs3".equals(item.getFieldName())) ksShjs3 = item.getString("UTF-8");                	


                } else {

					fieldName = item.getFieldName();
                    if("perphoto".equals(fieldName)){

						s_FileName = item.getName();
						if(null == s_FileName) throw new Exception("照片数据错误！");
                        if(s_FileName.indexOf("\\")>-1) s_FileName=s_FileName.substring(s_FileName.lastIndexOf("\\")+1);
                        long sizeInBytes = item.getSize();
                        logger.info(fieldName+":"+s_FileName+":"+sizeInBytes);
                        if(s_FileName.length()>3) {
							hasPhoto = true;
							
							try{
								afs=new AttachFileService();
								AttachFile attachFile=afs.addFile(s_FileName,"img","person",sizeInBytes);
								s_imgID=attachFile.getUUID();
								File uploadedFile = new File(RS_HOME + APP_ATTACH_FILE_PATH+attachFile.getPath()+"/"+attachFile.getUUID());
								item.write(uploadedFile);
								afs.commit();
							}catch(Exception e){
								if(null != afs) afs.rollback();
								throw e;
							}
						}
                    }
                }
            }


            if(0==ksShfzh.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("身份证号不能为空!").toUTF8String());
                return;
            }

            if(0==ksName.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("姓名不能为空!").toUTF8String());
                return;
            }
            if(0==ksYddh.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("联系电话不能为空!").toUTF8String());
                return;
            }
            
            if(0==ksTxdzh.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("通信地址不能为空!").toUTF8String());
                return;
            }
            if(0==ksYzbm.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("邮政编码不能为空!").toUTF8String());
                return;
            }
            if(0==ksShxr.length())
            {
                response.sendRedirect("error.jsp?error="+new UTF8String("收信人不能为空!").toUTF8String());
                return;
            }
			hasPhoto = false;
			if(!hasPhoto && (null == bmxxId)){
			    //response.sendRedirect("error.jsp?error="+new UTF8String("请添加照片!").toUTF8String());
                //return;
            }
            DBOperator dbo=new DBOperator();
            ICommonList icl;
            Bmxx bmxx;
            SimpleDateFormat sdf;
            Hjqk hjqk1,hjqk2,hjqk3;
			Hdqk grhd1, grhd2, grhd3;
            Date zhs1,zhs2,zhs3, hds1, hds2, hds3;
            Bkzy bkzy1, bkzy2, bkzy3, bkzy4, bkzy5, bkzy6, bkzy7, bkzy8;
            int seqKey=0;
            try {
                dbo.init(false);
            } catch (Exception e2) {
                logger.error(e2.getMessage());
                response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }

            try {
            	sdf = new SimpleDateFormat("yyyy-MM-dd");
				if((null == ksJlzy1) || (ksJlzy1.length() == 0)) {
					zhs1 = null;
            	} else if((null == ksJlzm1) || (ksJlzm1.length() == 0)) {
					zhs1 = sdf.parse(ksJlzy1+"-1-1");
				}
				else 
					zhs1 = sdf.parse(ksJlzy1+"-"+ksJlzm1+"-1");
				if((null == ksJlzy2) || (ksJlzy2.length() == 0)) {
					zhs2 = null;
            	} else if((null == ksJlzm2) || (ksJlzm2.length() == 0)) {
					zhs2 = sdf.parse(ksJlzy2+"-1-1");
				}
				else 
					zhs2 = sdf.parse(ksJlzy2+"-"+ksJlzm2+"-1");
				if((null == ksJlzy3) || (ksJlzy3.length() == 0)) {
					zhs3 = null;
            	} else if((null == ksJlzm3) || (ksJlzm3.length() == 0)) {
					zhs3 = sdf.parse(ksJlzy3+"-1-1");
				}
				else 
					zhs3 = sdf.parse(ksJlzy3+"-"+ksJlzm3+"-1");
				if((null == ksShzy1) || (ksShzy1.length() == 0)) {
					hds1 = null;
            	} else if((null == ksShzm1) || (ksShzm1.length() == 0)) {
					hds1 = sdf.parse(ksShzy1+"-1-1");
				}
				else 
					hds1 = sdf.parse(ksShzy1+"-"+ksShzm1+"-1");
				if((null == ksShzy2) || (ksShzy2.length() == 0)) {
					hds2 = null;
            	} else if((null == ksShzm2) || (ksShzm2.length() == 0)) {
					hds2 = sdf.parse(ksShzy2+"-1-1");
				}
				else 
					hds2 = sdf.parse(ksShzy2+"-"+ksShzm2+"-1");
				if((null == ksShzy3) || (ksShzy3.length() == 0)) {
					hds3 = null;
            	} else if((null == ksShzm3) || (ksShzm3.length() == 0)) {
					hds3 = sdf.parse(ksShzy3+"-1-1");
				}
				else 
					hds3 = sdf.parse(ksShzy3+"-"+ksShzm3+"-1");
				
				
                bmxx = new Bmxx();
                icl = new BmxxList();


                bmxx.setUserid(Integer.parseInt(userId));
                bmxx.setKsxm(ksName);
                bmxx.setKsxb(Integer.parseInt(ksXb));
                bmxx.setWyyz(ksWyyz);
                bmxx.setJg(ksJg);
                bmxx.setZzmm(zzmm);
                bmxx.setMz(mz); 
                bmxx.setZxmc(ksZxmc);
                bmxx.setKskl(ksKl);
                bmxx.setShfzh(ksShfzh);
                bmxx.setTxdz(ksTxdzh);
                bmxx.setYzbm(ksYzbm);
                bmxx.setShxr(ksShxr); 
                bmxx.setKsshji(ksYddh);

			    bmxx.setFmxm(ksFmname);
                bmxx.setFmgzdw(ksFmdw);
                bmxx.setFmyddh(ksFmShji);
                bmxx.setFmzw(ksFmzw);				
				bmxx.setMmxm(ksMmname);
                bmxx.setMmgzdw(ksMmdw);
                bmxx.setMmyddh(ksMmShji);
                bmxx.setMmzw(ksMmzw);
                bmxx.setKsah(ksAhtc);
                bmxx.setSqly(ksSqly);				

				if(hasPhoto)
					bmxx.setKszp(s_imgID);
				else
					bmxx.setKszp(null);

				if(null != bmxxId){
					bmxx.setBmxxid(Integer.parseInt(bmxxId));
					dbo.update(icl.update(bmxx));
					seqKey = bmxx.getBmxxid();
				}
				else {
		            dbo.insert(icl.insert(bmxx));
					seqKey = dbo.getLastInsertId();		
				}

            	hjqk1 = new Hjqk();  //高中获奖情况
            	hjqk1.setBmxxid(seqKey);
            	hjqk1.setHjsj(zhs1); 
            	hjqk1.setHjmc(ksJlmc1);
            	hjqk1.setJsjb(ksJljb1);
            	hjqk1.setHjdj(ksJldj1);
            	hjqk1.setSjbm(ksJlbm1);
	
            	hjqk2 = new Hjqk();
            	hjqk2.setBmxxid(seqKey);
            	hjqk2.setHjsj(zhs2); 
            	hjqk2.setHjmc(ksJlmc2);
            	hjqk2.setJsjb(ksJljb2);
            	hjqk2.setHjdj(ksJldj2);
            	hjqk2.setSjbm(ksJlbm2);
	
            	hjqk3 = new Hjqk();
            	hjqk3.setBmxxid(seqKey);
             	hjqk3.setHjsj(zhs3); 
            	hjqk3.setHjmc(ksJlmc3);
            	hjqk3.setJsjb(ksJljb3);
            	hjqk3.setHjdj(ksJldj3);
            	hjqk3.setSjbm(ksJlbm3);

				grhd1 = new Hdqk();    //参加社会活动1
            	grhd1.setBmxxid(seqKey);
            	grhd1.setHdsj(hds1); 
            	grhd1.setHdmc(ksShmc1);
            	grhd1.setBrjsgx(ksShjs1);
	
				grhd2 = new Hdqk();    //参加社会活动2
            	grhd2.setBmxxid(seqKey);
            	grhd2.setHdsj(hds2); 
            	grhd2.setHdmc(ksShmc2);
            	grhd2.setBrjsgx(ksShjs2);
				grhd3 = new Hdqk();    //参加社会活动3
            	grhd3.setBmxxid(seqKey);
            	grhd3.setHdsj(hds3); 
            	grhd3.setHdmc(ksShmc3);
            	grhd3.setBrjsgx(ksShjs3);
	
            	bkzy1 = new Bkzy();
                bkzy1.setBmxxid(seqKey);
                bkzy1.setZyid(Integer.parseInt(pzhiyuan1));
                bkzy1.setTjf(1);
				bkzy1.setXh(1);
                bkzy2 = new Bkzy();
                bkzy2.setBmxxid(seqKey);
                bkzy2.setZyid(Integer.parseInt(pzhiyuan2));
                bkzy2.setTjf(1);
				bkzy2.setXh(2);

            	bkzy3 = new Bkzy();   //报考专业志愿3
                bkzy3.setBmxxid(seqKey);
                bkzy3.setZyid(Integer.parseInt(pzhiyuan3));
                bkzy3.setTjf(1);
				bkzy3.setXh(3);
            	bkzy4 = new Bkzy();
                bkzy4.setBmxxid(seqKey);
                bkzy4.setZyid(Integer.parseInt(pzhiyuan4));
                bkzy4.setTjf(1);
				bkzy4.setXh(4);
            	bkzy5 = new Bkzy();
                bkzy5.setBmxxid(seqKey);
                bkzy5.setZyid(Integer.parseInt(pzhiyuan5));
                bkzy5.setTjf(1);
				bkzy5.setXh(5);
            	bkzy6 = new Bkzy();
                bkzy6.setBmxxid(seqKey);
                bkzy6.setZyid(Integer.parseInt(pzhiyuan6));
                bkzy6.setTjf(1);
				bkzy6.setXh(6);
            	bkzy7 = new Bkzy();
                bkzy7.setBmxxid(seqKey);
                bkzy7.setZyid(Integer.parseInt(pzhiyuan7));
                bkzy7.setTjf(1);
				bkzy7.setXh(7);
            	bkzy8 = new Bkzy();
                bkzy8.setBmxxid(seqKey);
                bkzy8.setZyid(Integer.parseInt(pzhiyuan8));
                bkzy8.setTjf(1);
				bkzy8.setXh(8);

				
                icl = new HjqkList(seqKey);
				if(null != bmxxId){
					dbo.delete(icl.delete(null));
				}

				dbo.insert(icl.insert(hjqk1));
				dbo.insert(icl.insert(hjqk2));
				dbo.insert(icl.insert(hjqk3));

                icl = new HdqkList(seqKey);
				if(null != bmxxId){
					dbo.delete(icl.delete(null));
				}

				dbo.insert(icl.insert(grhd1));
				dbo.insert(icl.insert(grhd2));
				dbo.insert(icl.insert(grhd3));
			
                icl = new BkzyList(seqKey);
				if(null != bmxxId){
					dbo.delete(icl.delete(null));
				}
				dbo.insert(icl.insert(bkzy1));
				dbo.insert(icl.insert(bkzy2));
				dbo.insert(icl.insert(bkzy3));
				dbo.insert(icl.insert(bkzy4));
				dbo.insert(icl.insert(bkzy5));
				dbo.insert(icl.insert(bkzy6));
				dbo.insert(icl.insert(bkzy7));
				dbo.insert(icl.insert(bkzy8));
				
				Log log = new Log();
				icl = new LogsList();
				log.setContent(USERNAME + " 填写报名表。");
				dbo.insert(icl.insert(log));
                
				dbo.commit();
				
				session.setAttribute("bmxxid" , ""+seqKey);
            } catch (Exception ess) {
                dbo.rollback();
                logger.error(ess.getMessage());
				if(ess.getMessage().indexOf("uplicate") > 0)
					response.sendRedirect("error.jsp?error=" + new UTF8String("此身份证已经报过名了！不能再用此身份证报名").toUTF8String());
				else
					response.sendRedirect("error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
                return;
            }
            finally{
                if(null!=dbo) dbo.dispose();
            }
            response.sendRedirect("loginin/saveok.html");
            return;
        }
        catch(Exception e)
        {
            logger.error(e.getMessage());
            response.sendRedirect("error.jsp?error=" + new UTF8String("用户报名时发生错误！").toUTF8String());
            return;
        }
    }
 }
