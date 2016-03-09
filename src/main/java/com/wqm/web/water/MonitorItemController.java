package com.wqm.web.water;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import com.wqm.entity.water.MonitorItem;
import com.wqm.service.water.MonitorItemService;
import com.wqm.web.BaseController;

/**
 * 监测项管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/monitorItem")
public class MonitorItemController extends BaseController{

	@Autowired
	private MonitorItemService monitorItemService;
	
	/**
	 * 监测项管理界面<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/monitorItemManager")
	public String  monitorItemsManager(Model model){		 
		return "/water/monitorItemManager";
	}
	
	/**
	 * 监测项编辑，新增界面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/monitorItemEdit")
	public String  monitorItemsEditForm(Model model,@Valid Long id){	
		MonitorItem monitorItem = null;
		String sortType = "create";
		if(id != null){
			monitorItem =  monitorItemService.getMonitorItemById(id);
			sortType = "update";
		}
		model.addAttribute("monitorItem",monitorItem);
		model.addAttribute("sortType", sortType);
		return "/water/monitorItemForm";
	}
	
	/**
	 * 获取全部监测项
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorItemsList")
	public List<MonitorItem> getMonitorItemsList(){
		List<MonitorItem> monitorItems= monitorItemService.getAllMonitorItems();
		return monitorItems;
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorItemsTree")
	public List<Map<String,Object>>  getMonitorItemsTree(){
		List<MonitorItem> monitorItems= monitorItemService.getAllMonitorItems();
		List<Map<String,Object>> tree =  new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> ctree =  new ArrayList<Map<String,Object>>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		for(MonitorItem mi:monitorItems){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id",mi.getCode());
			map.put("text", mi.getName());
			ctree.add(map);
		}
		pmap.put("id", "");
		pmap.put("text", "全部监测项");
		pmap.put("children", ctree);
		tree.add(pmap);
		return tree;
	}
	
	/**
	 * 分页查询监测项
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorItemsPage")
	public Map<String,Object> getMonitorItemsPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<MonitorItem> specf = new SpecificationFactory<MonitorItem>();
		specf.addSearchParam("code", Operator.LIKE, request.getParameter("code"));
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("name"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		//分页排序信息
		Page<MonitorItem> monitorItems= monitorItemService.getMonitorItemsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(monitorItems);
	}
	
	/**
	 * 创建监测项<br/>
	 * @param monitorItem
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Map<String,Object>  createMonitorItem(@Valid MonitorItem monitorItem){
		Date date = new Date();
		
		monitorItem.setCreateDate(date);
		monitorItem.setUpdateDate(date);
		monitorItem.setUser(this.getCurrentUser()); 
		monitorItemService.saveMonitorItem(monitorItem);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新监测项<br/>
	 * 权限编码 007001003
	 * @param monitorItem
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Map<String,Object>  updateMonitorItem(@Valid @ModelAttribute("monitorItem") MonitorItem monitorItem){
		Date date = new Date();
		monitorItem.setUpdateDate(date);
		monitorItem.setUser(this.getCurrentUser()); 
		monitorItemService.saveMonitorItem(monitorItem);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 更改监测项状态<br/>
	 * @param monitorItem
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	public Map<String,Object>  updateMonitorItemStatus(@Valid @ModelAttribute("monitorItem") MonitorItem monitorItem){
		Date date = new Date();
		monitorItem.setUpdateDate(date);
		monitorItem.setUser(this.getCurrentUser()); 
		monitorItemService.saveMonitorItem(monitorItem);
		return convertToResult("message","更新监测项状态成功");
	}
	
	/**
	 *  删除监测项 <br/>
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Map<String,Object>  deleMonitorItems(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		monitorItemService.deleMonitorItem(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("monitorItem") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getMonitorItem(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("monitorItem", monitorItemService.getMonitorItemById(id));
		}
	}
}
