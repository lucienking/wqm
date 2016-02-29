package com.wqm.entity.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 * 权限实体类
 * @author wangxj
 *
 */

@Entity
@Table(name="BASE_SYS_AUTHORITY")
public class AuthorityEntity  extends IdEntity{
	
	private static final long serialVersionUID = 1L;
	
	private String authorCode;  //权限编码
	
	private String authorName;  //权限名称
	
	private String authorDesc;	//权限描述
	
	private String parentCode;  //父权限ID
	
	@Column(unique=true,nullable=false)
	public String getAuthorCode() {
		return authorCode;
	}

	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getAuthorDesc() {
		return authorDesc;
	}

	public void setAuthorDesc(String authorDesc) {
		this.authorDesc = authorDesc;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
}
