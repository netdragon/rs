package edu.cup.rs.reg.sys;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class KemuList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	private String lxid = null;
	private int id = 0;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("kmmc", "kmmc");
		fieldMap.put("kmid", "kmid");
		fieldMap.put("kmlxid", "kmlxid");
	}
	public KemuList(){
	}
	public KemuList(String lxid){
		this.lxid = lxid;
	}
	public KemuList(int id){
		this.id = id;
	}
	
    public String getQL(){
		if(lxid != null)
			return "select * from kemu where kmlxid=" + lxid + " order by kmid";
		else if(id != 0)
			return "select * from kemu where kmid=" + id + " order by kmid";
		else
			return "select * from kemu order by kmid";
	}
    public String insert(Object obj){
		Kemu zy = (Kemu)obj;
		StringBuffer sql = new StringBuffer("insert Kemu(" +
				"kmlxid, kmmc) values(");
		sql.append(zy.getKmlxid());
		sql.append(",'");
		sql.append(zy.getKmmc());
		sql.append("')");
		return sql.toString();
	}
	
    public String delete(){
		return null;
	}
	public String delete(String id) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from Kemu where kmid=");
		sql.append(id);
		return sql.toString();
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		Kemu zy = (Kemu)obj;
		StringBuffer sql = new StringBuffer("update Kemu " +
				"set kmmc='");
		sql.append(zy.getKmmc());
		sql.append("' where kmid=");
		sql.append(zy.getKmid());
		
		return sql.toString();
	}
    public Object getObject(){
		return new Kemu();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}
	public String getByKemuName(String name) {
		return "select * from kemu where kmmc='" + name + "'";
	}
}