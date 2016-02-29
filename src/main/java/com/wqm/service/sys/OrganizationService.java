package com.wqm.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wqm.entity.sys.OrganizationEntity;
import com.wqm.repository.sys.OrganizationDao;


@Component
@Transactional
public class OrganizationService {
	
	@Autowired
	private OrganizationDao organizationDao ;
	
	public List<OrganizationEntity> getAllFarms(){
		return organizationDao.getAllFarms();
	}
}
