package edu.cup.rs.reg;

import java.util.HashMap;
import edu.cup.rs.common.ICommonList;

public class UserList implements ICommonList{
	private int userId = 0;
	private String userName = "";
	private static HashMap<String, String> fieldMap;
	static {
		fieldMap = new HashMap<String, String>();
		fieldMap.put("userid", "userid");
	    fieldMap.put("username", "username");
        fieldMap.put("reg_time", "regTime");
        fieldMap.put("reg_ip", "regIp");
        fieldMap.put("userpwd", "userpwd");
        fieldMap.put("question", "question");
        fieldMap.put("answer", "answer");
        fieldMap.put("email", "email");
		fieldMap.put("admin", "admin");
	}
	public UserList(){
		
	}
	public UserList(int id){
		this.userId = id;
	}
	public UserList(String userName){
		this.userName = userName;
	}
	public HashMap<String, String> getFieldMap() {
		return fieldMap;
	}


	public Object getObject() {
		return new User();
	}


	public String getQL() {
		if(0 == this.userId){
			if(userName.length()>0) 
				return "select userpwd,userid,username,email,question,answer,admin from user where username='" + userName +"'";
			return "select userpwd,userid,username,email,question,answer,admin from user";
		}
		return "select userpwd,userid,username,email,question,answer,admin from user where userid=" + this.userId;
	}

	public String delete(Object obj) {
		return "";
	}
	public String update(Object obj) {
		return "";
	}
	public String modifyPwd(String pwd, int userid){
		return "update user set userpwd='" + pwd +"' where userid=" + userid;
	}
	public String modifyReg(User user){
		return "update user set email='" + user.getEmail() +"', question='" + user.getQuestion() + "', answer='" + user.getAnswer() +"' where userid=" + user.getUserid();
	}
	
	public String insert(Object obj) {
		User user = (User)obj;
		StringBuffer sql = new StringBuffer("insert user(reg_time, username,userpwd,reg_ip,question,answer,email) values(now(),'");
		sql.append(user.getUsername());
		sql.append("','");
		sql.append(user.getUserpwd());
		sql.append("','");
		sql.append(user.getRegIp());
		sql.append("','");
		sql.append(user.getQuestion());
		sql.append("','");
		sql.append(user.getAnswer());
		sql.append("','");
		sql.append(user.getEmail());
		sql.append("')");
		return sql.toString();
	}

}
