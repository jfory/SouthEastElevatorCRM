package com.dncrm.entity.nonstandrad;

/**
 * 用于在WordView构建非标列表的JavaBean对象
 * 在word表格中分别使用${content}和${number}遍历获得值
 *
 * Templ4docx 2.0.0 - Table Variables 文档：
 * http://jsolve.github.io/java/templ4docx-2-0-0-table-variables/
 */
public class NonStandardBean {

    private String content;

    private String number;
    
    private String nonstandrad;

    public String getNonstandrad() {
		return nonstandrad;
	}

	public void setNonstandrad(String nonstandrad) {
		this.nonstandrad = nonstandrad;
	}

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public NonStandardBean(String content, String number) {
        this.content = content;
        this.number = number;
    }
    
    
    public NonStandardBean(String content, String nonstandrad, String number) {
		super();
		this.content = content;
		this.number = number;
		this.nonstandrad = nonstandrad;
	}
    
	@Override
	public String toString() {
		return "NonStandardBean [content=" + content + ", number=" + number + ", nonstandrad=" + nonstandrad + "]";
	}

	public NonStandardBean() {
    }
}
