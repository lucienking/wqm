package com.wqm.repository.sys;


import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.wqm.entity.sys.DictionaryEntity;

public interface DictionaryDao extends PagingAndSortingRepository<DictionaryEntity, Long>,JpaSpecificationExecutor<DictionaryEntity> {
	
	@Modifying
	@Query("delete from DictionaryEntity dict where dict.id in (?1)")
	public void deleDictionaryByIds(List<Long> ids);
	
	public List<DictionaryEntity> findByDictGroup(String group,Sort sort);
	
	@Query("select dict from DictionaryEntity dict where dict.dictGroup = ?1 order by dict.dictValue")
	public List<DictionaryEntity> findByDictGroup(String group);
	
	@Query("select dict from DictionaryEntity dict where dict.dictCode = ?1 and dict.dictGroup = ?2")
	public DictionaryEntity findByDictGroupAndCode(String dictCode,String dictGroup);

	@Query("select dict from DictionaryEntity dict where dict.dictValue = ?1 and dict.dictGroup = ?2")
	public DictionaryEntity findByDictGroupAndValue(String dictValue,String dictGroup);
}
