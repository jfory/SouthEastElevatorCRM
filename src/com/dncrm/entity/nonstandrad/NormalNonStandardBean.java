package com.dncrm.entity.nonstandrad;

/**
 * 用于在WordView构建常规非标列表的JavaBean对象
 * 在word表格中分别使用${description}和${value}遍历获得值
 *
 * Templ4docx 2.0.0 - Table Variables 文档：
 * http://jsolve.github.io/java/templ4docx-2-0-0-table-variables/
 */
public class NormalNonStandardBean {

    private String description;

    private String value;

    public NormalNonStandardBean(String description, String value) {
        this.description = description;
        this.value = value;
    }

    public NormalNonStandardBean() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
