package com.wqm.entity.forum;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.wqm.entity.IdEntity;
import com.wqm.entity.sys.UserEntity;

/**
 * 版块菜单
 * 
 * @author tangwl
 * 
 */
@Entity
@Table(name = "BASE_FORUM_BOARD")
public class BoardEntity extends IdEntity {

	private static final long serialVersionUID = 1L;

	private String boardName; 		// 版块名称

	private String moderators; 		// 版主

	private String boardStatus; 	// 版块状态

	private int sortNum; 			// 版块顺序

	private String boardType; 		// 版块类型

	private String authorId; 		// 版块权限

	private Date createDate;		// 创建时间
	
	private Date updateDate;		// 更新时间

	private UserEntity user; 		// 创建人员

	private String keyword; 		// 关键字

	private String boardLogo; 		// 版块logo
	
	private Long parentId; 			// 父菜单Id
	//private String partionName; // 分区名称
	//private String theme; // 主题
	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getModerators() {
		return moderators;
	}

	public void setModerators(String moderators) {
		this.moderators = moderators;
	}

	public int getSortNum() {
		return sortNum;
	}

	public void setSortNum(int sortNum) {
		this.sortNum = sortNum;
	}

	public String getAuthorId() {
		return authorId;
	}

	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	// JPA 基于USERID列的多对一关系定义
	@ManyToOne
	@JoinColumn(name = "userId")
	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getBoardLogo() {
		return boardLogo;
	}

	public void setBoardLogo(String boardLogo) {
		this.boardLogo = boardLogo;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

}
