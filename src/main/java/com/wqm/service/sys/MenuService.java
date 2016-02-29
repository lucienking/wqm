package com.wqm.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.sys.MenuEntity;
import com.wqm.repository.sys.MenuDao;

@Component
@Transactional
public class MenuService {
	
	@Autowired
	private MenuDao menuDao;
	
	/**
	 * 获取一级菜单
	 * @return
	 */
	public List<MenuEntity> getMenuListByRoot(){
		return menuDao.getMenusByParentId(0L,new Sort(Direction.ASC, "sortNum"));
	}
	
	/**
	 * 按ID查找目录
	 * @param id
	 * @return
	 */
	public MenuEntity getMenuById(Long id){
		return menuDao.findOne(id);
	}
	
	/**
	 * 按ID获取子菜单
	 * @param id
	 * @return
	 */
	public List<MenuEntity> getMenuListById(Long id,Sort sort){
		return menuDao.getMenusByParentId(id,sort);
	}
	
	/**
	 * 按ID获取子菜单
	 * @param id
	 * @return
	 */
	public List<MenuEntity> getMenuListById(Long id){
		return menuDao.getMenusByParentId(id);
	}
	
	/**
	 * 获取全部菜单
	 * @return
	 */
	public List<MenuEntity> getAllMenus(){
		return (List<MenuEntity>) menuDao.findAll();
	}
	
	/**
	 * 分页查询菜单
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<MenuEntity> getMenusByPage(Specification<MenuEntity> spec,PageRequest pageRequest){
		return menuDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 获取全部的父菜单项
	 * @return
	 */
	public List<MenuEntity> getAllParents(){
		List<MenuEntity> menus = (List<MenuEntity>) menuDao.findAllParents();
		MenuEntity menu = new MenuEntity();
		menu.setId(0L);
		menu.setName("根目录");
		menus.add(menu);
		return menus;
	}
	
	/**
	 * 保存菜单
	 * @param menu
	 * @return
	 */
	public MenuEntity saveMenu(MenuEntity menu){
		return menuDao.save(menu);
	}
	
	/**
	 * 删除目录
	 * @param ids
	 */
	public void deleMenu(List<Long> ids){
		menuDao.deleMenusByIds(ids);
	}
}
