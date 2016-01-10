package edu.cup.rs.common;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.HashMap;
import java.util.UUID;

import edu.cup.rs.log.LogHandler;

public class AttachFileService{
    
    private LogHandler logger=LogHandler.getInstance(AttachFileService.class);
    private static String APP_ATTACH_FILE_PATH=null;
    
    private DBOperator dbo=null;
    static {
        HashMap<String,String> hm_env=CachedItem.getEnv();
        APP_ATTACH_FILE_PATH=hm_env.get("RS_HOME").trim() + "/data/appfiles/files/attach_files";
    }
    public AttachFileService(){
        try{
            this.dbo=new DBOperator();
            this.dbo.init(false);
        }
        catch(Exception e){
            logger.error("AttachFileService():"+e.getMessage());
        }
    }
    public void commit(){
		try{
			if(null!=dbo){
				dbo.commit();
				dbo.dispose();
			}
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
    }
    public void rollback(){
        if(null!=dbo){
            dbo.rollback();
            dbo.dispose();
        }
    }
    public AttachFile getFile(String uuid){
        ResultSet rs=null;
        try{
            Connection conn=dbo.getConnection();
            PreparedStatement pst=conn.prepareStatement("select * from attach_file where uuid=?");
            
            pst.setString(1,uuid);
            rs =pst.executeQuery();
            if(rs.next()){
                AttachFile attachFile=new AttachFile(rs.getString("name"),rs.getString("type"),uuid,APP_ATTACH_FILE_PATH+rs.getString("path"),rs.getString("catalog"),rs.getLong("size"));
                return attachFile;
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            logger.error("getFile():"+e.getMessage());
            return null;
        }
        finally{
            
            try{
                if(null!=rs) rs.close();
            }catch(Exception e){
                logger.error("getFile();"+e.getMessage());
            }
            if(null!=dbo) dbo.dispose();
        }
    }
    public AttachFile addFile(String name,String type,String catalog,long size){
        Calendar c=Calendar.getInstance();
        String uuid = UUID.randomUUID().toString();
        int year=c.get(Calendar.YEAR);
        int month=c.get(Calendar.MONTH)+1;
        try{
            String path="/"+year+"/"+month;

            File dir=new File(APP_ATTACH_FILE_PATH+"/"+year);
            if(!dir.exists()){
                dir.mkdir();
            }
            dir=new File(APP_ATTACH_FILE_PATH+path);
            if(!dir.exists()){
                dir.mkdir();
            }
            
            Connection conn=dbo.getConnection();
            
            PreparedStatement pst=conn.prepareStatement("insert into attach_file(catalog,type,uuid,path,name,size,create_time) values(?,?,?,?,?,?,now())");
            
            pst.setString(1,catalog);
            pst.setString(2,type);
            pst.setString(3,uuid);
            pst.setString(4,path);
            pst.setString(5,name);
            pst.setLong(6,size);
            
            pst.executeUpdate();
            
            AttachFile attachFile=new AttachFile(name,type,uuid,path,catalog,size);
            return attachFile;
        }
        catch(Exception e){
            logger.error("addFile():"+e.getMessage());
            return null;
        }
    }
    
}


