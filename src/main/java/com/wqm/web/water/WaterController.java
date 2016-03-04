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
import com.wqm.entity.water.WaterEntity;
import com.wqm.service.sys.DictionaryService;
import com.wqm.service.water.WaterService;
import com.wqm.web.BaseController;

/**
 * 系统-水体管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/water")
public class WaterController extends BaseController{

	@Autowired
	private WaterService waterService;
	
	@Autowired
	private DictionaryService dictionaryService;
	
	private final static Logger logger = LoggerFactory.getLogger(WaterController.class);
	
	/**
	 * 按父节点加载水体，返回水体树JSON
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getWaters")
	public List<Map<String,Object>> getWatersJson(@RequestParam(value = "code", defaultValue = "0") String code){
		/* 启用水体状态功能 允许失效
		 *  Sort sort = new Sort(Direction.ASC, "sortNum");
			List<WaterEntity> waters= waterService.getWaterListById(id,sort);
		*/
		List<WaterEntity> waters= waterService.getWaterListById(code);
		List<Map<String,Object>> tree =  new ArrayList<Map<String,Object>>();
		for(WaterEntity water:waters){
			Map<String, Object> map = new HashMap<String, Object>();
			String text = water.getName();
			map.put("id",water.getId()+"");
			map.put("iconCls", water.getIconCls());
			if(!water.getIsLeaf()){
				map.put("state","closed");
				text = "<span class='waterTreeParent'>"+text+"</span>" ;
			}
			map.put("text",text);
			
			Map<String,String> attribute = new HashMap<String,String>();
			attribute.put("url", water.getWaterUrl());
			map.put("attributes",attribute );
		//水体权限	if(PrincipalUtil.isHavePermission(water.getAuthorId())||"admin".equals(PrincipalUtil.getCurrentUserName()))
				tree.add(map);
		}
		logger.info("加载水体:"+tree.toString());
		return tree;
	}
	
	/**
	 * 水体管理界面<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/waterManager")
	public String  watersManager(Model model){		 
		return "/water/waterManager";
	}
	
	/**
	 * 水体编辑，新增界面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/waterEdit")
	public String  watersEditForm(Model model,@Valid Long id){	
		WaterEntity water = null;
		String sortType = "create";
		if(id != null){
			water =  waterService.getWaterById(id);
			sortType = "update";
		}
		model.addAttribute("water",water);
		model.addAttribute("sortType", sortType);
		return "/water/waterForm";
	}
	
	/**
	 * 获取全部水体
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getWatersList")
	public List<WaterEntity> getWatersList(){
		List<WaterEntity> waters= waterService.getAllWaters();
		return waters;
	}
	
	/**
	 * 分页查询水体
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getWatersPage")
	public Map<String,Object> getWatersPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<WaterEntity> specf = new SpecificationFactory<WaterEntity>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("waterName"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		specf.addSearchParam("authorId", Operator.LIKE,  request.getParameter("authorId"));
		specf.addSearchParam("parentCode", Operator.EQ,  StringUtils.isBlank(request.getParameter("parentId"))?
				"":Long.valueOf(request.getParameter("parentId")));
		specf.addSearchParam("isLeaf", Operator.EQ,  StringUtils.isBlank(request.getParameter("isLeaf"))?
				"":Boolean.valueOf(request.getParameter("isLeaf")));
		//分页排序信息
		Page<WaterEntity> waters= waterService.getWatersByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(waters);
	}
	
	/**
	 * 获得全部的父水体项，即所有的栏目。
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getParents")
	public List<WaterEntity> getParents(){
		List<WaterEntity> waters= waterService.getAllParents();
		return waters;
	}
	
	/**
	 * 创建水体<br/>
	 * @param water
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Map<String,Object>  createWater(@Valid WaterEntity water){
		Date date = new Date();
		
		water.setCreateDate(date);
		water.setUpdateDate(date);
		water.setUser(this.getCurrentUser()); 
		waterService.saveWater(water);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新水体<br/>
	 * 权限编码 007001003
	 * @param water
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007001003")
	public Map<String,Object>  updateWater(@Valid @ModelAttribute("water") WaterEntity water){
		Date date = new Date();
		water.setUpdateDate(date);
		water.setUser(this.getCurrentUser()); 
		waterService.saveWater(water);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 更改水体状态<br/>
	 * @param water
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	public Map<String,Object>  updateWaterStatus(@Valid @ModelAttribute("water") WaterEntity water){
		Date date = new Date();
		water.setUpdateDate(date);
		water.setUser(this.getCurrentUser()); 
		waterService.saveWater(water);
		return convertToResult("message","更新水体状态成功");
	}
	
	/**
	 *  删除水体 <br/>
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Map<String,Object>  deleWaters(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		waterService.deleWater(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("water") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getWater(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("water", waterService.getWaterById(id));
		}
	}
}