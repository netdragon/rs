package edu.cup.rs.reg;


import java.io.Serializable;
import java.util.Date;

/**
* 
* @author tangkf
* @date 2010-05-11
*/
public class Log implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;
	private java.sql.Timestamp timestamp; 
	private java.lang.String content;


	public int getId(){
		return this.id;
	}
	public void setId(int id){
		this.id	= id;
	}

	public java.sql.Timestamp getTimestamp(){
		return this.timestamp;
	}
	public void setTimestamp(java.sql.Timestamp timestamp){
		this.timestamp	= timestamp;
	}

	public java.lang.String getContent(){
		return this.content;
	}
	public void setContent(java.lang.String content){
		this.content	= content;
	}


	public String toString(){
		return "{" + "id()=" + id  + "," + "timestamp()=" + timestamp  + "content()=" + content + "," +  "}";
	}
}