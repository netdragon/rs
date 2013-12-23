package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class BkzyList implements ICommonList{
	private int bmxxId = 0;
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("bmxxid", "bmxxid");
	    fieldMap.put("zyid", "zyid");
	    fieldMap.put("tjf", "tjf");
		fieldMap.put("zymc", "zymc");
		fieldMap.put("xh", "xh");
	}
	public BkzyList(){
		
	}
	public BkzyList(int id){
		this.bmxxId = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}
	public void setBmxxid(int id){
		this.bmxxId = id;
	}

	public Object getObject() {
		return new Bkzy();
	}

	public String getQL() {
		return "select a.bmxxid,a.zyid,a.tjf,a.xh,b.zymc from bkzy a left join zhshzy b on a.zyid = b.zyid where a.bmxxid=" + this.bmxxId + " order by xh";
	}

	public String delete(Object obj) {
		return "delete from bkzy where bmxxid=" + this.bmxxId;
	}
	public String update(Object obj) {
		Bkzy bkzy = (Bkzy)obj;

		StringBuffer sql = new StringBuffer("update bkzy set zyid=");	
		sql.append(bkzy.getZyid());
		sql.append(", tjf=");
		sql.append(bkzy.getTjf());
		sql.append(", xh=");
		sql.append(bkzy.getXh());
		sql.append(" where zyid=");
		sql.append(bkzy.getZyid());
		sql.append(" and bmxxid=");
		sql.append(bkzy.getBmxxid());
		return sql.toString();
	}
	public String insert(Object obj) {
		Bkzy bkzy = (Bkzy)obj;
		StringBuffer sql = new StringBuffer("insert bkzy(" +
				"bmxxid,zyid,tjf,xh) values(");
		sql.append(bkzy.getBmxxid());
		sql.append(",");
		sql.append(bkzy.getZyid());
		sql.append(",");
		sql.append(bkzy.getTjf());
		sql.append(",");
		sql.append(bkzy.getXh());
		sql.append(")");
		return sql.toString();
	}
}
