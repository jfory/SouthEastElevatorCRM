package com.dncrm.entity.Indicator;

import java.io.Serializable;
import java.util.Date;

public class IndicatorModel implements Serializable {

    private String indicator_id;

    private String department_id;

    private String department_name;

    private Integer indicator_year;

    private String indicator_num;

    private Date indicator_date;

    public String getDepartment_name() {
        return department_name;
    }

    public void setDepartment_name(String department_name) {
        this.department_name = department_name;
    }

    public Integer getIndicator_year() {
        return indicator_year;
    }

    public void setIndicator_year(Integer year) {
        this.indicator_year = year;
    }

    public String getIndicator_num() {
        return indicator_num;
    }

    public void setIndicator_num(String indicator) {
        this.indicator_num = indicator;
    }

    public Date getIndicator_date() {
        return indicator_date;
    }

    public void setIndicator_date(Date indicator_date) {
        this.indicator_date = indicator_date;
    }

    public String getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(String department_id) {
        this.department_id = department_id;
    }

    public String getIndicator_id() {
        return indicator_id;
    }

    public void setIndicator_id(String id) {
        this.indicator_id = id;
    }
}
