package com.wqm.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.sys.SysLogEntity;
import com.wqm.repository.sys.SysLogDao;

@Component
@Transactional
public class SysLogService {
	
	@Autowired 
	private SysLogDao sysLogDao;
	
	/**
	 * 获取全部系统日志
	 * @param menu
	 * @return
	 */
	public List<SysLogEntity> getAllSysLogs(){
		return (List<SysLogEntity>) sysLogDao.findAll();
	}
	  
	/**
	 * 分页查询系统日志
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<SysLogEntity> getLogsByPage(Specification<SysLogEntity> spec,PageRequest pageRequest){
		return sysLogDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存系统日志
	 * @param param
	 * @return
	 */
	public SysLogEntity saveLog(SysLogEntity param){
		return sysLogDao.save(param);
	} 
}
