package com.wqm.repository.sys;



import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.SysLogEntity;

public interface SysLogDao extends PagingAndSortingRepository<SysLogEntity, Long>,JpaSpecificationExecutor<SysLogEntity> {
	
}
