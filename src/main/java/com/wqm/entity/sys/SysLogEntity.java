package com.wqm.entity.sys;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.wqm.entity.IdEntity;

/**
 *  系统日志
 * @author wangxj
 * 
 */

@Entity
@Table(name = "BASE_SYS_SYSLOG")
public class SysLogEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String operateAccount;		//操作账号
	
	private Date operateDate;			//操作日期
	
	private String operateContent;		//操作内容
	
	private String operateIp;			//操作IP
	
	private String operateBrowser;		//操作客户端
	
	private String operateDescription;	//操作描述
	
	private String operateModule;		//操作模块

	public String getOperateAccount() {
		return operateAccount;
	}

	public void setOperateAccount(String operateAccount) {
		this.operateAccount = operateAccount;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getOperateDate() {
		return operateDate;
	}

	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}

	public String getOperateContent() {
		return operateContent;
	}

	public void setOperateContent(String operateContent) {
		this.operateContent = operateContent;
	}

	public String getOperateIp() {
		return operateIp;
	}

	public void setOperateIp(String operateIp) {
		this.operateIp = operateIp;
	}

	public String getOperateBrowser() {
		return operateBrowser;
	}

	public void setOperateBrowser(String operateBrowser) {
		this.operateBrowser = operateBrowser;
	}

	public String getOperateDescription() {
		return operateDescription;
	}

	public void setOperateDescription(String operateDescription) {
		this.operateDescription = operateDescription;
	}

	public String getOperateModule() {
		return operateModule;
	}

	public void setOperateModule(String operateModule) {
		this.operateModule = operateModule;
	}

}
