package edu.cup.rs.common;

import java.util.HashMap;

public interface ICommonList
{
    //public String setFilter(Object o);
    public String getQL();
    public String insert(Object obj);
    public String delete(Object obj);
	public String update(Object obj);
    public Object getObject();
    public HashMap<String, String> getFieldMap();
}
