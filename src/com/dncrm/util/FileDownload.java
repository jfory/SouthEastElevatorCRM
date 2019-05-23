package com.dncrm.util;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;


/**
 * 下载文件
 * 创建人：Simon创建时间：2014年12月23日
 */
public class FileDownload {

    /**
     * @param response
     * @param filePath //文件完整路径(包括文件名和扩展名)
     * @param fileName //下载后看到的文件名
     * @return 文件名
     */
    public static void fileDownload(final HttpServletResponse response, String filePath, String fileName) throws Exception {

        byte[] data = FileUtil.toByteArray2(filePath);
        String perfixname=fileName.substring(0,fileName.lastIndexOf("."));//获得upload部
        String lastname = fileName.substring(fileName.lastIndexOf("."));
        String concat = perfixname.concat(lastname);
        fileName = new String(concat.getBytes(), "ISO-8859-1");
//        fileName = URLEncoder.encode(fileName, "UTF-8");
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream;charset=UTF-8");
        OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
        outputStream.write(data);
        outputStream.flush();
        outputStream.close();
        response.flushBuffer();

    }

}
