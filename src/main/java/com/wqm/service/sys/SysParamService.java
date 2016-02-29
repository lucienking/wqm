package com.wqm.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.sys.SysParamEntity;
import com.wqm.repository.sys.SysParamDao;

@Component
@Transactional
public class SysParamService {
	
	@Autowired 
	private SysParamDao sysParamDao;
	
	/**
	 * 获取全部系统参数项
	 * @param menu
	 * @return
	 */
	public List<SysParamEntity> getAllSysParam(){
		return (List<SysParamEntity>) sysParamDao.findAll();
	}
	
	/**
	 * 按ID查找系统参数
	 * @param id
	 * @return
	 */
	public SysParamEntity getSysParamById(Long id){
		return sysParamDao.findOne(id);
	}
	
	 
	/**
	 * 按ID查找系统参数,并缓存
	 * @param id
	 * @return
	 */
	@Cacheable(value = "systemParam", key = "#id")
	public SysParamEntity getParamByIdCache(Long id){
		return sysParamDao.findOne(id);
	}
	
	/**
	 * 按paramCode 查找字典项 并缓存
	 * @param paramCode
	 * @return
	 */
	@Cacheable(value = "systemParam", key = "#paramCode")
	public SysParamEntity getParamByCode(String paramCode){
		return sysParamDao.findBySysParamCode(paramCode);
	}
	
	/**
	 * 分页查询系统参数项
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<SysParamEntity> getParamsByPage(Specification<SysParamEntity> spec,PageRequest pageRequest){
		return sysParamDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存系统参数项
	 * @param param
	 * @return
	 */
	public SysParamEntity saveParam(SysParamEntity param){
		return sysParamDao.save(param);
	}
	
	/**
	 * 删除系统参数项
	 * @param ids
	 */
	public void deleParams(List<Long> ids){
		sysParamDao.deleSysParamByIds(ids);
	}
}
