package edu.cup.rs.reg.sys;

import java.io.Serializable;

public class Sqbkly implements Serializable {
	private static final long serialVersionUID = 1L;

	private java.lang.String mc;
	private int id;
	private int type;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getType() {
		return this.type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public java.lang.String getMc() {
		return this.mc;
	}

	public void setMc(java.lang.String mc) {
		this.mc = mc;
	}

	public String toString() {
		return "{" + "mc()=" + mc + "}";
	}
}