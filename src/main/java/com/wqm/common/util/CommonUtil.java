package com.wqm.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

/**
 * 常用工具封装
 * 
 * @author wangxj
 * 
 */
public class CommonUtil {

	/**
	 * 打印请求参数
	 * @param request
	 */
	public static void printRequestParams(HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		Enumeration<String> paramNames = request.getParameterNames();
		System.out.println("请求"+request.getRequestURI());
		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();
			String[] paramValues = request.getParameterValues(paramName);
			if (paramValues.length == 1) {
				String paramValue = paramValues[0];
				if (paramValue.length() != 0) {
					System.out.println("	参数：" + paramName + "=" + paramValue);
					map.put(paramName, paramValue);
				}
			}
		}
	}
	
	/**
	 * 根据配置文件名和属性名 获取 属性值
	 * @param file
	 * @param name
	 * @return
	 */
	public static String getPropertyValue(String fileName,String propertyName){
		ResourceBundle res = ResourceBundle.getBundle(fileName); 
		return res.getString(propertyName);
	}
	
	/**
	 * 获取当前时间的格式化字符串
	 * @param formatter
	 * @return
	 */
	public static String getNowDateFormat(String formatter){
		Date date  = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		return sdf.format(date);
	}
	
	public static String underscoreName(String name){
		StringBuilder result = new StringBuilder();
	    if (name != null && name.length() > 0) {
	        // 将第一个字符处理成大写
	        result.append(name.substring(0, 1).toUpperCase());
	        // 循环处理其余字符
	        for (int i = 1; i < name.length(); i++) {
	            String s = name.substring(i, i + 1);
	            // 在大写字母前添加下划线
	            if (s.equals(s.toUpperCase()) && !Character.isDigit(s.charAt(0))) {
	                result.append("_");
	            }
	            // 其他字符直接转成大写
	            result.append(s.toUpperCase());
	        }
	    }
	    return result.toString();
	}
	
	/**
	 * 获取请求客户端IP地址
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 获取客户端浏览器信息
	 * @param request
	 * @return
	 */
	public static String getClientBrowser(HttpServletRequest request){
		String str = "未知";  
		String info = request.getHeader("user-agent");
		Pattern pattern = Pattern.compile("");
		Matcher matcher;
		if (info.indexOf("MSIE") != -1) {
			str = "MSIE"; // 微软IE
			pattern = Pattern.compile(str + "\\s([0-9.]+)");
		} else if (info.indexOf("Firefox") != -1) {
			str = "Firefox"; // 火狐
			pattern = Pattern.compile(str + "\\/([0-9.]+)");
		} else if (info.indexOf("Chrome") != -1) {
			str = "Chrome"; // Google
			pattern = Pattern.compile(str + "\\/([0-9.]+)");
		} else if (info.indexOf("Opera") != -1) {
			str = "Opera"; // Opera
			pattern = Pattern.compile("Version\\/([0-9.]+)");
		}
		matcher = pattern.matcher(info);
		if (matcher.find())
			str = str + " " + matcher.group(1);
		return str;
	}
	
	/**
	 * 获取客户端操作系统
	 * @param request
	 * @return
	 */
	public static String getClientOS(String userAgent){
		String cos = "unknow os";

		Pattern p = Pattern.compile(".*(Windows NT 6\\.1).*");
		Matcher m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Win 7";
			return cos;
		}
		
		p = Pattern.compile(".*(Windows NT 5\\.1|Windows XP).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "WinXP";
			return cos;
		}

		p = Pattern.compile(".*(Windows NT 5\\.2).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Win2003";
			return cos;
		}

		p = Pattern.compile(".*(Win2000|Windows 2000|Windows NT 5\\.0).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Win2000";
			return cos;
		}

		p = Pattern.compile(".*(Mac|apple|MacOS8).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "MAC";
			return cos;
		}

		p = Pattern.compile(".*(WinNT|Windows NT).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "WinNT";
			return cos;
		}

		p = Pattern.compile(".*Linux.*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Linux";
			return cos;
		}

		p = Pattern.compile(".*(68k|68000).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Mac68k";
			return cos;
		}

		p = Pattern.compile(".*(9x 4.90|Win9(5|8)|Windows 9(5|8)|95/NT|Win32|32bit).*");
		m = p.matcher(userAgent);
		if (m.find()) {
			cos = "Win9x";
			return cos;
		}

		return cos;
	}
}
