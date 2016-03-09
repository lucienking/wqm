package com.wqm.web.water;


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
import com.wqm.entity.water.AreaEntity;
import com.wqm.service.water.AreaService;
import com.wqm.web.BaseController;

/**
 * 区域管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/area")
public class AreaController extends BaseController{

	@Autowired
	private AreaService areaService;
	
	private final static Logger logger = LoggerFactory.getLogger(AreaController.class);
	
	/**
	 * 按父节点加载区域，返回区域树JSON
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAreas")
	public List<Map<String,Object>> getAreasJson(@RequestParam(value = "code", defaultValue = "0") String code){
		/* 启用区域状态功能 允许失效
		 *  Sort sort = new Sort(Direction.ASC, "sortNum");
			List<AreaEntity> areas= areaService.getAreaListById(id,sort);
		*/
		List<AreaEntity> areas= areaService.getAreaListById(code);
		List<Map<String,Object>> tree =  new ArrayList<Map<String,Object>>();
		for(AreaEntity area:areas){
			Map<String, Object> map = new HashMap<String, Object>();
			String text = area.getName();
			map.put("id",area.getId()+"");
			map.put("iconCls", area.getIconCls());
			map.put("text",text);
			
			Map<String,String> attribute = new HashMap<String,String>();
			map.put("attributes",attribute );
		//区域权限	if(PrincipalUtil.isHavePermission(area.getAuthorId())||"admin".equals(PrincipalUtil.getCurrentUserName()))
				tree.add(map);
		}
		logger.info("加载区域:"+tree.toString());
		return tree;
	}
	
	/**
	 * 区域管理界面<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/areaManager")
	public String  areasManager(Model model){		 
		return "/water/areaManager";
	}
	
	/**
	 * 区域编辑，新增界面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/areaEdit")
	public String  areasEditForm(Model model,@Valid Long id){	
		AreaEntity area = null;
		String sortType = "create";
		if(id != null){
			area =  areaService.getAreaById(id);
			sortType = "update";
		}
		model.addAttribute("area",area);
		model.addAttribute("sortType", sortType);
		return "/water/areaForm";
	}
	
	/**
	 * 获取全部区域
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAreasList")
	public List<AreaEntity> getAreasList(){
		List<AreaEntity> areas= areaService.getAllAreas();
		return areas;
	}
	
	/**
	 * 分页查询区域
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAreasPage")
	public Map<String,Object> getAreasPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<AreaEntity> specf = new SpecificationFactory<AreaEntity>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("name"));
		specf.addSearchParam("code", Operator.LIKE, request.getParameter("code"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		specf.addSearchParam("parentCode", Operator.EQ,  StringUtils.isBlank(request.getParameter("parentId"))?
				"":Long.valueOf(request.getParameter("parentCode")));
		//分页排序信息
		Page<AreaEntity> areas= areaService.getAreasByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(areas);
	}
	
	/**
	 * 创建区域<br/>
	 * @param area
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Map<String,Object>  createArea(@Valid AreaEntity area){
		Date date = new Date();
		
		area.setCreateDate(date);
		area.setUpdateDate(date);
		area.setUser(this.getCurrentUser()); 
		areaService.saveArea(area);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新区域<br/>
	 * 权限编码 007001003
	 * @param area
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007001003")
	public Map<String,Object>  updateArea(@Valid @ModelAttribute("area") AreaEntity area){
		Date date = new Date();
		area.setUpdateDate(date);
		area.setUser(this.getCurrentUser()); 
		areaService.saveArea(area);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 更改区域状态<br/>
	 * @param area
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	public Map<String,Object>  updateAreaStatus(@Valid @ModelAttribute("area") AreaEntity area){
		Date date = new Date();
		area.setUpdateDate(date);
		area.setUser(this.getCurrentUser()); 
		areaService.saveArea(area);
		return convertToResult("message","更新区域状态成功");
	}
	
	/**
	 *  删除区域 <br/>
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Map<String,Object>  deleAreas(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		areaService.deleArea(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("area") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getArea(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("area", areaService.getAreaById(id));
		}
	}
	
	/**
	 * 获得全部的父水体项，即所有的栏目。
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getParents")
	public List<AreaEntity> getParents(){
		List<AreaEntity> areas= areaService.getAllAreas();
		return areas;
	}
}
