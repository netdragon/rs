package edu.cup.rs.util;
import org.bouncycastle.crypto.BlockCipher;
public class Encoder {
    public static String encrypt(String src){
    public static String decrypt(String src)
    private static byte[] trimBytes(byte[] src)
            if(src[i]==0)length--;
            else break;
        }
        byte[] dest=new byte[length];
        for(int i=0;i<length;i++)dest[i]=src[i];
        return dest;
    }
    public static void main(String[] args) {
        /*try{
            throw new Exception("");
        }
        catch(FileNotFoundException e){
            e.printStackTrace();
        }
        catch(Exception e2){
            System.out.print("aaa");
        }
        */
        //String src="abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcde";
}