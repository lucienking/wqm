package com.wqm.repository.sys;


import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.SysParamEntity;

public interface SysParamDao extends PagingAndSortingRepository<SysParamEntity, Long>,JpaSpecificationExecutor<SysParamEntity> {
	
	@Modifying
	@Query("delete from SysParamEntity param where param.id in (?1)")
	public void deleSysParamByIds(List<Long> ids);
	
	@Query("select param from SysParamEntity param where param.sysParamCode = ?1")
	public SysParamEntity findBySysParamCode(String paramCode);
}
