package edu.cup.rs.reg;

import java.io.Serializable;

public class Zhshzy implements Serializable {
	private static final long serialVersionUID = 1L;

	private int zyid;
	private java.lang.String zymc;
	private int type;

	public int getZyid() {
		return this.zyid;
	}

	public void setZyid(int zyid) {
		this.zyid = zyid;
	}

	public int getType() {
		return this.type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public java.lang.String getZymc() {
		return this.zymc;
	}

	public void setZymc(java.lang.String zymc) {
		this.zymc = zymc;
	}

	public String toString() {
		return "{" + "zyid()=" + zyid + "," + "zymc()=" + zymc + "," + "}";
	}
}