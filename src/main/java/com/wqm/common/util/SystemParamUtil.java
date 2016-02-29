package com.wqm.common.util;

import com.wqm.common.context.SpringContextHolder;
import com.wqm.service.sys.SysParamService;

public class SystemParamUtil {

	/**
	 * 根据字典编码查找字典值
	 * @param code
	 * @return
	 */
	public static String getParamValueByCode(String code){
		String value = null;
		SysParamService sysParamService = (SysParamService)SpringContextHolder.getBean("sysParamService");
		if(sysParamService.getParamByCode(code)!=null) 
			value = sysParamService.getParamByCode(code).getsysParamValue();
		return value;
	}
}
