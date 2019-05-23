package com.dncrm.test;

import java.io.Serializable;

public class Person implements Serializable{

	/**
	 * 人员编制javabean
	 */
	private static final long serialVersionUID = 8451866712906877545L;
	
	private Integer id;// 编号
	private String name;// 名称
	private String sex;//性别

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	


}
