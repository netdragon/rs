package edu.cup.rs.reg;


import java.io.Serializable;
import java.util.Date;

public class Hjqk implements Serializable {

	private int hjqkid;
	private int bmxxid;
	private java.util.Date hjsj;
	private java.lang.String hjmc;
	private java.lang.String jsjb;
	private String hjdj;
	private java.lang.String sjbm;

	public java.lang.String getSjbm(){
		return this.sjbm;
	}
	public void setSjbm(java.lang.String sjbm){
		this.sjbm = sjbm;
	}
	public String getHjdj(){
		return this.hjdj;
	}
	public void setHjdj(String hjdj){
		this.hjdj = hjdj;
	}

	public int getHjqkid(){
		return this.hjqkid;
	}
	public void setHjqkid(int hjqkid){
		this.hjqkid	= hjqkid;
	}
	public int getBmxxid(){
		return this.bmxxid;
	}
	public void setBmxxid(int bmxxid){
		this.bmxxid	= bmxxid;
	}
	public Date getHjsj(){
		return this.hjsj;
	}
	public void setHjsj(Date hjsj){
		this.hjsj	= hjsj;
	}
	public java.lang.String getHjmc(){
		return this.hjmc;
	}
	public void setHjmc(java.lang.String hjmc){
		this.hjmc	= hjmc;
	}
	public java.lang.String getJsjb(){
		return this.jsjb;
	}
	public void setJsjb(java.lang.String jsjb){
		this.jsjb	= jsjb;
	}

	public String toString(){
		return "{" + "hjqkid()=" + hjqkid + "," + "bmxxid()=" + bmxxid + "," + "hjsj()=" + hjsj + "," + "hjmc()=" + hjmc + "," + "jsjb()=" + jsjb + "," +  "}";
	}
}
