/**
 * 
 */
package com.wqm.entity.sys;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.wqm.entity.IdEntity;

/**
 * 附件实体类 通用
 * @author wangxj
 *
 */


@Entity
@Table(name = "BASE_SYS_ATTACHMENT")
public class Attachment extends IdEntity {
	
	private static final long serialVersionUID = 1L;

	private String attachmentName;			//附件名称
	
	private String attachmentType;			//附件类型
	
	private String attachmentLong;			//附件大小
	
	private String attachmentDirection;		//附件路径
	
	private String attachmentModule;	 	//所属模块
	
	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAttachmentType() {
		return attachmentType;
	}

	public void setAttachmentType(String attachmentType) {
		this.attachmentType = attachmentType;
	}

	public String getAttachmentLong() {
		return attachmentLong;
	}

	public void setAttachmentLong(String attachmentLong) {
		this.attachmentLong = attachmentLong;
	}

	public String getAttachmentDirection() {
		return attachmentDirection;
	}

	public void setAttachmentDirection(String attachmentDirection) {
		this.attachmentDirection = attachmentDirection;
	}

	public String getAttachmentModule() {
		return attachmentModule;
	}

	public void setAttachmentModule(String attachmentModule) {
		this.attachmentModule = attachmentModule;
	}
}
