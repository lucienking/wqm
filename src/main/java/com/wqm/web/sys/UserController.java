package com.wqm.web.sys;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.wqm.common.util.PrincipalUtil;
import com.wqm.entity.sys.UserEntity;
import com.wqm.service.sys.UserService;
import com.wqm.web.BaseController;

@Controller
@RequestMapping(value = "/sys/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;

	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "id", defaultValue = "-1") Long id,Model model) {
		UserEntity user = userService.getUser(id);
		model.addAttribute("user", user);

		return "account/adminUserList";
	} 
	/**
	 * 显示页面
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/userManager")
	@RequiresPermissions("007005")
	public String  userManager(Model model){		 
		return "/sys/userManager";
	}
	
	/**
	 * 分页查询用户信息
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.POST,value = "/getUserPage")
	public Map<String,Object> getUserPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<UserEntity> specf = new SpecificationFactory<UserEntity>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("userName"));
		specf.addSearchParam("identityNumber", Operator.LIKE,  request.getParameter("identityNumber"));
		specf.addSearchParam("sex", Operator.EQ,  StringUtils.isBlank(request.getParameter("sex"))?
				"":request.getParameter("sex"));
		specf.addSearchParam("nationCode", Operator.EQ,  request.getParameter("nationCode"));
		System.out.println("------------------------------------------查询用户信息-------------------------------------");
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("identityNumber"));
		System.out.println(StringUtils.isBlank(request.getParameter("sex"))?
				"":request.getParameter("sex"));
		System.out.println(request.getParameter("nationCode"));
		System.out.println("------------------------------------------查询用户信息-------------------------------------");
		//分页排序信息
		Page<UserEntity> user= userService.getUserByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(user);
	}
	
	
	
	/**
	 * 新增用户信息<br/>
	 * 权限编码 007005001
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("007005001")
	public Map<String,Object>  createUser(UserEntity user){
		Date date = new Date();
		user.setCreateDate(date);
    	userService.createUser(user);
		return convertToResult("message","新增成功");
	}
	
	
	/**
	 * 更新用户信息<br/>
	 * 权限编码 007005003
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("007005003")
	public Map<String,Object>  updateUser(@Valid @ModelAttribute("user") UserEntity user){ 
		System.out.println("------------------数据更新开始----------------------------");
		System.out.println("数据"+user);	
		userService.updateUser(user);
		System.out.println("------------------数据更新结束----------------------------");
		return convertToResult("message","更新成功");
	}
	
	
	/**
	 *  删除用户 <br/>
	 * 权限编码 007005002
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("007005002")
	public Map<String,Object>  deleMenus(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			if(PrincipalUtil.getCurrentUserId()==Long.valueOf(id)){
				return convertToResult("message","请勿删除当前ID:"+PrincipalUtil.getCurrentUserId());
			}
			idlist.add(Long.valueOf(id));
		}
		userService.deleUser(idlist);
		return convertToResult("message","删除成功");
	}
	
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("user") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getUser(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			System.out.println("------------------数据二次绑定----------------------------");
			model.addAttribute("user", userService.getUserById(id));
			System.out.println("数据"+userService.getUserById(id));
			System.out.println("数据"+model);
			System.out.println("------------------数据二次绑定----------------------------");
			
		}
	}
}
