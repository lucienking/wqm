package com.wqm.entity.sys;



import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 * 部门
 * @author wangxj
 *
 */
 
@Entity
@Table(name="BASE_SYS_DEPARTMENT")
public class DepartmentEntity extends IdEntity{
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	
	private String code;
	
	private int level;
	
	private DepartmentEntity parent;
	
	private OrganizationEntity organization;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name.trim();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code.trim();
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@ManyToOne
	@JoinColumn(name="parentId")
	public DepartmentEntity getParent() {
		return parent;
	}

	public void setParent(DepartmentEntity parent) {
		this.parent = parent;
	}

	@ManyToOne
	@JoinColumn(name="organizationId")
	public OrganizationEntity getOrganization() {
		return organization;
	}

	public void setOrganization(OrganizationEntity organization) {
		this.organization = organization;
	}
}
