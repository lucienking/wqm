package com.wqm.common.util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;

import com.wqm.service.account.ShiroDbRealm.ShiroUser;


public class PrincipalUtil {
	
	public final static String URL_PARAM_CAS_AUTHORITY = "authority";
	
	public final static String URL_PARAM_CAS_PERMISSION = "url";
	
	public final static String URL_PARAM_CAS_ROLE = "role";
	
	public final static String URL_PARAM_CAS_APPCODE = "appCode";
	
	public final static String PROPERTY_APPLICATION_CODE = "application.code";
	
	public final static String PROPERTY_FILE_NAME = "application"; 
	
	/**
	 * 获取登录用户的信息，如果未登录则返回null
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Map<String,String> getPrincipalInfo(Subject subject) throws UnsupportedEncodingException{
		Map<String,String> infomap=new HashMap<String,String>();
		if(subject==null){
				return null;
	   	 }
		SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject .getPrincipals();
		 if (principalCollection==null) {
			return null;
		}
		ShiroUser user = (ShiroUser) principalCollection.getPrimaryPrincipal();
		infomap.put("userName", user.getName());
		infomap.put("name", user.getName());
		return infomap;
	}
	
	/**
	 * 获取当前登录操作员ID
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Long getCurrentUserId(){
		Subject subject = SecurityUtils.getSubject();
		Long userId = 0L;
		SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject .getPrincipals();
		 if (principalCollection==null) {
			return null;
		}
		ShiroUser user = (ShiroUser) principalCollection.getPrimaryPrincipal();
		userId = user.id;
		return userId;
	}
	
	
	/**
	 * 获取当前登录操作员登录账号
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCurrentUserAccount(){
		return getValueByName("userName");
	}
	
	/**
	 * 获取当前登录操作员登录员名字
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCurrentUserName(){
		return getValueByName("name");
	}
	
	/**
	 * 获取当前登录操作员部门名称
	 * @return
	 */
	public static String getCurrentUserDepartmentName(){
		return getValueByName("depname");
	}
	
	/**
	 * 获取当前登录操作员部门编码
	 * @return
	 */
	public static String getCurrentUserDepartmentCode(){
		return getValueByName("depcode");
	}
	
	/**
	 * 获取当前登录操作员登录账号
	 * @param subject
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCurrentUserName(PrincipalCollection principals){
		String username = "";
		Subject subject = SecurityUtils.getSubject();
		SimplePrincipalCollection principalCollection= (SimplePrincipalCollection) subject .getPrincipals();
		 if (principalCollection==null) {
			return null;
		}
		ShiroUser user = (ShiroUser) principalCollection.getPrimaryPrincipal();
		username = user.userName;
		return username;
	}
	
	/**
	 * 是否拥有permission权限 
	 * @param permission
	 * @return
	 */
	public static boolean isHavePermission(String permission){
		boolean isShow = Boolean.FALSE ;
		Subject currentUser = SecurityUtils.getSubject(); 
		if(StringUtils.isBlank(permission)) 
			isShow = Boolean.FALSE;
		else if (currentUser.hasRole("admin")||currentUser.isPermitted(permission)) {  
			isShow = Boolean.TRUE;
		}  
		return isShow;
	}
	
	private static String getValueByName(String name){
		String value = "";
		Subject subject = SecurityUtils.getSubject();
		if(subject!=null&&subject.getPrincipals()!=null){
			try {
				value = getPrincipalInfo(subject).get(name);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return value;
	}
}
