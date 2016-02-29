package com.wqm.web.sys;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wqm.common.persistence.SpecificationFactory;
import com.wqm.common.persistence.SearchFilter.Operator;
import com.wqm.entity.sys.SysLogEntity;
import com.wqm.service.sys.SysLogService;
import com.wqm.web.BaseController;

/**
 * 系统日志处理Cotroller
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/sys/log/")
public class SysLogController extends BaseController{
	
	@Autowired
	private SysLogService sysLogService;
	
	@SuppressWarnings("unused")
	private final static Logger logger = LoggerFactory.getLogger(SysLogController.class);
	
	@RequestMapping(method = RequestMethod.GET,value = "/sysLogManager")
	@RequiresPermissions("007004")
	public String manager(){
		return "/sys/sysLogManager";
	}
	
	/**
	 * 分页查询系统日志
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getSysLog")
	public Map<String,Object> getByPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<SysLogEntity> specf = new SpecificationFactory<SysLogEntity>();
		specf.addSearchParam("operateModule", Operator.LIKE, request.getParameter("operateModule"));
		specf.addSearchParam("operateAccount", Operator.LIKE,  request.getParameter("operateAccount"));
		specf.addSearchParam("operateContent", Operator.LIKE,  request.getParameter("operateContent"));
		//分页排序信息
		Page<SysLogEntity> logs= sysLogService.getLogsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(logs);
	}
}
