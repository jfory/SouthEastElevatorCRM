package com.dncrm.listener.workflow;

import java.io.Serializable;

public class CheckTerm implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 是否通过
     */
    private boolean approve=true;

    public boolean isApprove() {
        return approve;
    }

    public void setApprove(boolean approve) {
        this.approve = approve;
    }

    /**
     * 是否需要下一级审批
     */
    private  boolean nextlevel;

    public boolean isNextlevel() {
        return nextlevel;
    }

    public void setNextlevel(boolean nextlevel) {
        this.nextlevel = nextlevel;
    }

    /**
     * 佣金超标标志
     */
    private String chargesstatus;

    /**
     * 总折扣率
     */
    private double alldiscount;

    /**
     * 是否财务审核判断
     */
    private boolean checkfinance;

    public String getChargesstatus() {
        return chargesstatus;
    }
    public void setChargesstatus(String chargesstatus) {
        this.chargesstatus = chargesstatus;
    }

    public double getAlldiscount() {
        return alldiscount;
    }
    public void setAlldiscount(double alldiscount) {
        this.alldiscount = alldiscount;
    }


    public boolean isCheckfinance() {
        return checkfinance;
    }
    public void setCheckfinance(boolean checkfinance) {
        this.checkfinance = checkfinance;
    }

    /**
     * 常规梯折扣率
     */
    private double changguidiscount;
    /**
     * 毛利润标志 0 小于32 1 大于32
     */
    private String profit;
    /**
     * 是否需要股份公司评审标志
     */
    private boolean checkiscompany;

    public double getChangguidiscount() {
        return changguidiscount;
    }
    public void setChangguidiscount(double changguidiscount) {
        this.changguidiscount = changguidiscount;
    }

    public String getProfit() {
        return profit;
    }
    public void setProfit(String profit) {
        this.profit = profit;
    }

    public boolean isCheckiscompany() {
        return checkiscompany;
    }

    public void setCheckiscompany(boolean checkiscompany) {
        this.checkiscompany = checkiscompany;
    }
}
