package edu.cup.rs.reg;


import java.io.Serializable;


public class User implements Serializable {

	/**
	* userid
	*/
	private int userid;
	private int admin;

	/**
	* username
	*/
	private java.lang.String username;

	/**
	* userpwd
	*/
	private java.lang.String userpwd;
	private java.lang.String question;
	private java.lang.String answer;
	private java.lang.String email;
	/**
	* regTime
	*/
	private java.util.Date regTime;

	/**
	* regIp
	*/
	private java.lang.String regIp;

	/**
	* 获取 userid 的属性值
	* @return userid : userid
	* @author tangkf
	*/
	public int getUserid(){
		return this.userid;
	}

	/**
	* 设置 userid 的属性值
	* @param userid : userid
	* @author tangkf
	*/
	public void setUserid(int userid){
		this.userid	= userid;
	}
	public int getAdmin(){
		return this.admin;
	}

	/**
	* 设置 userid 的属性值
	* @param userid : userid
	* @author tangkf
	*/
	public void setAdmin(int admin){
		this.admin	= admin;
	}

	/**
	* 获取 username 的属性值
	* @return username : username
	* @author tangkf
	*/
	public java.lang.String getUsername(){
		return this.username;
	}

	/**
	* 设置 username 的属性值
	* @param username : username
	* @author tangkf
	*/
	public void setUsername(java.lang.String username){
		this.username	= username;
	}

	/**
	* 获取 userpwd 的属性值
	* @return userpwd : userpwd
	* @author tangkf
	*/
	public java.lang.String getUserpwd(){
		return (null == this.userpwd)?"":this.userpwd;
	}

	/**
	* 设置 userpwd 的属性值
	* @param userpwd : userpwd
	* @author tangkf
	*/
	public void setUserpwd(java.lang.String userpwd){
		this.userpwd	= userpwd;
	}

	/**
	* 获取 regTime 的属性值
	* @return regTime : regTime
	* @author tangkf
	*/
	public java.util.Date getRegTime(){
		return this.regTime;
	}

	/**
	* 设置 regTime 的属性值
	* @param regTime : regTime
	* @author tangkf
	*/
	public void setRegTime(java.util.Date regTime){
		this.regTime	= regTime;
	}

	/**
	* 获取 regIp 的属性值
	* @return regIp : regIp
	* @author tangkf
	*/
	public java.lang.String getRegIp(){
		return this.regIp;
	}

	/**
	* 设置 regIp 的属性值
	* @param regIp : regIp
	* @author tangkf
	*/
	public void setRegIp(java.lang.String regIp){
		this.regIp	= regIp;
	}

	public String toString(){
		return "{" + "userid()=" + userid + "," + "username()=" + username + "," + "userpwd()=" + userpwd + "," + "regTime()=" + regTime + "," + "regIp()=" + regIp + "," +  "}";
	}

	public void setQuestion(java.lang.String question) {
		this.question = question;
	}

	public java.lang.String getQuestion() {
		return question;
	}

	public void setAnswer(java.lang.String answer) {
		this.answer = answer;
	}

	public java.lang.String getAnswer() {
		return (null == this.answer) ?"":this.answer;
	}

	public void setEmail(java.lang.String email) {
		this.email = email;
	}

	public java.lang.String getEmail() {
		return (null == this.email) ?"":this.email;
	}
}