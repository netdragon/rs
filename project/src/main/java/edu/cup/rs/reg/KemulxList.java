package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.HashMap;

import edu.cup.rs.common.ICommonList;

public class KemulxList implements ICommonList {
	private int lxid = 0;
	private static HashMap<String, String> fieldMap;
	static {
		fieldMap = new HashMap<String, String>();
		fieldMap.put("lxid", "lxid");
		fieldMap.put("lxmc", "lxmc");
		fieldMap.put("ksrq", "ksrq");
		fieldMap.put("kssj", "kssj");
		fieldMap.put("jssj", "jssj");
	}

	public KemulxList() {

	}

	public KemulxList(int id) {
		this.lxid = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

	public Object getObject() {
		return new Kemulx();
	}

	public String getQL() {
		if (0 != this.lxid)
			return "select lxid,lxmc,ksrq,kssj,jssj from kemulx where lxid="
					+ this.lxid + " order by lxid";
		else
			return "select lxid,lxmc,ksrq,kssj,jssj from kemulx order by lxid";
	}

	public String delete(Object obj) {
		return null;
	}

	public String update(Object obj) {
		Kemulx kemulx = (Kemulx) obj;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String rq = sdf.format(kemulx.getKsrq());
		StringBuffer sql = new StringBuffer("update kemulx set lxmc='");
		sql.append(kemulx.getLxmc());
		sql.append("', ksrq='");
		sql.append(rq);
		sql.append("', kssj='");
		sql.append(kemulx.getKssj());
		sql.append("', jssj='");
		sql.append(kemulx.getJssj());
		sql.append("' where lxid=");
		sql.append(kemulx.getLxid());
		return sql.toString();
	}

	public String insert(Object obj) {
		Kemulx kemulx = (Kemulx) obj;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String rq = sdf.format(kemulx.getKsrq());
		StringBuffer sql = new StringBuffer("insert kemulx("
				+ "lxid,lxmc,ksrq,kssj,jssj) values(");
		sql.append(kemulx.getLxid());
		sql.append(",'");
		sql.append(kemulx.getLxmc());
		sql.append("','");
		sql.append(rq);
		sql.append("','");
		sql.append(kemulx.getKssj());
		sql.append("','");
		sql.append(kemulx.getJssj());
		sql.append("')");
		return sql.toString();
	}
}
