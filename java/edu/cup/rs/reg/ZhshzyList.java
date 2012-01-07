package edu.cup.rs.reg;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class ZhshzyList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	private int type = -1;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("zyid", "zyid");
	    fieldMap.put("zymc", "zymc");
		fieldMap.put("type", "type");
	}
	public ZhshzyList(){
	}
	public void setType(int type) {
		this.type = type;
	}
    public String getQL(){
		switch(this.type) {
			case -1:
				return "select * from zhshzy";
			default:
				return "select * from zhshzy where type="+this.type;
		}
	}
    public String insert(Object obj){
		return null;
	}
	
    public String delete(){
		return null;
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		return null;
	}
    public Object getObject(){
		return new Zhshzy();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}