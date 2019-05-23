package com.dncrm.service.system.item;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:ElevatorService
 *创建人:arisu
 *创建时间:2016年9月28日 
 */
@Service("elevatorService")
public class ElevatorService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/*
	 *查询所有电梯信息
	 */
	public List<PageData> findAllElevator()throws Exception{
		return (List<PageData>)dao.findForList("ElevatorMapper.findAllElevator", "");
	}
	
}
