package com.wqm.repository.sys;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.MenuEntity;

public interface MenuDao extends PagingAndSortingRepository<MenuEntity, Long>,JpaSpecificationExecutor<MenuEntity> {
	/**
	 * 根据父Id获取全部子菜单
	 */
	public List<MenuEntity> getMenusByParentId(Long id,Sort sort);
	
	/**
	 * 根据父Id获取全部子菜单
	 */
	@Query("select menu from MenuEntity menu where menu.menuStatus = '1' and menu.parentId = ?1 order by menu.sortNum")
	public List<MenuEntity> getMenusByParentId(Long id);
	
	/**
	 * 获得全部的父菜单项
	 * @return
	 */
	@Query("select menu from MenuEntity menu where menu.isLeaf = 'false'")
	public List<MenuEntity> findAllParents();
	
	/**
	 * 删除菜单
	 */
	@Modifying
	@Query("delete from MenuEntity menu where menu.id in (?1)")
	public void deleMenusByIds(List<Long> ids);
}
