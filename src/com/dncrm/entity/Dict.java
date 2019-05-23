package com.dncrm.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 字典
 * 
 */
public class Dict implements Serializable {

	private static final long serialVersionUID = 1L;
	// 编号
	private Long id;
	// 标签名
	private String name;
	// 数据值
	private String value;
	// 类型
	private String type;
	// 描述
	private String description;
	// 排序（升序）
	private BigDecimal sort;
	// 父级编号
	private Long parentId;
	// 创建者
	private String createBy;
	// 创建时间
	private String createDate;
	// 更新者
	private String updateBy;
	// 更新时间
	private String updateDate;
	// 备注信息
	private String remarks;
	// 删除标记
	private String delFlag;
	// 扩展
	private String extend_s1;
	// 扩展
	private String extend_s2;
	// 扩展
	private String extend_s3;
	// 扩展
	private String extend_s4;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BigDecimal getSort() {
		return sort;
	}
	public void setSort(BigDecimal sort) {
		this.sort = sort;
	}
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getExtend_s1() {
		return extend_s1;
	}
	public void setExtend_s1(String extend_s1) {
		this.extend_s1 = extend_s1;
	}
	public String getExtend_s2() {
		return extend_s2;
	}
	public void setExtend_s2(String extend_s2) {
		this.extend_s2 = extend_s2;
	}
	public String getExtend_s3() {
		return extend_s3;
	}
	public void setExtend_s3(String extend_s3) {
		this.extend_s3 = extend_s3;
	}
	public String getExtend_s4() {
		return extend_s4;
	}
	public void setExtend_s4(String extend_s4) {
		this.extend_s4 = extend_s4;
	}
	
}