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

import com.wqm.common.persistence.SpecificationFactory;
import com.wqm.common.persistence.SearchFilter.Operator;
import com.wqm.common.util.EhCacheUtil;
import com.wqm.entity.sys.SysParamEntity;
import com.wqm.service.sys.SysParamService;
import com.wqm.web.BaseController;

/**
 * 系统参数处理Cotroller
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/sys/param/")
public class SysParamController extends BaseController{
	
	@Autowired
	private SysParamService sysParamService;
	
	@SuppressWarnings("unused")
	private final static Logger logger = LoggerFactory.getLogger(SysParamController.class);
	
	@RequestMapping(method = RequestMethod.GET,value = "/paramManager")
	@RequiresPermissions("007003")
	public String manager(){
		return "/sys/sysParamManager";
	}
	
	/**
	 * 分页查询系统参数
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getSysParamsPage")
	public Map<String,Object> getByPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<SysParamEntity> specf = new SpecificationFactory<SysParamEntity>();
		specf.addSearchParam("sysParamName", Operator.LIKE, request.getParameter("sysParamName"));
		specf.addSearchParam("sysParamCode", Operator.LIKE,  request.getParameter("sysParamCode"));
		specf.addSearchParam("sysParamValue", Operator.LIKE,  request.getParameter("sysParamValue"));
		//分页排序信息
		Page<SysParamEntity> menus= sysParamService.getParamsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(menus);
	}
	
	/**
	 * 创建系统参数<br/>
	 * 权限编码 007003001
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("007003001")
	public Map<String,Object>  create(@Valid SysParamEntity param){
		sysParamService.saveParam(param);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更新系统参数<br/>
	 * 权限编码 007003003
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007003003")
	public Map<String,Object>  update(@Valid @ModelAttribute("param") SysParamEntity param){
		sysParamService.saveParam(param);
		return convertToResult("message","更新成功");
	}
	
	/**
	 *  删除系统参数 <br/>
	 * 权限编码 007003002
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("007003002")
	public Map<String,Object>  delete(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		sysParamService.deleParams(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("param") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getEntity(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("sysParam", sysParamService.getSysParamById(id));
		}
	}
	
	/**
	 * 更新字典缓存
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/refresh", method = RequestMethod.GET)
	public Map<String,Object> refresh(){
		EhCacheUtil.refresh("systemParam");
		return convertToResult("message","系统参数缓存刷新成功");
	}
}
