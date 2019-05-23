package com.dncrm.service.system.contractModify;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 *类名:ContractModifyService
 *创建人:arisu
 *创建时间:2017年1月18日 
 */
@Service("contractModifyService")
public class ContractModifyService {
    @Resource(name="daoSupport")
    private DaoSupport dao;
    @Resource(name="contractNewService")
    private ContractNewService contractNewService;
    @Resource(name="contractNewAzService")
    private ContractNewAzService contractNewAzService;
    
    /**
     *根据项目列表合同变更 
     */
    public List<PageData> list(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.list", pd);
    }
    
    /**
     *查询列表页面头信息(项目名称/客户名称) 
     */
    public PageData findHeadMsg(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findHeadMsg", pd);
    }
    
    /**
     *查询新增编辑页面头信息 
     */
    public PageData findHeadInfo(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findHeadInfo", pd);
    }
    
    /**
     *根据合同主键查询电梯列表 
     */
    public List<PageData>findDtinfoForAdd(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findDtinfoForAdd", pd);
    }
    
    
    /**
     *根据合同主键查询付款方式
     */
    public List<PageData>findFkfsForAdd(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findFkfsForAdd", pd);
    }
    
    /**
     *保存合同变更 
     */
    public void saveContractModify(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveContractModify", pd);
    }
    
    /**
     *保存合同变更电梯信息 
     */
    public void saveCmElev(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveCmElev", pd);
    }
    
    
    /**
     *保存合同变更付款方式信息 
     */
    public void saveCmFkfs(PageData pd)throws Exception{
    	dao.save("contractModifyMapper.saveCmFkfs", pd);
    }
    
    /**
     *根据Id查询 
     */
    public PageData findContractModify(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("contractModifyMapper.findContractModify", pd);
    }
    
    /**
     *修改流程key 
     */
    public void editActKey(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.editActKey", pd);
    }
    
    /**
     *修改流程status
     */
    public void editActStatus(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.editActStatus", pd);
    }
    
    /**
     *删除 
     */
    public void deleteContractModify(PageData pd)throws Exception{
    	dao.delete("contractModifyMapper.deleteContractModify", pd);
    }
    

    /**
     *删除电梯 
     */
    public void deleteCmElev(PageData pd)throws Exception{
    	dao.delete("contractModifyMapper.deleteCmElev", pd);
    }
    

    /**
     *删除付款方式 
     */
    public void deleteCmFkfs(PageData pd)throws Exception{
    	dao.delete("contractModifyMapper.deleteCmFkfs", pd);
    }
    
    /**
     *根据变更主键查询电梯信息 
     */
    public List<PageData> findCmElevForEdit(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findCmElevForEdit", pd);
    }
    
    public List<PageData> findCmElevForModifyId(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findCmElevForModifyId", pd);
    }
    
    /**
     *根据变更主键查询付款方式
     */
    public List<PageData> findCmFkfsForEdit(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("contractModifyMapper.findCmFkfsForEdit", pd);
    }
    
    /**
     *编辑合同变更 
     */
    public void updateContractModify(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.updateContractModify", pd);
    }
    
    /**
     *编辑变更电梯信息 
     */
    public void updateCmElev(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.updateCmElev", pd);
    }
    
    /**
     *编辑变更付款方式 
     */
    public void updateCmFkfs(PageData pd)throws Exception{
    	dao.update("contractModifyMapper.updateCmFkfs", pd);
    }
    
    /**
 	 *变更协议输出
 	 */
     @SuppressWarnings("unchecked")
 	public List<PageData> printContractModify(Page page)throws Exception{
 		return (List<PageData>)dao.findForList("contractModifyMapper.printContractModify", page);
 	}
     
