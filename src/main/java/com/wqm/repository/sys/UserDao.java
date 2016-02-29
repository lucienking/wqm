
package com.wqm.repository.sys;


import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.UserEntity;

public interface UserDao extends PagingAndSortingRepository<UserEntity, Long>,JpaSpecificationExecutor<UserEntity> {
	
	/**
	 * 按用户名查找用户
	 * @param loginName
	 * @return
	 */
	@Query("select user from UserEntity user where user.userName = ?1")
	public UserEntity findByUserName(String loginName);
	
	
}
