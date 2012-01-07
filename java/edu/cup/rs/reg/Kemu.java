package edu.cup.rs.reg;


import java.io.Serializable;

/**
* 
* @author tangkf
* @date 2010-05-11
*/
public class Kemu implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	* 类名称
	*/
	public static String REF="Kemu";

	/**
	* kmid 的属性名
	*/
	public static String PROP_KMID="kmid";

	/**
	* kmmc 的属性名
	*/
	public static String PROP_KMMC="kmmc";
	
	/**
	* kmid
	*/
	private int kmid;

	/**
	* kmmc
	*/
	private java.lang.String kmmc;

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
	* 获取 kmmc 的属性值
	* @return kmmc : kmmc
	* @author tangkf
	*/
	public java.lang.String getKmmc(){
		return this.kmmc;
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
	* 设置 kmmc 的属性值
	* @param kmmc : kmmc
	* @author tangkf
	*/
	public void setKmmc(java.lang.String kmmc){
		this.kmmc	= kmmc;
	}

	public String toString(){
		return "{" + "kmid()=" + kmid + "," + "kmmc()=" + kmmc + "," +  "}";
	}
}