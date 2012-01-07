package edu.cup.rs.reg;


import java.io.Serializable;

/**
* 
* @author tangkf
* @date 2010-05-11
*/
public class Message implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	* 类名称
	*/
	public static String REF="Message";

	/**
	* msgid 的属性名
	*/
	public static String PROP_MSGID="msgid";

	/**
	* userid 的属性名
	*/
	public static String PROP_USERID="userid";

	/**
	* msgtitle 的属性名
	*/
	public static String PROP_MSGTITLE="msgtitle";

	/**
	* msgcontent 的属性名
	*/
	public static String PROP_MSGCONTENT="msgcontent";

	/**
	* msgcatery 的属性名
	*/
	public static String PROP_MSGCATERY="msgcatery";

	/**
	* issuetime 的属性名
	*/
	public static String PROP_ISSUETIME="issuetime";

	/**
	* msgid
	*/
	private int msgid;

	/**
	* userid
	*/
	private int userid;

	/**
	* msgtitle
	*/
	private java.lang.String msgtitle;

	/**
	* msgcontent
	*/
	private java.lang.String msgcontent;

	/**
	* msgcatery
	*/
	private java.lang.String msgcatery;

	/**
	* issuetime
	*/
	private java.lang.String issuetime;

	/**
	* 获取 msgid 的属性值
	* @return msgid : msgid
	* @author tangkf
	*/
	public int getMsgid(){
		return this.msgid;
	}

	/**
	* 设置 msgid 的属性值
	* @param msgid : msgid
	* @author tangkf
	*/
	public void setMsgid(int msgid){
		this.msgid	= msgid;
	}

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

	/**
	* 获取 msgtitle 的属性值
	* @return msgtitle : msgtitle
	* @author tangkf
	*/
	public java.lang.String getMsgtitle(){
		return this.msgtitle;
	}

	/**
	* 设置 msgtitle 的属性值
	* @param msgtitle : msgtitle
	* @author tangkf
	*/
	public void setMsgtitle(java.lang.String msgtitle){
		this.msgtitle	= msgtitle;
	}

	/**
	* 获取 msgcontent 的属性值
	* @return msgcontent : msgcontent
	* @author tangkf
	*/
	public java.lang.String getMsgcontent(){
		return this.msgcontent;
	}

	/**
	* 设置 msgcontent 的属性值
	* @param msgcontent : msgcontent
	* @author tangkf
	*/
	public void setMsgcontent(java.lang.String msgcontent){
		this.msgcontent	= msgcontent;
	}

	/**
	* 获取 msgcatery 的属性值
	* @return msgcatery : msgcatery
	* @author tangkf
	*/
	public java.lang.String getMsgcatery(){
		return this.msgcatery;
	}

	/**
	* 设置 msgcatery 的属性值
	* @param msgcatery : msgcatery
	* @author tangkf
	*/
	public void setMsgcatery(java.lang.String msgcatery){
		this.msgcatery	= msgcatery;
	}

	/**
	* 获取 issuetime 的属性值
	* @return issuetime : issuetime
	* @author tangkf
	*/
	public java.lang.String getIssuetime(){
		return this.issuetime;
	}

	/**
	* 设置 issuetime 的属性值
	* @param issuetime : issuetime
	* @author tangkf
	*/
	public void setIssuetime(java.lang.String issuetime){
		this.issuetime	= issuetime;
	}

	public String toString(){
		return "{" + "msgid()=" + msgid + "," + "userid()=" + userid + "," + "msgtitle()=" + msgtitle + "," + "msgcontent()=" + msgcontent + "," + "msgcatery()=" + msgcatery + "," + "issuetime()=" + issuetime + "," +  "}";
	}
}