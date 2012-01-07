package edu.cup.rs.reg;


import java.io.Serializable;


public class Zhkzh implements Serializable {
	private static final long serialVersionUID = 1L;
	private java.lang.String zhkzhid;
	private int kssjid;

	public java.lang.String getZhkzhid(){
		return this.zhkzhid;
	}

	public void setZhkzhid(java.lang.String zhkzhid){
		this.zhkzhid	= zhkzhid;
	}

	public int getKssjid(){
		return this.kssjid;
	}

	public void setKssjid(int kssjid){
		this.kssjid	= kssjid;
	}


	public String toString(){
		return "{" + "zhkzhid()=" + zhkzhid + "," + "kssjid()=" + kssjid +  "}";
	}
}