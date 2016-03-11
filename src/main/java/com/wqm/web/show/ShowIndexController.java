package com.wqm.web.show;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wqm.entity.water.AreaEntity;
import com.wqm.entity.water.WaterEntity;
import com.wqm.service.water.AreaService;
import com.wqm.service.water.WaterService;
import com.wqm.web.BaseController;

/**
 * 系统-水体管理Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/show")
public class ShowIndexController extends BaseController{

	@Autowired
	private WaterService waterService;
	
	@Autowired
	private AreaService areaService;
	
	//private final static Logger logger = LoggerFactory.getLogger(ShowIndexController.class);
	
	/**
	 * 按父节点加载菜单，返回菜单树JSON
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getWaterTree")
	public List<Map<String,Object>> getWatersJson(@RequestParam(value = "id", defaultValue = "a0") String id){
		String code = id.substring(1);
		
		List<Map<String,Object>> tree =  new ArrayList<Map<String,Object>>();
		if(id.startsWith("a")){
			List<AreaEntity> areas= areaService.getAreasByParentCode(code);
			for(AreaEntity area:areas){
				Map<String, Object> map = new HashMap<String, Object>();
				String text = area.getName();
				map.put("id","a"+area.getCode());
				map.put("iconCls", area.getIconCls());
				map.put("text",text);
				map.put("state","closed");
				Map<String,String> attribute = new HashMap<String,String>();
				map.put("attributes",attribute );
				tree.add(map);
			}
			List<WaterEntity> waters= waterService.getWaterByAreaCode(code);
			for(WaterEntity water:waters){
				Map<String, Object> map = new HashMap<String, Object>();
				String text = water.getName();
				map.put("id","w"+water.getCode());
				map.put("iconCls", water.getIconCls());
				if(!water.getIsLeaf()){
					map.put("state","closed");
					text = "<span class='menuTreeParent'>"+text+"</span>" ;
				}
				map.put("text",text);
				
				Map<String,String> attribute = new HashMap<String,String>();
				map.put("attributes",attribute );
				tree.add(map);
			}
		}else if(id.startsWith("w")){
			List<WaterEntity> waters= waterService.getWaterListByCode(code);
			for(WaterEntity water:waters){
				Map<String, Object> map = new HashMap<String, Object>();
				String text = water.getName();
				map.put("id","w"+water.getCode());
				map.put("iconCls", water.getIconCls());
				if(!water.getIsLeaf()){
					map.put("state","closed");
					text = "<span class='menuTreeParent'>"+text+"</span>" ;
				}
				map.put("text",text);
				
				Map<String,String> attribute = new HashMap<String,String>();
				map.put("attributes",attribute );
				tree.add(map);
			}
		}
		return tree;
	}
	
}