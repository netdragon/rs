package edu.cup.rs.reg;


import java.io.Serializable;


public class Kssjap implements Serializable {
	private static final long serialVersionUID = 1L;


	private int kssjid;

	/**
	* kmid
	*/
	private int kmid;

	/**
	* riqi
	*/
	private java.lang.String riqi;

	/**
	* kssj
	*/
	private java.util.Date kssj;

	/**
	* jssj
	*/
	private java.util.Date jssj;

	/**
	* 获取 kssjid 的属性值
	* @return kssjid : kssjid
	* @author tangkf
	*/
	public int getKssjid(){
		return this.kssjid;
	}

	/**
	* 设置 kssjid 的属性值
	* @param kssjid : kssjid
	* @author tangkf
	*/
	public void setKssjid(int kssjid){
		this.kssjid	= kssjid;
	}

	/**
	* 获取 kmid 的属性值
	* @return kmid : kmid
	* @author tangkf
	*/
	public int getKmid(){
		return this.kmid;
	}

	/**
	* 设置 kmid 的属性值
	* @param kmid : kmid
	* @author tangkf
	*/
	public void setKmid(int kmid){
		this.kmid	= kmid;
	}

	/**
	* 获取 riqi 的属性值
	* @return riqi : riqi
	* @author tangkf
	*/
	public java.lang.String getRiqi(){
		return this.riqi;
	}

	/**
	* 设置 riqi 的属性值
	* @param riqi : riqi
	* @author tangkf
	*/
	public void setRiqi(java.lang.String riqi){
		this.riqi	= riqi;
	}

	/**
	* 获取 kssj 的属性值
	* @return kssj : kssj
	* @author tangkf
	*/
	public java.util.Date getKssj(){
		return this.kssj;
	}

	/**
	* 设置 kssj 的属性值
	* @param kssj : kssj
	* @author tangkf
	*/
	public void setKssj(java.util.Date kssj){
		this.kssj	= kssj;
	}

	/**
	* 获取 jssj 的属性值
	* @return jssj : jssj
	* @author tangkf
	*/
	public java.util.Date getJssj(){
		return this.jssj;
	}

	/**
	* 设置 jssj 的属性值
	* @param jssj : jssj
	* @author tangkf
	*/
	public void setJssj(java.util.Date jssj){
		this.jssj	= jssj;
	}

	public String toString(){
		return "{" + "kssjid()=" + kssjid + "," + "kmid()=" + kmid + "," + "riqi()=" + riqi + "," + "kssj()=" + kssj + "," + "jssj()=" + jssj + "," +  "}";
	}
}