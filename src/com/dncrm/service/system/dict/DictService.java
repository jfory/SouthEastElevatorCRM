package com.dncrm.service.system.dict;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Dict;

@Service("dictService")
public class DictService {

	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	public List<Dict> findForType(String type) throws Exception {
		return (List<Dict>) dao.findForList("DictMapper.findForType", type);
	}

}
