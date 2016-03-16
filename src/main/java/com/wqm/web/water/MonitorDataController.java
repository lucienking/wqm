package com.wqm.web.water;


import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.wqm.common.util.JsonMapper;
import com.wqm.entity.water.MonitorData;
import com.wqm.entity.water.WaterEntity;
import com.wqm.service.water.MonitorDataService;
import com.wqm.service.water.WaterService;
import com.wqm.web.BaseController;

/**
 * 监测项管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/monitorData")
public class MonitorDataController extends BaseController{

	@Autowired
	private MonitorDataService monitorDataService;
	
	@Autowired
	private WaterService waterService;
	
	/**
	 * 监测项管理界面<br/>
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/monitorDataManager")
	public String  monitorDatasManager(Model model,@RequestParam(value = "parentCode", defaultValue = "0") String parentCode
			,@RequestParam(value = "areaCode", defaultValue = "0") String areaCode){	
		model.addAttribute("parentCode", parentCode);
		model.addAttribute("areaCode", areaCode);
		return "/water/monitorDataManager";
	}
	
	/**
	 * 监测项编辑，新增界面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/monitorDataEdit")
	public String  monitorDatasEditForm(Model model,@Valid Long id){	
		MonitorData monitorData = null;
		String sortType = "create";
		if(id != null){
			monitorData =  monitorDataService.getMonitorDataById(id);
			sortType = "update";
		}
		model.addAttribute("monitorData",monitorData);
		model.addAttribute("sortType", sortType);
		return "/water/monitorDataForm";
	}
	
	/**
	 * 获取全部监测项
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorDatasList")
	public List<MonitorData> getMonitorDatasList(){
		List<MonitorData> monitorDatas= monitorDataService.getAllMonitorDatas();
		return monitorDatas;
	}
	
	/**
	 * 分页查询监测项
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getMonitorDatasPage")
	public Map<String,Object> getMonitorDatasPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<MonitorData> specf = new SpecificationFactory<MonitorData>();
		specf.addSearchParam("code", Operator.LIKE, request.getParameter("code"));
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("name"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		//分页排序信息
		Page<MonitorData> monitorDatas= monitorDataService.getMonitorDatasByPage(specf.getSpecification(),buildPageRequest(request));
		
		return convertToResult(monitorDatas);
	}
	
	/**
	 * 创建监测项<br/>
	 * @param monitorData
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public Map<String,Object>  createMonitorData(@Valid MonitorData monitorData){
		Date date = new Date();
		
		monitorData.setCreateDate(date);
		monitorData.setUpdateDate(date);
		monitorData.setUser(this.getCurrentUser()); 
		monitorDataService.saveMonitorData(monitorData);
		return convertToResult("message","新增成功");
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveMonitorData", method = RequestMethod.POST)
	public Map<String,Object> saveMonitorData(@RequestParam(value = "itemData", defaultValue = "[]") String itemData,
			@RequestParam(value = "waterName", defaultValue = "[]") String waterName,
			@RequestParam(value = "waterCode", defaultValue = "[]") String waterCode,
			@RequestParam(value = "monitorDate", defaultValue = "[]") String monitorDate){
		JsonMapper jm = new JsonMapper();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date mdate;
		try {
			mdate = sdf.parse(monitorDate);
		} catch (ParseException e) {
			mdate = new Date();
		}
		for(String item:itemData.split("@@")){
			Map<String,String> data = jm.fromJson(item,jm.contructMapType(HashMap.class, String.class, String.class));
			MonitorData md = new MonitorData();
			md.setCreateDate(new Date());
			md.setItemName(data.get("name"));
			md.setItemValue(data.get("value"));
			md.setMonitorDate(mdate);
			md.setUpdateDate(new Date());
			WaterEntity  water = waterService.getWaterByCode(waterCode);
			md.setWater(water);
			md.setUser(getCurrentUser());
			monitorDataService.saveMonitorData(md);
			water.setIsMonitored("Y");
			waterService.saveWater(water);
		}
		return convertToResult("message","录入成功");
	}
	
	/**
	 * 更新监测项<br/>
	 * 权限编码 007001003
	 * @param monitorData
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public Map<String,Object>  updateMonitorData(@Valid @ModelAttribute("monitorData") MonitorData monitorData){
		Date date = new Date();
		monitorData.setUpdateDate(date);
		monitorData.setUser(this.getCurrentUser()); 
		monitorDataService.saveMonitorData(monitorData);
		return convertToResult("message","更新成功");
	}
	
	/**
	 *  删除监测项 <br/>
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public Map<String,Object>  deleMonitorDatas(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		monitorDataService.deleMonitorData(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("monitorData") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getMonitorData(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("monitorData", monitorDataService.getMonitorDataById(id));
		}
	}
}
