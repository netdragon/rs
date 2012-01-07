package edu.cup.rs.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.ResultSet;
import java.util.Properties;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.util.PropertyAdapter;


public class CachedItem {

    private static LogHandler logger = LogHandler.getInstance(CachedItem.class);

    private static HashMap<String,HashMap> hm_RoleItem=new HashMap<String,HashMap>();
    private static HashMap hm_EnvItem = new HashMap();
    private static boolean iscached = false;
    private static boolean isBaseEnvCached = false;


    public static void init_base() {
        if (!isBaseEnvCached) {
            cacheBaseEnv();
            isBaseEnvCached = true;
        }
    }

    public static void init() {
        init_base();
        if (!iscached) {
            cacheEnv();
            iscached = true;
        }
    }
    public static void reload() {
        iscached=false;
        isBaseEnvCached = false;
    }

    private static void cacheBaseEnv() {

      Properties prop;
      logger.info("Cache Env data From File... ... ...");

      try{
        PropertyAdapter pa = new PropertyAdapter();
        prop = pa.getProp("/rsconfig.properties");
        hm_EnvItem.putAll(prop);
		//#2048*1024
		hm_EnvItem.put("DOWNLOAD_FILE_BUFFER_SIZE","2097152");
		//#200*1024*1024
		hm_EnvItem.put("UPLOAD_FILE_MAX_SIZE","419430400");
		//#2*1024*1024
		hm_EnvItem.put("UPLOAD_MEMERY_FILE_SIZE","1048576");
		hm_EnvItem.put("WS_TRANSFER_PACKAGE_SIZE","1048576");
		//# 300 * 1024
		hm_EnvItem.put("BASE64_CONVERT_BUFFER_SIZE","30720");
      }catch(Exception e){
          logger.error("CachedItem Error!" + e.getMessage());
      }
   }

    private static void cacheEnv() {

        Properties prop;
        DBOperator dbo = new DBOperator();
        ResultSet rs = null;
        String s_item=null;
        String s_value;
        try {
            logger.info("Cache Env data From DB... ... ...");

            dbo.init(true);
            rs=dbo.query("select * from system_settings");
            while(rs.next()){
                s_item=rs.getString("item");
                if(null!=s_item){
                    s_value=BaseFunction.null2value(rs.getString("value"));
                    hm_EnvItem.put(s_item,s_value);
                }
            }
            if(null!=rs)rs.close();
        }
        catch (Exception e) {
            logger.error("CachedItem Error!" + e.getMessage());
        }
        finally{
            if(null!=dbo) dbo.dispose();
        }
    }


    public static HashMap getEnv() {
        init();
        return hm_EnvItem;
    }
    public static HashMap getBaseEnv() {
        init_base();
        return hm_EnvItem;
    }

}

