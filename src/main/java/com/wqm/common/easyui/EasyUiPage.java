package com.wqm.common.easyui;


/**
 * 
 * EasyUi page 对象封装
 * 
 * @author wangxj
 *
 */
public class EasyUiPage {
	
	private int pageNumber; 				//当前页数
	
	private int pageSize;					//每页记录数
	
	private String sortString;				//排序字段
	
	private String sortType;				//排序类型   asc  desc
	
	public EasyUiPage(){
		pageNumber = 1;
		pageSize = 15;
		sortString = "id";
		sortType  = "asc";		
	}
	
	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getSortString() {
		return sortString;
	}

	public void setSortString(String sortString) {
		this.sortString = sortString;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
}
