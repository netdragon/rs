package edu.cup.rs.reg.sys;

import java.util.HashMap;

import edu.cup.rs.common.ICommonList;

public class SqbklyList implements ICommonList {
	private static HashMap<String, String> fieldMap;
	private String id = null;
	static {
		fieldMap = new HashMap<String, String>();
		fieldMap.put("mc", "mc");
		fieldMap.put("id", "id");
		fieldMap.put("type", "type");
	}

	public SqbklyList(String id) {
		this.id = id;
	}

	public SqbklyList() {

	}

	public String getQL() {
		if (id != null)
			return "select * from sqbkly where id=" + id
					+ " order by convert(mc using gbk)";
		else
			return "select * from sqbkly order by convert(mc using gbk)";
	}

	public String insert(Object obj) {
		Sqbkly zy = (Sqbkly) obj;
		StringBuffer sql = new StringBuffer("insert sqbkly("
				+ "mc,type) values('");
		sql.append(zy.getMc());
		sql.append("',");
		sql.append(zy.getType());
		sql.append(")");
		return sql.toString();
	}

	public String delete() {
		return null;
	}

	public String delete(String mc) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from sqbkly where mc='");
		sql.append(mc);
		sql.append("'");
		return sql.toString();
	}

	public String delete(Object obj) {
		return null;
	}

	public String update(Object obj) {
		return null;
	}

	public String update(String oldId, Object obj) {
		Sqbkly zy = (Sqbkly) obj;
		StringBuffer sql = new StringBuffer("update sqbkly " + "set mc='");
		sql.append(zy.getMc());
		sql.append("', type=");
		sql.append(zy.getType());
		sql.append(" where id=");
		sql.append(oldId);
		return sql.toString();
	}

	public Object getObject() {
		return new Sqbkly();
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

}
