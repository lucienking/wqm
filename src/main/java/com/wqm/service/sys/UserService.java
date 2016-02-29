package com.wqm.service.sys;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.security.utils.Digests;
import org.springside.modules.utils.Clock;
import org.springside.modules.utils.Encodes;

import com.wqm.entity.sys.UserEntity;
import com.wqm.repository.sys.UserDao;
import com.wqm.service.ServiceException;
import com.wqm.service.account.ShiroDbRealm.ShiroUser;

/**
 * 用户管理类
 * @author wangxj
 *
 */
@Component
@Transactional
public class UserService {
	
	public static final String HASH_ALGORITHM = "SHA-1";
	
	public static final int HASH_INTERATIONS = 1024;
	
	private static final int SALT_SIZE = 8;
	
	@Autowired
	private UserDao userDao;
	
	private Clock clock = Clock.DEFAULT;

	public List<UserEntity> getAllUser() {
		return (List<UserEntity>) userDao.findAll();
	}

	public UserEntity getUser(Long id) {
		return userDao.findOne(id);
	}

	public UserEntity findUserByLoginName(String loginName) {
		return userDao.findByUserName(loginName);
	}

	public void registerUser(UserEntity user) {
		entryptPassword(user);
		user.setCreateDate(clock.getCurrentDate());

		userDao.save(user);
	}

	public void updateUser(UserEntity user) {
		if (StringUtils.isNotBlank(user.getPlainPassword())) {
			entryptPassword(user);
		}
		userDao.save(user);
	}

	public void deleteUser(Long id) {
		if (isSupervisor(id)) {
			throw new ServiceException("不能删除超级管理员用户");
		}
		userDao.delete(id);
	}

	/**
	 * 判断是否超级管理员.
	 */
	private boolean isSupervisor(Long id) {
		return id==1;
	}

	/**
	 * 取出Shiro中的当前用户LoginName.
	 */
	protected String getCurrentUserName() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return user.userName;
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(UserEntity user) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		user.setSalt(Encodes.encodeHex(salt));

		byte[] hashPassword = Digests.sha1(user.getPlainPassword().getBytes(), salt, HASH_INTERATIONS);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}

	public void setClock(Clock clock) {
		this.clock = clock;
	}
	
	public UserEntity getUserById(Long id) {
		return userDao.findOne(id);
	}
	
	/**
	 * 分页查询菜单
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<UserEntity> getUserByPage(Specification<UserEntity> spec,PageRequest pageRequest){
		return userDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 新增用户
	 * @param user
	 */
	public void createUser(UserEntity user) {
		entryptPassword(user);
		userDao.save(user);
	}
	
	/**
	 * 删除用户
	 * @param ids
	 */
	public void deleUser(List<Long> ids){
	    for(long id : ids){
	    	if (isSupervisor(id)) {
				throw new ServiceException("不能删除超级管理员用户");
			}
	    	userDao.delete(id);
	    }

		
	}
	
}
