package edu.cup.rs.reg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class CjjdList implements ICommonList{
	private int bmxxId = 0;
	private static HashMap<String, String> fieldMap;
	static {
	    fieldMap = new HashMap<String, String>();
	    fieldMap.put("bmxxid", "bmxxid");
	    fieldMap.put("cjjdid", "cjjdid");
	    fieldMap.put("zxtxdz", "zxtxdz");
	    fieldMap.put("zxjb", "zxjb");
	    fieldMap.put("zxybm", "zxybm");		
	    fieldMap.put("zxlxdh", "zxlxdh");
	    fieldMap.put("njfzr", "njfzr");
		
	    fieldMap.put("gysyw", "gysyw");
	    fieldMap.put("gyssx", "gyssx");	
	    fieldMap.put("gyswy", "gyswy");
	    fieldMap.put("gyswl", "gyswl");	
	    fieldMap.put("gyshx", "gyshx");
	    fieldMap.put("gyssw", "gyssw");	
	    fieldMap.put("gysls", "gysls");
	    fieldMap.put("gyszz", "gyszz");	
	    fieldMap.put("gysdl", "gysdl");
	    fieldMap.put("gysty", "gysty");		
	    fieldMap.put("gyszf", "gyszf");
	    fieldMap.put("gysbjmc", "gysbjmc");	
	    fieldMap.put("gysbjrs", "gysbjrs");
	    fieldMap.put("gysnjmc", "gysnjmc");	
	    fieldMap.put("gysnjrs", "gysnjrs");

	    fieldMap.put("gyxyw", "gyxyw");
	    fieldMap.put("gyxsx", "gyxsx");	
	    fieldMap.put("gyxwy", "gyxwy");
	    fieldMap.put("gyxwl", "gyxwl");	
	    fieldMap.put("gyxhx", "gyxhx");
	    fieldMap.put("gyxsw", "gyxsw");	
	    fieldMap.put("gyxls", "gyxls");
	    fieldMap.put("gyxzz", "gyxzz");	
	    fieldMap.put("gyxdl", "gyxdl");
	    fieldMap.put("gyxty", "gyxty");		
	    fieldMap.put("gyxzf", "gyxzf");
	    fieldMap.put("gyxbjmc", "gyxbjmc");	
	    fieldMap.put("gyxbjrs", "gyxbjrs");
	    fieldMap.put("gyxnjmc", "gyxnjmc");	
	    fieldMap.put("gyxnjrs", "gyxnjrs");

	    fieldMap.put("gesyw", "gesyw");
	    fieldMap.put("gessx", "gessx");	
	    fieldMap.put("geswy", "geswy");
	    fieldMap.put("geswl", "geswl");	
	    fieldMap.put("geshx", "geshx");
	    fieldMap.put("gessw", "gessw");	
	    fieldMap.put("gesls", "gesls");
	    fieldMap.put("geszz", "geszz");	
	    fieldMap.put("gesdl", "gesdl");
	    fieldMap.put("gesty", "gesty");		
	    fieldMap.put("geszf", "geszf");
	    fieldMap.put("gesbjmc", "gesbjmc");	
	    fieldMap.put("gesbjrs", "gesbjrs");
	    fieldMap.put("gesnjmc", "gesnjmc");	
	    fieldMap.put("gesnjrs", "gesnjrs");
		
	    fieldMap.put("gexyw", "gexyw");
	    fieldMap.put("gexsx", "gexsx");	
	    fieldMap.put("gexwy", "gexwy");
	    fieldMap.put("gexwl", "gexwl");	
	    fieldMap.put("gexhx", "gexhx");
	    fieldMap.put("gexsw", "gexsw");	
	    fieldMap.put("gexls", "gexls");
	    fieldMap.put("gexzz", "gexzz");	
	    fieldMap.put("gexdl", "gexdl");
	    fieldMap.put("gexty", "gexty");		
	    fieldMap.put("gexzf", "gexzf");
	    fieldMap.put("gexbjmc", "gexbjmc");	
	    fieldMap.put("gexbjrs", "gexbjrs");
	    fieldMap.put("gexnjmc", "gexnjmc");	
	    fieldMap.put("gexnjrs", "gexnjrs");

	    fieldMap.put("gssyw", "gssyw");
	    fieldMap.put("gsssx", "gsssx");	
	    fieldMap.put("gsswy", "gsswy");
	    fieldMap.put("gsswl", "gsswl");	
	    fieldMap.put("gsshx", "gsshx");
	    fieldMap.put("gsssw", "gsssw");	
	    fieldMap.put("gssls", "gssls");
	    fieldMap.put("gsszz", "gsszz");	
	    fieldMap.put("gssdl", "gssdl");
	    fieldMap.put("gssty", "gssty");		
	    fieldMap.put("gsszf", "gsszf");
	    fieldMap.put("gssbjmc", "gssbjmc");	
	    fieldMap.put("gssbjrs", "gssbjrs");
	    fieldMap.put("gssnjmc", "gssnjmc");	
	    fieldMap.put("gssnjrs", "gssnjrs");

	    fieldMap.put("hkyw", "hkyw");
	    fieldMap.put("hksx", "hksx");	
	    fieldMap.put("hkwy", "hkwy");
	    fieldMap.put("hkwl", "hkwl");	
	    fieldMap.put("hkhx", "hkhx");
	    fieldMap.put("hksw", "hksw");	
	    fieldMap.put("hkls", "hkls");
	    fieldMap.put("hkzz", "hkzz");	
	    fieldMap.put("hkdl", "hkdl");
	    fieldMap.put("hkty", "hkty");		
	    fieldMap.put("hkzf", "hkzf");
	    fieldMap.put("hkbjmc", "hkbjmc");	
	    fieldMap.put("hkbjrs", "hkbjrs");
	    fieldMap.put("hknjmc", "hknjmc");	
	    fieldMap.put("hknjrs", "hknjrs");

	    fieldMap.put("zjyw", "zjyw");
	    fieldMap.put("zjsx", "zjsx");	
	    fieldMap.put("zjwy", "zjwy");
	    fieldMap.put("zjwl", "zjwl");	
	    fieldMap.put("zjhx", "zjhx");
	    fieldMap.put("zjsw", "zjsw");	
	    fieldMap.put("zjls", "zjls");
	    fieldMap.put("zjzz", "zjzz");	
	    fieldMap.put("zjdl", "zjdl");
	    fieldMap.put("zjty", "zjty");		
	    fieldMap.put("zjzf", "zjzf");
	    fieldMap.put("zjbjmc", "zjbjmc");	
	    fieldMap.put("zjbjrs", "zjbjrs");
	    fieldMap.put("zjnjmc", "zjnjmc");	
	    fieldMap.put("zjnjrs", "zjnjrs");
		fieldMap.put("bzrpj", "bzrpj");
	}
	public CjjdList(){
		
	}
	public CjjdList(int id){
		this.bmxxId = id;
	}

	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}
	public void setBmxxid(int id){
		this.bmxxId = id;
	}

	public Object getObject() {
		return new Cjjd();
	}

	public String getQL() {
		return "select * from cjjd where bmxxid=" + this.bmxxId;
	}

	public String delete(Object obj) {
		return "delete from cjjd where bmxxid=" + this.bmxxId;
	}
	public String update(Object obj) {
		Cjjd Cjjd = (Cjjd)obj;
		StringBuffer sql = new StringBuffer("update cjjd set zxtxdz='");	

		sql.append(Cjjd.getZxtxdz());
		sql.append("', zxjb='");
		sql.append(Cjjd.getZxjb());
		sql.append("', zxybm='");
		sql.append(Cjjd.getZxybm());
		sql.append("', zxlxdh='");		
		sql.append(Cjjd.getZxlxdh());		

		sql.append("', njfzr='");		
		sql.append(Cjjd.getNjfzr());		

		sql.append("', gysyw='");		
		sql.append(Cjjd.getGysyw());			
		sql.append("', gyssx='");		
		sql.append(Cjjd.getGyssx());			
		sql.append("', gyswy='");		
		sql.append(Cjjd.getGyswy());			
		sql.append("', gyswl='");		
		sql.append(Cjjd.getGyswl());			
		sql.append("', gyshx='");		
		sql.append(Cjjd.getGyshx());			
		sql.append("', gyssw='");		
		sql.append(Cjjd.getGyssw());			
		sql.append("', gysls='");		
		sql.append(Cjjd.getGysls());			
		sql.append("', gyszz='");		
		sql.append(Cjjd.getGyszz());			
		sql.append("', gysdl='");		
		sql.append(Cjjd.getGysdl());			
		sql.append("', gysty='");		
		sql.append(Cjjd.getGysty());			
		sql.append("', gyszf='");		
		sql.append(Cjjd.getGyszf());			
		sql.append("', gysbjmc=");		
		sql.append(Cjjd.getGysbjmc());			
		sql.append(", gysbjrs=");		
		sql.append(Cjjd.getGysbjrs());			
		sql.append(", gysnjmc=");		
		sql.append(Cjjd.getGysnjmc());			
		sql.append(", gysnjrs=");		
		sql.append(Cjjd.getGysnjrs());			

		sql.append(", gyxyw='");		
		sql.append(Cjjd.getGyxyw());			
		sql.append("', gyxsx='");		
		sql.append(Cjjd.getGyxsx());			
		sql.append("', gyxwy='");		
		sql.append(Cjjd.getGyxwy());			
		sql.append("', gyxwl='");		
		sql.append(Cjjd.getGyxwl());			
		sql.append("', gyxhx='");		
		sql.append(Cjjd.getGyxhx());			
		sql.append("', gyxsw='");		
		sql.append(Cjjd.getGyxsw());			
		sql.append("', gyxls='");		
		sql.append(Cjjd.getGyxls());			
		sql.append("', gyxzz='");		
		sql.append(Cjjd.getGyxzz());			
		sql.append("', gyxdl='");		
		sql.append(Cjjd.getGyxdl());			
		sql.append("', gyxty='");		
		sql.append(Cjjd.getGyxty());			
		sql.append("', gyxzf='");		
		sql.append(Cjjd.getGyxzf());			
		sql.append("', gyxbjmc=");		
		sql.append(Cjjd.getGyxbjmc());			
		sql.append(", gyxbjrs=");		
		sql.append(Cjjd.getGyxbjrs());			
		sql.append(", gyxnjmc=");		
		sql.append(Cjjd.getGyxnjmc());			
		sql.append(", gyxnjrs=");		
		sql.append(Cjjd.getGyxnjrs());		
		
		sql.append(", gesyw='");		
		sql.append(Cjjd.getGesyw());			
		sql.append("', gessx='");		
		sql.append(Cjjd.getGessx());			
		sql.append("', geswy='");		
		sql.append(Cjjd.getGeswy());			
		sql.append("', geswl='");		
		sql.append(Cjjd.getGeswl());			
		sql.append("', geshx='");		
		sql.append(Cjjd.getGeshx());			
		sql.append("', gessw='");		
		sql.append(Cjjd.getGessw());			
		sql.append("', gesls='");		
		sql.append(Cjjd.getGesls());			
		sql.append("', geszz='");		
		sql.append(Cjjd.getGeszz());			
		sql.append("', gesdl='");		
		sql.append(Cjjd.getGesdl());			
		sql.append("', gesty='");		
		sql.append(Cjjd.getGesty());			
		sql.append("', geszf='");		
		sql.append(Cjjd.getGeszf());			
		sql.append("', gesbjmc=");		
		sql.append(Cjjd.getGesbjmc());			
		sql.append(", gesbjrs=");		
		sql.append(Cjjd.getGesbjrs());			
		sql.append(", gesnjmc=");		
		sql.append(Cjjd.getGesnjmc());			
		sql.append(", gesnjrs=");		
		sql.append(Cjjd.getGesnjrs());		
		
		sql.append(", gexyw='");		
		sql.append(Cjjd.getGexyw());			
		sql.append("', gexsx='");		
		sql.append(Cjjd.getGexsx());			
		sql.append("', gexwy='");		
		sql.append(Cjjd.getGexwy());			
		sql.append("', gexwl='");		
		sql.append(Cjjd.getGexwl());			
		sql.append("', gexhx='");		
		sql.append(Cjjd.getGexhx());			
		sql.append("', gexsw='");		
		sql.append(Cjjd.getGexsw());			
		sql.append("', gexls='");		
		sql.append(Cjjd.getGexls());			
		sql.append("', gexzz='");		
		sql.append(Cjjd.getGexzz());			
		sql.append("', gexdl='");		
		sql.append(Cjjd.getGexdl());			
		sql.append("', gexty='");		
		sql.append(Cjjd.getGexty());			
		sql.append("', gexzf='");		
		sql.append(Cjjd.getGexzf());			
		sql.append("', gexbjmc=");		
		sql.append(Cjjd.getGexbjmc());			
		sql.append(", gexbjrs=");		
		sql.append(Cjjd.getGexbjrs());			
		sql.append(", gexnjmc=");		
		sql.append(Cjjd.getGexnjmc());			
		sql.append(", gexnjrs=");		
		sql.append(Cjjd.getGexnjrs());		
		
		sql.append(", gssyw='");		
		sql.append(Cjjd.getGssyw());			
		sql.append("', gsssx='");		
		sql.append(Cjjd.getGsssx());			
		sql.append("', gsswy='");		
		sql.append(Cjjd.getGsswy());			
		sql.append("', gsswl='");		
		sql.append(Cjjd.getGsswl());			
		sql.append("', gsshx='");		
		sql.append(Cjjd.getGsshx());			
		sql.append("', gsssw='");		
		sql.append(Cjjd.getGsssw());			
		sql.append("', gssls='");		
		sql.append(Cjjd.getGssls());			
		sql.append("', gsszz='");		
		sql.append(Cjjd.getGsszz());			
		sql.append("', gssdl='");		
		sql.append(Cjjd.getGssdl());			
		sql.append("', gssty='");		
		sql.append(Cjjd.getGssty());			
		sql.append("', gsszf='");		
		sql.append(Cjjd.getGsszf());			
		sql.append("', gssbjmc=");		
		sql.append(Cjjd.getGssbjmc());			
		sql.append(", gssbjrs=");		
		sql.append(Cjjd.getGssbjrs());			
		sql.append(", gssnjmc=");		
		sql.append(Cjjd.getGssnjmc());			
		sql.append(", gssnjrs=");		
		sql.append(Cjjd.getGssnjrs());		

		sql.append(", hkyw='");		
		sql.append(Cjjd.getHkyw());			
		sql.append("', hksx='");		
		sql.append(Cjjd.getHksx());			
		sql.append("', hkwy='");		
		sql.append(Cjjd.getHkwy());			
		sql.append("', hkwl='");		
		sql.append(Cjjd.getHkwl());			
		sql.append("', hkhx='");		
		sql.append(Cjjd.getHkhx());			
		sql.append("', hksw='");		
		sql.append(Cjjd.getHksw());			
		sql.append("', hkls='");		
		sql.append(Cjjd.getHkls());			
		sql.append("', hkzz='");		
		sql.append(Cjjd.getHkzz());			
		sql.append("', hkdl='");		
		sql.append(Cjjd.getHkdl());			
		sql.append("', hkty='");		
		sql.append(Cjjd.getHkty());			
		sql.append("', hkzf='");		
		sql.append(Cjjd.getHkzf());			
		sql.append("', hkbjmc=");		
		sql.append(Cjjd.getHkbjmc());			
		sql.append(", hkbjrs=");		
		sql.append(Cjjd.getHkbjrs());			
		sql.append(", hknjmc=");		
		sql.append(Cjjd.getHknjmc());			
		sql.append(", hknjrs=");		
		sql.append(Cjjd.getHknjrs());		

		sql.append(", zjyw='");		
		sql.append(Cjjd.getZjyw());			
		sql.append("', zjsx='");		
		sql.append(Cjjd.getZjsx());			
		sql.append("', zjwy='");		
		sql.append(Cjjd.getZjwy());			
		sql.append("', zjwl='");		
		sql.append(Cjjd.getZjwl());			
		sql.append("', zjhx='");		
		sql.append(Cjjd.getZjhx());			
		sql.append("', zjsw='");		
		sql.append(Cjjd.getZjsw());			
		sql.append("', zjls='");		
		sql.append(Cjjd.getZjls());			
		sql.append("', zjzz='");		
		sql.append(Cjjd.getZjzz());			
		sql.append("', zjdl='");		
		sql.append(Cjjd.getZjdl());			
		sql.append("', zjty='");		
		sql.append(Cjjd.getZjty());			
		sql.append("', zjzf='");		
		sql.append(Cjjd.getZjzf());			
		sql.append("', zjbjmc=");		
		sql.append(Cjjd.getZjbjmc());			
		sql.append(", zjbjrs=");		
		sql.append(Cjjd.getZjbjrs());			
		sql.append(", zjnjmc=");		
		sql.append(Cjjd.getZjnjmc());			
		sql.append(", zjnjrs=");		
		sql.append(Cjjd.getZjnjrs());		
		sql.append(", bzrpj='");	
		sql.append(Cjjd.getBzrpj());
		sql.append("'");

		sql.append(" where cjjdid=");
		sql.append(Cjjd.getCjjdid());
		sql.append(" and bmxxid=");
		sql.append(Cjjd.getBmxxid());

		return sql.toString();
	}
	public String insert(Object obj) {
		Cjjd Cjjd = (Cjjd)obj;
		StringBuffer sql = new StringBuffer("insert into cjjd(" +
				"bmxxid,zxtxdz,zxjb,zxybm,zxlxdh,njfzr,"+
				"gysyw,gyssx,gyswy,gyswl,gyshx,gyssw,gysls,gyszz,gysdl,gysty,gyszf,gysbjmc,gysbjrs,gysnjmc,gysnjrs," +
				"gyxyw,gyxsx,gyxwy,gyxwl,gyxhx,gyxsw,gyxls,gyxzz,gyxdl,gyxty,gyxzf,gyxbjmc,gyxbjrs,gyxnjmc,gyxnjrs,"+
				"gesyw,gessx,geswy,geswl,geshx,gessw,gesls,geszz,gesdl,gesty,geszf,gesbjmc,gesbjrs,gesnjmc,gesnjrs,"+
				"gexyw,gexsx,gexwy,gexwl,gexhx,gexsw,gexls,gexzz,gexdl,gexty,gexzf,gexbjmc,gexbjrs,gexnjmc,gexnjrs,"+
				"gssyw,gsssx,gsswy,gsswl,gsshx,gsssw,gssls,gsszz,gssdl,gssty,gsszf,gssbjmc,gssbjrs,gssnjmc,gssnjrs,"+
				"hkyw,hksx,hkwy,hkwl,hkhx,hksw,hkls,hkzz,hkdl,hkty,hkzf,hkbjmc,hkbjrs,hknjmc,hknjrs,"+
				"zjyw,zjsx,zjwy,zjwl,zjhx,zjsw,zjls,zjzz,zjdl,zjty,zjzf,zjbjmc,zjbjrs,zjnjmc,zjnjrs,bzrpj) values(");
		sql.append(Cjjd.getBmxxid());
		sql.append(",'");
		sql.append(Cjjd.getZxtxdz());
		sql.append("','");
		sql.append(Cjjd.getZxjb());
		sql.append("','");
		sql.append(Cjjd.getZxybm());
		sql.append("','");
		sql.append(Cjjd.getZxlxdh());
		sql.append("','");
		sql.append(Cjjd.getNjfzr());
		sql.append("','");
		
		sql.append(Cjjd.getGysyw());		
		sql.append("','");
		sql.append(Cjjd.getGyssx());
		sql.append("','");
		sql.append(Cjjd.getGyswy());
		sql.append("','");
		sql.append(Cjjd.getGyswl());
		sql.append("','");
		sql.append(Cjjd.getGyshx());
		sql.append("','");
		sql.append(Cjjd.getGyssw());
		sql.append("','");
		sql.append(Cjjd.getGysls());
		sql.append("','");
		sql.append(Cjjd.getGyszz());
		sql.append("','");
		sql.append(Cjjd.getGysdl());
		sql.append("','");
		sql.append(Cjjd.getGysty());
		sql.append("','");
		sql.append(Cjjd.getGyszf());
		sql.append("',");
		
		sql.append(Cjjd.getGysbjmc());
		sql.append(",");
		sql.append(Cjjd.getGysbjrs());
		sql.append(",");
		sql.append(Cjjd.getGysnjmc());
		sql.append(",");
		sql.append(Cjjd.getGysnjrs());
		
		sql.append(",'");
		sql.append(Cjjd.getGyxyw());		
		sql.append("','");
		sql.append(Cjjd.getGyxsx());
		sql.append("','");
		sql.append(Cjjd.getGyxwy());
		sql.append("','");
		sql.append(Cjjd.getGyxwl());
		sql.append("','");
		sql.append(Cjjd.getGyxhx());
		sql.append("','");
		sql.append(Cjjd.getGyxsw());
		sql.append("','");
		sql.append(Cjjd.getGyxls());
		sql.append("','");
		sql.append(Cjjd.getGyxzz());
		sql.append("','");
		sql.append(Cjjd.getGyxdl());
		sql.append("','");
		sql.append(Cjjd.getGyxty());
		sql.append("','");
		sql.append(Cjjd.getGyxzf());
		sql.append("',");
		sql.append(Cjjd.getGyxbjmc());
		sql.append(",");
		sql.append(Cjjd.getGyxbjrs());
		sql.append(",");
		sql.append(Cjjd.getGyxnjmc());
		sql.append(",");
		sql.append(Cjjd.getGyxnjrs());
		
		sql.append(",'");
		sql.append(Cjjd.getGesyw());		
		sql.append("','");
		sql.append(Cjjd.getGessx());
		sql.append("','");
		sql.append(Cjjd.getGeswy());
		sql.append("','");
		sql.append(Cjjd.getGeswl());
		sql.append("','");
		sql.append(Cjjd.getGeshx());
		sql.append("','");
		sql.append(Cjjd.getGessw());
		sql.append("','");
		sql.append(Cjjd.getGesls());
		sql.append("','");
		sql.append(Cjjd.getGeszz());
		sql.append("','");
		sql.append(Cjjd.getGesdl());
		sql.append("','");
		sql.append(Cjjd.getGesty());
		sql.append("','");
		sql.append(Cjjd.getGeszf());
		sql.append("',");
		sql.append(Cjjd.getGesbjmc());
		sql.append(",");
		sql.append(Cjjd.getGesbjrs());
		sql.append(",");
		sql.append(Cjjd.getGesnjmc());
		sql.append(",");
		sql.append(Cjjd.getGesnjrs());
		
		sql.append(",'");
		sql.append(Cjjd.getGexyw());		
		sql.append("','");
		sql.append(Cjjd.getGexsx());
		sql.append("','");
		sql.append(Cjjd.getGexwy());
		sql.append("','");
		sql.append(Cjjd.getGexwl());
		sql.append("','");
		sql.append(Cjjd.getGexhx());
		sql.append("','");
		sql.append(Cjjd.getGexsw());
		sql.append("','");
		sql.append(Cjjd.getGexls());
		sql.append("','");
		sql.append(Cjjd.getGexzz());
		sql.append("','");
		sql.append(Cjjd.getGexdl());
		sql.append("','");
		sql.append(Cjjd.getGexty());
		sql.append("','");
		sql.append(Cjjd.getGexzf());
		sql.append("',");
		
		sql.append(Cjjd.getGexbjmc());
		sql.append(",");
		sql.append(Cjjd.getGexbjrs());
		sql.append(",");
		sql.append(Cjjd.getGexnjmc());
		sql.append(",");
		sql.append(Cjjd.getGexnjrs());
		sql.append(",'");
		
		sql.append(Cjjd.getGssyw());		
		sql.append("','");
		sql.append(Cjjd.getGsssx());
		sql.append("','");
		sql.append(Cjjd.getGsswy());
		sql.append("','");
		sql.append(Cjjd.getGsswl());
		sql.append("','");
		sql.append(Cjjd.getGsshx());
		sql.append("','");
		sql.append(Cjjd.getGsssw());
		sql.append("','");
		sql.append(Cjjd.getGssls());
		sql.append("','");
		sql.append(Cjjd.getGsszz());
		sql.append("','");
		sql.append(Cjjd.getGssdl());
		sql.append("','");
		sql.append(Cjjd.getGssty());
		sql.append("','");
		sql.append(Cjjd.getGsszf());
		sql.append("',");
		sql.append(Cjjd.getGssbjmc());
		sql.append(",");
		sql.append(Cjjd.getGssbjrs());
		sql.append(",");
		sql.append(Cjjd.getGssnjmc());
		sql.append(",");
		sql.append(Cjjd.getGssnjrs());
		sql.append(",'");
		
		sql.append(Cjjd.getHkyw());		
		sql.append("','");
		sql.append(Cjjd.getHksx());
		sql.append("','");
		sql.append(Cjjd.getHkwy());
		sql.append("','");
		sql.append(Cjjd.getHkwl());
		sql.append("','");
		sql.append(Cjjd.getHkhx());
		sql.append("','");
		sql.append(Cjjd.getHksw());
		sql.append("','");
		sql.append(Cjjd.getHkls());
		sql.append("','");
		sql.append(Cjjd.getHkzz());
		sql.append("','");
		sql.append(Cjjd.getHkdl());
		sql.append("','");
		sql.append(Cjjd.getHkty());
		sql.append("','");
		sql.append(Cjjd.getHkzf());
		sql.append("',");
		sql.append(Cjjd.getHkbjmc());
		sql.append(",");
		sql.append(Cjjd.getHkbjrs());
		sql.append(",");
		sql.append(Cjjd.getHknjmc());
		sql.append(",");
		sql.append(Cjjd.getHknjrs());

		sql.append(",'");
		sql.append(Cjjd.getZjyw());		
		sql.append("','");
		sql.append(Cjjd.getZjsx());
		sql.append("','");
		sql.append(Cjjd.getZjwy());
		sql.append("','");
		sql.append(Cjjd.getZjwl());
		sql.append("','");
		sql.append(Cjjd.getZjhx());
		sql.append("','");
		sql.append(Cjjd.getZjsw());
		sql.append("','");
		sql.append(Cjjd.getZjls());
		sql.append("','");
		sql.append(Cjjd.getZjzz());
		sql.append("','");
		sql.append(Cjjd.getZjdl());
		sql.append("','");
		sql.append(Cjjd.getZjty());
		sql.append("','");
		sql.append(Cjjd.getZjzf());
		sql.append("',");
		sql.append(Cjjd.getZjbjmc());
		sql.append(",");
		sql.append(Cjjd.getZjbjrs());
		sql.append(",");
		sql.append(Cjjd.getZjnjmc());
		sql.append(",");
		sql.append(Cjjd.getZjnjrs());
		sql.append(",'");
		sql.append(Cjjd.getBzrpj());
		
		sql.append("')");
		return sql.toString();
	}
}
