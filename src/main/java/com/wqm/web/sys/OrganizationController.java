package com.wqm.web.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wqm.entity.sys.OrganizationEntity;
import com.wqm.service.sys.OrganizationService;
import com.wqm.web.BaseController;

/**
 * 组织机构Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/sys/org/")
public class OrganizationController extends BaseController{

	@Autowired
	private OrganizationService organizationService;
	
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getAllFarms")
	public List<Map<String,String>> getAllFarms(){
		List<Map<String,String>> maps =  new ArrayList<Map<String,String>>();
		List<OrganizationEntity> orgs = organizationService.getAllFarms();
		Map<String,String> defau = new HashMap<String,String>();
		defau.put("name", "海南农垦");
		defau.put("selected", "true");
		defau.put("code", "1");
		maps.add(defau);
		for(OrganizationEntity o:orgs){
			Map<String,String> map = new HashMap<String,String>();
			map.put("name", o.getName());
			map.put("code", o.getPermissions());
			maps.add(map);
		}
		return maps;
	}
	 
}
