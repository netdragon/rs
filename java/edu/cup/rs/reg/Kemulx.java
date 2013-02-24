package edu.cup.rs.reg;


import java.io.Serializable;

/**
* 
* @author tangkf
* @date 2010-05-11
*/
public class Kemulx implements Serializable {
	private static final long serialVersionUID = 1L;



	
	/**
	* lxid
	*/
	private int lxid;

	/**
	* lxmc
	*/
	private java.lang.String lxmc;

	/**
	* 获取 lxid 的属性值
	* @return lxid : lxid
	* @author tangkf
	*/
	public int getLxid(){
		return this.lxid;
	}

	/**
	* 设置 lxid 的属性值
	* @param lxid : lxid
	* @author tangkf
	*/
	public void setLxid(int lxid){
		this.lxid	= lxid;
	}

	/**
	* 获取 lxmc 的属性值
	* @return lxmc : lxmc
	* @author tangkf
	*/
	public java.lang.String getLxmc(){
		return this.lxmc;
	}
	private java.util.Date ksrq;

	/**
	* kssj
	*/
	private String kssj;

	/**
	* jssj
	*/
	private String jssj;
	public java.util.Date getKsrq(){
		return this.ksrq;
	}

	/**
	* 设置 ksrq 的属性值
	* @param ksrq : ksrq
	* @author tangkf
	*/
	public void setKsrq(java.util.Date ksrq){
		this.ksrq	= ksrq;
	}

	/**
	* 获取 kssj 的属性值
	* @return kssj : kssj
	* @author tangkf
	*/
	public String getKssj(){
		return this.kssj;
	}

	/**
	* 设置 kssj 的属性值
	* @param kssj : kssj
	* @author tangkf
	*/
	public void setKssj(String kssj){
		this.kssj	= kssj;
	}

	/**
	* 获取 jssj 的属性值
	* @return jssj : jssj
	* @author tangkf
	*/
	public String getJssj(){
		return this.jssj;
	}

	/**
	* 设置 jssj 的属性值
	* @param jssj : jssj
	* @author tangkf
	*/
	public void setJssj(String jssj){
		this.jssj	= jssj;
	}
	/**
	* 设置 lxmc 的属性值
	* @param lxmc : lxmc
	* @author tangkf
	*/
	public void setLxmc(java.lang.String lxmc){
		this.lxmc	= lxmc;
	}

	public String toString(){
		return "{" + "lxid()=" + lxid + "," + "lxmc()=" + lxmc + "," +  "}";
	}
}