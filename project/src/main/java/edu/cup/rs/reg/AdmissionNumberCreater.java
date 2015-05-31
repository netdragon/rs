package edu.cup.rs.reg;

public class AdmissionNumberCreater {
	public static String getNumber(int num) {
		StringBuffer rtn = new StringBuffer();
		if (0 < num && 10 > num) {
			rtn.append("000");
			rtn.append(num);
		} else if (10 <= num && 100 > num) {
			rtn.append("00");
			rtn.append(num);
		} else if (100 <= num && 1000 > num) {
			rtn.append("0");
			rtn.append(num);
		} else {
			return null;
		}
		return rtn.toString();
	}
}