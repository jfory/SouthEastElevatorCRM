package com.dncrm.service.system.discount;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;


/**
 *@类名称: DiscountSevice
 *@创建人: arisu
 *@创建时间: 2016/11/17 
 */

@Service("discountService")
public class DiscountService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	/*
	 *根据用户id查询折扣和额度信息 
	 */
	public PageData findDiscountConfigByUserId(String str)throws Exception{
		return (PageData)dao.findForObject("DiscountMapper.findDiscountConfigByUserId", str);
	}
	
	/*
	 *根据id查询折扣和额度信息 
	 */
	public PageData findDiscountConfigById(String str)throws Exception{
		return (PageData)dao.findForObject("DiscountMapper.findDiscountConfigById", str);
	}
	
	/*
	 *根据userId年份查询折扣额度信息
	 */
	public List<PageData> findDiscountUsedByUserIdAndYearNo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("DiscountMapper.findDiscountUsedByUserIdAndYearNo", pd);
	}
	
	/*
	 *根据年份查询用户总消耗额度
	 */
	public float findCountUserdByUserIdAndYearNo(PageData pd)throws Exception{
		float countUsed = 0;
		List<PageData> list = (List<PageData>)dao.findForList("DiscountMapper.findDiscountUsedByUserIdAndYearNo", pd);
		for(PageData usedPd : list){
			countUsed += Float.parseFloat(usedPd.get("limit_used").toString());
		}
		return countUsed;
	}
	
	/*
	 *保存新增折扣申请信息 
	 */
	public void saveDiscountApply(PageData pd)throws Exception{
		dao.save("DiscountMapper.saveDiscountApply", pd);
	}
	
	/*
	 *更新流程实例id 
	 */
	public void editDiscountInstance(PageData pd)throws Exception{
		dao.update("DiscountMapper.editDiscountInstance", pd);
	}
	
	public void editDiscountStatus(PageData pd)throws Exception{
		dao.update("DiscountMapper.editDiscountStatus", pd);
	}
	
	/*
	 *根据用户id查询折扣申请 
	 */
	public List<PageData> findDiscountApplyListByUserId(String USER_ID)throws Exception{
		return (List<PageData>)dao.findForList("DiscountMapper.findDiscountApplyListByUserId", USER_ID);
	}
	
	/*
	 *根据id查询折扣申请 
	 */
	public PageData findApplyById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DiscountMapper.findApplyById", pd);
	}
	
	/*
	 *根据id查询折扣 
	 */
	public String findApplyDiscountById(String id)throws Exception{
		return (String)dao.findForObject("DiscountMapper.findApplyDiscountById", id);
	}
	
	/*
	 *向折扣额度记录表插入数据 
	 */
	public void saveDiscountUsed(PageData pd)throws Exception{
		dao.save("DiscountMapper.saveDiscountUsed", pd);
	}
	
	
	public PageData findDiscountPend(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DiscountMapper.findDiscountPend", pd);
	}
	
	public List<PageData> findItemDiscountListByUserId(String id)throws Exception{
		return (List<PageData>)dao.findForList("DiscountMapper.findItemDiscountListByUserId", id);
	}
	
	public List<PageData> findDiscountApplyByItemId(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("DiscountMapper.findDiscountApplyByItemId", item_id);
	}
	
	public List<PageData> findDiscountTreeList()throws Exception{
		return (List<PageData>)dao.findForList("DiscountMapper.findDiscountTreeList", "");
	}
	
	public void saveDiscountConfig(PageData pd)throws Exception{
		dao.save("DiscountMapper.saveDiscountConfig", pd);
	}
	
	public void editDiscountConfig(PageData pd)throws Exception{
		dao.update("DiscountMapper.editDiscountConfig", pd);
	}
	
}
