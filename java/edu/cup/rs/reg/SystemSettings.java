package edu.cup.rs.reg;


import java.io.Serializable;


public class SystemSettings implements Serializable {
	private static final long serialVersionUID = 1L;
	private java.lang.String item;
	private java.lang.String value;

	public java.lang.String getItem(){
		return this.item;
	}

	public void setItem(java.lang.String item){
		this.item	= item;
	}
	public java.lang.String getValue(){
		return this.value;
	}

	public void setValue(java.lang.String value){
		this.value	= value;
	}

	public String toString(){
		return "{" + "item()=" + item + "," + "value()=" + value +  "}";
	}
}