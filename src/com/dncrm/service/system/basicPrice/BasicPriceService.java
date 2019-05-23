package com.dncrm.service.system.basicPrice;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("basicPriceService")
public class BasicPriceService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	//---------直梯相关功能---------
	/**
	 * 电梯标准分页列表
	 */
	public List<PageData> listPageRegelevStandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("BasicPriceMapper.regelevStandardlistPage", page);
	}
	
	/**
	 * 电梯标准价格添加
	 */
	public void regelevStandardAdd(PageData pd) throws Exception{
		dao.save("BasicPriceMapper.regelevStandardAdd", pd);
	}
	
	/**
	 * 根据主键查询
	 */
	public PageData findById(PageData pd) throws Exception{
		return (PageData)dao.findForObject("BasicPriceMapper.findById", pd);
	}
	
	/**
     * 保存修改
     */
    public void editS(PageData pd) throws Exception {
        dao.update("BasicPriceMapper.editS", pd);
    }
    
    /**
     * 删除
     */
    public void delete(PageData pd) throws Exception {
        dao.delete("BasicPriceMapper.delete", pd);
    }
    
    /**
	 * 根据  型号名称 速度 载重 层站获取基础价格（直梯）
	 */
	public PageData setBasicPrice(PageData pd) throws Exception{
		return (PageData)dao.findForObject("BasicPriceMapper.setBasicPrice", pd);
	}
	
	/**
	 * 根据  型号名称 规格 角度 梯结宽度获取基础价格(扶梯)
	 */
	public PageData setBasicPrice_F(PageData pd) throws Exception{
		return (PageData)dao.findForObject("BasicPriceMapper.setBasicPrice_F", pd);
	}
	
	//---------扶梯相关功能---------
		/**
		 * 列表
		 */
		public List<PageData> F_basicPricelistPage(Page page) throws Exception{
			return (List<PageData>) dao.findForList("BasicPriceMapper.F_basicPricelistPage", page);
		}
		
		/**
		 * 电梯标准价格添加
		 */
		public void saveF(PageData pd) throws Exception{
			dao.save("BasicPriceMapper.saveF", pd);
		}
		
		/**
		 * 根据主键查询
		 */
		public PageData findByF_BPId(PageData pd) throws Exception{
			return (PageData)dao.findForObject("BasicPriceMapper.findByF_BPId", pd);
		}
		
		/**
	     * 保存修改
	     */
	    public void editF(PageData pd) throws Exception {
	        dao.update("BasicPriceMapper.editF", pd);
	    }
	    
	    /**
	     * 删除
	     */
	    public void deleteF(PageData pd) throws Exception {
	        dao.delete("BasicPriceMapper.deleteF", pd);
	    }
	    
	    /**
		 * 根据基础参数 获取基础价格
		 */
		public PageData setF_BasicPrice(PageData pd) throws Exception{
			return (PageData)dao.findForObject("BasicPriceMapper.setBasicPrice", pd);
		}
		
		public List<PageData> findbasicPriceList(PageData pd) throws Exception{
			return (List<PageData>) dao.findForList("BasicPriceMapper.setBasicPrice", pd);
		}
		
		public List<PageData> findbasicPriceFList(PageData pd) throws Exception{
			return (List<PageData>) dao.findForList("BasicPriceMapper.setBasicPrice_F", pd);
		}
		
		/**
		 * 是否存在直梯基价
		 * 
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		public boolean isExistBascPrice(PageData pd) throws Exception{
			List<PageData> basePd = findbasicPriceList(pd);
			return basePd != null && basePd.size() > 0;
		}

		/**
		 * 是否存在扶梯基价
		 * 
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		public boolean isExistBascPriceF(PageData pd) throws Exception {
			List<PageData> basePd = findbasicPriceFList(pd);
			return basePd != null && basePd.size() > 0;
		}
		
}
