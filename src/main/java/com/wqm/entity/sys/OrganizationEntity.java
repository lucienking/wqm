package com.wqm.entity.sys;


import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 * 组织机构
 * 
 * @author wangxj
 *
 */
@Entity
@Table(name = "BASE_SYS_ORGANIZATION")
public class OrganizationEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	
	private String code;
	
	private String orgCode;
	
	private int level;
	
	private int sort;
	
	private OrganizationEntity parent;
	
	private String provinceCode;
	
	private String orgProp;
	
	private String permissions;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	@ManyToOne
	@JoinColumn(name="parentId")
	public OrganizationEntity getParent() {
		return parent;
	}

	public void setParent(OrganizationEntity parent) {
		this.parent = parent;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getOrgProp() {
		return orgProp;
	}

	public void setOrgProp(String orgProp) {
		this.orgProp = orgProp;
	}

	public String getPermissions() {
		return permissions;
	}

	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

 
}
