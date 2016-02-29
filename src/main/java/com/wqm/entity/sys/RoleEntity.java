package com.wqm.entity.sys;


import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;
 
/**
 *  角色
 * @author wangxj
 *
 */
@Entity
@Table(name="BASE_SYS_ROLE")
public class RoleEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String code;
	
	private String name;
	
	private String roleDesc;
	
	private Set<AuthorityEntity> authority;
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name.trim();
	}

	@ManyToMany
	@JoinTable(name = "BASE_SYS_ROLEAUTHORITY", joinColumns = { @JoinColumn(name ="roleId" )}, 
	  inverseJoinColumns = { @JoinColumn(name = "authorCode",referencedColumnName = "authorCode") })
	public Set<AuthorityEntity> getAuthority() {
		return authority;
	}

	public void setAuthority(Set<AuthorityEntity> authority) {
		this.authority = authority;
	}

}
