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

import com.wqm.entity.water.AreaEntity;
import com.wqm.repository.water.AreaDao;



@Component
@Transactional
public class AreaService {
	
	@Autowired
	private AreaDao areaDao;
	
	/**
	 * 获取一级区域
	 * @return
	 */
	public List<AreaEntity> getAreaListByRoot(){
		return areaDao.getAreasByParentCode("root",new Sort(Direction.ASC, "sortNum"));
	}
	
	/**
	 * 按ID查找区域
	 * @param id
	 * @return
	 */
	public AreaEntity getAreaById(Long id){
		return areaDao.findOne(id);
	}
	
	/**
	 * 按ID获取子区域
	 * @param id
	 * @return
	 */
	public List<AreaEntity> getAreaListById(String code,Sort sort){
		return areaDao.getAreasByParentCode(code,sort);
	}
	
	/**
	 * 按code获取子区域
	 * @param id
	 * @return
	 */
	public List<AreaEntity> getAreaListById(String code){
		return areaDao.getAreasByParentId(code);
	}
	
	/**
	 * 获取全部区域
	 * @return
	 */
	public List<AreaEntity> getAllAreas(){
		return (List<AreaEntity>) areaDao.findAll();
	}
	
	/**
	 * 分页查询区域
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<AreaEntity> getAreasByPage(Specification<AreaEntity> spec,PageRequest pageRequest){
		return areaDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存区域
	 * @param area
	 * @return
	 */
	public AreaEntity saveArea(AreaEntity area){
		return areaDao.save(area);
	}
	
	/**
	 * 删除区域
	 * @param ids
	 */
	public void deleArea(List<Long> ids){
		areaDao.deleAreasByIds(ids);
	}
}
