package com.wqm.web.water;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
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
 * 区域管理Controller
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
	 * 区域管理界面<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/monitorItemManager")
	public String  monitorItemsManager(Model model){		 
		return "/monitorItem/monitorItemManager";
	}
	
	/**
	 * 区域编辑，新增界面
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
		return "/monitorItem/monitorItemForm";
	}
	
	/**
	 * 获取全部区域
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorItemsList")
	public List<MonitorItem> getMonitorItemsList(){
		List<MonitorItem> monitorItems= monitorItemService.getAllMonitorItems();
		return monitorItems;
	}
	
	/**
	 * 分页查询区域
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorItemsPage")
	public Map<String,Object> getMonitorItemsPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<MonitorItem> specf = new SpecificationFactory<MonitorItem>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("monitorItemName"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		specf.addSearchParam("authorId", Operator.LIKE,  request.getParameter("authorId"));
		specf.addSearchParam("parentCode", Operator.EQ,  StringUtils.isBlank(request.getParameter("parentId"))?
				"":Long.valueOf(request.getParameter("parentId")));
		specf.addSearchParam("isLeaf", Operator.EQ,  StringUtils.isBlank(request.getParameter("isLeaf"))?
				"":Boolean.valueOf(request.getParameter("isLeaf")));
		//分页排序信息
		Page<MonitorItem> monitorItems= monitorItemService.getMonitorItemsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(monitorItems);
	}
	
	/**
	 * 创建区域<br/>
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
	 * 更新区域<br/>
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
	 * 更改区域状态<br/>
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
		return convertToResult("message","更新区域状态成功");
	}
	
	/**
	 *  删除区域 <br/>
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
