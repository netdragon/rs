package edu.cup.rs.reg.sys;

import edu.cup.rs.common.ICommonList;
import java.util.HashMap;

public class SqbklyList implements ICommonList{
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
		fieldMap.put("mc", "mc");
	}
	public SqbklyList(){
	}

    public String getQL(){

		return "select * from Sqbkly order by convert(mc using gbk)";

	}
    public String insert(Object obj){
		Sqbkly zy = (Sqbkly)obj;
		StringBuffer sql = new StringBuffer("insert Sqbkly(" +
				"mc) values('");
		sql.append(zy.getMc());
		sql.append("')");
		return sql.toString();
	}
	
    public String delete(){
		return null;
	}
	public String delete(String mc) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from Sqbkly where mc='");
		sql.append(mc);
		sql.append("'");
		return sql.toString();
	}
    public String delete(Object obj){
		return null;
	}
	public String update(Object obj){
		Sqbkly zy = (Sqbkly)obj;
		StringBuffer sql = new StringBuffer("update Sqbkly " +
				"set mc='");
		sql.append(zy.getMc());
		sql.append("' where mc='");
		sql.append(zy.getMc());
		sql.append("'");
		return sql.toString();
	}
    public Object getObject(){
		return new Sqbkly();
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}