package com.wqm.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.AuthorizationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wqm.common.util.PrincipalUtil;
import com.wqm.service.ServiceException;
import com.wqm.service.sys.MenuService;


@Controller
@RequestMapping(value = "/")
public class ManagerController {
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(Model model) {
		model.addAttribute("userName",PrincipalUtil.getCurrentUserName() );
		return "/front/index";
	}
	
	@RequestMapping(method = RequestMethod.GET,value="admin")
	public String adminManager(){
		return "/default";
	}
	
	@RequestMapping(method = RequestMethod.GET,value="/admin/index")
	public String workbench(){
		return "/sys/index";
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value="unauthorized")
	public Map<String,String> unauthorized(HttpServletRequest request){
		Map<String, String> result = new HashMap<String,String>();
		result.put("resultCode", "0");
		result.put("message", "您没有该权限！如有疑问，请联系管理员。");
		result.put("detailInfo", request.getParameter("message"));
		return  result;
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value="exception")
	public Map<String,String> exception(HttpServletRequest request){
		Map<String, String> result = new HashMap<String,String>();
		result.put("resultCode", "0");
		result.put("message", "系统业务异常，请联系管理员。");
		result.put("detailInfo", request.getParameter("message"));
		return result;
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value="error")
	public Map<String,String> error(HttpServletRequest request){
		Map<String, String> result = new HashMap<String,String>();
		result.put("resultCode", "0");
		result.put("message", "系统运行异常，请联系管理员。");
		result.put("detailInfo", request.getParameter("message"));
		return result;
	}
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value="fileUploadError")
	public Map<String,String> fileUpload(HttpServletRequest request){
		Map<String, String> result = new HashMap<String,String>();
		result.put("resultCode", "0");
		result.put("message", "上传文件超出大小限制。");
		result.put("detailInfo", request.getParameter("message"));
		return  result;
	}
	
	@RequestMapping(method = RequestMethod.GET,value="test/{type}")
	public void test(@PathVariable("type") String type){
		if(type.equals("serviceException")){
			throw new ServiceException("serviceException test");
		}else if(type.equals("Exception")){
			int[] a = {2,3};
			a[10] = a[8] + a[3];
		}else if(type.equals("AuthorizationException")){
			throw new AuthorizationException("AuthorizationException test");
		}
	}
}
