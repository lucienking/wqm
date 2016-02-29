package com.wqm.common.util;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.wqm.common.context.SpringContextHolder;
import com.wqm.entity.sys.SysLogEntity;
import com.wqm.service.sys.SysLogService;

/**
 * 系统日志工具类
 * @author wangxj
 *
 */
public class SystemLogUtil {

	/**
	 * 保存日志
	 * @param code
	 * @return
	 */
	public static void saveSysLog(HttpServletRequest request,String content){
		saveSysLog(request,content,"无详细描述");
	}
	
	public static void saveSysLog(HttpServletRequest request,String content,String description){
		saveSysLog(request,content,description,"通用模块");
	}
	
	public static void saveSysLog(HttpServletRequest request,String content,String description,String module){
		SysLogEntity sysLog = new SysLogEntity();
		sysLog.setOperateAccount(PrincipalUtil.getCurrentUserAccount());
		sysLog.setOperateBrowser(CommonUtil.getClientBrowser(request));
		sysLog.setOperateContent(content);
		sysLog.setOperateDate(new Date());
		sysLog.setOperateDescription(description);
		sysLog.setOperateIp(CommonUtil.getIpAddr(request));
		sysLog.setOperateModule(module);
		
		SysLogService sysParamService = (SysLogService)SpringContextHolder.getBean("sysLogService");
		sysParamService.saveLog(sysLog);
	}
}
