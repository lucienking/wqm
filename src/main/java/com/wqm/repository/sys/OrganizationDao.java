package com.wqm.repository.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.OrganizationEntity;

public interface OrganizationDao  extends PagingAndSortingRepository<OrganizationEntity, Long>,JpaSpecificationExecutor<OrganizationEntity> {
	
	/**
	 * 所有的农场
	 */
	@Query("select org from OrganizationEntity org where org.parent = '202' ")
	public List<OrganizationEntity> getAllFarms(); 
	
}
