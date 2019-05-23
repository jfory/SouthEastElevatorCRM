package com.dncrm.service.system.offer;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("offerService")
public class OfferService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 报价列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPdPageOffer(Page page) throws Exception{
		return (List<PageData>) dao.findForList("OfferMapper.offerlistPage", page);
	}
	
	/**
	 * 根据ID查找报价对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findOfferById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("OfferMapper.findOfferById", pd);
	}
	
	/**
	 * 报价添加
	 * @param pd
	 * @throws Exception
	 */
	public void offerAdd(PageData pd) throws Exception{
		dao.save("OfferMapper.offerAdd", pd);
	}
	
	/**
	 * 报价编辑
	 * @param pd
	 * @throws Exception
	 */
	public void offerUpdate(PageData pd) throws Exception{
		dao.update("OfferMapper.offerUpdate", pd);
	}
	
	/**
	 * 报价删除
	 * @param pd
	 * @throws Exception
	 */
	public void offerDelete(PageData pd) throws Exception{
		dao.delete("OfferMapper.offerDelete", pd);
	}
	
	/**
	 * 批量删除报价
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void offerDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("OfferMapper.offerDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 *根据项目id修改总价
	 */
	public void offerUpdateByItemId(PageData pd)throws Exception{
		dao.update("OfferMapper.offerUpdateByItemId", pd);
	}
	
	/**
	 * 生成电梯工号
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> createElevatorJobNo(PageData pd) throws Exception{
		List<PageData> totleBranchProductLineList = new ArrayList<>();//分支总数
		List<PageData> resultProductNoList = new ArrayList<>();//返回结果
		Map<Integer,Integer> map = new HashMap<>();
		List<PageData> yearInfoList = (List<PageData>) dao.findForList("OfferMapper.findYearInfoList", pd);//查询年份详情
		String year = new SimpleDateFormat("yyyy").format(new Date());//获取当前年
		String jobNum = "";
		for(PageData pds : yearInfoList){
			if(year.equals(pds.get("year"))){
				year = pds.getString("name");//获取年份名称
				break;
			}
		}
		//根据项目ID获取电梯列表
		List<PageData> elevatorDetailsList = (List<PageData>) dao.findForList("OfferMapper.elevatorDetailsByItemIdList", pd);
		/*for(PageData pds:elevatorDetailsList){
			Integer product_id = (Integer)pds.get("product_id");
			if(!totleBranchProductLine.containsKey(product_id)){
				totleBranchProductLine.put(product_id, product_id);
				pd.put("product_id", product_id);
				PageData product = (PageData) dao.findForObject("OfferMapper.findProductByProductId", pd);
				productNo = (Integer) product.get("product_no");
				totleBranchProductLineList.add(product);//获取产品线
			}
			
		}*/
		
		//获取添加的每条产品线数量
		for(PageData pds:elevatorDetailsList){
			Integer product_id = (Integer)pds.get("product_id");
			if(map.containsKey(product_id)){
				map.put(product_id, map.get(product_id).intValue()+1);
			}else{
				map.put(product_id, 1);
			}
		}
		for(Map.Entry<Integer, Integer> entry:map.entrySet()){
			PageData totleBranchProductLine = new PageData();//全部分支产品线
			totleBranchProductLine.put("product_id", entry.getKey());
			totleBranchProductLine.put("num", entry.getValue());
			totleBranchProductLineList.add(totleBranchProductLine);
		}
		for(PageData pds : totleBranchProductLineList){
			Integer num = (Integer) pds.get("num");
			PageData product = (PageData) dao.findForObject("OfferMapper.findProductByProductId", pds);
			PageData sumProductNo =  (PageData) dao.findForObject("OfferMapper.sumProductNo", null);
			BigDecimal bd = (BigDecimal) sumProductNo.get("product_no");
			Integer sumNo = bd.intValue();
			Integer nums = (Integer) product.get("product_no");
			Integer total = num+nums;
			String product_name = product.getString("product_name");
			for(int i=0;i<num;i++){
				nums = nums+1;
				sumNo = sumNo + 1;
				jobNum = year + sumNo + product_name + nums;
				PageData result = new PageData();
				result.put("product_no", jobNum);
				resultProductNoList.add(result);
			}
			pds.put("num", total);
			dao.update("OfferMapper.productUpdateByProductId", pds);
		}
		
		
		
		
		return resultProductNoList;
	}
	
	/**
	 *查询此项目是否已进行报价
	 */
	public boolean findOfferByItemId(String item_id)throws Exception{
		List<PageData> pdList = (List<PageData>)dao.findForList("OfferMapper.findOfferByItemId", item_id);
		if(pdList.size()>0){
			return true;
		}else{
			return false;
		}
	}
	//-------------------------------------------------------------------------------------------------------
	/**
	 *查询所有报价 
	 */
	public List<PageData> findOfferList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findOfferList", "");
	}
	/***
	 * 
	 */
	public List<PageData> findElevatorList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorList", "");
	}
	
	public List<PageData> findElevatorAuditList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorAuditList", "");
	}
	public List<PageData> findElevatorBaseList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorBaseList", "");
	}
	public List<PageData> findElevatorDetailsList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorDetailsList", "");
	}
	public List<PageData> findElevatorHeightList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorHeightList", "");
	}
	public List<PageData> findElevatorInfoList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorInfoList", "");
	}
	public List<PageData> findElevatorNonstandardList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorNonstandardList", "");
	}
	public List<PageData> findElevatorNumList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorNumList", "");
	}
	public List<PageData> findElevatorOptionalList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorOptionalList", "");
	}
	public List<PageData> findElevatorSpecList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findElevatorSpecList", "");
	}
	public List<PageData> findModelsList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findModelsList", "");
	}
	public List<PageData> findProductInfoList()throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findProductInfoList", "");
	}
	
	/**
	 *添加报价, 导入用
	 */
	public void saveOffer(PageData pd)throws Exception{
		dao.save("OfferMapper.saveOffer", pd);
	}
	public void saveElevator(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevator", pd);
	}
	public void saveElevatorAudit(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorAudit", pd);
	}
	public void saveElevatorBase(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorBase", pd);
	}
	public void saveElevatorDetails(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorDetails", pd);
	}
	public void saveElevatorHeight(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorHeight", pd);
	}
	public void saveElevatorInfo(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorInfo", pd);
	}
	public void saveElevatorNonstandard(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorNonstandard", pd);
	}
	public void saveElevatorNum(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorNum", pd);
	}
	public void saveElevatorOptional(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorOptional", pd);
	}
	public void saveElevatorSpec(PageData pd)throws Exception{
		dao.save("OfferMapper.saveElevatorSpec", pd);
	}
	public void saveModels(PageData pd)throws Exception{
		dao.save("OfferMapper.saveModels", pd);
	}
	public void saveProductInfo(PageData pd)throws Exception{
		dao.save("OfferMapper.saveProductInfo", pd);
	}
	
	public String findItemStatusByItemId(String item_id)throws Exception{
		return (String)dao.findForObject("OfferMapper.findItemStatusByItemId", item_id);
	}
	
	/**
	 *zTree版选配项配置 
	 */
	public List<PageData> findCascadeListByElevator(String elevator_id)throws Exception{
		return (List<PageData>)dao.findForList("OfferMapper.findCascadeListByElevator", elevator_id);
	}
	
	/**
	 *根据电梯id查询非标描述列表 
	 */
	public List<PageData>findNonstandardCentreByItemId(String elevator_no)throws Exception{
		return (List<PageData>) dao.findForList("OfferMapper.findNonstandardCentreByItemId", elevator_no);
	}
}
