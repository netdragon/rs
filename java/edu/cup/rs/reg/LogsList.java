package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.log.*;

public class LogsList implements ICommonList{
	private LogHandler logger = LogHandler.getInstance(LogsList.class);
	private static HashMap<String, String> fieldMap;
	private String xmFilter = "";
	private int count = 0;
	private int start = 0;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("id", "id");
	    fieldMap.put("timestamp", "timestamp");
	    fieldMap.put("content", "content");
	}
	public LogsList(){		
	}
	public void setXmFilter(String filter) {
		this.xmFilter = filter;
	}
	public void setStart(int start) {
		this.start = (0 < start) ? (start-1):start;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}


	public Object getObject() {
		return new Log();
	}

	public String getCount(){
		if(this.xmFilter.length() == 0)
			return "select count(id) as count from sys_log";
		else
			return "select count(id) as count from sys_log where content like '%" + this.xmFilter + "%'";
	}
	
	public String getQL() {
		String sql;
		if(this.xmFilter.length() == 0)
			sql = "select * from sys_log order by timestamp desc limit "+this.count + " offset "+this.start;
		else
			sql = "select * from sys_log where content like '%" + this.xmFilter + "%' order by timestamp desc limit "+this.count + " offset "+this.start;
		return sql;
	}

	public String delete(Object obj) {
		return "";
	}
	public String update(Object obj) {
		return "";
	}
	public String insert(Object obj) {
		Log log = (Log)obj;
		StringBuffer sql = new StringBuffer("insert sys_log(" +
				"content,timestamp) values('");
		sql.append(log.getContent());
		sql.append("',now()");
		sql.append(")");
		return sql.toString();
	}
}
