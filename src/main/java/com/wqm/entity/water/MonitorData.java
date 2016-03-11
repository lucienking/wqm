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
 * 水体监测数据
 * @author wangxj
 *
 */
@Entity
@Table(name = "BUSI_WTR_MONITORDATA")
public class MonitorData extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	//private WaterEntity waterEntity;        //不关联实体
	private String waterCode;
	
	private String waterName;
	
	private Date monitorDate;
	
	private String itemName;
	
	private String  itemValue;
	
	private UserEntity user;	//创建人员
	
	private Date createDate;	//创建时间
	
	private Date updateDate;	//更新日期

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

	/*@ManyToOne
	@JoinColumn(name = "waterCode",referencedColumnName = "code")
	public WaterEntity getWaterEntity() {
		return waterEntity;
	}

	public void setWaterEntity(WaterEntity waterEntity) {
		this.waterEntity = waterEntity;
	}*/

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getMonitorDate() {
		return monitorDate;
	}

	public void setMonitorDate(Date monitorDate) {
		this.monitorDate = monitorDate;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemValue() {
		return itemValue;
	}

	public void setItemValue(String itemValue) {
		this.itemValue = itemValue;
	}

	public String getWaterCode() {
		return waterCode;
	}

	public void setWaterCode(String waterCode) {
		this.waterCode = waterCode;
	}

	public String getWaterName() {
		return waterName;
	}

	public void setWaterName(String waterName) {
		this.waterName = waterName;
	}
}
