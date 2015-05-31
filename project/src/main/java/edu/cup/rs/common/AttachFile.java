package edu.cup.rs.common;


public class AttachFile{
    private String type=null;
    private String uuid=null;
    private String name=null;
    private String path=null;
    private String catalog=null;
    private long size=-1;
    public AttachFile(String name,String type,String uuid,String path,String catalog,long size){
        this.type=type;
        this.name=name;
        this.uuid=uuid;
        this.path=path;
        this.catalog=catalog;
        this.size=size;
    }
    public String getType(){
        return type;
    }
    public String getName(){
        return name;
    }
    public String getCatalog(){
        return catalog;
    }
    public String getUUID(){
        return uuid;
    }
    public String getPath(){
        return path;
    }
    public long getSize(){
        return size;
    }
}


