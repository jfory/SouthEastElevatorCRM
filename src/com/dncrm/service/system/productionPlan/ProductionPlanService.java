package com.dncrm.service.system.productionPlan;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("productionPlanService")
public class ProductionPlanService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// 查询基本信息（一排）
	@SuppressWarnings("unchecked")
	public List<PageData> proPlanlistPage(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProductionPlanMapper.proPlanlistPage", page);
	}

	// 查询基本信息（二排）
	@SuppressWarnings("unchecked")
	public List<PageData> proTowPlanlistPage(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProductionPlanMapper.proTowPlanlistPage", page);
	}

	// 查询审核通过等待进入排产计划的电梯信息（一排）
	@SuppressWarnings("unchecked")
	public List<PageData> elevatorlistPage(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProductionPlanMapper.elevatorlistPage", page);
	}

	// 查询审核通过等待进入排产计划的电梯信息（二排）
	@SuppressWarnings("unchecked")
	public List<PageData> elevatorTowlistPage(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProductionPlanMapper.elevatorTowlistPage", page);
	}

	/**
	 * 根据电梯编号查询电梯信息
	 * 
	 * @param pd
	 *            the pd
	 * @return the page data
	 * @throws Exception
	 *             the exception
	 */
	public PageData findelevadById(PageData pd) throws Exception {

        return (PageData) dao.findForObject("ProductionPlanMapper.findelevadById", pd);
    }
	//根据电梯编号查询电梯是不是特批电梯(一排)
	public PageData fpById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ProductionPlanMapper.fpById", pd);
    }
	//根据电梯编号查询电梯是不是特批电梯(二排)
		public PageData fpTowById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ProductionPlanMapper.fpTowById", pd);
	    }
	/**
	 * 根据排产计划编号 查询所属的电梯信息
	 * 
	 * @param pd
	 *            the pd
	 * @return the page data
	 * @throws Exception
	 *             the exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> findplanById(Page page) throws Exception {
		return (List<PageData>) dao.findForList("ProductionPlanMapper.findplanById", page);
	}

	/**
	 * 保存新增排产计划（二排）
	 * 
	 * @param pd
	 *            the pd
	 * @throws Exception
	 *             the exception
	 */
	public void saveStow(PageData pd) throws Exception {
		dao.save("ProductionPlanMapper.saveStow", pd);
	}

	/**
	 * 保存新增排产计划（一排）
	 * 
	 * @param pd
	 *            the pd
	 * @throws Exception
	 *             the exception
	 */
	public void saveS(PageData pd) throws Exception {
		dao.save("ProductionPlanMapper.saveS", pd);
	}

	/**
	 * 保存新增排产电梯
	 * 
	 * @param pd
	 *            the pd
	 * @throws Exception
	 *             the exception
	 */
	public void elevatorsaveS(PageData pd) throws Exception {
		dao.save("ProductionPlanMapper.elevatorsaveS", pd);
	}

	// 电梯添加到排产计划后 更新状态（一排）
	public void upfindById(PageData pd) throws Exception {
		dao.update("ProductionPlanMapper.upfindById", pd);
	}
	// 电梯添加到排产计划后 更新状态（二排）
	public void upfindtowById(PageData pd) throws Exception {
		dao.update("ProductionPlanMapper.upfindtowById", pd);
	}
	
	
	//=======================报表=============================
		//统计方式为   总数
		  //查询每一年数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionYearNum()throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionYearNum", "");
		}
	    //当前年份 每月的数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionMonthNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionMonthNum", year);
		}
	    //当前年份  每个季度的数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionQuarterNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionQuarterNum", year);
		}
	    
	  //统计方式为   梯种
		  //查询每一年数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionYearTypeNum()throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionYearTypeNum", "");
		}
	    //当前年份 每月的数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionMonthTypeNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionMonthTypeNum", year);
		}
	    //当前年份  每个季度的数量
	    @SuppressWarnings("unchecked")
		public List<PageData> productionQuarterTypeNum(String year)throws Exception{
			return (List<PageData>)dao.findForList("ProductionPlanMapper.productionQuarterTypeNum", year);
		}
	    
	    
	    
	    /**
	   	 * 一排获取option集合
	   	 * @return
	   	 * @throws Exception
	   	 */
	   	public List<PageData> findProductionPlanOneList() throws Exception{
	   		return (List<PageData>) dao.findForList("ProductionPlanMapper.findProductionPlanOneList", null);
	   	}
	    /**
	   	 * er排获取option集合
	   	 * @return
	   	 * @throws Exception
	   	 */
	   	public List<PageData> findProductionPlanTowList() throws Exception{
	   		return (List<PageData>) dao.findForList("ProductionPlanMapper.findProductionPlanTowList", null);
	   	}
}
