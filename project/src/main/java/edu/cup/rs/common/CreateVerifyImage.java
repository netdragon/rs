package edu.cup.rs.common;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class CreateVerifyImage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        response.setContentType("image/jpeg");
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires", 0);
        HttpSession session=request.getSession(true);

        int width=110, height=40;
        String base = "234567890abcdefghijkmnopqrstuvwxyz";
        String[] fontTypes = {"Times New Roman","Arial"};
        int length= base.length();
        int fontTypesLength = fontTypes.length;
        int x;
        int y;
        int xl;
        int yl;
        int start;
        String rand;

        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        Random random = new Random();
        StringBuffer sRand = new StringBuffer();;

        g.setColor(getRandColor(random, 200, 250));
        g.fillRect(0, 0, width, height);
        g.setColor(Color.BLACK);
        g.drawRect(0,0,width-1,height-1);
        g.setColor(getRandColor(random, 160, 200));
        for (int i=0;i<255;i++) {
            x = random.nextInt(width);
            y = random.nextInt(height);
            xl = random.nextInt(12);
            yl = random.nextInt(12);
            g.drawLine(x,y,x+xl,y+yl);
        }


        g.setColor(getRandColor(random, 180, 199));
        g.setFont(new Font("Times New Roman",Font.PLAIN,18));

        for ( int i = 0; i < 4; i++) {
            g.drawString( "@*@*@*@*@*@*@*" , 0, 5 * (i + 2)); 
        }

        for ( int i = 0; i < 4; i++) {
            start = random.nextInt(length);
            rand = base.substring(start, start + 1);
            sRand.append(rand);
            g.setColor(getRandColor(random, 10, 150));
            g.setFont( new Font(fontTypes[random.nextInt(fontTypesLength)],
            Font.BOLD, 18 + random.nextInt(6)));
            g.drawString(rand, 24 * i + 10 + random.nextInt(8), 24);
        }

        session.setAttribute( "rand" , sRand.toString());
        g.dispose();
        ServletOutputStream responseOutputStream =response.getOutputStream();
        ImageIO.write(image, "JPEG", responseOutputStream);

        responseOutputStream.flush();
        responseOutputStream.close();
    }

    Color getRandColor(Random random, int fc,int bc){
        if(fc>255) fc=255;
        if(bc>255) bc=255;
        int r=fc+random.nextInt(bc-fc);
        int g=fc+random.nextInt(bc-fc);
        int b=fc+random.nextInt(bc-fc);
        return new Color(r,g,b);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
}