     /**
      *查询变更协议流水号 
      */
     public PageData findSerialNumber()throws Exception{
    	 PageData resultPd = new PageData();
    	 String pre = "BD"+new SimpleDateFormat("yyMMdd").format(new Date());
    	 PageData pd = (PageData)dao.findForObject("contractModifyMapper.findSerialNumber", "");
    	 if(pd!=null){
        	 String sizeNum = "";
    		 DecimalFormat df = new DecimalFormat("000");
    		 int a=Integer.parseInt(pd.getString("serial_number"));
    		 sizeNum = df.format(a);
    		 resultPd.put("modify_number", pre+sizeNum);
    		 resultPd.put("serial_number", Integer.parseInt(pd.getString("serial_number"))+1);
    	 }else{
    		 resultPd.put("modify_number", pre+"001");
    		 resultPd.put("serial_number", "1");
    	 }
    	 return resultPd;
     }
     
     /**
  	 *获取合同信息
  	 */
      @SuppressWarnings("unchecked")
      public PageData findContractModifyById(PageData pd)throws Exception{
    	  	return (PageData)dao.findForObject("contractModifyMapper.findContractModifyById", pd);
      }

    /**
     * 合同变更审核完成后自动修改设备合同对应的电梯信息与付款方式
     * @param pd
     * @throws Exception
     */
    public void updateContractInfo(PageData pd) throws Exception{
      PageData pdcm=this.findContractModify(pd);
      if(pdcm!=null){
          List<PageData> dtInfoList = this.findCmElevForEdit(pd);
          if(dtInfoList!=null&&dtInfoList.size()>0){//更新电梯信息
              for (PageData pdate:dtInfoList) {
                  dao.update("contractModifyMapper.updateContractDtInfo",pdate);
              }
          }
          dao.update("contractModifyMapper.updateContractTotalPrice",pdcm);

          dao.delete("contractModifyMapper.deleteContractFkfs",pd);

          List<PageData> fkfsList = this.findCmFkfsForEdit(pd);
          if(fkfsList!=null&&fkfsList.size()>0){//更新付款方式信息
              for (PageData pdfkfs:fkfsList) {
                if(pdfkfs.getString("FKFS_UUID")!=null&&!"".equals(pdfkfs.getString("FKFS_UUID"))){//修改的付款方式则更新
                    dao.update("contractModifyMapper.updateContractFkfs",pdfkfs);
                }else {//新增的付款方式则插入
                    pdfkfs.put("FKFS_UUID", UUID.randomUUID().toString());
                    pdfkfs.put("FKFS_QS", pdfkfs.get("period").toString());
                    pdfkfs.put("FKFS_KX", pdfkfs.get("FKFS_KX").toString());
                    pdfkfs.put("FKFS_PDRQ", pdfkfs.get("FKFS_PDRQ").toString());
                    pdfkfs.put("FKFS_PCRQ", "");
                    pdfkfs.put("FKFS_FKBL", pdfkfs.get("FKFS_FKBL").toString());
                    pdfkfs.put("FKFS_JE", pdfkfs.get("FKFS_JE").toString());
                    pdfkfs.put("FKFS_BZ", pdfkfs.get("REMARK").toString());
                    pdfkfs.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    pdfkfs.put("FKFS_HT_UUID",pdcm.get("contract_id"));
                    pdfkfs.put("FKFS_FKTS", pdfkfs.get("FKFS_FKTS").toString());

                    contractNewService.saveFkfs(pdfkfs);
                }
              }
          }
          dao.delete("contractModifyMapper.deleteContractYSK",pd);//删除不存在对应付款方式的应收款
          dao.update("contractModifyMapper.updateContractYSK",pd);//更新对应应收款金额
          List<PageData> yskpdlist=(List<PageData>)dao.findForList("contractModifyMapper.findNoYSKFkfs",pd);//查找对应不存在应收款的付款方式
          if(yskpdlist!=null&&yskpdlist.size()>0){
              for(PageData pdysk:yskpdlist){
                  pdysk.put("YSK_UUID", UUID.randomUUID().toString());
                  contractNewAzService.saveYsk(pdysk);
              }
          }
      }
    }
    
    /**
     * 分页显示显示待我处理
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditcontractModifyPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("contractModifyMapper.findAuditcontractModifyPage", pd);
    }
    
    
    /**
     * 获取变更通过列表
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findContractModifyPassList(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("contractModifyMapper.findContractModifyPassList", pd);
    }
    
    public List<PageData> findPrevContractModifyList(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("contractModifyMapper.findPrevContractModifyList", pd);
    }
    
}


