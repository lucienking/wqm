package com.wqm.service.water;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.water.MonitorItem;
import com.wqm.repository.water.MonitorItemDao;



@Component
@Transactional
public class MonitorItemService {
	
	@Autowired
	private MonitorItemDao monitorItemDao;
	
	
	/**
	 * 按ID查找监测项
	 * @param id
	 * @return
	 */
	public MonitorItem getMonitorItemById(Long id){
		return monitorItemDao.findOne(id);
	}
	
	/**
	 * 获取全部监测项
	 * @return
	 */
	public List<MonitorItem> getAllMonitorItems(){
		return (List<MonitorItem>) monitorItemDao.findAll();
	}
	
	/**
	 * 按codes获取全部监测项
	 * @return
	 */
	public List<MonitorItem> getMonitorItemsByCodes(List<String> codes){
		return (List<MonitorItem>) monitorItemDao.getMonitorItemsByCodes(codes);
	}
	
	/**
	 * 按code获取监测项
	 * @return
	 */
	public MonitorItem getMonitorItemByCode(String code){
		return (MonitorItem) monitorItemDao.getMonitorItemByCode(code);
	}
	
	/**
	 * 分页查询监测项
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<MonitorItem> getMonitorItemsByPage(Specification<MonitorItem> spec,PageRequest pageRequest){
		return monitorItemDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存监测项
	 * @param monitorItem
	 * @return
	 */
	public MonitorItem saveMonitorItem(MonitorItem monitorItem){
		return monitorItemDao.save(monitorItem);
	}
	
	/**
	 * 删除监测项
	 * @param ids
	 */
	public void deleMonitorItem(List<Long> ids){
		monitorItemDao.deleMonitorItemsByIds(ids);
	}
}
