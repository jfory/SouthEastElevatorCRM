package com.dncrm.controller.system.statistics;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.statistics.StatisticsService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@RequestMapping("/statistics")
@Controller
public class StatisticsController extends BaseController
{
	@Resource(name = "statisticsService")
	private StatisticsService  statisticsService ;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	/**
	 * 显示  统计信息
	 *
	 * @return
	 */
	@RequestMapping("/statistics")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> statisticsList = statisticsService.listPdPageStatistics(page);
			mv.setViewName("system/statistics/statistics");
			mv.addObject("statisticsList", statisticsList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 显示  每个城市东南装梯数量和对手装梯数量
	 *
	 * @return
	 */
	@RequestMapping("/statisticslist")
	@ResponseBody
	public JSONObject statisticslist(Page page) {
		JSONObject result = new JSONObject();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> statisticsList = statisticsService.StatisticsList(page);
			result.put("statlist", statisticsList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return result;
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	
}
