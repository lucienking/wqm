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
	 * 按ID查找区域
	 * @param id
	 * @return
	 */
	public MonitorItem getMonitorItemById(Long id){
		return monitorItemDao.findOne(id);
	}
	
	
	
	/**
	 * 获取全部区域
	 * @return
	 */
	public List<MonitorItem> getAllMonitorItems(){
		return (List<MonitorItem>) monitorItemDao.findAll();
	}
	
	/**
	 * 分页查询区域
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<MonitorItem> getMonitorItemsByPage(Specification<MonitorItem> spec,PageRequest pageRequest){
		return monitorItemDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存区域
	 * @param monitorItem
	 * @return
	 */
	public MonitorItem saveMonitorItem(MonitorItem monitorItem){
		return monitorItemDao.save(monitorItem);
	}
	
	/**
	 * 删除区域
	 * @param ids
	 */
	public void deleMonitorItem(List<Long> ids){
		monitorItemDao.deleMonitorItemsByIds(ids);
	}
}
