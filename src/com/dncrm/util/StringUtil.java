package com.dncrm.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

/**
 * 字符串相关方法
 */
public class StringUtil extends org.apache.commons.lang3.StringUtils{

    /**
     * 将以逗号分隔的字符串转换成字符串数组
     *
     * @param valStr
     * @return String[]
     */
    public static String[] StrList(String valStr) {
        int i = 0;
        String TempStr = valStr;
        String[] returnStr = new String[valStr.length() + 1 - TempStr.replace(",", "").length()];
        valStr = valStr + ",";
        while (valStr.indexOf(',') > 0) {
            returnStr[i] = valStr.substring(0, valStr.indexOf(','));
            valStr = valStr.substring(valStr.indexOf(',') + 1, valStr.length());

            i++;
        }
        return returnStr;
    }
    
    /**
	 * 获得用户远程地址
	 */
    public static String getRemoteAddr(HttpServletRequest request){
    	String remoteAddr = request.getHeader("X-Real-IP");
    	if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("X-Forwarded-For");
        }else if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("Proxy-Client-IP");
        }else if (isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("WL-Proxy-Client-IP");
        }
    	if(remoteAddr == null || remoteAddr.length() == 0 || "unknown".equalsIgnoreCase(remoteAddr)) {  
    		remoteAddr = request.getRemoteAddr();  
            if(remoteAddr.equals("127.0.0.1") || remoteAddr.equals("0:0:0:0:0:0:0:1")){  
                //根据网卡取本机配置的IP  
                InetAddress inet=null;  
                try {  
                    inet = InetAddress.getLocalHost();  
                } catch (UnknownHostException e) {  
                    e.printStackTrace();  
                }  
                remoteAddr= inet.getHostAddress();  
            }  
        }  
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割  
        if(remoteAddr!=null && remoteAddr.length()>15){ //"***.***.***.***".length() = 15  
            if(remoteAddr.indexOf(",")>0){  
            	remoteAddr = remoteAddr.substring(0,remoteAddr.indexOf(","));  
            }  
        }
    	return remoteAddr;
    }
}
