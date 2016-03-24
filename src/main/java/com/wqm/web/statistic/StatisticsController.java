package com.wqm.web.statistic;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.wqm.web.BaseController;

/**
 * 统计Controller
 * 
 * @author wangxj
 *
 */
@Controller
@RequestMapping(value = "/statistic")
public class StatisticsController extends BaseController{

	/**
	 * 主index界面
	 */
	@RequestMapping(method = RequestMethod.GET,value="/example1")
	public String statistc1(){
		return "/statistic/example1";
	}
	@RequestMapping(method = RequestMethod.GET,value="/example2")
	public String statistc2(){
		return "/statistic/example2";
	}
	@RequestMapping(method = RequestMethod.GET,value="/example3")
	public String statistc3(){
		return "/statistic/example3";
	}
}
