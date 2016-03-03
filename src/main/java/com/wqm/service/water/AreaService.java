package com.wqm.service.water;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.water.WaterEntity;
import com.wqm.repository.water.WaterDao;


@Component
@Transactional
public class AreaService {
	
	@Autowired
	private WaterDao waterDao;
	
	/**
	 * 获取一级水体
	 * @return
	 */
	public List<WaterEntity> getWaterListByRoot(){
		return waterDao.getWatersByParentCode("root",new Sort(Direction.ASC, "sortNum"));
	}
	
	/**
	 * 按ID查找水体
	 * @param id
	 * @return
	 */
	public WaterEntity getWaterById(Long id){
		return waterDao.findOne(id);
	}
	
	/**
	 * 按ID获取子水体
	 * @param id
	 * @return
	 */
	public List<WaterEntity> getWaterListById(String code,Sort sort){
		return waterDao.getWatersByParentCode(code,sort);
	}
	
	/**
	 * 按code获取子水体
	 * @param id
	 * @return
	 */
	public List<WaterEntity> getWaterListById(String code){
		return waterDao.getWatersByParentId(code);
	}
	
	/**
	 * 获取全部水体
	 * @return
	 */
	public List<WaterEntity> getAllWaters(){
		return (List<WaterEntity>) waterDao.findAll();
	}
	
	/**
	 * 分页查询水体
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<WaterEntity> getWatersByPage(Specification<WaterEntity> spec,PageRequest pageRequest){
		return waterDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 获取全部的父水体项
	 * @return
	 */
	public List<WaterEntity> getAllParents(){
		List<WaterEntity> waters = (List<WaterEntity>) waterDao.findAllParents();
		WaterEntity water = new WaterEntity();
		water.setId(0L);
		water.setName("全部水体");
		waters.add(water);
		return waters;
	}
	
	/**
	 * 保存水体
	 * @param water
	 * @return
	 */
	public WaterEntity saveWater(WaterEntity water){
		return waterDao.save(water);
	}
	
	/**
	 * 删除水体
	 * @param ids
	 */
	public void deleWater(List<Long> ids){
		waterDao.deleWatersByIds(ids);
	}
}
