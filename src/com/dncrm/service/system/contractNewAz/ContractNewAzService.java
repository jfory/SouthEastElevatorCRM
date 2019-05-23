package com.dncrm.service.system.contractNewAz;

import java.util.List;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;
import com.dncrm.util.UuidUtil;

/**
 *类名:contractNewAzService
 *创建人:stone
 *创建时间:2018年1月18日 
 */
@Service("contractNewAzService")
public class ContractNewAzService 
{
    @Resource(name="daoSupport")
    private DaoSupport dao;
    
    /**
	 * 查询 设备合同信息(合同类型为 设备安装分开)
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> SoContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.SoContractlistPage", page);
	    }
	 
	 /**
	 * 查询所有  安装合同信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> AzContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.AzContractlistPage", page);
	    }
	 
	 /**
     * 根据安装合同UUID 获取合同信息
     */
    public PageData findAzConByUUid(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewAzMapper.findAzConByUUid", pd);
	    }
	 
    /**
     * 根据合同id获取 tb_so_fkfs
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findFkfsByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.findFkfsByHtId", pd);
	    }
 
    //保存 新增合同信息
    public void save(PageData pd)throws Exception{
    	dao.save("ContractNewAzMapper.save", pd);
    }
    /**
     * 根据AZ_UUID 删除tb_az_contract 
     */
    public void deleteContract(PageData pd) throws Exception {
        dao.delete("ContractNewAzMapper.deleteContract", pd);
    }
    
    /**
     * 根据AZ_UUID 删除tb_so_fkfs
     */
    public void deleteFkfs(PageData pd) throws Exception {
        dao.delete("ContractNewAzMapper.deleteFkfs", pd);
    }
  
    //编辑合同信息
    public void edit(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.edit", pd);
    }

    //修改流程key
    public void editAct_Key(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.editAct_Key", pd);
    }
    
    //修改流程状态
    public void editAct_Status(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.editAct_Status", pd);
    }
    
    //保存 新增合同信息
    public void saveYsk(PageData pd)throws Exception{
    	dao.save("ContractNewAzMapper.saveYsk", pd);
    }
    
    /**
   	 * 查询 应收款信息
   	 */
   	 @SuppressWarnings("unchecked")
   	public List<PageData> SoYsklistPage(Page page) throws Exception {
   	        return (List<PageData>) dao.findForList("ContractNewAzMapper.SoYsklistPage", page);
   	    }
     
    	/*
  	 *安装合同输出
  	 */
      @SuppressWarnings("unchecked")
  	public List<PageData> printContractInstallation(Page page)throws Exception{
  		return (List<PageData>)dao.findForList("ContractNewAzMapper.printContractInstallation", page);
  	}
   
     /**
      * 根据id获取 tb_so_ysk 应收款信息
      */
     public PageData findYskById(PageData pd) throws Exception {
 	        return (PageData) dao.findForObject("ContractNewAzMapper.findYskById", pd);
 	    }
     /**
      * 根据 id获取 tb_so_fkfs
      */
     public PageData findFkfsById(PageData pd) throws Exception {
 	        return (PageData) dao.findForObject("ContractNewAzMapper.findFkfsById", pd);
 	    }
     
     /**
      * 根据 id获取 tb_invoice
      */
     public PageData findInvoiceById(PageData pd) throws Exception {
 	        return (PageData) dao.findForObject("ContractNewAzMapper.findInvoiceById", pd);
 	    }
     
     //修改安装合同总价
     public void editPrice(PageData pd) throws Exception
     {
     	dao.update("ContractNewAzMapper.editPrice", pd);
     }

	/*public String yskCount(String DQTS) throws Exception {
		return (String) dao.findForObject("ContractNewAzMapper.yskCount", DQTS);
	}*/
     

	public String yskCount(PageData pd) throws Exception {
		return (String) dao.findForObject("ContractNewAzMapper.yskCount", pd);
	}

	 //修改流程状态
    public void editAct_StatusEnd(PageData pd) throws Exception
    {
    	dao.update("ContractNewAzMapper.editAct_StatusEnd", pd);
    }

	public void editAct_StatusError(PageData pd) throws Exception {
		dao.update("ContractNewAzMapper.editAct_StatusError", pd);
		
	}
	
	/**
     * 分页显示显示待我处理的合同
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditContractNewAzPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("ContractNewAzMapper.findAuditContractNewAzPage", pd);
    }
    
    /**
	 * 导出Excel
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> findContractNewAzExcel(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewAzMapper.findContractNewAzExcel", pd);
	  }

	public void editLK(PageData pd) throws Exception {
		
		if(!"".equals(pd.getNoneNULLString("YSK_UUID"))) {
			PageData ysk = findYskById(pd);
			
			if(ysk != null && "".equals(ysk.getNoneNULLString("YSK_HT_ID")))return;
			
			if("".equals(pd.getNoneNULLString("LK_UUID"))) {
				PageData lkPd = new PageData();
				lkPd.put("LK_UUID", UuidUtil.get32UUID());
				lkPd.put("LK_HT_ID", ysk.get("YSK_HT_ID"));
				lkPd.put("LK_ITEM_ID", ysk.get("YSK_ITEM_ID"));
				lkPd.put("LK_FKFS_ID", ysk.get("YSK_FKFS_ID"));
				lkPd.put("LK_QS", ysk.get("YSK_QS"));
				lkPd.put("LK_KX", ysk.get("YSK_KX"));
				lkPd.put("LK_LKJE", pd.get("LK_LKJE"));
				lkPd.put("LK_LKRQ", pd.get("LK_LKRQ"));
				lkPd.put("LK_BOND", pd.get("LK_BOND"));
				lkPd.put("LK_REMARKS", pd.get("LK_REMARKS"));
				lkPd.put("LK_INPUT_NAME", pd.get("input_user"));
				
				dao.save("ContractNewAzMapper.saveLk", lkPd);
				
				pd.put("YSK_LK_ID", lkPd.get("LK_UUID"));
				dao.update("ContractNewAzMapper.updateYskLK", pd);
			
			} else {
				
				dao.update("ContractNewAzMapper.updateLk", pd);
			}
			
			//更新项目状态
			pd.put("HT_UUID", ysk.getNoneNULLString("YSK_HT_ID"));
			PageData sbhtpd = (PageData) dao.findForObject("ContractNewMapper.findHtDJLK", pd);
			if(sbhtpd != null && !"".equals(sbhtpd.getNoneNULLString("HT_UUID"))) {
				String json = sbhtpd.getNoneNULLString("CONTRACT_ATTA_JSON");
				String je = sbhtpd.getNoneNULLString("LK_LKJE");
				if(StringUtils.isNoneBlank(je) && StringUtils.isNoneBlank(json)
						&& !"[]".equals(json)) {
					
					PageData hpd = new PageData();
					hpd.put("CONTRACT_STATUS", "1");
					hpd.put("HT_UUID", ysk.getNoneNULLString("YSK_HT_ID"));
					dao.update("ContractNewMapper.updateContractStatus", hpd);
					
				} else {
					PageData hpd = new PageData();
					hpd.put("CONTRACT_STATUS", "0");
					hpd.put("HT_UUID", ysk.getNoneNULLString("YSK_HT_ID"));
					dao.update("ContractNewMapper.updateContractStatus", hpd);
				}
				
			}
			
		}
		
	}
	
	public PageData findLkById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ContractNewAzMapper.findLkById", pd);
	}
    
}
    

