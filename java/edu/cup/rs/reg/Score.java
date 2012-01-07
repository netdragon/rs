package edu.cup.rs.reg;


import java.io.Serializable;

/**
* 
* @author tangkf
* @date 2010-05-11
*/
public class Score implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	* 类名称
	*/
	public static String REF="Score";

	/**
	* kmid 的属性名
	*/
	public static String PROP_KMID="kmid";

	/**
	* bmxxid 的属性名
	*/
	public static String PROP_BMXXID="bmxxid";

	/**
	* fenshu 的属性名
	*/
	public static String PROP_FENSHU="fenshu";

	/**
	* lrcjsj 的属性名
	*/
	public static String PROP_LRCJSJ="lrcjsj";

	/**
	* kmid
	*/
	private int kmid;

	/**
	* bmxxid
	*/
	private int bmxxid;

	/**
	* fenshu
	*/
	private float fenshu;

	/**
	* lrcjsj
	*/
	private java.util.Date lrcjsj;

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
	* 获取 bmxxid 的属性值
	* @return bmxxid : bmxxid
	* @author tangkf
	*/
	public int getBmxxid(){
		return this.bmxxid;
	}

	/**
	* 设置 bmxxid 的属性值
	* @param bmxxid : bmxxid
	* @author tangkf
	*/
	public void setBmxxid(int bmxxid){
		this.bmxxid	= bmxxid;
	}

	/**
	* 获取 fenshu 的属性值
	* @return fenshu : fenshu
	* @author tangkf
	*/
	public float getFenshu(){
		return this.fenshu;
	}

	/**
	* 设置 fenshu 的属性值
	* @param fenshu : fenshu
	* @author tangkf
	*/
	public void setFenshu(float fenshu){
		this.fenshu	= fenshu;
	}

	/**
	* 获取 lrcjsj 的属性值
	* @return lrcjsj : lrcjsj
	* @author tangkf
	*/
	public java.util.Date getLrcjsj(){
		return this.lrcjsj;
	}

	/**
	* 设置 lrcjsj 的属性值
	* @param lrcjsj : lrcjsj
	* @author tangkf
	*/
	public void setLrcjsj(java.util.Date lrcjsj){
		this.lrcjsj	= lrcjsj;
	}

	public String toString(){
		return "{" + "kmid()=" + kmid + "," + "bmxxid()=" + bmxxid + "," + "fenshu()=" + fenshu + "," + "lrcjsj()=" + lrcjsj + "," +  "}";
	}
}