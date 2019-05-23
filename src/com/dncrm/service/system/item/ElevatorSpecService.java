package com.dncrm.service.system.item;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:ElevatorSpecService
 *创建人:arisu
 *创建时间:2016年9月28日 
 */
@Service("elevatorSpecService")
public class ElevatorSpecService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/*
	 *查询项目列表 
	 */
	public List<PageData> findAllElevatorSpec()throws Exception{
		return (List<PageData>)dao.findForList("elevatorSpecMapper.findAllElevatorSpec", "");
	}
	
}
