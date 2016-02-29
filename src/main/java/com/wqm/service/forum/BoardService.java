package com.wqm.service.forum;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.wqm.entity.forum.BoardEntity;
import com.wqm.repository.forum.BoardDao;

@Component
@Transactional
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	/**
	 * 保存菜单
	 * 
	 * @param board
	 * @return
	 */
	public BoardEntity saveBoard(BoardEntity board) {
		return boardDao.save(board);
	}

	/**
	 * 删除目录
	 * 
	 * @param ids
	 */
	public void deleBoard(List<Long> ids) {
		boardDao.deleBoardsByIds(ids);
	}
	
	/**
	 * 按ID查找目录
	 * @param id
	 * @return
	 */
	public BoardEntity getBoardById(Long id){
		return boardDao.findOne(id);
	}
	
	/**
	 * 分页查询菜单
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<BoardEntity> getBoardsByPage(Specification<BoardEntity> spec,PageRequest pageRequest){
		return boardDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存菜单
	 * @param board
	 * @return
	 */
	public BoardEntity saveMenu(BoardEntity board){
		return boardDao.save(board);
	}
	
	/**
	 * 获取全部的父菜单项
	 * @return
	 */
	public List<BoardEntity> getAllParents(){
		List<BoardEntity> boards = (List<BoardEntity>) boardDao.findAllParents();
		BoardEntity board = new BoardEntity();
		board.setId(0L);
		board.setBoardName("根目录");
		boards.add(board);
		return boards ;
	}
}
