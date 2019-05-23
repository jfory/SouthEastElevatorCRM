package com.dncrm.service.system.statistics;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("statisticsService")
public class StatisticsService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// 统计楼盘信息
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageStatistics(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StatisticsMapper.statisticslistPage", page);
	}

	// 统计每个城市东南装梯数量和对手装梯数量
	@SuppressWarnings("unchecked")
	public List<PageData> StatisticsList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("StatisticsMapper.statisticsList", page);
	}
}
