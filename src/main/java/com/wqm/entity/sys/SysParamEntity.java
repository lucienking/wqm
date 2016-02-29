package com.wqm.entity.sys;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 *  系统参数表 
 * @author wangxj
 * 
 */

@Entity
@Table(name = "BASE_SYS_SYSPARAM")
public class SysParamEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String sysParamCode;	//参数项编码
	
	private String sysParamName;	//参数项名称
	
	private String sysParamValue;	//参数项值
	

	public String getsysParamCode() {
		return sysParamCode;
	}

	public void setsysParamCode(String sysParamCode) {
		this.sysParamCode = sysParamCode;
	}

	public String getsysParamName() {
		return sysParamName;
	}

	public void setsysParamName(String sysParamName) {
		this.sysParamName = sysParamName;
	}

	public String getsysParamValue() {
		return sysParamValue;
	}

	public void setsysParamValue(String sysParamValue) {
		this.sysParamValue = sysParamValue;
	}

}
