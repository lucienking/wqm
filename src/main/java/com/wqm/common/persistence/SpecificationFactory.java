package com.wqm.common.persistence;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.data.jpa.domain.Specification;

import com.wqm.common.persistence.SearchFilter.Operator;

/**
 * 查询条件spec 类组装
 * 
 * @author wangxj
 *
 */
public class SpecificationFactory<T> {
	private Collection<SearchFilter> filters;
	
	public SpecificationFactory (){
		filters = new ArrayList<SearchFilter>();
	}
	
	public Specification<T> getSpecification(){
		Specification<T>  spec = DynamicSpecifications.bySearchFilter(filters);
		return spec;
	}
	
	public void addSearchParam(String fieldName, Operator operator, Object value){
		if(value != null && value != "")
			this.filters.add(new SearchFilter(fieldName,operator,value));
	}
	
	public void addSubListSearchParam(String fieldName, Operator operator, Object value){
		/*if(value != null && value != "")
			this.filters.add(new SearchFilter(fieldName,operator,value));*/
	}
	
}
