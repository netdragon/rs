package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class HdqkList implements ICommonList{
	private int bmxxId = 0;
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("hdqkid", "hdqkid");
	    fieldMap.put("bmxxid", "bmxxid");
	    fieldMap.put("hdsj", "hdsj");
	    fieldMap.put("hdmc", "hdmc");
	    fieldMap.put("brjsgx", "brjsgx");
	}
	public HdqkList(){
		
	}
	public HdqkList(int id){
		this.bmxxId = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}


	public Object getObject() {
		return new Hdqk();
	}


	public String getQL() {
		if(0 == this.bmxxId){
			return "select * from hdqk order by hdqkid";
		}
		return "select * from hdqk where bmxxid=" + this.bmxxId + " order by hdqkid";
	}

	public String delete(Object obj) {
		return "delete from hdqk where bmxxid=" + this.bmxxId;
	}
	public String update(Object obj) {
		Hdqk hdqk = (Hdqk)obj;
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		String hdsj = sdf.format(hdqk.getHdsj());
		StringBuffer sql = new StringBuffer("update hdqk set hdmc='");	
		sql.append(hdqk.getHdmc());
		sql.append("',hdsj='");
		sql.append(hdsj);
		sql.append("',brjsgx='");
		sql.append(hdqk.getBrjsgx());
		sql.append("' where hdqkid=");
		sql.append(hdqk.getHdqkid());
		return sql.toString();
	}
	public String insert(Object obj) {
		Hdqk hdqk = (Hdqk)obj;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String hdsj;
		if(null != hdqk.getHdsj())
			hdsj = sdf.format(hdqk.getHdsj());
		else hdsj = null;

		StringBuffer sql = new StringBuffer("insert hdqk(" +
				"bmxxid,hdmc,hdsj,brjsgx) values(");
		sql.append(hdqk.getBmxxid());
		sql.append(",'");
		sql.append(hdqk.getHdmc());
		if(null != hdsj) {
			sql.append("','");
			sql.append(hdsj);
			sql.append("','");
		} else {
			sql.append("',null,'");
		}
		sql.append(hdqk.getBrjsgx());
		sql.append("')");
		return sql.toString();
	}
}
