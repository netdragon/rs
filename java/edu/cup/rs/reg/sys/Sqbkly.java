package edu.cup.rs.reg.sys;


import java.io.Serializable;


public class Sqbkly implements Serializable {
	private static final long serialVersionUID = 1L;

	private java.lang.String mc;


	public java.lang.String getMc(){
		return this.mc;
	}

	public void setMc(java.lang.String mc){
		this.mc	= mc;
	}

	public String toString(){
		return "{" + "mc()=" + mc +  "}";
	}
}