package com.wqm.service.water;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.water.MonitorData;
import com.wqm.repository.water.MonitorDataDao;



@Component
@Transactional
public class MonitorDataService {
	
	@Autowired
	private MonitorDataDao monitorDataDao;
	
	
	/**
	 * 按ID查找监测数据
	 * @param id
	 * @return
	 */
	public MonitorData getMonitorDataById(Long id){
		return monitorDataDao.findOne(id);
	}
	
	public List<MonitorData> getMonitorDataByCode(String code){
		return monitorDataDao.getMonitorDataByWaterCode(code);
	}
	
	/**
	 * 获取全部监测数据
	 * @return
	 */
	public List<MonitorData> getAllMonitorDatas(){
		return (List<MonitorData>) monitorDataDao.findAll();
	}
	
	/**
	 * 分页查询监测数据
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<MonitorData> getMonitorDatasByPage(Specification<MonitorData> spec,PageRequest pageRequest){
		return monitorDataDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存监测数据
	 * @param monitorData
	 * @return
	 */
	public MonitorData saveMonitorData(MonitorData monitorData){
		return monitorDataDao.save(monitorData);
	}
	
	/**
	 * 删除监测数据
	 * @param ids
	 */
	public void deleMonitorData(List<Long> ids){
		monitorDataDao.deleMonitorDatasByIds(ids);
	}
}
