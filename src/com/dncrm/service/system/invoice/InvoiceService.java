package com.dncrm.service.system.invoice;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("invoiceService")
public class InvoiceService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	//查询发票基本信息
	@SuppressWarnings("unchecked")
	public List<PageData> invoicelistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("InvoiceMapper.invoicelistPage", page);
	    }
	 //查询来款信息
  	@SuppressWarnings("unchecked")
  	public List<PageData> comeFundlistPage(Page page) throws Exception {
  	        return (List<PageData>) dao.findForList("InvoiceMapper.comeFundlistPage", page);
  	    }
  	 /*
     * 根据编号查询来款信息
     */
    public PageData findComeFundById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("InvoiceMapper.findComeFundById", pd);
    }
    /*
     * 根据编号查询发票信息
     */
    public PageData findInvoiceById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("InvoiceMapper.findInvoiceById", pd);
    }
    /**
     * 保存新增
     * @param pd the pd
     * @throws Exception the exception
     */
    public void saveS(PageData pd) throws Exception {
        dao.save("InvoiceMapper.saveS", pd);
    }
    /**
     * 根据编号删除发票信息
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delInvoice(PageData pd) throws Exception {
        dao.delete("InvoiceMapper.delInvoice", pd);
    }
    /**
     * 根据编号删除承运信息
     * @param pd the pd
     * @throws Exception the exception
     */
    public void delCarriage(PageData pd) throws Exception {
        dao.delete("InvoiceMapper.delCarriage", pd);
    }
    /**
     * 保存修改
     * @param pd the pd
     * @throws Exception the exception
     */
    public void editS(PageData pd) throws Exception {
        dao.update("InvoiceMapper.editS", pd);
    }
    /**
     * 保存修改状态
     * @param pd the pd
     * @throws Exception the exception
     */
    public void editStates(PageData pd) throws Exception {
        dao.update("InvoiceMapper.editStates", pd);
    }
    /**
     * 保存新增承运单
     * @param pd the pd
     * @throws Exception the exception
     */
    public void  AddCarriage(PageData pd) throws Exception {
        dao.save("InvoiceMapper.AddCarriage", pd);
    }
    /*
     * 根据编号查询承运单信息
     */
    public PageData findCarriageById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("InvoiceMapper.findCarriageById", pd);
    }
    
    
    /**
	 * 获取option集合
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findInvoiceList() throws Exception{
		return (List<PageData>) dao.findForList("InvoiceMapper.findInvoiceList", null);
	}
}
