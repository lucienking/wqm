package com.wqm.web.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import com.wqm.common.util.EhCacheUtil;
import com.wqm.entity.sys.DictionaryEntity;
import com.wqm.service.sys.DictionaryService;
import com.wqm.web.BaseController;

/**
 * 数据字典处理Controller
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/sys/dict/")
public class DictionaryController extends BaseController{
	
	@Autowired
	private DictionaryService dictionaryService;
	
	@SuppressWarnings("unused")
	private final static Logger logger = LoggerFactory.getLogger(DictionaryController.class);
	
	@RequestMapping(method = RequestMethod.GET,value = "/dictManager")
	@RequiresPermissions("007002")
	public String manager(){
		return "/sys/dictManager";
	}
	
	/**
	 * 分页查询字典
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getDictsPage")
	public Map<String,Object> getByPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<DictionaryEntity> specf = new SpecificationFactory<DictionaryEntity>();
		specf.addSearchParam("dictName", Operator.LIKE, request.getParameter("dictName"));
		specf.addSearchParam("dictCode", Operator.LIKE,  request.getParameter("dictCode"));
		specf.addSearchParam("dictGroup", Operator.LIKE,  request.getParameter("dictGroup"));
		//分页排序信息
		Page<DictionaryEntity> menus= dictionaryService.getDictsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(menus);
	}
	
	/**
	 * 创建字典<br/>
	 * 权限编码 007002001
	 * @param dict
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("007002001")
	public Map<String,Object>  create(@Valid DictionaryEntity dict){
		dictionaryService.saveDict(dict);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新字典<br/>
	 * 权限编码 007002003
	 * @param dict
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007002003")
	public Map<String,Object>  update(@Valid @ModelAttribute("dict") DictionaryEntity dict){
		dictionaryService.saveDict(dict);
		return convertToResult("message","更新成功");
	}
	
	/**
	 * 删除字典 <br/>
	 * 权限编码 007002002
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("007002002")
	public Map<String,Object>  delete(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		dictionaryService.deleDicts(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("dict") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getEntity(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("dict", dictionaryService.getDictById(id));
		}
	}
	
	/**
	 * 更新字典缓存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/refresh", method = RequestMethod.GET)
	public Map<String,Object> refresh(){
		EhCacheUtil.refresh("dictionary");
		return convertToResult("message","字典缓存刷新成功");
	}
	
	/**
	 * 根据字典值和字典组获取字典名
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findValueByCodeAndeGroup",method=RequestMethod.GET)
	public Map<String,Object> findValueByCodeAndeGroup(HttpServletRequest request){
		String dictValue=request.getParameter("dictValue");
		String dictGroup=request.getParameter("dictGroup");
		DictionaryEntity de=dictionaryService.getDictItemByVAndG(dictValue, dictGroup);
		return convertToResult("dictName",de==null? null:de.getDictName());
	}
	
	/**
	 * 根据字典值和字典组获取字典名
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findNameByValueAndGroup",method=RequestMethod.GET)
	public Map<String,Object> findNameByValueAndGroup(HttpServletRequest request){
		String dictValue=request.getParameter("dictValue");
		String dictGroup=request.getParameter("dictGroup");
		DictionaryEntity de=dictionaryService.getDictItemByVAndG(dictValue, dictGroup);
		return convertToResult("dictName",de==null? dictValue:de.getDictName());
	}
}
