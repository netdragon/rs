package edu.cup.rs.reg;

import java.io.Serializable;
import java.util.Date;

public class Hdqk implements Serializable {

	private int hdqkid;
	private int bmxxid;
	private java.util.Date hdsj;
	private java.lang.String hdmc;
	private java.lang.String brjsgx;

	public java.lang.String getBrjsgx() {
		return this.brjsgx;
	}

	public void setBrjsgx(java.lang.String brjsgx) {
		this.brjsgx = brjsgx;
	}

	public int getHdqkid() {
		return this.hdqkid;
	}

	public void setHdqkid(int hdqkid) {
		this.hdqkid = hdqkid;
	}

	public int getBmxxid() {
		return this.bmxxid;
	}

	public void setBmxxid(int bmxxid) {
		this.bmxxid = bmxxid;
	}

	public Date getHdsj() {
		return this.hdsj;
	}

	public void setHdsj(Date hdsj) {
		this.hdsj = hdsj;
	}

	public java.lang.String getHdmc() {
		return this.hdmc;
	}

	public void setHdmc(java.lang.String hdmc) {
		this.hdmc = hdmc;
	}

	public String toString() {
		return "{" + "hdqkid()=" + hdqkid + "," + "bmxxid()=" + bmxxid + ","
				+ "hdsj()=" + hdsj + "," + "hdmc()=" + hdmc + "}";
	}
}
