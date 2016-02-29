package com.wqm.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.sys.DictionaryEntity;
import com.wqm.repository.sys.DictionaryDao;

@Component
@Transactional
public class DictionaryService {
	
	@Autowired 
	private DictionaryDao dictionaryDao;
	
	/**
	 * 获取全部数据字典项
	 * @param menu
	 * @return
	 */
	public List<DictionaryEntity> getAllDictionary(){
		return (List<DictionaryEntity>) dictionaryDao.findAll();
	}
	
	/**
	 * 按ID查找数据字典
	 * @param id
	 * @return
	 */
	public DictionaryEntity getDictById(Long id){
		return dictionaryDao.findOne(id);
	}
	
	 
	/**
	 * 按ID查找数据字典,并缓存
	 * @param id
	 * @return
	 */
	@Cacheable(value = "dictionary", key = "#id")
	public DictionaryEntity getDictByIdCache(Long id){
		return dictionaryDao.findOne(id);
	}
	
	/**
	 * 按group 查找字典项 并缓存
	 * @param groupId
	 * @return
	 */
	@Cacheable(value = "dictionary", key = "#groupId")
	public List<DictionaryEntity> getDictItemByGroup(String groupId){
		List<DictionaryEntity> dicts = dictionaryDao.findByDictGroup(groupId);
		return dicts;
	}
	
	/**
	 * 按group ，code 查找字典项 并缓存
	 * @param groupId
	 * @return
	 */
	@Cacheable(value = "dictionary", key = "#dictCode+#dictGroup")
	public DictionaryEntity getDictItemByGroup(String dictCode,String dictGroup){
		return dictionaryDao.findByDictGroupAndCode(dictCode,dictGroup);
	}
	
	/**
	 * 按value,group查找字典项并缓存
	 * @param dictCode
	 * @param dictGroup
	 * @return
	 */
	@Cacheable(value = "dictionary", key = "#dictValue+#dictGroup")
	public DictionaryEntity getDictItemByVAndG(String dictValue,String dictGroup){
		return dictionaryDao.findByDictGroupAndValue(dictValue,dictGroup);
	}
	
	/**
	 * 分页查询数据字典项
	 * 带查询条件spec
	 * @param pageRequest
	 * @param spec
	 * @return
	 */
	public Page<DictionaryEntity> getDictsByPage(Specification<DictionaryEntity> spec,PageRequest pageRequest){
		return dictionaryDao.findAll(spec,pageRequest);
	}
	
	/**
	 * 保存数据字典项
	 * @param dict
	 * @return
	 */
	public DictionaryEntity saveDict(DictionaryEntity dict){
		return dictionaryDao.save(dict);
	}
	
	/**
	 * 删除数据字典项
	 * @param ids
	 */
	public void deleDicts(List<Long> ids){
		dictionaryDao.deleDictionaryByIds(ids);
	}
}
