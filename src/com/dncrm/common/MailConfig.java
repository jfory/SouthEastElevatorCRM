package com.dncrm.common;

import java.io.InputStream;
import java.util.Properties;

/**
 * Created by LGD on 2018/04/17.
 */
public class MailConfig {
    private static final String PROPERTIES_DEFAULT = "mailConfig.properties";
    public static String host;
    public static Integer port;
    public static String userName;
    public static String passWord;
    public static String emailForm;
    public static String timeout;
    public static String personal;
    public static Properties properties;
    public static String tomail;
    public static String formmail;
    public static String IntervalTime;
    
    static{
        init();
    }

    /**
     * 初始化
     */
    private static void init() {
        properties = new Properties();
        try{
            InputStream inputStream = MailConfig.class.getClassLoader().getResourceAsStream(PROPERTIES_DEFAULT);
            properties.load(inputStream);
            inputStream.close();
            host = properties.getProperty("mailHost");
            port = Integer.parseInt(properties.getProperty("mailPort"));
            userName = properties.getProperty("mailUsername");
            passWord = properties.getProperty("mailPassword");
            emailForm = properties.getProperty("mailFrom");
            timeout = properties.getProperty("mailTimeout");
            personal = properties.getProperty("personal");
            tomail = properties.getProperty("tomail");
            IntervalTime = properties.getProperty("IntervalTime");
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
