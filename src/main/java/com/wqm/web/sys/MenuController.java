package com.wqm.web.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wqm.common.persistence.SearchFilter.Operator;
import com.wqm.common.persistence.SpecificationFactory;
import com.wqm.entity.sys.MenuEntity;
import com.wqm.service.sys.DictionaryService;
import com.wqm.service.sys.MenuService;
import com.wqm.web.BaseController;

/**
 * 系统-菜单管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/sys/menu/")
public class MenuController extends BaseController{

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private DictionaryService dictionaryService;
	
	private final static Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	/**
	 * 按父节点加载菜单，返回菜单树JSON
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMenus")
	public List<Map<String,Object>> getMenusJson(@RequestParam(value = "id", defaultValue = "0") Long id){
		/* 启用菜单状态功能 允许失效
		 *  Sort sort = new Sort(Direction.ASC, "sortNum");
			List<MenuEntity> menus= menuService.getMenuListById(id,sort);
		*/
		List<MenuEntity> menus= menuService.getMenuListById(id);
		List<Map<String,Object>> tree =  new ArrayList<Map<String,Object>>();
		for(MenuEntity menu:menus){
			Map<String, Object> map = new HashMap<String, Object>();
			String text = menu.getName();
			map.put("id",menu.getId()+"");
			map.put("iconCls", menu.getIconCls());
			if(!menu.getIsLeaf()){
				map.put("state","closed");
				text = "<span class='menuTreeParent'>"+text+"</span>" ;
			}
			map.put("text",text);
			
			Map<String,String> attribute = new HashMap<String,String>();
			attribute.put("url", menu.getMenuUrl());
			attribute.put("openType", menu.getOpenType());
			map.put("attributes",attribute );
		//菜单权限	if(PrincipalUtil.isHavePermission(menu.getAuthorId())||"admin".equals(PrincipalUtil.getCurrentUserName()))
				tree.add(map);
		}
		logger.info("加载菜单:"+tree.toString());
		return tree;
	}
	
	/**
	 * 菜单管理界面<br/>
	 * 权限编码 007001
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/menuManager")
	@RequiresPermissions("007001")
	public String  menusManager(Model model){		 
		return "/sys/menuManager";
	}
	
	/**
	 * 菜单编辑，新增界面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/menuEdit")
	public String  menusEditForm(Model model,@Valid Long id){	
		MenuEntity menu = null;
		String sortType = "create";
		if(id != null){
			menu =  menuService.getMenuById(id);
			sortType = "update";
		}
		model.addAttribute("menu",menu);
		model.addAttribute("sortType", sortType);
		return "/sys/menuForm";
	}
	
	/**
	 * 获取全部菜单
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMenusList")
	public List<MenuEntity> getMenusList(){
		List<MenuEntity> menus= menuService.getAllMenus();
		return menus;
	}
	
	/**
	 * 分页查询菜单
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMenusPage")
	public Map<String,Object> getMenusPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<MenuEntity> specf = new SpecificationFactory<MenuEntity>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("menuName"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		specf.addSearchParam("authorId", Operator.LIKE,  request.getParameter("authorId"));
		specf.addSearchParam("parentId", Operator.EQ,  StringUtils.isBlank(request.getParameter("parentId"))?
				"":Long.valueOf(request.getParameter("parentId")));
		specf.addSearchParam("isLeaf", Operator.EQ,  StringUtils.isBlank(request.getParameter("isLeaf"))?
				"":Boolean.valueOf(request.getParameter("isLeaf")));
		//分页排序信息
		Page<MenuEntity> menus= menuService.getMenusByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(menus);
	}
	
	/**
	 * 获得全部的父菜单项，即所有的栏目。
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getParents")
	public List<MenuEntity> getParents(){
		List<MenuEntity> menus= menuService.getAllParents();
		return menus;
	}
	
	/**
	 * 创建菜单<br/>
	 * 权限编码 007001001
	 * @param menu
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("007001001")
	public Map<String,Object>  createMenu(@Valid MenuEntity menu){
		Date date = new Date();
		
		menu.setCreateDate(date);
		menu.setUpdateDate(date);
		menu.setUser(this.getCurrentUser()); 
		menuService.saveMenu(menu);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新菜单<br/>
	 * 权限编码 007001003
	 * @param menu
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007001003")
	public Map<String,Object>  updateMenu(@Valid @ModelAttribute("menu") MenuEntity menu){
		Date date = new Date();
		menu.setUpdateDate(date);
		menu.setUser(this.getCurrentUser()); 
		menuService.saveMenu(menu);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 更改菜单状态<br/>
	 * 权限编码 007001003
	 * @param menu
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	@RequiresPermissions("007001003")
	public Map<String,Object>  updateMenuStatus(@Valid @ModelAttribute("menu") MenuEntity menu){
		Date date = new Date();
		menu.setUpdateDate(date);
		menu.setUser(this.getCurrentUser()); 
		menuService.saveMenu(menu);
		return convertToResult("message","更新菜单状态成功");
	}
	
	/**
	 *  删除菜单 <br/>
	 * 权限编码 007001002
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("007001002")
	public Map<String,Object>  deleMenus(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		menuService.deleMenu(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("menu") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getMenu(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("menu", menuService.getMenuById(id));
		}
	}
}
