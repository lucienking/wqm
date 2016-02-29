package com.wqm.entity.sys;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.wqm.entity.IdEntity;

/**
 * 用户实体类  <br/>
 * 表名：BASE_SYS_USER
 * @author wangxj
 * 
 */

@Entity
@Table(name = "BASE_SYS_USER")
public class UserEntity extends IdEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String salt;			//随机生成的salt 用作1024次 sha-1 hash.
	
	private String userName;		//登录名
	
	private String password;		//加密后的密码
	
	private String plainPassword;	//明文密码，用于存储用户所输入的明文密码
	
	private String name;			//姓名
	
	private String sex;				//性别
	
	private String nationCode;		//民族
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;			//出生日期
	
	private String nativePlace;		//籍贯
	
	private String email;			//邮箱
	
	private String identityNumber;	//身份证号
	
	private String phoneNumber;		//联系电话
	
	private String politicalCode;	//政治面貌
	
	private String degreeCode;		//文化程度
	
	private String faithCode;		//信仰
	
	private String job;				//职务
	
	private String defaultJob="员工";//默认职务
	
	private String jobTitleCode;	//职称
	
	private Date joinDate;			//入职日期
	
	private Date createDate;		//创建时间
	
	private String status;			//账号状态,0:停用，1:启用
	
	private DepartmentEntity department;
	
	private List<RoleEntity>	roleEntity;

	public UserEntity() {
	}

	public UserEntity(Long id) {
		this.id = id;
	}

	@NotBlank
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// 不持久化到数据库，也不显示在Restful接口的属性.
	@Transient
	@JsonIgnore
	public String getPlainPassword() {
		return plainPassword;
	}

	public void setPlainPassword(String plainPassword) {
		this.plainPassword = plainPassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	@Transient
	@JsonIgnore
	public List<String> getRoleList() {
		// 角色列表在数据库中实际以逗号分隔字符串存储，因此返回不能修改的List.
		// return ImmutableList.copyOf(StringUtils.split(roles, ","));
		return null;
	}

	// 设定JSON序列化时的日期格式
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	@Column(unique=true,nullable=false)
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getNationCode() {
		return nationCode;
	}

	public void setNationCode(String nationCode) {
		this.nationCode = nationCode;
	}

	public Date getBirthday() {
		return birthday;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getNativePlace() {
		return nativePlace;
	}

	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdentityNumber() {
		return identityNumber;
	}

	public void setIdentityNumber(String identityNumber) {
		this.identityNumber = identityNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	@ManyToMany
	@JoinTable(name = "BASE_SYS_USERROLE", joinColumns = { @JoinColumn(name ="userId" )}, 
	    inverseJoinColumns = { @JoinColumn(name = "roleId") })
	public List<RoleEntity> getRoleEntity() {
		return roleEntity;
	}

	public void setRoleEntity(List<RoleEntity> roleEntity) {
		this.roleEntity = roleEntity;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPoliticalCode() {
		return politicalCode;
	}

	public void setPoliticalCode(String politicalCode) {
		this.politicalCode = politicalCode;
	}

	public String getDegreeCode() {
		return degreeCode;
	}

	public void setDegreeCode(String degreeCode) {
		this.degreeCode = degreeCode;
	}

	public String getFaithCode() {
		return faithCode;
	}

	public void setFaithCode(String faithCode) {
		this.faithCode = faithCode;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getDefaultJob() {
		return defaultJob;
	}

	public void setDefaultJob(String defaultJob) {
		this.defaultJob = defaultJob;
	}

	public String getJobTitleCode() {
		return jobTitleCode;
	}

	public void setJobTitleCode(String jobTitleCode) {
		this.jobTitleCode = jobTitleCode;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@ManyToOne
	@JoinColumn(name="departmentId")
	public DepartmentEntity getDepartment() {
		return department;
	}

	public void setDepartment(DepartmentEntity department) {
		this.department = department;
	}
}