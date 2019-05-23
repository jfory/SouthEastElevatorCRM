package com.dncrm.service.system.forecast;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:ForecastService
 *创建人:arisu
 *创建时间:2016年10月18日 
 */
@Service("forecastService")
public class ForecastService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	/*
	 *列表项目预测 
	 */
	public List<PageData> listPageAllForecast(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.listPageAllForecast", page);
	}
	
	/*
	 *新增 
	 */
	public void saveForecast(PageData pd)throws Exception{
		dao.save("ForecastMapper.saveForecast", pd);
	}
	/*
	 *修改 
	 */
	public void editForecast(PageData pd)throws Exception{
		dao.update("ForecastMapper.editForecast", pd);
	}
	
	/*
	 *删除 
	 */
	public void delForecastById(PageData pd)throws Exception{
		dao.delete("ForecastMapper.delForecastById", pd);
	}
	
	/*
	 * 根据id查询
	 */
	public PageData findForecastById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ForecastMapper.findForecastById", pd);
	}
	
	/*
	 *修改项目状态 
	 */
	public void editStatus(PageData pd)throws Exception{
		dao.update("ForecastMapper.editStatus", pd);
	}
	
	/*
	 *修改预测流程id 
	 */
	public void editForecastInstanceId(PageData pd)throws Exception{
		dao.update("ForecastMapper.editForecastInstanceId", pd);
	}
	
	
	public List<String> findItemIdsByInputUser(PageData pd)throws Exception{
		List<PageData> list =  (List<PageData>)dao.findForList("ForecastMapper.findItemIdsByInputUser", pd);
		List<String> ids = new ArrayList<String>();
		for(PageData forecastPd : list){
			if(forecastPd.get("item_id").toString().lastIndexOf(",")>-1){
				for(String id : forecastPd.get("item_id").toString().split(",")){
					ids.add(id);
				}
			}else{
				ids.add(forecastPd.get("item_id").toString());
			}
		}
		return ids;
	}
	
	/*
	 *根据月份编号查询项目id 
	 */
	public List<String> findItemIdByMonthNo(String month_no)throws Exception{
		List<String> list = new ArrayList<String>();
		List<String> idList =  (List<String>)dao.findForList("ForecastMapper.findItemIdByMonthNo", month_no);
		for(String ids : idList){
			if(ids.lastIndexOf(",")>-1){
				for(String id : ids.split(",")){
					list.add(id);
				}
			}else{
				list.add(ids);
			}
		}
		return list;
	}
	
	/*
	 *保存预测操作历史记录 
	 */
	public void saveForecastLog(PageData pd)throws Exception{
		dao.save("ForecastMapper.saveForecastLog", pd);
	}
	
	/*
	 *根据登录人id查询列表 
	 */
	public List<PageData> findForecastListByInputUser(String input_user)throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.findForecastListByInputUser", input_user);
	}
	
	public List<PageData> findForecastListByUserIdAndMonthNo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.findForecastListByUserIdAndMonthNo", pd);
	}
	
	public Integer findForecastCountByUserIdAndMonthNo(PageData pd)throws Exception{
		List<PageData> list = (List<PageData>)dao.findForList("ForecastMapper.findForecastCountByUserIdAndMonthNo", pd);
		if(list==null){
			return 0;
		}else{
			return list.size();
		}
	}
	
	public List<PageData> findQuotaList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.findQuotaList", page);
	}
	
	public String findMonthQuotaByUserAndMonth(PageData pd)throws Exception{
		return (String)dao.findForObject("ForecastMapper.findMonthQuotaByUserAndMonth", pd);
	}
	
	public List<PageData> findQuotaTreeList()throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.findQuotaTreeList", "");
	}
	public List<PageData> findQuotaByUserId(String id)throws Exception{
		return (List<PageData>)dao.findForList("ForecastMapper.findQuotaByUserId", id);
	}
	public PageData findQuotaById(String id)throws Exception{
		return (PageData)dao.findForObject("ForecastMapper.findQuotaById", id);
	}
	public void saveQuota(PageData pd)throws Exception{
		dao.save("ForecastMapper.saveQuota", pd);
	}
	public void editQuota(PageData pd)throws Exception{
		dao.update("ForecastMapper.editQuota", pd);
	}
	public void delQuota(PageData pd)throws Exception{
		dao.delete("ForecastMapper.delQuota", pd);
	}
	
	public List<String> findMonthNoByYear(PageData pd)throws Exception{
		List<String> monthNoList = (List<String>)dao.findForList("ForecastMapper.findMonthNoByYear", pd);
		List<String> list = new ArrayList<String>();
		for(int i =1;i<13;i++){
			list.add(String.format("%02d", i));
		}
		if(monthNoList.size()>0){
			for(String month : monthNoList){
				month = month.substring(4);
				for(int j =0;j<list.size();j++){
					if(list.get(j).equals(month)){
						list.remove(j);
						j--;
					}
				}
			}
		}
		if(pd.get("type").toString().equals("edit")){
			String year = pd.get("month_no").toString().substring(0,4);
			if(year.equals(pd.get("year").toString())){
				list.add(pd.get("month_no").toString().substring(4));
			}
		}
		return list;
	}
}
