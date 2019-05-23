package com.dncrm.service.system.productInfo;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("productInfoService")
public class ProductInfoService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 产品信息列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageProductInfo(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ProductInfoMapper.productInfolistPage", page);
	}
	
	/**
	 * 根据ID查找产品对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findProductInfoById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ProductInfoMapper.findProductInfoById", pd);
	}
	
	/**
	 * 根据类型查找产品列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findProductInfoByTypeList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ProductInfoMapper.findProductInfoByTypeList", pd);
	}
	
	/**
	 * 产品添加
	 * @param pd
	 * @throws Exception
	 */
	public void productInfoAdd(PageData pd) throws Exception{
		dao.save("ProductInfoMapper.productInfoAdd", pd);
	}
	
	/**
	 * 产品编辑
	 * @param pd
	 * @throws Exception
	 */
	public void productInfoUpdate(PageData pd) throws Exception{
		dao.update("ProductInfoMapper.productInfoUpdate", pd);
	}
	
	/**
	 * 产品删除
	 * @param pd
	 * @throws Exception
	 */
	public void productInfoDelete(PageData pd) throws Exception{
		dao.delete("ProductInfoMapper.productInfoDelete", pd);
	}
	
	/**
	 * 批量删除产品
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void productInfoDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ProductInfoMapper.productInfoDeleteAll", ArrayDATA_IDS);
	}
	
	/**
	 *根据电梯数量表id查询产品信息列表总价
	 * @param pd
	 * @throws Exception
	 */
	public double findProductInfoCountPriceById(PageData pd)throws Exception{
		BigDecimal countPrice = new BigDecimal(0);
		PageData pPd = (PageData)dao.findForObject("ProductInfoMapper.findProductInfoCountPriceById", pd);
		if(pPd!=null&&pPd.containsKey("countPrice")){
			countPrice = (BigDecimal)pPd.get("countPrice");
		}
		return countPrice.doubleValue();
	}
	
	/**
	 *根据电梯数量表id删除产品信息 
	 */
	public void ProductInfoDeleteById(PageData pd)throws Exception{
			dao.delete("ProductInfoMapper.ProductInfoDeleteById", pd);
	}
	
	
	
}
