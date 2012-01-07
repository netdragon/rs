package edu.cup.rs.common;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import edu.cup.rs.log.LogHandler;
import edu.cup.rs.reg.User;
import java.util.HashMap;
import java.util.ArrayList;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.ResultSetMetaData;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
public class DBOperator {
    private LogHandler logger = LogHandler.getInstance(DBOperator.class);
    private String url = "";
    private String driver = "com.mysql.jdbc.Driver";
    private static String useid = "dsfsdfdsfsdf";
    private static String pwd = "dsfdsfsd";
    private Statement st;
    private ResultSet rs = null;
    private Connection conn;
    private String dbpoolname = "";
    private boolean isPoolConnect = false;

	
    public DBOperator(String DBUrl, String DBDriver, String UserID,
            String Password) {
        this.url = DBUrl;
        this.driver = DBDriver;
        this.useid = UserID;
        this.pwd = Password;
        isPoolConnect = false;
    }
    public DBOperator(String DBUrl) {
        this.url = DBUrl;
        isPoolConnect = false;
    }

    public DBOperator(String dbpoolname, boolean isPoolConnect) {
        this.url = dbpoolname;
        this.isPoolConnect = true;
    }
    /**  Constructor for the DBOperator object */
    public DBOperator() {
      HashMap<String,String> hm_env=CachedItem.getBaseEnv();
	  this.useid = hm_env.get("USERNAME").trim();
      this.pwd = hm_env.get("PASSWORD").trim();
      this.url = hm_env.get("DB_CONN_URL").trim();
      this.isPoolConnect = false;
    }
    /**
     *  Description of the Method
     *
     *@param  isAutoCommit   Description of the Parameter
     *@exception  Exception  Description of the Exception
     */
    public void init(boolean isAutoCommit)
        throws Exception {
        if (this.isPoolConnect) {
            InitialContext ctx;
            try {
                ctx = new InitialContext();
                DataSource ds;
                ds = (DataSource) ctx.lookup(dbpoolname);
                conn = ds.getConnection();
            }
            catch (NamingException e) {
                throw e;
            }
            catch (SQLException e) {
                throw e;
            }
        }
        else {
            try {
                Class.forName(driver);
            }
            catch (ClassNotFoundException e) {
                logger.error("Can't find the DB driver!");
                throw e;
            }
            try {
                conn = DriverManager.getConnection(url, useid, pwd);
            }
            catch (SQLException e) {
                throw e;
            }
        }
        try {
            conn.setAutoCommit(isAutoCommit);
        }
        catch (SQLException e) {
            throw e;
        }
    }
    /**
     *  Description of the Method
     *
     *@exception  Exception  Description of the Exception
     */
    public void commit() throws Exception{
        try {
            this.conn.commit();
        }
        catch (SQLException ex) {
            logger.error("please check the db service status." + ex.getMessage());
			throw ex;
        }
    }
    /**
     *  Description of the Method
     *
     *@exception  Exception  Description of the Exception
     */
    public void rollback()
    {
        try {
            this.conn.rollback();
        }
        catch (SQLException ex) {
            logger.error("please check the db service status." + ex.getMessage());
        }
    }
    /**
     *  Description of the Method
     *
     *@param  s_SQL          Description of the Parameter
     *@exception  Exception  Description of the Exception
     */
    public void executeUpdate(String s_SQL)
        throws Exception {
        try {
            st = conn.createStatement();
            st.executeUpdate(s_SQL);
        }
        catch (SQLException ex) {
            throw ex;
        }
    }
    /**
     *  Description of the Method
     *
     *@param  s_SQL          Description of the Parameter
     *@exception  Exception  Description of the Exception
     */
    public void execute(String s_SQL)
        throws Exception {
        try {
            st = conn.createStatement();
            st.execute(s_SQL);
        }
        catch (SQLException ex) {
            throw ex;
        }
    }
    /**
     *  Description of the Method
     *
     *@param  s_SQL          Description of the Parameter
     *@return                Description of the Return Value
     *@exception  Exception  Description of the Exception
     */
    public ResultSet query(String s_SQL)
        throws Exception {
        try {
            //ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY
            st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            //logger.info(s_SQL);
            rs = st.executeQuery(s_SQL);
        }
        catch (SQLException ex) {
            throw ex;
        }
        return rs;
    }
    /**
     *  Gets the connection attribute of the DBOperator object
     *
     *@return    The connection value
     */
    public Connection getConnection() {
        return this.conn;
    }
    /**
     *  Gets the url attribute of the DBOperator object
     *
     *@return    The url value
     */
    public String getUrl() {
        return this.url;
    }
    /**
     *  Gets the userID attribute of the DBOperator object
     *
     *@return    The userID value
     */
    public String getUserID() {
        return this.useid;
    }
    /**
     *  Gets the pwd attribute of the DBOperator object
     *
     *@return    The pwd value
     */
    public String getPwd() {
        return this.pwd;
    }
    /**
     *  Gets the driverName attribute of the DBOperator object
     *
     *@return    The driverName value
     */
    public String getDriverName() {
        return this.driver;
    }
    /**  Description of the Method */
    public void dispose() {
        try {
            if(null!=rs) rs.close();
            if(null!=st) st.close();
            if (null != conn)
                conn.close();
        }
        catch (SQLException ex) {
            logger.warn("unclose+1");
            //log and unclose+1
        }
    }
    /**
     *  Description of the Method
     *
     *@param  outer_conn  Description of the Parameter
     */
    public void dispose(Connection outer_conn) {
        try {
            outer_conn.close();
        }
        catch (SQLException ex) {
            logger.warn("unclose+1");
            //log and unclose+1
        }
    }
    public ArrayList getQueryList(String sql, ICommonList cl) throws Exception{
        PreparedStatement pst=null;
        ArrayList list = new ArrayList();
        try{
            //logger.debug(sql);
            pst=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs=pst.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            while(rs.next()){
                Object obj = convertToObj(rs, rsmd, cl);
                list.add(obj);
            }
        }
        catch(Exception e){
            throw e;
        }
        return list;
    }
    public ArrayList getList(ICommonList cl) {
        PreparedStatement pst=null;
        ArrayList list = new ArrayList();
        try{
            logger.debug(cl.getQL());
            pst=conn.prepareStatement(cl.getQL(),ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs=pst.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            while(rs.next()){
                Object obj = convertToObj(rs, rsmd, cl);
                list.add(obj);
            }
        }
        catch(Exception e){
            logger.error(e.getMessage());
			return null;
        }
        return list;
    }
	public int getCount(String sql){
		try{
			query(sql);
			if(this.rs.next()) return this.rs.getInt("count");
			else return 0;
        }
        catch(Exception e){
            logger.error(e.getMessage());
            return 0;
        }
	}
    public Object convertToObj(ResultSet rs, ResultSetMetaData rsmd, ICommonList cl) {
        String setMethodName;
        int dbType = 0;
        Method method = null;
        Object obj = cl.getObject();
        HashMap<String, String> fieldMap = cl.getFieldMap();
        Class <? extends Object> objClass = obj.getClass();
        try {
            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                setMethodName = rsmd.getColumnName(i);
				//logger.debug(setMethodName);
                setMethodName = "set"
                     + fieldMap.get(setMethodName).substring(0, 1).toUpperCase()
                     + fieldMap.get(setMethodName).substring(1);
                dbType = rsmd.getColumnType(i);
                if (dbType == Types.TINYINT) {
                    method = objClass.getMethod(setMethodName, int.class);
                    method.invoke(obj, rs.getByte(i));
                } else if (dbType == Types.SMALLINT) {
                    method = objClass.getMethod(setMethodName, int.class);
                    method.invoke(obj, rs.getShort(i));
                } else if (dbType == Types.INTEGER) {
                    method = objClass.getMethod(setMethodName, int.class);
                    method.invoke(obj, rs.getInt(i));
                } else if (dbType == Types.BIGINT) {
                    method = objClass.getMethod(setMethodName, long.class);
                    method.invoke(obj, rs.getLong(i));
                } else if (dbType == Types.FLOAT
                        || dbType == Types.REAL) {
                    method = objClass.getMethod(setMethodName, float.class);
                    method.invoke(obj, rs.getFloat(i));
                } else if (dbType == Types.DOUBLE) {
                    method = objClass.getMethod(setMethodName, double.class);
                    method.invoke(obj, rs.getDouble(i));
                } else if (dbType == Types.DECIMAL
                        || dbType == Types.NUMERIC) {
                    method = objClass.getMethod(setMethodName, BigDecimal.class);
                    method.invoke(obj, rs.getBigDecimal(i));
                } else if (dbType == Types.BIT) {
                    method = objClass.getMethod(setMethodName, boolean.class);
                    method.invoke(obj, rs.getBoolean(i));
                } else if (dbType == Types.CHAR
                        || dbType == Types.VARCHAR
                        || dbType == Types.LONGVARCHAR
                        || dbType == Types.CLOB) {
                    method = objClass.getMethod(setMethodName, String.class);
                    method.invoke(obj, rs.getString(i));
                } else if (dbType == Types.DATE) {
                    method = objClass.getMethod(setMethodName, java.util.Date.class);
                    method.invoke(obj, rs.getDate(i));
                } else if (dbType == Types.TIME) {
                    method = objClass.getMethod(setMethodName, Time.class);
                    method.invoke(obj, rs.getTime(i));
                } else if (dbType == Types.TIMESTAMP) {
                    method = objClass.getMethod(setMethodName, Timestamp.class);
                    method.invoke(obj, rs.getTimestamp(i));
                } else if (dbType == Types.BINARY
                        || dbType == Types.VARBINARY
                        || dbType == Types.LONGVARBINARY
                        || dbType == Types.BLOB) {
                    method = objClass.getMethod(setMethodName, byte[].class);
                    method.invoke(obj, rs.getBytes(i));
                } else {
                    throw new Exception("Can't find this type:" + dbType);
                }
            }
        } catch (NoSuchMethodException ex) {
            logger.error("Can't find this method!" + ex.getMessage());
        } catch (IllegalAccessException ex) {
            logger.error("Can't get a instance from this Object!" + ex.getMessage());
        } catch (InvocationTargetException ex) {
            logger.error("Method invoke failed!" + ex.getMessage());
        } catch (SecurityException ex) {
            logger.error("Security Warnning!" + ex.getMessage());
        } catch (IllegalArgumentException ex) {
            logger.error("Wrong parameters!" + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("DB Error!" + ex.getMessage());
        } catch (Exception ex) {
            logger.error("DB Error ___!" + dbType + ex.getMessage());
        }
        return obj;
    }
    public void update(String sql) throws Exception{
        try{
			logger.debug(sql);
            executeUpdate(sql);
        }
        catch(Exception e){
			throw e;
        }
    }
    public void insert(String insert) throws Exception {
        try{
			logger.debug(insert);
            executeUpdate(insert);
        }catch(Exception e){
            throw e;
        }
    }
    public void delete(String delete) throws Exception {
        try{
			//logger.debug(delete);
            executeUpdate(delete);
        }catch(Exception e){
            throw e;
        }
    }
    public int getLastInsertId() throws Exception{
        int i = 0;
        PreparedStatement pst;
        try {
            pst=conn.prepareStatement("select LAST_INSERT_ID() as seq");
            rs=pst.executeQuery();
            if(rs.next()) i = rs.getInt("seq");
        }
        catch(Exception e){
            throw e;
        }
        return i;
    }
}
