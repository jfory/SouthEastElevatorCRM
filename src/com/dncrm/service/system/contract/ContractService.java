package com.dncrm.service.system.contract;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:ContractService
 *创建人:stone
 *创建时间:2016年11月11日 
 */
@Service("contractService")
public class ContractService 
{
    @Resource(name="daoSupport")
    private DaoSupport dao;
    
    /**
     * 根据登录用户角色分级查询项目列表
     */
    @SuppressWarnings("unchecked")
    public List<PageData> listPageAllItemByRole(Page page)throws Exception{
    	return (List<PageData>) dao.findForList("ContractMapper.listPageAllItemByRole", page);
    }
    
    /*
	 *查询项目列表 
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPageAllItem(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listPageAllItem", page);
	}
    /*//查询全部合同信息
    @SuppressWarnings("unchecked")
    public List<PageData> contractlistPage(Page page) throws Exception
    {
    	return (List<PageData>) dao.findForList("ContractMapper.ContractlistPage",page);
    }*/
    //根据合同编号删除合同信息
    public void delContract(PageData pd) throws Exception {
        dao.delete("ContractMapper.delContract", pd);
    }
    //查询报价信息
    @SuppressWarnings("unchecked")
	public List<PageData> offerlistPage(Page page) throws Exception {
        return (List<PageData>) dao
                .findForList("ContractMapper.offerlistPage", page);
    }
    
    /**
     * 根据合同编号查询合同信息
     *
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findContractById(PageData pd) throws Exception {

        return (PageData) dao.findForObject("ContractMapper.findById", pd);
    }
    
    /**
     * 根据设备合同编号查询设备合同信息
     *
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findSoContractById(PageData pd) throws Exception {

        return (PageData) dao.findForObject("ContractMapper.findSoContractById", pd);
    }
    
    /**
     * 根据安装合同编号查询安装合同信息
     *
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findAzContractById(PageData pd) throws Exception {

        return (PageData) dao.findForObject("ContractMapper.findAzContractById", pd);
    }
    
    
    /**
     * 根据合同uuid查询合同信息
     *
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findContractByuuId(PageData pd) throws Exception {

        return (PageData) dao.findForObject("ContractMapper.findByuuId", pd);
    }
    //根据项目name查询项目id（导入）
    public PageData findItemByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findItemByName", pd);
    }
    //根据报价编号查询报价信息
    public PageData findItemById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findItemById", pd);
    }
    
    
    //查询流程实例
    public PageData specialID(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.specialID", pd);
    }
    /**
     * 保存新增
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveS(PageData pd) throws Exception {
        dao.save("ContractMapper.saveS", pd);
    }
    /**
     * 保存修改
     *
     * @param pd the pd
     * @throws Exception the exception
     */
    public void editS(PageData pd) throws Exception 
    {
        dao.update("ContractMapper.editS", pd);
    }
    
    /**
     *查询流程
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData> ConProcessKey(Page page) throws Exception
    {
          return (List<PageData>) dao.findForList("ContractMapper.ConProcessKey",page);
    }
    
    /**
     *查询特种梯流程
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	public List<PageData>SpecialKey(Page page) throws Exception
    {
          return (List<PageData>) dao.findForList("ContractMapper.SpecialKey",page);
    }
    
    //更新流程审核状态
    public void updateConApproval(PageData pd) throws Exception {
        dao.update("ContractMapper.updateConApproval", pd);
    }
    //更新流程审核状态
    public void updateConApproval2(PageData pd) throws Exception {
        dao.update("ContractMapper.updateConApproval2", pd);
    }
    
    //根据项目编号查询全部电梯信息
    @SuppressWarnings("unchecked")
	public List<PageData> elevatorList(PageData pd) throws Exception
    {
          return (List<PageData>) dao.findForList("ContractMapper.elevatorList",pd);
    }
    
    
    //binding工号
    public void updateBinding(PageData pd) throws Exception {
        dao.update("ContractMapper.updateBinding", pd);
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
		List<PageData> elevatorList =elevatorList(pd);   //查询出全部电梯信息
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
				//------------------------------
				PageData pd1 = new PageData();
				pd1.put("no", jobNum);
				pd1.put("id",elevatorList.get(0));
				this.updateBinding(pd1);     //修改工号
				elevatorList.remove(0);
				//------------------------------
				PageData result = new PageData();
				result.put("product_no", jobNum);
				resultProductNoList.add(result);
			}
			pds.put("num", total);
			dao.update("OfferMapper.productUpdateByProductId", pds);
		}
		return resultProductNoList;
	}
	
	//=======================报表=============================
	//统计方式为   总数
	  //查询每一年合同数量
    public List<PageData> ContractYearNum()throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractYearNum", "");
	}
    //当前年份 每月的数量
    public List<PageData> ContractMonthNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractMonthNum", year);
	}
    //当前年份  每个季度的数量
    public List<PageData> ContractQuarterNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractQuarterNum", year);
	}
  //统计方式为   状态=================================================
	  //查询每一年合同数量
  public List<PageData> ContractYearStatusNum()throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractYearStatusNum", "");
	}
  //当前年份 每月的数量
  public List<PageData> ContractMonthStatusNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractMonthStatusNum", year);
	}
  //当前年份  每个季度的数量
  public List<PageData> ContractQuarterStatusNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.ContractQuarterStatusNum", year);
	}
  
  
  
  /**
	 * 获取option集合
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findContractList() throws Exception{
		return (List<PageData>) dao.findForList("ContractMapper.findContractList", null);
	}
	
	
	/**
     * 根据item_id获取客户信息
     *2017-03-03  Stone
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findByItem_Id(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findByItem_Id", pd);
    }
    
    /**
     * 根据offer_Id获取客户信息
     *2017-03-03  Stone
     * @param pd the pd
     * @return the page data
     * @throws Exception the exception
     */
    public PageData findByoffer_Id(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findByoffer_Id", pd);
    }
    
   /*根据客户获取客户信息（Ordinary）
    * 2017-03-03  Stone
    * */
    public PageData findByOrdinary(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findByOrdinary", pd);
    }
    /*根据客户获取客户信息（Merchant）
     * 2017-03-03  Stone
     * */
    public PageData findByMerchant(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findByMerchant", pd);
    }
    /*根据客户获取客户信息（Core）
     * 2017-03-03  Stone
     * */
    public PageData findByCore(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractMapper.findByCore", pd);
    }
    /*根据项目id获取电梯信息
     * 2017-03-04  Stone
     * */
   	@SuppressWarnings("unchecked")
   	public List<PageData> findByElev(PageData pdelev)throws Exception{
   		return (List<PageData>)dao.findForList("ContractMapper.findByElev", pdelev);
   	}
   	
   	@SuppressWarnings("unchecked")
	public List<PageData> findByElevl(PageData pdelev) throws Exception {
		List<PageData> resList =(List<PageData>)dao.findForList("ContractMapper.findByElevl", pdelev);
//		for (PageData pageData : resList) {
//			if (pageData.getNoneNULLString("CJF") != null) {
//				String cjf = pageData.getNoneNULLString("CJF");
//				cjf.substring(0, cjf.lastIndexOf(".")+2);
//				pageData.put("CJF", cjf);
//			}
//		}
		return resList;
	}
   	
	@SuppressWarnings("unchecked")
	public List<PageData> findByFkfs(PageData pdelev) throws Exception {
		return (List<PageData>)dao.findForList("ContractMapper.findByFkfs", pdelev);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> findByAZFkfs(PageData pdelev) throws Exception {
		return (List<PageData>)dao.findForList("ContractMapper.findByAZFkfs", pdelev);
	}
}
    

