package com.dncrm.service.system.product;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("productService")
public class ProductService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 产品线列表分页
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPdPageProduct(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ProductMapper.productlistPage", page);
	}
	
	/**
	 * 产品线列表全部
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllProduct() throws Exception{
		return (List<PageData>) dao.findForList("ProductMapper.listAllProduct", "");
	}
	
	/**
	 * 根据ID查找产品线对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findProductById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ProductMapper.findProductById", pd);
	}
	
	/**
	 * 根据Id查找产品线列表
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findProductByIdList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ProductMapper.findProductByIdList", pd);
	}
	
	/**
	 * 产品线添加
	 * @param pd
	 * @throws Exception
	 */
	public void productAdd(PageData pd) throws Exception{
		dao.save("ProductMapper.productAdd", pd);
	}
	
	/**
	 * 产品线编辑
	 * @param pd
	 * @throws Exception
	 */
	public void productUpdate(PageData pd) throws Exception{
		dao.update("ProductMapper.productUpdate", pd);
	}
	
	/**
	 * 产品线删除
	 * @param pd
	 * @throws Exception
	 */
	public void productDelete(PageData pd) throws Exception{
		dao.delete("ProductMapper.productDelete", pd);
	}
	
	/**
	 * 批量删除产品线
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void productDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("ProductMapper.productDeleteAll", ArrayDATA_IDS);
	}
	/**
	 * 查询全部电梯类型
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> elevatorList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ProductMapper.elevatorList", pd);
	}
	
}
