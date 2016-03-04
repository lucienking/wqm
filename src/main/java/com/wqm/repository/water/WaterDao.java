package com.wqm.repository.water;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.water.WaterEntity;


public interface WaterDao extends PagingAndSortingRepository<WaterEntity, Long>,JpaSpecificationExecutor<WaterEntity> {
	/**
	 * 根据父Id获取全部子水体
	 */
	public List<WaterEntity> getWatersByParentCode(String code,Sort sort);
	
	/**
	 * 根据父Id获取全部子水体
	 */
	@Query("select water from WaterEntity water where water.status = '1' and water.parentCode = ?1 order by water.sortNum")
	public List<WaterEntity> getWatersByParentId(String code);
	
	/**
	 * 获得全部的父水体项
	 * @return
	 */
	@Query("select water from WaterEntity water where water.isLeaf = 'false'")
	public List<WaterEntity> findAllParents();
	
	/**
	 * 删除水体
	 */
	@Modifying
	@Query("delete from WaterEntity water where water.id in (?1)")
	public void deleWatersByIds(List<Long> ids);
}