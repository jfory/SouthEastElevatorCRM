package com.dncrm.service.system.item;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *类名:ItemService
 *创建人:arisu
 *创建时间:2016年9月28日 
 */
@Service("itemService")
public class ItemService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	/*
	 *查询项目列表 
	 */
	public List<PageData> listPageAllItem(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.listPageAllItem", page);
	}
	
	/**
	 *根据角色分级查询项目列表 
	 */
	public List<PageData> listPageAllItemByRole(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.listPageAllItemByRole", page);
	}
	
	public List<PageData> listPageElevator(Page page) throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.elevatorlistPage", page);
	}
	
	/*
	 *新增项目报备 
	 */
	public void saveItem(PageData pd)throws Exception{
		dao.save("ItemMapper.saveItem", pd);
	}
	
	/*
	 *删除项目报备 
	 */
	public void delItem(PageData pd)throws Exception{
		dao.delete("ItemMapper.delItem", pd);
	}
	
	/*
	 *删除项目报备 
	 */
	@Transactional
	public boolean deleteAllItem(String item_ids)throws Exception{
		if(StringUtils.isBlank(item_ids))return false;

        PageData pd = new PageData();
		for (String item_id : item_ids.split(",")) {
        	pd.put("item_id",  item_id);
        	PageData itemPd = findItemsByItemId(pd);
        	String icr = itemPd.getNoneNULLString("is_cross_region");
			String ia = itemPd.getNoneNULLString("item_approval");
			if("1".equals(icr) && ("2".equals(ia) || "3".equals(ia))) {
				continue;
			}
        	
        	//清空tb_item_follow_up
			delItemFollowUp(item_id);
			//删除电梯数量信息
			delElevatorNum(pd);
			//删除项目报备信息
			delItem(pd);
        }
		
		return true;
	}
	
	/*
	 *删除项目报备相关的电梯数量信息
	 */
	public void delElevatorNum(PageData pd)throws Exception{
		dao.delete("ItemMapper.delElevatorNum", pd);
	}
	/*
	 *保存电梯数量信息 
	 */
	public void saveElevatorNum(PageData pd)throws Exception{
		try{
			
			dao.save("ItemMapper.saveElevatorNum", pd);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
	
	/*
	 *根据项目id查询电梯数量信息 
	 */
	public List<PageData> findElevatorNumByItemId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findElevatorNumByItemId", pd);
	}
	
	/*
	 *根据id查询电梯数量信息 
	 */
	public PageData findElevatorNumById(PageData pd)throws Exception{
		return (PageData) dao.findForObject("ItemMapper.findElevatorNumById", pd);
	}
	
	/*
	 *修改项目时更新电梯数量信息 
	 */
	public void updateElevatorNum(PageData pd)throws Exception{
		dao.update("ItemMapper.updateElevatorNum", pd);
	}
	
	/*
	 *根据id删除电梯数量信息 
	 */
	public void delElevatorNumById(PageData pd)throws Exception{
		dao.delete("ItemMapper.delElevatorNumById", pd);
	}
	
	/*
	 *删除修改项目报备时移除的电梯数量信息 
	 */
	public void deleteElevatorNumByItem(List<String> idList,String item_id)throws Exception{
		if(idList!=null){
			PageData pd = new PageData();
			pd.put("item_id", item_id);
			List<PageData> pds = findElevatorNumByItemId(pd);
			for(PageData p : pds){
				if(!idList.contains(p.get("id").toString())){
					delElevatorNumById(p);
					dao.delete("ProductInfoMapper.ProductInfoDeleteById", p);
				}
			}
		}
	}
	
	
	/*
	 *根据项目id查询项目报价总价 
	 */
	public double findOfferCountPriceByItemId(PageData pd)throws Exception{
		BigDecimal countPrice = new BigDecimal(0);
		PageData iPd = (PageData)dao.findForObject("ItemMapper.findOfferCountPriceByItemId", pd);
		if(iPd!=null&&iPd.containsKey("countPrice")){
			countPrice = (BigDecimal)iPd.get("countPrice");
		}
		return countPrice.doubleValue();
	}
	/*
	 *根据id查询 
	 */
	public PageData findItemById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ItemMapper.findItemById", pd);
	}
	
	/*
	 *根据id查询项目信息和地址信息 
	 */
	public PageData findItemAndAddressById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ItemMapper.findItemAndAddressById", pd);
	}
	
	public PageData findItemsByItemId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ItemMapper.findItemsByItemId", pd);
	}
	/*
	 *根据id查询项目的4个地址id 
	 */
	public PageData findAddressIdByItemId(PageData pd)throws Exception{
		return(PageData)dao.findForObject("ItemMapper.findAddressIdByItemId", pd);
	}
	
	/**
	 * 获取option集合
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findItemList() throws Exception{
		return (List<PageData>) dao.findForList("ItemMapper.findItemList", null);
	}
	/*
	 *修改项目报备 
	 */
	public void editItem(PageData pd)throws Exception{
		dao.update("ItemMapper.editItem", pd);
	}
	
	/*
	 *检测新增项目名称 
	 */
	public boolean checkItemName(PageData pd)throws Exception{
		List<PageData> pdList = (List<PageData>)dao.findForList("ItemMapper.findItemByName", pd);
		return pdList.isEmpty();
	}
	
	/*
	 *检测修改项目名称 
	 */
	public boolean checkItemOldName(PageData pd)throws Exception{
		List<PageData> pdList = (List<PageData>)dao.findForList("ItemMapper.findItemByOldName", pd);
		return pdList.isEmpty();
	}
	
	/*
	 *列表项目抄送通知设置信息 
	 */
	public List<PageData> listPageAllItemReport(Page page)throws Exception {
		return (List<PageData>)dao.findForList("itemReportMapper.listPageAllItemReport", page);
	}
	
	/*
	 *保存项目报备时查询抄送通知的相关设置 
	 */
	public List<PageData> findItemReportConfig()throws Exception{
		return (List<PageData>)dao.findForList("itemReportMapper.findItemReportConfig", "");
	}
	
	/*
	 *根据项目id查询项目信息
	 */
	public PageData findItemReportById(PageData pd)throws Exception{
		return (PageData) dao.findForObject("itemReportMapper.findItemReportById",pd);
	}
	
	/*
	 *保存项目信息 
	 */
	public void saveItemReport(PageData pd)throws Exception{
		dao.save("itemReportMapper.saveItemReport", pd);
	}
	
	/*
	 *修改抄送设置信息 
	 */
	public void editItemReport(PageData pd)throws Exception{
		dao.update("itemReportMapper.editItemReport", pd);
	}
	
	/*
	 *删除抄送设置信息 
	 */
	public void delItemReport(PageData pd)throws Exception{
		dao.delete("itemReportMapper.deleteItemReport", pd);
	}
	
	/*
	 *列表销售考核设置 
	 */
	public List<PageData> listPageAllItemExamin(Page page)throws Exception{
		return (List<PageData>)dao.findForList("itemExaminMapper.listPageItemExamin", page);
	}
	
	/*
	 *修改销售考核设置 
	 */
	public void updateExamin(PageData pd)throws Exception{
		dao.update("itemExaminMapper.updateExamin", pd);
	}
	
	/*
	 * 根据id查找销售考核
	 */
	public PageData findExaminById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("itemExaminMapper.findExaminById", pd);
	}
	
	/*
	 *根据录入人查询项目信息 
	 */
	public List<PageData> findItemListByInputUser(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findItemListByInputUser", pd);
	}
	
	/*
	 *查询录入人还未进行预测的项目列表
	 */
	public List<PageData> findItemListNotForecastByInputUser(PageData pd)throws Exception{
		List<PageData> list = (List<PageData>)dao.findForList("ItemMapper.findItemListNotForecastByInputUser", pd);
		System.out.println(pd);
		return list;
	}
	
	/*
	 *根据项目id查询电梯总数 
	 */
	public String findCountByItemId(List<String> ids)throws Exception{
		return (String)dao.findForObject("ItemMapper.findCountByItemId", ids);
	}
	
	
	/*
	 *插入项目地址信息 
	 */
	public void saveItemAddress(PageData pd)throws Exception{
		dao.save("ItemMapper.saveItemAddress", pd);
	}
	/*
	 *根据id修改项目地址信息 
	 */
	public void editItemAddressById(PageData pd)throws Exception{
		dao.update("ItemMapper.editItemAddressById", pd);
	}
	
	/*
	 *根据id列表查询项目列表 
	 */
	public List<PageData> findItemListByIdList(List<String> ids)throws Exception{
		if(ids.size()>0){
			return (List<PageData>)dao.findForList("ItemMapper.findItemListByIdList", ids);
		}else{
			return null;
		}
	}
	
	/*
	 *修改项目为重点关注项目 
	 */
	public void updateTopStatus(PageData pd)throws Exception{
		dao.update("ItemMapper.updateTopStatus", pd);
	}
	
	/*
	 *修改项目为top项目 
	 */
	public void updateAtnStatus(PageData pd)throws Exception{
		dao.update("ItemMapper.updateAtnStatus", pd);
	}
	
	
	public String findElevatorInfoById(String item_id)throws Exception{
		return (String)dao.findForObject("ItemMapper.findElevatorInfoById", item_id);
	}
	
	/*
	 *根据idlist查询项目所跨区域分公司列表 
	 */
	public List<PageData> findItemCrossAreaByIdList(List<String> list)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findItemCrossAreaByIdList", list);
	}
	
	/*
	 *根据idlist查询项目所跨分公司
	 */
	public List<PageData> findAreaByItemIdList(List<String> list)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findAreaByItemIdList", list);
	}
	
	/*
	 *修改报价页面部分项目信息 
	 */
	public void updateItemOffer(PageData pd)throws Exception{
		dao.update("ItemMapper.updateItemOffer", pd);
	}
	
	/*
	 *根据录入人和项目状态查询项目列表 
	 */
	public List<PageData> findItemListByInputUserAndStatus(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findItemListByInputUserAndStatus", pd);
	}
	
	/*
	 *根据项目id查询总价 
	 */
	public String findItemTotalById(String item_id)throws Exception{
		return (String)dao.findForObject("ItemMapper.findItemTotalById", item_id);
	}
	
	public List<PageData> findItemListByIdArray(List<String> list)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.findItemListByIdArray", list);
	}
	
	public String findItemStatusByItemId(String item_id)throws Exception{
		return (String)dao.findForObject("ItemMapper.findItemStatusByItemId", item_id);
	}
	
	
	public void updateItemStatus(PageData pd)throws Exception{
		dao.update("ItemMapper.updateItemStatus", pd);
	}
	
	public void saveElevatorDetails(PageData pd)throws Exception{
		dao.save("ItemMapper.saveElevatorDetails", pd);
	}
	
	public void delElevatorDetails(String item_id)throws Exception{
		dao.delete("ItemMapper.delElevatorDetails", item_id);
	}
	
	public void updateElevatorDetailsProduct()throws Exception{
		dao.update("ItemMapper.updateElevatorDetailsProduct", "");
	}
	
	public List<PageData> itemYearNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.itemYearNum", pd);
	}
	
	public List<PageData> itemMonthNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.itemMonthNum", pd);
	}
	
	public List<PageData> itemQuarterNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ItemMapper.itemQuarterNum", pd);
	}
	
	public void saveItemImportExcel(PageData pd)throws Exception{
		/*dao.save("ItemMapper.saveItemImportExcel", pd);*/
		dao.save("ItemMapper.saveItem", pd);
	}
	
	public Integer findMinYearItem()throws Exception{
		String minYear = (String)dao.findForObject("ItemMapper.findMinYearItem", "");
		return Integer.parseInt(minYear);
	}
	
	public String findSaleTypeById(String item_id)throws Exception{
		return (String)dao.findForObject("ItemMapper.findSaleTypeById", item_id);
	}
	
	public List<PageData> findItemToExcel(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("ItemMapper.findItemToExcel", pd);
	}
	
	
	public Boolean checkExistIName(String name)throws Exception{
		String num = (String)dao.findForObject("ItemMapper.checkExistIName", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistCName(String name)throws Exception{
		String num = (String)dao.findForObject("ItemMapper.checkExistCName", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistAName(String name)throws Exception{
		String num = (String)dao.findForObject("ItemMapper.checkExistAName", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistDName(String name)throws Exception{
		String num = (String)dao.findForObject("ItemMapper.checkExistDName", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public String findEndUesrId(String name)throws Exception{
		return (String) dao.findForObject("ItemMapper.findEndUesrId", name);
	}
	
	public String findAgentId(String name)throws Exception{
		return (String) dao.findForObject("ItemMapper.findAgentId", name);
	}
	
	public String findUserId(String name)throws Exception{
		return (String) dao.findForObject("ItemMapper.findUserId", name);
	}
	
	public String findDepartmentId(String name)throws Exception{
		return (String) dao.findForObject("ItemMapper.findDepartmentId", name);
	}
	
	

	public boolean findcitybranch(PageData pd)throws Exception {
		List<PageData> pdList = (List<PageData>)dao.findForList("ItemMapper.findcitybranch", pd);
		return pdList.isEmpty();
	}

	public void delItemFollowUp(String item_id) throws Exception {
		dao.delete("ItemMapper.delItemFollowUp", item_id);
	}

	public void saveItemFollowUp(PageData genjinInfoPd) throws Exception {
		dao.save("ItemMapper.saveItemFollowUp", genjinInfoPd);
	}
	
	//关闭项目
	public boolean closeItem(PageData pd)throws Exception{
		
		PageData itemPd = findItemsByItemId(pd);
		if(itemPd != null) {
			String icr = itemPd.getNoneNULLString("is_cross_region");
			String ia = itemPd.getNoneNULLString("item_approval");
			String is = itemPd.getNoneNULLString("i_status");
			
			if("1".equals(is) && ("0".equals(icr) || ("1".equals(icr) && ("1".equals(ia) || "4".equals(ia) || "5".equals(ia))))) {
				dao.update("ItemMapper.closeItem", pd);
				return true;
			}
		}
		return false;
	}

	public void itemUpdate(PageData pd) throws Exception {
		dao.update("ItemMapper.itemUpdate", pd);	
	}

	public void updateItemApproval(PageData pd) throws Exception {
		dao.update("ItemMapper.updateItemApproval", pd);	
		
	}
	
	//获取登录人所属分公司id
	public PageData getFgsIdByUserId(PageData pd) throws Exception {
	    return (PageData) dao.findForObject("ItemMapper.getFgsIdByUserId", pd);
	}
	//获取项目所属分公司id
	public PageData getFgsIdByItemId(PageData pd) throws Exception {
	    return (PageData) dao.findForObject("ItemMapper.getFgsIdByItemId", pd);
	}
	//获取待办
	public PageData findItemByUUid(PageData consultApply) throws Exception {
	    return (PageData) dao.findForObject("ItemMapper.findItemByUUid", consultApply);
	}

	public String listPageAllItemByRoleCount(PageData pd) throws Exception {
		return (String) dao.findForObject("ItemMapper.ItemByCount", pd);
	}

	public String cityName(PageData pd) throws Exception {
		return (String) dao.findForObject("ItemMapper.cityName", pd);
	}

	public void saveTempElevatorDetails(PageData i) throws Exception {
		// TODO Auto-generated method stub
		dao.save("ItemMapper.saveTempElevatorDetails", i);
	}
	
	/**
     * 分页显示显示待我处理
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditItemPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("ItemMapper.findAuditItemPage", pd);
    }

	public PageData findOrderOrg(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("ItemMapper.findOrderOrg", pd);
		
	}
	
	public void updateItemFollowUp(PageData pd) throws Exception {
		//将跟进信息插入tb_item_follow_up表;
		PageData genjinInfoPd = new PageData();
		String item_id = pd.get("item_id").toString();
		String genjinJsonStr = pd.get("genjin_info").toString();
		JSONArray jsonArray = JSONArray.fromObject(genjinJsonStr);
		//清空tb_item_follow_up
		delItemFollowUp(item_id);
		for(int i =0;i<jsonArray.size();i++){
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			genjinInfoPd.put("item_id", item_id);
			genjinInfoPd.put("genjindate", jsonObj.get("genjindate").toString());
			genjinInfoPd.put("genjinremark", jsonObj.get("genjinremark").toString());
			genjinInfoPd.put("genjinmanager", jsonObj.get("genjinmanager").toString());
			genjinInfoPd.put("genjinstatus", jsonObj.get("genjinstatus").toString());
			genjinInfoPd.put("genjinJsonStr", genjinJsonStr);
			saveItemFollowUp(genjinInfoPd);
		}
	}
	
}

