package com.dncrm.entity.system;

import java.util.List;

import com.dncrm.entity.Page;

/**
 * 类名称：User.java
 * 类描述：
 * 创建人：Simon
 * 作者单位：
 * 联系方式：
 * 创建时间：2014年6月28日
 *
 * @version 1.0
 */
public class User {
    private String USER_ID;        //用户id
    private String USERNAME;    //用户名
    private String PASSWORD;    //密码
    private String NAME;        //姓名
    private String RIGHTS;        //权限
    private String ROLE_ID;        //角色id
    private String LAST_LOGIN;    //最后登录时间
    private String IP;            //用户登录ip地址
    private String STATUS;        //状态
    private Role role;            //角色对象
    private Page page;            //分页对象
    private String SKIN;        //皮肤
    private String AVATAR;        //头像
    private String POSITION_ID;        //岗位
    private String HX_USERNAME;        //HX用户名
    private String HX_PASSWORD;        //HX密码
    private List<Role> roleList;//用户角色集合

    
    public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

	public String getSKIN() {
        return SKIN;
    }

    public void setSKIN(String sKIN) {
        SKIN = sKIN;
    }

    public String getUSER_ID() {
        return USER_ID;
    }

    public void setUSER_ID(String uSER_ID) {
        USER_ID = uSER_ID;
    }

    public String getUSERNAME() {
        return USERNAME;
    }

    public void setUSERNAME(String uSERNAME) {
        USERNAME = uSERNAME;
    }

    public String getPASSWORD() {
        return PASSWORD;
    }

    public void setPASSWORD(String pASSWORD) {
        PASSWORD = pASSWORD;
    }

    public String getNAME() {
        return NAME;
    }

    public void setNAME(String nAME) {
        NAME = nAME;
    }

    public String getRIGHTS() {
        return RIGHTS;
    }

    public void setRIGHTS(String rIGHTS) {
        RIGHTS = rIGHTS;
    }

    public String getROLE_ID() {
        return ROLE_ID;
    }

    public void setROLE_ID(String rOLE_ID) {
        ROLE_ID = rOLE_ID;
    }

    public String getLAST_LOGIN() {
        return LAST_LOGIN;
    }

    public void setLAST_LOGIN(String lAST_LOGIN) {
        LAST_LOGIN = lAST_LOGIN;
    }

    public String getIP() {
        return IP;
    }

    public void setIP(String iP) {
        IP = iP;
    }

    public String getSTATUS() {
        return STATUS;
    }

    public void setSTATUS(String sTATUS) {
        STATUS = sTATUS;
    }

    public String getAVATAR() {
        return AVATAR;
    }

    public void setAVATAR(String aVATAR) {
        AVATAR = aVATAR;
    }

    public String getPOSITION_ID() {
        return POSITION_ID;
    }

    public void setPOSITION_ID(String POSITION_ID) {
        this.POSITION_ID = POSITION_ID;
    }

    public String getHX_USERNAME() {
        return HX_USERNAME;
    }

    public void setHX_USERNAME(String hX_USERNAME) {
        HX_USERNAME = hX_USERNAME;
    }

    public String getHX_PASSWORD() {
        return HX_PASSWORD;
    }

    public void setHX_PASSWORD(String hX_PASSWORD) {
        HX_PASSWORD = hX_PASSWORD;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Page getPage() {
        if (page == null)
            page = new Page();
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

}
