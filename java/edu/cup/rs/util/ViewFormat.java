package edu.cup.rs.util;

import java.util.Calendar;
import java.text.SimpleDateFormat;
import edu.cup.rs.log.*;

public class ViewFormat {
    private static LogHandler logger;
    public static String longDateTime_NoBlank() {
        String s_DateTime = "";
        SimpleDateFormat sdf;
        Calendar c;
        try {
            c = Calendar.getInstance();
            sdf = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            s_DateTime = sdf.format(c.getTime());
        } catch (Exception e) {
            logger= LogHandler.getInstance(ViewFormat.class);
            logger.error(e.getMessage());
        }
        return s_DateTime;
    }
    public static String longDateTime() {
        SimpleDateFormat sdf;
        String s_DateTime = "";
        Calendar c;
        try {
            c = Calendar.getInstance();
            sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            s_DateTime = sdf.format(c.getTime());
        } catch (Exception e) {
            logger= LogHandler.getInstance(ViewFormat.class);
            logger.error(e.getMessage());
        }
        return s_DateTime;
    }
}

