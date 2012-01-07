package edu.cup.rs.util;

import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Properties;
import java.io.FileNotFoundException;
import java.net.URL;



public class PropertyAdapter {

    public boolean isExists(String fileName){
        URL propFilePath=getClass().getResource(fileName);
        
        if(null==propFilePath) return false;
        else return true;
    }
    public URL getURI(String fileName){
        URL propFilePath=getClass().getResource(fileName);
        
        return propFilePath;

    }
    public static URL getURI(Class className,String fileName){
        URL propFilePath=className.getClassLoader().getResource(fileName);
        
        return propFilePath;

    }
    public Properties getProp(String fileName) throws Exception{
        Properties prop = new Properties();
        try{
            InputStream in = null ;
            try {
                in =getClass().getResourceAsStream(fileName) ;
                prop.load(in) ;
            }
            catch (FileNotFoundException e) {
                
                throw e ;
                
            }
            finally {
                try {
                    in.close() ;
                }
                catch (Exception e) {
                    
                    throw e;
                }
            }
        } catch (Exception e) {

            throw e;
        }
        return prop;
    }
    public Properties getAbsProp(String fileName) throws Exception{
        Properties prop = new Properties();
        try{
            InputStream in = null ;
            try {
                in = new FileInputStream(fileName);
                prop.load(in) ;
            }
            catch (FileNotFoundException e) {
                
                throw e;
                
            }
            finally {
                try {
                    in.close() ;
                }
                catch (Exception e) {
                    
                    throw e;
                }
            }
        } catch (Exception e) {

            throw e;
        }
        return prop;
    }
}
