package edu.cup.rs.reg;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class ZhkzhList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("zhkzhid", "zhkzhid");
	    fieldMap.put("bmxxid", "bmxxid");
	}
	public ZhkzhList(){
		
	}
    public String getQL(){
		return "select bmxxid, zhkzhid from zhkzh order by zyid";
	}
    public String insert(Object obj){
		Zhkzh zkz = (Zhkzh)obj;
		StringBuffer sql = new StringBuffer("insert zhkzh(kssjid,zhkzhid) values(");
		sql.append(zkz.getKssjid());
		sql.append(", '");
		sql.append(zkz.getZhkzhid());
		sql.append("')");
		return sql.toString();
	}
	
    public String delete(){
		return "delete from zhkzh";
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		return null;
	}
    public Object getObject(){
		return new Zhkzh();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}