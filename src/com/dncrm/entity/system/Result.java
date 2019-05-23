package com.dncrm.entity.system;

import java.util.ArrayList;

public class Result {
    /**
     * 表示上传的结果。
     */
    /**
     * 表示图片是否已上传成功。
     */
    public Boolean success;
    /**
     * 自定义的附加消息。
     */
    public String msg;
    /**
     * 表示原始图片的保存地址。
     */
    public String sourceUrl;
    /**
     * 表示所有头像图片的保存地址，该变量为一个数组。
     */
    public ArrayList avatarUrls;
}
