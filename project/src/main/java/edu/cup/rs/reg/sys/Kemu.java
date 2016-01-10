package edu.cup.rs.reg.sys;

import java.io.Serializable;

public class Kemu implements Serializable {
	private static final long serialVersionUID = 1L;

	private java.lang.String kmmc;
	private int kmid;
	private int kmlxid;

	public int getKmid() {
		return this.kmid;
	}

	public void setKmlxid(int kmlxid) {
		this.kmlxid = kmlxid;
	}

	public int getKmlxid() {
		return this.kmlxid;
	}

	public void setKmid(int kmid) {
		this.kmid = kmid;
	}

	public java.lang.String getKmmc() {
		return this.kmmc;
	}

	public void setKmmc(java.lang.String kmmc) {
		this.kmmc = kmmc;
	}

	public String toString() {
		return "{" + "kmmc()=" + kmmc + "}";
	}
}