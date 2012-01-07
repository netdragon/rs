package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class KemuList implements ICommonList{
	private int kmid = 0;
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("kmid", "kmid");
	    fieldMap.put("kmmc", "kmmc");
		fieldMap.put("ksrq", "ksrq");
		fieldMap.put("kssj", "kssj");
		fieldMap.put("jssj", "jssj");
	}
	public KemuList(){
		
	}
	public KemuList(int id){
		this.kmid = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}
	public Object getObject() {
		return new Kemu();
	}


	public String getQL() {
		if(0 != this.kmid)
			return "select kmid,kmmc,ksrq,kssj,jssj from kemu where kmid=" + this.kmid + " order by kmid";
		else
			return "select kmid,kmmc,ksrq,kssj,jssj from kemu order by kmid";
	}

	public String delete(Object obj) {
		return null;	
	}
	public String update(Object obj) {
		Kemu kemu = (Kemu)obj;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	String rq = sdf.format(kemu.getKsrq());
		StringBuffer sql = new StringBuffer("update kemu set kmmc='");	
		sql.append(kemu.getKmmc());
		sql.append("', ksrq='");
		sql.append(rq);
		sql.append("', kssj='");
		sql.append(kemu.getKssj());
		sql.append("', jssj='");
		sql.append(kemu.getJssj());
		sql.append("' where kmid=");
		sql.append(kemu.getKmid());
		return sql.toString();
	}
	public String insert(Object obj) {
		Kemu kemu = (Kemu)obj;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	String rq = sdf.format(kemu.getKsrq());
		StringBuffer sql = new StringBuffer("insert kemu(" +
				"kmid,kmmc,ksrq,kssj,jssj) values(");
		sql.append(kemu.getKmid());
		sql.append(",'");
		sql.append(kemu.getKmmc());
		sql.append("','");
		sql.append(rq);
		sql.append("','");
		sql.append(kemu.getKssj());
		sql.append("','");
		sql.append(kemu.getJssj());
		sql.append("')");
		return sql.toString();
	}
}
