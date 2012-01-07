package edu.cup.rs.common;

import java.io.UnsupportedEncodingException;

public class UTF8String {
	private String content;
	public UTF8String(String content) {
		this.content = content;
	}
    public String toUTF8String() {
    	try {
			return java.net.URLEncoder.encode(content,"utf-8");
		} catch (UnsupportedEncodingException e) {
			return content;
		}
    }
}
