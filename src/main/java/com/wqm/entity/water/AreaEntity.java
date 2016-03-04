package com.wqm.entity.water;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.wqm.entity.IdEntity;
import com.wqm.entity.sys.UserEntity;

/**
 * 系统区域
 * @author wangxj
 *
 */
@Entity
@Table(name = "BUSI_WTR_AREA")
public class AreaEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String code; 		//区域编号
	
	private String name;	 	//区域名称
	
	private String address; 	//区域地址
	
	private String status;  	//区域状态
	
	private String sortNum;     //排序号
	
	private String iconCls;		//区域图标
	
	private String parentCode;	//父区域Code
	
	private UserEntity user;	//创建人员
	
	private Date createDate;	//创建时间
	
	private Date updateDate;	//更新日期

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWaterUrl() {
		return address;
	}

	public void setWaterUrl(String waterUrl) {
		this.address = waterUrl;
	}

	public String getWaterStatus() {
		return status;
	}

	public void setWaterStatus(String waterStatus) {
		this.status = waterStatus;
	}
	
	public String getSortNum() {
		return sortNum;
	}

	public void setSortNum(String sortNum) {
		this.sortNum = sortNum;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	// JPA 基于USERID列的多对一关系定义
	@ManyToOne
	@JoinColumn(name = "userId")
	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
