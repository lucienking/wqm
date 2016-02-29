package com.wqm.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.wqm.common.easyui.EasyUiPage;
import com.wqm.common.util.PrincipalUtil;
import com.wqm.entity.sys.UserEntity;

/**
 * Controller 通用方法封封装
 * 
 * @author wangxj
 *
 */
public class BaseController {
	
	/**
	 * 获取EasyUi传过来的Page 内容 包含排序
	 * @param request
	 * @return
	 */
	protected EasyUiPage getPage(HttpServletRequest request){
		EasyUiPage page = new EasyUiPage();
		if(StringUtils.isNumeric(request.getParameter("page")))
			page.setPageNumber(Integer.valueOf(request.getParameter("page")));
		if(StringUtils.isNumeric(request.getParameter("rows")))
			page.setPageSize(Integer.valueOf(request.getParameter("rows")));
		if(!StringUtils.isBlank(request.getParameter("sort")))
			page.setSortString(request.getParameter("sort"));
		if(!StringUtils.isBlank(request.getParameter("order")))
			page.setSortType(request.getParameter("order"));
		return page;
	}
	
	/**
	 * 创建分页请求
	 * @param request
	 * @return
	 */
	protected PageRequest buildPageRequest(HttpServletRequest request) {
		EasyUiPage page = this.getPage(request);
		Sort sort = null;
		sort =  "desc".equals(page.getSortType()) ?
			new Sort(Direction.DESC, page.getSortString()):
			new Sort(Direction.ASC, page.getSortString());
		return new PageRequest(page.getPageNumber() - 1, page.getPageSize(), sort);
	}
	
	/**
	 * 设置返回结果  object
	 * @param object
	 * @return
	 */
	protected Map<String,Object> convertToResult(String key, String message) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(key,message);
		return result;
	}
	
	/**
	 * 设置返回结果 自定义key
	 * @param key
	 * @param object
	 * @return
	 */
	protected Map<String, Object> convertToResult(String key, Object object) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(key, object);
		return result;
	}
	
	/**
	 * 设置返回结果 Page 实体 List
	 * @param pageList
	 * @return
	 */
	protected  Map<String, Object> convertToResult(List<?>  list) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total",list == null?0: list.size());
		result.put("rows", list);
		return result;
	}
	
	/**
	 * 设置返回结果 Page 实体 List
	 * @param pageList
	 * @return
	 */
	protected  Map<String, Object> convertToResult(Page<?>  pageList) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total",pageList.getTotalElements());
		result.put("rows", pageList.getContent());
		return result;
	}
	
	/**
	 * 获取当前登录用户
	 * @return
	 */
	protected UserEntity getCurrentUser(){
		return new UserEntity(PrincipalUtil.getCurrentUserId());
	}
	
	/**
	 * 获得请求参数
	 * @
	 */
	protected String getParameter(String key){
		ServletRequestAttributes attr = (ServletRequestAttributes) 
	                RequestContextHolder.currentRequestAttributes(); 
	    HttpServletRequest request = attr.getRequest();
	    return StringUtils.isBlank(request.getParameter(key))? null:
	    	request.getParameter(key);
	}
	
	/**
	 * 获得请求参数
	 * @
	 */
	protected String getFarmCodeParameter(){
	    String farmCode = PrincipalUtil.getCurrentUserDepartmentCode();
	    if(getAdminList().indexOf(farmCode)>-1) farmCode ="1";
	    else if(getFarmList().indexOf(farmCode)>-1) farmCode= farmCode+"";
	    else farmCode = "";
	    return farmCode;
	}
	
	private static List<String> getAdminList(){
		List<String> list = new ArrayList<String>();
		for(int i=101;i<139;i++){
			list.add(String.valueOf(i));
		}
		list.add("1");
		return list;
	}
	
	private static List<String> getFarmList(){
		List<String> list = new ArrayList<String>();
		for(int i=301;i<340;i++){
			list.add(String.valueOf(i));
		}
		return list;
	}
}
