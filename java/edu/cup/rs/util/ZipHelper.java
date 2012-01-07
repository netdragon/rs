package edu.cup.rs.util;
import java.io.*;
import java.util.zip.*;


public class ZipHelper {
    final static int BUFFER = 2048;
    private String filePath;
    private java.util.zip.ZipOutputStream out;
    private java.io.File fromFile;


    public void zip(String zipFileName, String inputFile) throws Exception {
        zip(zipFileName, new File(inputFile));
    }


    public void zip(String zipFileName, File inputFile) throws Exception {
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
        zip(out, inputFile, "");
        out.close();
    }


    public void unzip(String zipFileName, String outputDirectory) throws Exception {
        ZipInputStream in = new ZipInputStream(new FileInputStream(zipFileName));
        ZipEntry z;
        while ((z = in.getNextEntry()) != null) {
            if (z.isDirectory()) {
                String name = z.getName();
                name = name.substring(0, name.length() - 1);
                File f = new File(outputDirectory + File.separator + name);
                f.mkdir();
            } else {
                File f = new File(outputDirectory + File.separator + z.getName());
                f.createNewFile();
                FileOutputStream out = new FileOutputStream(f);
                int b;
                while ((b = in.read()) != -1) {
                    out.write(b);
                }
                out.close();
            }
        }

        in.close();
    }


    public void zip(ZipOutputStream out, File f, String base) throws Exception {
        System.out.println("Zipping  " + f.getName());
        if (f.isDirectory()) {
            File[] fl = f.listFiles();
            out.putNextEntry(new ZipEntry(base + "/"));
            base = base.length() == 0 ? "" : base + "/";
            for (int i = 0; i < fl.length; i++) {
                zip(out, fl[i], base + fl[i].getName());
            }
        } else {
            if(base.length()==0) {base =f.getName();}
            out.putNextEntry(new ZipEntry(base));
            FileInputStream in = new FileInputStream(f);
            int b;
            while ((b = in.read()) != -1) {
                out.write(b);
            }
            in.close();
        }

    }

    public static void main(String[] args) {
        try {
            ZipHelper t = new ZipHelper();
            t.zip("/root/test1.zip", "/root/test");
            //t.unzip("c:\\test.zip", "c:\\test2");
        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
    }

}


