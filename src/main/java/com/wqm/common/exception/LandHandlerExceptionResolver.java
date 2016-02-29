package com.wqm.common.exception;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.wqm.common.util.PrincipalUtil;
import com.wqm.service.ServiceException;

/**
 * 系统异常统一拦截处理<br/>
 * header LandException  true
 * @author wangxj
 *
 */
public class LandHandlerExceptionResolver extends SimpleMappingExceptionResolver{
	private final static Logger logger = LoggerFactory.getLogger(LandHandlerExceptionResolver.class);
	
    @Override 
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, 
											Object handler, Exception exception) {
    	
    	logger.info("--------------异常统一处理----------------");
    	ModelAndView mv = null;
    	String viewName = determineViewName(exception, request);  
    	logger.info("viewName"+viewName);
        if (viewName != null) {//JSP格式返回  
        	logger.info("request.X-Requested-With:"+request.getHeader("X-Requested-With"));
        	logger.info("request.accept:"+request.getHeader("accept"));
            if(request.getHeader("accept").indexOf("application/json")>-1 
            		&& request.getHeader("X-Requested-With").indexOf("XMLHttpRequest")>-1){//如果不是异步请求  
                /*Integer statusCode = determineStatusCode(request, viewName);  
                if (statusCode != null) {  
                    applyStatusCodeIfPossible(request, response, statusCode);  
                    return getModelAndView(viewName, exception, request);  
                }*/
            	mv = viewExceptionResolver(exception);
            }else{//JSON格式返回  
            	mv = viewExceptionResolver(exception);
            }
        }
        return mv;
    }
    
    private ModelAndView viewExceptionResolver(Exception exception){
    	String message = exception.getMessage();
    	Map<String, Object> model=new HashMap<String, Object>();  
        model.put("message", message);
    	if(exception instanceof AuthorizationException ){  
             logger.error("权限异常：用户[{}] {}",PrincipalUtil.getCurrentUserAccount(),message);
             ModelAndView mv = new ModelAndView("redirect:/unauthorized",model);
             return mv;  
        }else if(exception instanceof ServiceException ){
         	logger.error("业务异常：{}  {}" , message,exception.getCause());
         	ModelAndView mv = new ModelAndView("redirect:/exception",model);
         	return mv;  
        }else if (exception instanceof MaxUploadSizeExceededException){
         	logger.error("上传文件过大：{}  {}" , message,exception.getCause());
         	ModelAndView mv = new ModelAndView("redirect:/fileUploadError",model);
         	return mv;  
     	}else{
         	logger.error("异常信息：{}  {}",message,exception );
         	ModelAndView mv = new ModelAndView("redirect:/error",model);
         	return mv;  
        } 
    }
    
    @SuppressWarnings("unused")
	private ModelAndView jsonExceptionResolver(Exception exception){
    	Map<String, Object> model=new HashMap<String, Object>();  
        model.put("message", "Exception");  
        return new ModelAndView();
    }
}
