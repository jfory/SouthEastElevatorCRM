package com.dncrm.service.system.newInvoice;

import com.dncrm.dao.DaoSupport;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("newInvoiceService")
public class NewInvoiceService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	/**
	 *列表新开票 
	 */
	public List<PageData> list()throws Exception{
		return (List<PageData>)dao.findForList("NewInvoiceMapper.list", "");
	}
	
	/**
	 *查询合同列表 
	 */
	public List<PageData> findContractList()throws Exception{
		return (List<PageData>)dao.findForList("NewInvoiceMapper.findContractList", "");
	}
	
	/**
	 *根据合同查询应收款列表
	 */
	public List<PageData> findYskListByContract(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("NewInvoiceMapper.findYskListByContract", pd);
	}
	
	/**
	 *根据合同查询电梯信息列表 
	 */
	public List<PageData> findDtInfoListByContract(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("NewInvoiceMapper.findDtInfoListByContract", pd);
	}
	
	/**
	 *根据合同id查询开票头信息 
	 */
	public PageData findHeadInfo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("NewInvoiceMapper.findHeadInfo", pd);
	}
	
	/**
	 *新增开票信息 
	 */
	public void saveInvoice(PageData pd)throws Exception{
		dao.save("NewInvoiceMapper.saveInvoice", pd);
	}
	
	/**
	 *新增发票信息 
	 */
	public void saveInvoiceInfo(PageData pd)throws Exception{
		dao.save("NewInvoiceMapper.saveInvoiceInfo", pd);
	}
	
	/**
	 *删除开票信息 
	 */
	public void deleteInvoice(PageData pd)throws Exception{
		dao.delete("NewInvoiceMapper.deleteInvoice", pd);
	}
	
	/**
	 *删除开票子信息 
	 */
	public void deleteInvoiceInfo(PageData pd)throws Exception{
		dao.delete("NewInvoiceMapper.deleteInvoiceInfo", pd);
	}
	
	/**
	 *查询开票信息 
	 */
	public PageData findInvoice(PageData pd)throws Exception{
		return (PageData)dao.findForObject("NewInvoiceMapper.findInvoice", pd);
	}
	
	/**
	 *查询开票子信息 
	 */
	public List<PageData> findInvoiceInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("NewInvoiceMapper.findInvoiceInfo", pd);
	}
	
	/**
	 *编辑发票信息 
	 */
	public void editInvoiceInfo(PageData pd)throws Exception{
		dao.update("NewInvoiceMapper.editInvoiceInfo", pd);
	}
	
	/**
	 *编辑开票信息 
	 */
	public void editInvoice(PageData pd)throws Exception{
		dao.update("NewInvoiceMapper.editInvoice", pd);
	}
	
	/**
	 *根据主键查询invoiceinfo
	 */
	public PageData findInvoiceInfoById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("NewInvoiceMapper.findInvoiceInfoById", pd);
	}
	
	/**
	 *编辑操作之后删除多余数据 
	 */
	public void deleteInvoiceInfoAfterEdit(PageData pd)throws Exception{
		dao.delete("NewInvoiceMapper.deleteInvoiceInfoAfterEdit", pd);
	}
	
	/**
	 *查询合同开票信息 
	 */
	public PageData findKP(PageData pd)throws Exception{
		PageData res = (PageData)dao.findForObject("NewInvoiceMapper.findKP", pd);
		if (res!=null&&res.size()>0) {
			String wk_price = String.valueOf(res.get("WK_PRICE"));
			wk_price = wk_price.substring(0,wk_price.indexOf(".")+2);
			String yk_price = String.valueOf(res.get("YK_PRICE"));
			yk_price = yk_price.substring(0,yk_price.indexOf(".")+2);
			res.put("WK_PRICE", wk_price);
			res.put("YK_PRICE", yk_price);
		}
		
		
		return res;
	}
	
	/**
	 *修改流程状态 
	 */
	public void editActStatus(PageData pd)throws Exception{
		dao.update("NewInvoiceMapper.editActStatus", pd);
	}
	
	/**
	 *修改流程状态 
	 */
	public void editActKey(PageData pd)throws Exception{
		dao.update("NewInvoiceMapper.editActKey", pd);
	}
	
	//查询流程是否存在
    @SuppressWarnings("unchecked")
	public List<PageData> SelAct_Key(PageData pd) throws Exception
    {
    	return (List<PageData>) dao.findForList("NewInvoiceMapper.SelAct_Key", pd);
    }

    ////修改发票号和快递单号
	public void editFph(PageData pd) throws Exception {
		dao.update("NewInvoiceMapper.editFph", pd);

	}
    public PageData findCustomerInfoByItemId(PageData pd) throws Exception{
        return (PageData)dao.findForObject("NewInvoiceMapper.findCustomerInfoByItemId", pd);
    }
    
    /**
     * 分页显示显示待我处理的合同
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditNewInvoicePage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("NewInvoiceMapper.findAuditNewInvoicePage", pd);
    }
    
}
