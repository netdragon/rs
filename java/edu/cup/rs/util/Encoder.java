package edu.cup.rs.util;
import org.bouncycastle.crypto.BlockCipher;import org.bouncycastle.crypto.BufferedBlockCipher;import org.bouncycastle.crypto.CryptoException;import org.bouncycastle.crypto.DataLengthException;import org.bouncycastle.crypto.engines.DESEngine;import org.bouncycastle.crypto.paddings.PaddedBufferedBlockCipher;import org.bouncycastle.crypto.params.KeyParameter;import org.bouncycastle.util.encoders.Hex;
public class Encoder {    private static byte[] key=new byte[64];    static BufferedBlockCipher cipher;    static{        key=Hex.decode("LICX456789ABCDEF");        BlockCipher engine = new DESEngine();        cipher = new PaddedBufferedBlockCipher(engine);    }
    public static String encrypt(String src){        byte[] input,cipherText;        try        {            cipher.init(true, new KeyParameter(key));            input=src.getBytes();            cipherText = new byte[cipher.getOutputSize(input.length)];            int outputLen = cipher.processBytes(input, 0, input.length, cipherText, 0);            cipher.doFinal(cipherText, outputLen);            return new String(Hex.encode(cipherText));        }        catch (CryptoException ce)        {            return src;        }        catch(DataLengthException de)        {            return src;        }        catch(Exception e)        {            return src;        }    }
    public static String decrypt(String src)    {        byte[] cipherText,dencypted,trimed;        try        {            cipher.init(false, new KeyParameter(key));            cipherText=Hex.decode(src.getBytes());            dencypted = new byte[cipher.getOutputSize(cipherText.length)];            int outputLen = cipher.processBytes(cipherText, 0, cipherText.length, dencypted, 0);            cipher.doFinal(dencypted, outputLen);            trimed=trimBytes(dencypted);            return new String(trimed);        }        catch (CryptoException ce)        {            return src;        }        catch(DataLengthException de)        {            return src;        }        catch(Exception e)        {            return src;        }    }
    private static byte[] trimBytes(byte[] src)    {        int length=src.length;        for(int i=src.length-1;i>=0;i--)        {
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
        //String src="abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcde";        String src = "bbbbbb";        System.out.println("src:'"+src+"'");        System.out.println("length='"+src.length()+"'");        String encrypt=Encoder.encrypt(src);        System.out.println("encrypted='"+encrypt+"'");        System.out.println("length='"+encrypt.length()+"'");		String decrypt=Encoder.decrypt(src);        System.out.println("encrypted='"+decrypt+"'");        System.out.println("length='"+decrypt.length()+"'");    }
}
