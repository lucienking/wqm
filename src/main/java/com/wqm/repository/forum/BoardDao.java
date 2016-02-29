package com.wqm.repository.forum;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.forum.BoardEntity;


public interface BoardDao extends PagingAndSortingRepository<BoardEntity, Long>,JpaSpecificationExecutor<BoardEntity> {

	/**
	 * 根据父Id获取全部子版块
	 */
	public List<BoardEntity> getBoardsByParentId(Long id, Sort sort);
	
	/**
	 * 根据父Id获取全部子版块
	 */
	@Query("select board from BoardEntity board where board.boardStatus = '1'  order by board.sortNum")
	public List<BoardEntity> getBoardsByParentId(Long id);
	
	/**
	 * 删除菜单
	 */
	@Modifying
	@Query("delete from BoardEntity board where board.id in (?1)")
	public void deleBoardsByIds(List<Long> ids);
	
	/**
	 * 获得全部的父菜单项
	 * @return
	 */
	@Query("select board from BoardEntity board")
	public List<BoardEntity> findAllParents();
	
	
	
}
