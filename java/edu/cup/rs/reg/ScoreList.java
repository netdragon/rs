package edu.cup.rs.reg;

import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class ScoreList implements ICommonList{
	private int bmxxId = 0;
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("bmxxid", "bmxxid");
	    fieldMap.put("kmid", "kmid");
	    fieldMap.put("fenshu", "fenshu");
	}
	public ScoreList(){
		
	}
	public ScoreList(int id){
		this.bmxxId = id;
	}
	public void setBmxxid(int id){
		this.bmxxId = id;
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}


	public Object getObject() {
		return new Score();
	}


	public String getQL() {
		return "select bmxxid,a.kmid,fenshu from score a left join kemu b on a.kmid=b.kmid where bmxxid=" + this.bmxxId + " order by b.kmlxid,a.kmid";
	}

	public String delete(Object obj) {
		Score score = (Score)obj;
		return "delete from score where bmxxid=" + score.getBmxxid();	
	}
	public String update(Object obj) {
		return null;
	}
	public String insert(Object obj) {
		Score score = (Score)obj;
		StringBuffer sql = new StringBuffer("insert score(" +
				"bmxxid,kmid,fenshu,lrcjsj) values(");
		sql.append(score.getBmxxid());
		sql.append(",");
		sql.append(score.getKmid());
		sql.append(",'");
		sql.append(score.getFenshu());
		sql.append("',now())");
		return sql.toString();
	}
	public String deleteAll() {
		return "delete from score";
	}
}
