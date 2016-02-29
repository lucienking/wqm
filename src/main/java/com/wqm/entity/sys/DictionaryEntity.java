package com.wqm.entity.sys;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 *  系统字典表 
 * @author wangxj
 * 
 */

@Entity
@Table(name = "BASE_SYS_DICT")
public class DictionaryEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String dictCode;	//字典项编码
	
	private String dictName;	//字典项名称

	private String dictValue;	//字典项值
	
	private String dictGroup;	//字典项组别

	public String getDictCode() {
		return dictCode;
	}

	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public String getDictValue() {
		return dictValue;
	}

	public void setDictValue(String dictValue) {
		this.dictValue = dictValue;
	}

	public String getDictGroup() {
		return dictGroup;
	}

	public void setDictGroup(String dictGroup) {
		this.dictGroup = dictGroup;
	}
	
}
