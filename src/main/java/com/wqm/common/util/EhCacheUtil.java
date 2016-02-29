package com.wqm.common.util;

import java.util.Collection;

import org.springframework.cache.ehcache.EhCacheCacheManager;

import com.wqm.common.context.SpringContextHolder;

import org.springframework.cache.Cache;
import org.springframework.cache.Cache.ValueWrapper;

/**
 * EhCache 通用方法 封装类
 * 
 * @author wangxj
 *
 */
public class EhCacheUtil {
	
	private static final String DEFAULT_CACHE_MANAGER = "cacheManager";
	
	/**
	 * 从缓存中取值
	 * @param key
	 * @param cacheName
	 * @return
	 */
	public static Object getValue(String key,String cacheName){
		ValueWrapper element = getCache(cacheName).get(key);
		return null == element ? null : element.get();
	}
	
	/**
	 * 将对象放入缓存
	 * @param key
	 * @param value
	 * @param cacheName
	 */
	public static void putValue(String key,Object value,String cacheName){
		getCache(cacheName).put(key, value);;
	}
	
	/**
	 * 刷新缓存
	 * @param cacheName
	 */
	public static void refresh(String cacheName){
		getCache(cacheName).clear();
	}
	
	/**
	 * 获取缓存对象
	 * @param cacheName
	 * @return
	 */
	public static Cache getCache(String cacheName){
		return getCacheManager().getCache(cacheName);
	}
	
	public static EhCacheCacheManager getCacheManager(){
		return (EhCacheCacheManager)SpringContextHolder.getBean(DEFAULT_CACHE_MANAGER);
	}
	
	/**
	 * 系统缓存信息
	 * @return
	 */
	public static String getCacheInfo(){
		Collection<String> names  = getCacheManager().getCacheNames();
		StringBuilder sb = new StringBuilder("------cacheName: "+DEFAULT_CACHE_MANAGER+" info-----------");
		sb.append("\n");
		for(String name:names){
			sb.append("name:").append(name).append(" ");
			sb.append("\n");
		}
		sb.append("\n all of "+ names.size());
		return sb.toString();
	}
	
	/**
	 * 获取缓存大小
	 * @param cacheName
	 * @return
	 */
	/*public static int getCacheSize(String cacheName){
		return getCacheManager();
	}*/
}
