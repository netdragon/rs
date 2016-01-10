package edu.cup.rs.reg;

import java.io.Serializable;

public class Bkzy implements Serializable {
	private static final long serialVersionUID = 1L;
	private int zyid;
	private int bmxxid;
	private int tjf;
	private int xh;
	private String zymc;

	public void setZymc(String zymc) {
		this.zymc = zymc;
	}

	public String getZymc() {
		return this.zymc;
	}

	public int getZyid() {
		return this.zyid;
	}

	public void setZyid(int zyid) {
		this.zyid = zyid;
	}

	public int getBmxxid() {
		return this.bmxxid;
	}

	public void setBmxxid(int bmxxid) {
		this.bmxxid = bmxxid;
	}

	public int getTjf() {
		return this.tjf;
	}

	public void setTjf(int tjf) {
		this.tjf = tjf;
	}

	public int getXh() {
		return this.xh;
	}

	public void setXh(int xh) {
		this.xh = xh;
	}

	public String toString() {
		return "{" + "zyid()=" + zyid + "," + "bmxxid()=" + bmxxid + ","
				+ "tjf()=" + tjf + "," + "}";
	}
}