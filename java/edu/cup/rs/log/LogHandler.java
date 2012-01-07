package edu.cup.rs.log;

import java.util.HashMap;
import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.Logger;
import edu.cup.rs.util.PropertyAdapter;
import edu.cup.rs.common.CachedItem;
/**
 *
*/
public class LogHandler implements java.io.Serializable {

    private static final long serialVersionUID = 1L;
    private static LogHandler logHandler = null;
    private static boolean SAVE_2_DB=false;
    private Logger logger = null;
    private static int i_filter=6291455;
    /**
    * logWritter config file
    */
    private static String confFileName = "/rslog.properties";
    private static HashMap<String,String> hm_env=null;
    static
    {
        PropertyAdapter pa=new PropertyAdapter();
        PropertyConfigurator.configure(pa.getURI(confFileName));
    }
    public static void setDestination(boolean save2db){
        SAVE_2_DB=save2db;
        
        hm_env=CachedItem.getEnv();
        try{
            i_filter=Integer.parseInt(hm_env.get("syslog_filter"));
        }catch(Exception e){
            e.printStackTrace();
        }

    }
    public static void setFilter(int filter){
        i_filter=filter;
    }
    /**
    * getInstance
    * @return
    */
    public static LogHandler getInstance() {

        logHandler = new LogHandler();

        return logHandler;
    }
    public static LogHandler getInstance(Class aclass) {

        logHandler = new LogHandler(aclass);

        return logHandler;
    }
    public static LogHandler getInstance(String className) {
        return new LogHandler(className);
    }
    private LogHandler(Class aclass) {
        logger = Logger.getLogger(aclass);
    }
    private LogHandler() {
        logger = Logger.getRootLogger();
    }
    private LogHandler(String className) {
        logger = Logger.getLogger(className);
    }
    public void debug(String msg)
    {

            logger.debug(msg);

    }
    public void info(String msg) {

            logger.info(msg);

    }

    public void warn(String msg)
    {

            logger.warn(msg);

    }

    public void error(String msg)
    {

            logger.error(msg);

    }
    public void fatal(String msg)
    {

            logger.fatal(msg);

    }

    public void debug(String msg,boolean cmd)
    {

            logger.debug(msg);

    }
    public void info(String msg,boolean cmd) {
 
            logger.info(msg);

    }

    public void warn(String msg,boolean cmd)
    {

            logger.warn(msg);

    }

    public void error(String msg,boolean cmd)
    {

            logger.error(msg);

    }
    public void fatal(String msg,boolean cmd)
    {

            logger.fatal(msg);
 
    }

    public static void main(String[] args) {
        LogHandler logger=LogHandler.getInstance(LogHandler.class);
//      for (int i = 0; i < 10; i++) {
            logger.debug("hello1");
            LogHandler.getInstance("String.class").info("hello2");
            logger.debug("hello1");
//      }
    }
}
