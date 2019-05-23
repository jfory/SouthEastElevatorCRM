package com.dncrm.service.system.city;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("cityService")
public class CityService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	//省份分页列表
	public List<PageData> listPdPageProvince(Page page) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.provincelistPage", page);
	}
	
	//城市分页列表
	public List<PageData> listPdPageCity(Page page) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.citylistPage", page);
	}
	
	//省份分页列表
	public List<PageData> listPdPageCounty(Page page) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.countylistPage", page);
	}
	
	//城市公司分页列表
	public List<PageData> listcityitemsubbranch(Page page) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.cityitemsubbranclistPage", page);
	}
	
	//根据ID查询省份
	public List<PageData> findProvinceById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findProvinceById", pd);
	}
	
	//根据ID查询城市
	public List<PageData> findCityById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findCityById", pd);
	}
	
	//根据ID查询城市
		public List<PageData> findDeptById(PageData pd) throws Exception{
			return (List<PageData>) dao.findForList("CityMapper.findDeptById", pd);
		}
	
	//根据ID查询区县
	public List<PageData> findCountyById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findCountyById", pd);
	}

	//查询全部国家
	public List<PageData> findAllCountry() throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findAllCountry", "");
	}
	
	//查询全部省份
	public List<PageData> findAllProvince() throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findAllProvince", "");
	}

	//查询运输费省份
	public List<PageData> findYSFProvince() throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findYSFProvince", "");
	}
	
	
	//根据省份查询城市
	public List<PageData> findAllCityByProvinceId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findAllCityByProvinceId", pd);
	}
	
	//根据城市查询区县
	public List<PageData> findAllCountyByCityId(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findAllCountyByCityId", pd);
	}
	
	//根据城市查询区县
	public List<PageData> findAllCityDeptId(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.findAllCityDeptId", pd);
	}
	
	//是否存在省份名称
	public List<PageData> existsProvinceName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.existsProvinceName", pd);
	}
	
	//省份添加
	public void provinceAdd(PageData pd) throws Exception{
		dao.save("CityMapper.provinceAdd", pd);
	}
	
	//省份更新
	public void provinceUpdate(PageData pd) throws Exception{
		dao.update("CityMapper.provinceUpdate", pd);
	}
	
	//省份删除
	public void provinceDeleteById(PageData pd) throws Exception {
        dao.delete("CityMapper.provinceDeleteById", pd);
    }
	
	
	//是否存在城市名称
	public List<PageData> existsCityName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.existsCityName", pd);
	}
	
	//城市添加
	public void cityAdd(PageData pd) throws Exception{
		dao.save("CityMapper.cityAdd", pd);
	}
	
	//城市更新
	public void cityUpdate(PageData pd) throws Exception{
		dao.update("CityMapper.cityUpdate", pd);
	}
	
	//城市删除
	public void cityDeleteById(PageData pd) throws Exception {
        dao.delete("CityMapper.cityDeleteById", pd);
    }
	
	
	//是否存在区县名称
	public List<PageData> existsCountyName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.existsCountyName", pd);
	}
	
	//是否存在城市公司对应关系
	public List<PageData> existsCityDeptName(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("CityMapper.existsCityDeptName", pd);
	}
	//城市公司对应关系添加
	public void cityDeptAdd(PageData pd) throws Exception{
		dao.save("CityMapper.cityDeptAdd", pd);
	}
	
	//区县添加
	public void countyAdd(PageData pd) throws Exception{
		dao.save("CityMapper.countyAdd", pd);
	}
		
	//区县更新
	public void countyUpdate(PageData pd) throws Exception{
		dao.update("CityMapper.countyUpdate", pd);
	}
	
	//区县删除
	public void countyDeleteById(PageData pd) throws Exception {
        dao.delete("CityMapper.countyDeleteById", pd);
    }
	
	//区县城市公司对应关系
	public void citydeptDeleteById(PageData pd) throws Exception {
        dao.delete("CityMapper.citydeptDeleteById", pd);
    }
	
	 //根据省份name获取省份信息
    public PageData findProvinceByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CityMapper.findProvinceByName", pd);
    }
    
    //根据城市name和省份id获取城市信息
    public PageData findCityByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CityMapper.findCityByName", pd);
    }
    
  //根据城市name获取城市信息
    public PageData findCityByName2(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CityMapper.findCityByName2", pd);
    }
    
  //根据公司获取公司信息
    public PageData findCityByName3(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CityMapper.findCityByName3", pd);
    }
    //根据区县name和城市id获取区县信息
    public PageData findCountyByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("CityMapper.findCountyByName", pd);
    }
    
}
