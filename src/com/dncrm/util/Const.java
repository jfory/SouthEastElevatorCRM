package com.dncrm.util;

import org.springframework.context.ApplicationContext;

/**
 * 项目名称：
 *
 * @author:DNCRM
 */
public class Const {
    public static final String SESSION_SECURITY_CODE = "sessionSecCode";
    public static final String SESSION_USER = "sessionUser";
    public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
    public static final String SESSION_ROLE_SELECT = "sessionRoleSelect"; //当前用户权限允许查询到的其他用户录入信息的集合
    public static final String SESSION_ROLE_TYPE = "sessionRoleType";//当前用户权限分级,1个人/2分公司/3区域/4管理员
    public static final String SESSION_menuList = "menuList"; // 当前菜单
    public static final String SESSION_allmenuList = "allmenuList"; // 全部菜单
    public static final String SESSION_QX = "QX";
    public static final String SESSION_userpds = "userpds";
    public static final String SESSION_USERROL = "USERROL"; // 用户对象
    public static final String SESSION_USERNAME = "USERNAME"; // 用户名
    public static final String TRUE = "T";
    public static final String FALSE = "F";
    public static final String LOGIN = "/login_toLogin.do"; // 登录地址
    public static final String SYSNAME = "admin/config/SYSNAME.txt"; // 系统名称路径
    public static final String PAGE = "admin/config/PAGE.txt"; // 分页条数配置路径
    public static final String EMAIL = "admin/config/EMAIL.txt"; // 邮箱服务器配置路径
    public static final String SMS1 = "admin/config/SMS1.txt"; // 短信账户配置路径1
    public static final String SMS2 = "admin/config/SMS2.txt"; // 短信账户配置路径2
    public static final String FWATERM = "admin/config/FWATERM.txt"; // 文字水印配置路径
    public static final String IWATERM = "admin/config/IWATERM.txt"; // 图片水印配置路径
    public static final String WEIXIN = "admin/config/WEIXIN.txt"; // 微信配置路径
    public static final String FILEPATHIMG = "uploadFiles/uploadImgs/"; // 图片上传路径
    public static final String ACTIVITIFILEPATHIMG = "uploadFiles/activitiDiagrams/"; // activiti图片上传路径
    public static final String ACTIVITIFILEPATHIMGEXT = "acitiviti/diagrams/"; // activiti图片上传路径
    
    public static final String FILEPATHFILE = "uploadFiles/file/"; // 文件上传路径
    public static final String ZT_CONNECT_URL = "http://121.14.62.198:9060/zjhtplatform/";//与中通的通信地址
    public static final String FILEPATHTWODIMENSIONCODE = "uploadFiles/twoDimensionCode/"; // 会员二维码存放路径
    public static final String FILEPATHTWODIMENSIONCODEAPPUSER = "uploadFiles/twoDimensionCode/appUser/"; // 会员二维码存放路径
    public static final String FILEPATHTWODIMENSIONCODESHOP = "uploadFiles/twoDimensionCode/shop/"; // 门店二维码存放路径
    public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(app)|(weixin)|(static)|(main)|(websocket)|(index)|(twoDimensionCode)|(index_two)|(uploadImgs)|(Nozzle)|(plugins)).*"; // 不对匹配该值的访问路径拦截（正则）

    public static ApplicationContext WEB_APP_CONTEXT = null; // 该值会在web容器启动时由WebAppContextListener初始化

    /**
     * APP Constants
     */
    // app注册接口_请求协议参数)
    public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[]{
            "countries", "uname", "passwd", "title", "full_name",
            "company_name", "countries_code", "area_code", "telephone",
            "mobile"};
    public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[]{
            "国籍", "邮箱帐号", "密码", "称谓", "名称", "公司名称", "国家编号", "区号", "电话", "手机号"};

    // app根据用户名获取会员信息接口_请求协议中的参数
    public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[]{"USERNAME"};
    public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[]{"用户名"};
    //与中通通信的接口
    public static final String ZT_KEY = "199011130353";
    public static final String ZT_PICTURE = "channel.viewPicFileContent";//应用图片查询
    public static final String ZT_ORDER = "trade.ticketTrade";//应用图片查询
    public static final String ZT_ORDER_STATE = "trade. queryTicketStatus";//应用图片查询
    
    
    //小业主需求变更
    public static final String HOUSES_LEVEL = "{'6':'6-7-8-9','7':'7-8-9','8':'8','9':'9'}";
    public static final String ITEM_LEVEL = "{'6':'6','7':'7','8':'8','9':'9'}";

}
