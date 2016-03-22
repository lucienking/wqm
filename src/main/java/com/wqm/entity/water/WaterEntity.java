package com.wqm.entity.water;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.wqm.entity.IdEntity;
import com.wqm.entity.sys.UserEntity;

/**
 * 系统水体
 * @author wangxj
 *
 */
@Entity
@Table(name = "BUSI_WTR_WATER")
public class WaterEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String code; 		//水体编号
	
	private String name;	 	//水体名称
	
	private String address; 	//水体地址
	
	private String authorId; 	//水体权限
	
	private String status;  	//水体状态
	
	private String sortNum;     //排序号
	
	private AreaEntity area;	//所属区域
	
	private boolean isLeaf;		//水体类型  true:水体 false:区域
	
	private String isMonitored; //是否已监测 Y:是 N：否
	
	private String iconCls;		//水体图标
	
	private String isManaged;  //水体状态  Y:已治理 N:未治理 M:治理中
	
	private String parentCode;	//父水体Code
	
	private String parentName;	//父水体Name
	
	private UserEntity user;	//创建人员
	
	private Date createDate;	//创建时间
	
	private Date updateDate;	//更新日期
	
	private List<MonitorItem> monitorItem;

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

	public String getAuthorId() {
		return authorId;
	}

	public void setAuthorId(String authorId) {
		this.authorId = authorId;
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

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	// JPA 基于USERID列的多对一关系定义
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userId")
	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	@ManyToOne
	@JoinColumn(name = "areaCode",referencedColumnName = "code")
	public AreaEntity getArea() {
		return area;
	}

	public void setArea(AreaEntity area) {
		this.area = area;
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

	public boolean getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}
	
	public String getIsMonitored() {
		return isMonitored;
	}

	public void setIsMonitored(String isMonitored) {
		this.isMonitored = isMonitored;
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

	@ManyToMany
	@JoinTable(name = "BUSI_WTR_WATERMONITORITEM", joinColumns = { @JoinColumn(name ="waterCode" ,referencedColumnName = "code")}, 
	  inverseJoinColumns = { @JoinColumn(name = "moniterItemCode",referencedColumnName = "code") })
	public List<MonitorItem> getMonitorItem() {
		return monitorItem;
	}

	public void setMonitorItem(List<MonitorItem> monitorItem) {
		this.monitorItem = monitorItem;
	}

	public String getIsManaged() {
		return isManaged;
	}

	public void setIsManaged(String isManaged) {
		this.isManaged = isManaged;
	}
}
