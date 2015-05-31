package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.HashMap;

import edu.cup.rs.common.ICommonList;

public class HjqkList implements ICommonList {
	private int bmxxId = 0;
	private static HashMap<String, String> fieldMap;
	static {
		fieldMap = new HashMap<String, String>();
		fieldMap.put("hjqkid", "hjqkid");
		fieldMap.put("bmxxid", "bmxxid");
		fieldMap.put("hjsj", "hjsj");
		fieldMap.put("hjdj", "hjdj");
		fieldMap.put("hjmc", "hjmc");
		fieldMap.put("jsjb", "jsjb");
		fieldMap.put("sjbm", "sjbm");
	}

	public HjqkList() {

	}

	public HjqkList(int id) {
		this.bmxxId = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

	public Object getObject() {
		return new Hjqk();
	}

	public String getQL() {
		if (0 == this.bmxxId) {
			return "select * from hjqk order by hjqkid";
		}
		return "select * from hjqk where bmxxid=" + this.bmxxId
				+ " order by hjqkid";
	}

	public String delete(Object obj) {
		return "delete from hjqk where bmxxid=" + this.bmxxId;
	}

	public String update(Object obj) {
		Hjqk hjqk = (Hjqk) obj;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String hjsj = sdf.format(hjqk.getHjsj());
		StringBuffer sql = new StringBuffer("update hjqk set hjmc='");
		sql.append(hjqk.getHjmc());
		sql.append("', jsjb='");
		sql.append(hjqk.getJsjb());
		sql.append("',hjsj='");
		sql.append(hjsj);
		sql.append("',sjbm='");
		sql.append(hjqk.getSjbm());
		sql.append("',hjdj='");
		sql.append(hjqk.getHjdj());
		sql.append("' where hjqkid=");
		sql.append(hjqk.getHjqkid());
		return sql.toString();
	}

	public String insert(Object obj) {
		Hjqk hjqk = (Hjqk) obj;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String hjsj;
		if (null != hjqk.getHjsj())
			hjsj = sdf.format(hjqk.getHjsj());
		else
			hjsj = null;
		StringBuffer sql = new StringBuffer("insert hjqk("
				+ "bmxxid,hjmc,hjsj,jsjb,hjdj,sjbm) values(");
		sql.append(hjqk.getBmxxid());
		sql.append(",'");
		sql.append(hjqk.getHjmc());
		if (null != hjsj) {
			sql.append("','");
			sql.append(hjsj);
			sql.append("','");
		} else {
			sql.append("',null,'");
		}
		sql.append(hjqk.getJsjb());
		sql.append("','");
		sql.append(hjqk.getHjdj());
		sql.append("','");
		sql.append(hjqk.getSjbm());
		sql.append("')");
		return sql.toString();
	}
}
