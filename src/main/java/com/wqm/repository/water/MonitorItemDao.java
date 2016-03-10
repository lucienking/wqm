package com.wqm.repository.water;


import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.water.MonitorItem;




public interface MonitorItemDao extends PagingAndSortingRepository<MonitorItem, Long>,JpaSpecificationExecutor<MonitorItem> {
	/**
	 * 删除监测项
	 */
	@Modifying
	@Query("delete from MonitorItem monitorItem where monitorItem.id in (?1)")
	public void deleMonitorItemsByIds(List<Long> ids);
	
	/**
	 * 查询监测项
	 */
	@Query("select monitorItem from MonitorItem monitorItem where monitorItem.code in (?1)")
	public List<MonitorItem> getMonitorItemsByCodes(List<String> codes);
	
	public MonitorItem getMonitorItemByCode(String code);
}
