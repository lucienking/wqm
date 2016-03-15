package com.wqm.repository.water;


import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.water.MonitorData;




public interface MonitorDataDao extends PagingAndSortingRepository<MonitorData, Long>,JpaSpecificationExecutor<MonitorData> {
	/**
	 * 删除监测项
	 */
	@Modifying
	@Query("delete from MonitorData monitorData where monitorData.id in (?1)")
	public void deleMonitorDatasByIds(List<Long> ids);
	
	@Query("select monitorData from MonitorData monitorData where monitorData.water.code =?1")
	public List<MonitorData> getMonitorDataByWaterCode(String code);
}
