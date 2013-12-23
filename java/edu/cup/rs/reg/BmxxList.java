package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.log.LogHandler;

public class BmxxList implements ICommonList{
	private int bmxxId = 0;
	private int count = 0;
	private int start = 0;
	private String xmFilter = "";
	private String userid = "-1";
	private String orderColName = " convert(ksxm using gbk)";
	private static HashMap<String, String> fieldMap;
	protected static final LogHandler logger=LogHandler.getInstance(BmxxList.class);
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("userid", "userid");
	    fieldMap.put("ksxm", "ksxm");
	    fieldMap.put("ksxb", "ksxb");
	    fieldMap.put("jg", "jg");
	    fieldMap.put("mz", "mz");
	    fieldMap.put("zzmm", "zzmm");
	    fieldMap.put("shfzh", "shfzh");
	    fieldMap.put("hkszd", "hkszd");
	    fieldMap.put("fmxm", "fmxm");
	    fieldMap.put("fmzw", "fmzw");
	    fieldMap.put("fmgzdw", "fmgzdw");
	    fieldMap.put("fmyddh", "fmyddh");
	    fieldMap.put("mmxm", "mmxm");
	    fieldMap.put("mmgzdw", "mmgzdw");
	    fieldMap.put("mmzw", "mmzw");
	    fieldMap.put("mmyddh", "mmyddh");
	    fieldMap.put("txdz", "txdz");
	    fieldMap.put("yzbm", "yzbm");
	    fieldMap.put("shxr", "shxr");
	    fieldMap.put("kskl", "kskl");
	    fieldMap.put("ksshji", "ksshji");
	    fieldMap.put("bmxxid", "bmxxid");
        fieldMap.put("kszp", "kszp");
        fieldMap.put("lqzy", "lqzy");
        fieldMap.put("sflq", "sflq");
        fieldMap.put("shhyj", "shhyj");
        fieldMap.put("shhqk", "shhqk");
        fieldMap.put("bmsj", "bmsj");
        fieldMap.put("wyyz", "wyyz");
        fieldMap.put("zxmc", "zxmc");
        fieldMap.put("ksah", "ksah");
        fieldMap.put("sqly", "sqly");
		fieldMap.put("sfjbmf", "sfjbmf");
		fieldMap.put("zhkzhid", "zhkzhid");
		fieldMap.put("kch", "kch");
		fieldMap.put("zongfen", "zongfen");
	}
	public BmxxList(){
		
	}
	public BmxxList(int id){
		this.bmxxId = id;
	}
	public BmxxList(String userid){
		this.userid = userid;
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}

	public void setOrder(String colName) {
		this.orderColName = colName;
		if(colName.indexOf("ksxm")!=-1){
			this.orderColName = this.orderColName.replaceAll("ksxm", " convert(ksxm using gbk)");
		}
		if(colName.indexOf("jg")!=-1){
			this.orderColName = this.orderColName.replaceAll("jg", " convert(jg using gbk)");
		}
		logger.debug("\n"+this.orderColName);
	}

	public void setXmFilter(String filter) {
		this.xmFilter = filter;
	}
	public void setStart(int start) {
		this.start = (0 < start) ? (start-1):start;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Object getObject() {
		return new Bmxx();
	}
	public String setAuditAdvice(String bmxxid, String advice){
		return "update bmxx set shhyj='" + advice +"' where bmxxid=" + bmxxid;
	}
	public String setAdjustAdmit(String bmxxid, int zyid){
		return "update bmxx, (select zymc from zhshzy where zyid=" + zyid + ") temp set bmxx.sflq=1, bmxx.lqzy=temp.zymc where shhqk=1 and zhkzhid is not null and bmxxid=" + bmxxid;
	}
	public String getCount(){
		if(this.xmFilter.length() == 0)
			return "select count(bmxxid) as count from bmxx";
		else
			return "select count(bmxxid) as count from bmxx where ksxm like '%" + this.xmFilter + "%'";
	}
	public String getQL() {
		if(0 == this.bmxxId){
			if("-1".equals(this.userid)){
					if(xmFilter.length() > 0)
						return "select bmxxid,jg,ksxm,ksxb,shfzh,shhqk,shhyj,sfjbmf,zhkzhid,zxmc,kskl,sflq,lqzy from bmxx where ksxm like '%" + this.xmFilter + "%' order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
					else
						return "select bmxxid,jg,ksxm,ksxb,shfzh,shhqk,shhyj,sfjbmf,zhkzhid,zxmc,kskl,sflq,lqzy from bmxx order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
			}
			else
				return "select bmxxid from bmxx where userid=" + this.userid;
		}
		return "select * from bmxx where bmxxid=" + this.bmxxId;
	}
    public String delete(Object obj){ return null;}
	public String delete_bkzy(String bmxxid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from bkzy where bmxxid=");
		sql.append(bmxxid);
		
		return sql.toString();
	}
	public String delete_hjqk(String bmxxid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from hjqk where bmxxid=");
		sql.append(bmxxid);
		
		return sql.toString();
	}
	public String delete_cjjd(String bmxxid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from cjjd where bmxxid=");
		sql.append(bmxxid);
		
		return sql.toString();
	}
	
	public String delete_hdqk(String bmxxid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from hdqk where bmxxid=");
		sql.append(bmxxid);
		
		return sql.toString();
	}
	public String delete(String bmxxid) {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from bmxx where bmxxid=");
		sql.append(bmxxid);
		
		return sql.toString();
	}
	
	public String setSumScore(String bmxxid, float sumScore) {		
		return "update bmxx set zongfen=" + sumScore + " where bmxxid=" + bmxxid;
	}

	public String getAdmissionKs() {
		return "select bmxxid,kskl from bmxx where sfjbmf=1 and shhqk=1 order by convert(ksxm using gbk)";
	}
	public String createAdmission(int bmxxid, String admNum){
		return "update bmxx set zhkzhid='" + admNum +"' where bmxxid=" + bmxxid;
	}
	public String getAuditResult() {
		if(xmFilter.length() > 0)
			return "select bmxxid,ksxm,jg,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sflq,lqzy,sfjbmf from bmxx where shhqk=1 and ksxm like '%" + this.xmFilter + "%' order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
		else
			return "select bmxxid,ksxm,jg,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sflq,lqzy,sfjbmf from bmxx where shhqk=1 order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
	}
	public String getExamResult() {
		if(xmFilter.length() > 0)
			return "select bmxxid,ksxm,jg,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sflq,lqzy from bmxx where shhqk=1 and zhkzhid is not null and ksxm like '%" + this.xmFilter + "%' order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
		else
			return "select bmxxid,ksxm,jg,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sflq,lqzy from bmxx where shhqk=1 and zhkzhid is not null order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
	}
	public String getAdmitResult(int score) {
		if(xmFilter.length() > 0)
			return "select bmxxid,ksxm,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sfjbmf,sflq,lqzy,sqly from bmxx where shhqk=1 and zhkzhid is not null and zongfen>=" + score +" and ksxm like '%" + this.xmFilter + "%' order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
		else
			return "select bmxxid,ksxm,ksxb,shfzh,zhkzhid,zongfen,zxmc,kskl,sfjbmf,sflq,lqzy,sqly from bmxx where shhqk=1 and zhkzhid is not null and zongfen>=" + score +" order by " + this.orderColName + " limit "+this.count + " offset "+this.start;
	}
	public String getAuditCount(){
		return "SELECT count(bmxxid) as count FROM bmxx where shhqk=1";
	}
	public String getAdmitCount(){
		return "SELECT count(bmxxid) as count FROM bmxx where shhqk=1 and zhkzhid is not null and sfjbmf=1 and sflq=1";
	}
	public String getUnauditedCount(){
		return "SELECT count(bmxxid) as count FROM bmxx where shhqk=0 or shhqk is null";
	}
	public String getUnconfirmedCount(){
		return "SELECT count(bmxxid) as count FROM bmxx where shhqk=1 and (sfjbmf=0 or sfjbmf is null)";
	}
	public String getAdmissionCount(){
		return "SELECT count(bmxxid) as count FROM bmxx where shhqk=1 and zhkzhid is not null";
	}
	public String getExamAdmission() {
		return "select bmxxid from bmxx where shhqk=1 and zhkzhid is not null order by convert(ksxm using gbk)";
	}
	public String getRoomMember() {
		return "SELECT kch,GROUP_CONCAT(zhkzhid order by zhkzhid SEPARATOR ',') as ksxm FROM (select kch,zhkzhid from bmxx where kch is not null and kch > 0 order by zhkzhid) kch_member group by kch";
	}
	public String arraRoom(int bmxxid, int roomNum){
		return "update bmxx set kch=" + roomNum + " where bmxxid=" + bmxxid;
	}
	public String initAdmission(){
		return "update bmxx set zhkzhid=null";
	}
	public String initExamRoom(){
		return "update bmxx set kch=null";
	}
	public String getRoomCount(){
		return "SELECT count(distinct kch) as count FROM bmxx where kch is not null and kch > 0";
	}
	public String admit(String bmxxs, boolean pass) {
		if(pass) {
			return "update bmxx, (select a.zyid,a.bmxxid,b.zymc from bkzy a, zhshzy b where a.zyid=b.zyid and a.xh=1) temp " + 
			" set bmxx.sflq=1, bmxx.lqzy=temp.zymc where bmxx.bmxxid=temp.bmxxid and bmxx.bmxxid in " + bmxxs;
		}	
		else{
			return "update bmxx set sflq=0, lqzy='' where bmxxid in " + bmxxs;
		}
	}
	public String audit(String bmxxs, boolean pass) {
		StringBuffer sql = new StringBuffer("update bmxx set shhqk=");	
		if(pass) {
			sql.append(1);
			sql.append(", shhyj=''");
		}
		else sql.append(-1);
		sql.append(" where bmxxid in");
		sql.append(bmxxs);
		return sql.toString();
	}
	public String confirmFee(String bmxxs, boolean pass) {
		
		StringBuffer sql = new StringBuffer("update bmxx set sfjbmf=");	
		if(pass) {
			sql.append(1);
		}
		else sql.append(0);
		sql.append(" where bmxxid in");
		sql.append(bmxxs);
		
		return sql.toString();
	}
	public String insert(Object obj) {
		Bmxx bmxx = (Bmxx)obj;
		StringBuffer sql = new StringBuffer("insert into bmxx(" +
				"userid,ksxm,ksxb,jg,mz,zzmm," +
				"shfzh,fmxm,fmgzdw,fmyddh,fmzw,mmxm,mmgzdw,mmyddh,mmzw,"+
				"txdz,yzbm,shxr,"+
				"ksshji,bmsj,kszp,ksah,wyyz,sqly,kskl,zxmc) values(");
		sql.append(bmxx.getUserid());
		sql.append(",'");
		sql.append(bmxx.getKsxm());
		sql.append("',");
		sql.append(bmxx.getKsxb());
		sql.append(",'");
		sql.append(bmxx.getJg());
		sql.append("','");
		sql.append(bmxx.getMz());
		sql.append("','");
		sql.append(bmxx.getZzmm());
		sql.append("','");
		sql.append(bmxx.getShfzh());
		sql.append("','");
		sql.append(bmxx.getFmxm());
		sql.append("','");
		sql.append(bmxx.getFmgzdw());
		sql.append("','");
		sql.append(bmxx.getFmyddh());
		sql.append("','");
		sql.append(bmxx.getFmzw());
		sql.append("','");
		sql.append(bmxx.getMmxm());
		sql.append("','");
		sql.append(bmxx.getMmgzdw());
		sql.append("','");
		sql.append(bmxx.getMmyddh());
		sql.append("','");
		sql.append(bmxx.getMmzw());
		sql.append("','");
		sql.append(bmxx.getTxdz());
		sql.append("','");
		sql.append(bmxx.getYzbm());
		sql.append("','");
		sql.append(bmxx.getShxr());
		sql.append("','");
		sql.append(bmxx.getKsshji());
		if(null != bmxx.getKszp()) {
			sql.append("',now(),'");
			sql.append(bmxx.getKszp());
			sql.append("','");
		} else {
			sql.append("',now(),null,'");
		}
		sql.append(bmxx.getKsah());
		sql.append("','");
		sql.append(bmxx.getWyyz());
		sql.append("','");
		sql.append(bmxx.getSqly());
		sql.append("','");
		sql.append(bmxx.getKskl());
		sql.append("','");
		sql.append(bmxx.getZxmc());
		sql.append("')");
		return sql.toString();
	}

	public String update(Object obj) {
		Bmxx bmxx = (Bmxx)obj;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		StringBuffer sql = new StringBuffer("update bmxx set ksxm='");	
		sql.append(bmxx.getKsxm());
		sql.append("',ksxb=");
		sql.append(bmxx.getKsxb());
		sql.append(",jg='");
		sql.append(bmxx.getJg());
		sql.append("',mz='");
		sql.append(bmxx.getMz());
		sql.append("',zzmm='");
		sql.append(bmxx.getZzmm());
		sql.append("',shfzh='");
		sql.append(bmxx.getShfzh());
		sql.append("',fmxm='");
		sql.append(bmxx.getFmxm());
		sql.append("',fmgzdw='");
		sql.append(bmxx.getFmgzdw());
		sql.append("',fmyddh='");
		sql.append(bmxx.getFmyddh());
		sql.append("',fmzw='");
		sql.append(bmxx.getFmzw());
		sql.append("',mmxm='");
		sql.append(bmxx.getMmxm());
		sql.append("',mmgzdw='");
		sql.append(bmxx.getMmgzdw());
		sql.append("',mmyddh='");
		sql.append(bmxx.getMmyddh());
		sql.append("',mmzw='");
		sql.append(bmxx.getMmzw());
		sql.append("',txdz='");
		sql.append(bmxx.getTxdz());
		sql.append("',yzbm='");
		sql.append(bmxx.getYzbm());
		sql.append("',shxr='");
		sql.append(bmxx.getShxr());
		sql.append("',ksshji='");
		sql.append(bmxx.getKsshji());
		if(null != bmxx.getKszp()) {
			sql.append("',kszp='");
			sql.append(bmxx.getKszp());
		}
		sql.append("',kskl='");
		sql.append(bmxx.getKskl());
		sql.append("',wyyz='");
		sql.append(bmxx.getWyyz());
		sql.append("',zxmc='");
		sql.append(bmxx.getZxmc());
		sql.append("',ksah='");
		sql.append(bmxx.getKsah());
		sql.append("',sqly='");
		sql.append(bmxx.getSqly());
		sql.append("' where bmxxid=");
		sql.append(bmxx.getBmxxid());
/*
		DBOperator dbo = new DBOperator();
		ResultSet rs;
		Connection conn = null;

		try{
			dbo.init(false);
			conn = dbo.getConnection();
		}catch(Exception e){
			logger.error(e.getMessage());
			response.sendRedirect("/error.jsp?error=" + new UTF8String("数据库访问错误！").toUTF8String());
			return;
		}
		try {
			PreparedStatement ps = conn.createPreparedStatement();
		}catch(Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("/error.jsp?error=" + new UTF8String("没有该考生或数据发生错误！").toUTF8String());
			return;
		}finally {
			if(null != dbo) dbo.dispose();
		}
*/
		return sql.toString();
	}
	public String getByZhkzh(String zhkzh) {
		return "select * from bmxx where zhkzhid='" + zhkzh + "'";
	}
}
