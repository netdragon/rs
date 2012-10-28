package edu.cup.rs.reg;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class ZhshzyList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	private int type = -1;
	private String id = null;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("zyid", "zyid");
	    fieldMap.put("zymc", "zymc");
		fieldMap.put("type", "type");
	}
	public ZhshzyList(){
	}
	public ZhshzyList(String id){
		this.id = id;
	}
	public void setType(int type) {
		this.type = type;
	}
    public String getQL(){
		if(null != this.id) return "select * from zhshzy where zyid=" + this.id;
		switch(this.type) {
			case -1:
				return "select * from zhshzy order by type, convert(zymc using gbk)";
			default:
				return "select * from zhshzy where type="+this.type;
		}
	}
    public String insert(Object obj){
		Zhshzy zy = (Zhshzy)obj;
		StringBuffer sql = new StringBuffer("insert Zhshzy(" +
				"zymc,type) values('");
		sql.append(zy.getZymc());
		sql.append("',");
		sql.append(zy.getType());
		sql.append(")");
		return sql.toString();
	}
	
    public String delete(){
		return null;
	}
	public String delete(String zyid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from zhshzy where zyid=");
		sql.append(zyid);
		
		return sql.toString();
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		Zhshzy zy = (Zhshzy)obj;
		StringBuffer sql = new StringBuffer("update Zhshzy " +
				"set zymc='");
		sql.append(zy.getZymc());
		sql.append("', type=");
		sql.append(zy.getType());
		sql.append(" where zyid=");
		sql.append(zy.getZyid());
		return sql.toString();
	}
    public Object getObject(){
		return new Zhshzy();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}