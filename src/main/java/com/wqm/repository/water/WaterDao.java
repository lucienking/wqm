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
	 * 根据父code获取全部子水体
	 */
	@Query("select water from WaterEntity water where water.parentCode = ?1 and water.isLeaf = 'true' order by water.sortNum")
	public List<WaterEntity> getWatersByParentCode(String code);
	
	/**
	 * 获得全部的父水体项
	 * @return
	 */
	@Query("select water from WaterEntity water where water.isLeaf = 'false'")
	public List<WaterEntity> findAllParents();
	
	/**
	 * 按code获得全部的水体项
	 * @return
	 */
	@Query("select water from WaterEntity water where water.isLeaf = 'false' and water.area.code = ?1")
	public List<WaterEntity> getWaterByAreaCode(String code);
	
	/**
	 * 按code获得水体项
	 * @return
	 */
	@Query("select water from WaterEntity water where water.code = ?1")
	public WaterEntity getWaterEntityByCode(String code);
	
	
	/**
	 * 删除水体
	 */
	@Modifying
	@Query("delete from WaterEntity water where water.id in (?1)")
	public void deleWatersByIds(List<Long> ids);
}
