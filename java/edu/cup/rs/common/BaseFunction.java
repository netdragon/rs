package edu.cup.rs.common;

import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.security.MessageDigest;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.File;


import java.io.IOException;
import edu.cup.rs.log.LogHandler;

public class BaseFunction {
    private static LogHandler logger=LogHandler.getInstance(BaseFunction.class);

    public static String null2value(Object obj) {
        if (obj == null)
            return "";
        else
            return (String) obj;
    }


    public static boolean isNumeric(String str) {
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(str);
        if (!isNum.matches())
            return false;
        return true;
    }


    public static String getHash(String fileName, String hashType) {
        String sResult = "";
        InputStream fis = null;
        try {

            fis = new FileInputStream(fileName);
            byte[] buffer = new byte[1024];
            MessageDigest md5 = MessageDigest.getInstance(hashType);
            int numRead = 0;
            while ((numRead = fis.read(buffer)) > 0)
                md5.update(buffer, 0, numRead);

            sResult = toHexString(md5.digest());
        }
        catch (Exception e) {
            logger.error(e.getMessage());
        }
        finally {
            try {
                fis.close();
            }
            catch (Exception e) {
            }
        }
        return sResult;
    }


    public static String toHexString(byte[] b) {
        char[] hexChar = {'0', '1', '2', '3',
                '4', '5', '6', '7',
                '8', '9', 'a', 'b',
                'c', 'd', 'e', 'f'};
        StringBuilder sb = new StringBuilder(b.length * 2);
        for (int i = 0; i < b.length; i++) {
            sb.append(hexChar[(b[i] & 0xf0) >>> 4]);
            sb.append(hexChar[b[i] & 0x0f]);
        }
        return sb.toString();
    }
    public static void deleteDirFile(String sDirFilePath) throws IOException
    {
        if (sDirFilePath != null && !sDirFilePath.trim().equals(""))
        {
            File tDirFile = new File(sDirFilePath);
            if (tDirFile.exists())
            {
                if (tDirFile.isDirectory())
                {
                    File[] arrFiles = tDirFile.listFiles();
                    
                    for (int i = 0; i < arrFiles.length; i++)
                    {
                        deleteDirFile(arrFiles[i].getAbsolutePath());
                    }
                    arrFiles = null;
                    
                    tDirFile.delete();
                }
                else
                {
                    tDirFile.delete();
                }
            }
            tDirFile = null;
        }
    }
    public static int power(int inputNumber,int powerNumber)
    {
        if(powerNumber==1)
            return inputNumber;
        else{
            if(powerNumber==0) return 1;
            else return inputNumber*power(inputNumber,powerNumber-1);
        }
    }
  }
