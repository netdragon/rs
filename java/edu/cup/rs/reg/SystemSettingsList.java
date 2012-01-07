package edu.cup.rs.reg;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class SystemSettingsList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	private String item = null;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("item", "item");
	    fieldMap.put("value", "value");
	}
	public SystemSettingsList(){
	}
	public SystemSettingsList(String item){
		this.item = item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String publishAudit() {
		return "update system_settings set value='1' where item='isPublic_Audit'";
	}
	public String publishScore() {
		return "update system_settings set value='1' where item='isPublic_Score'";
	}
	public String publishAdmit() {
		return "update system_settings set value='1' where item='isPublic_Admit'";
	}
	public String publishAdmission() {
		return "update system_settings set value='1' where item='isPublic_Admission'";
	}
	
    public String getQL(){
		if(item == null)
			return "select * from system_settings";
		else
			return "select * from system_settings where item='" + this.item +"'";
	}
    public String insert(Object obj){
		SystemSettings ss = (SystemSettings)obj;
		StringBuffer sql = new StringBuffer("insert system_settings(item,value) values('");
		sql.append(ss.getItem());
		sql.append("', '");
		sql.append(ss.getValue());
		sql.append("')");
		return sql.toString();
	}
	
    public String delete(){
		return "";
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		SystemSettings ss = (SystemSettings)obj;
		StringBuffer sql = new StringBuffer("update system_settings set value='");
		sql.append(ss.getValue());
		sql.append("' where item='");
		sql.append(ss.getItem());
		sql.append("'");
		return sql.toString();
	}
    public Object getObject(){
		return new SystemSettings();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}