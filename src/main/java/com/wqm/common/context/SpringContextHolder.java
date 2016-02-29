package com.wqm.common.context;

import org.apache.commons.lang3.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * SpringCotext 类封装
 * 
 * @author wangxj
 *
 */
public class SpringContextHolder implements ApplicationContextAware,DisposableBean {

	public SpringContextHolder() {
	}

	public static ApplicationContext getApplicationContext() {
		assertContextInjected();
		return applicationContext;
	}

	public static Object getBean(String name) {
		assertContextInjected();
		return applicationContext.getBean(name);
	}

	public static Object getBean(Class<?> requiredType) {
		assertContextInjected();
		return applicationContext.getBean(requiredType);
	}

	public static void clearHolder() {
		logger.debug((new StringBuilder())
				.append("\u6E05\u9664SpringContextHolder\u4E2D\u7684ApplicationContext:")
				.append(applicationContext).toString());
		applicationContext = null;
	}

	public void setApplicationContext(ApplicationContext appCxt) {
		logger.debug("\u6CE8\u5165ApplicationContext\u5230SpringContextHolder:{}",
				appCxt);
		if (appCxt != null)
			logger.warn((new StringBuilder())
					.append("SpringContextHolder\u4E2D\u7684ApplicationContext\u88AB\u8986\u76D6, \u539F\u6709ApplicationContext\u4E3A:")
					.append(appCxt).toString());
		applicationContext = appCxt;
	}

	public void destroy() throws Exception {
		clearHolder();
	}

	private static void assertContextInjected() {
		Validate.validState(
				applicationContext != null,
				"applicaitonContext\u5C5E\u6027\u672A\u6CE8\u5165, \u8BF7\u5728applicationContext.xml\u4E2D\u5B9A\u4E49SpringContextHolder.",
				new Object[0]);
	}

	private static ApplicationContext applicationContext = null;
	private final static Logger logger = LoggerFactory.getLogger(SpringContextHolder.class);
}
