package com.dncrm.controller.system.city;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.city.CityService;
import com.dncrm.util.Const;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/city")
public class CityController extends BaseController{

	@Resource(name = "cityService")
	private CityService cityService;
	
	/**
	 * 省份管理分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "provinceList")
	public ModelAndView provinceList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//如果有多个form,设置第几个,从0开始
        page.setFormNo(0);
        page.setPd(pd);
        List<PageData> provinceList = cityService.listPdPageProvince(page);
        
        pd.put("isActive1","1");
        mv.addObject("pd",pd);
        mv.addObject("province_name",pd.get("province_name"));
		mv.addObject("provinceList", provinceList);
		mv.setViewName("system/city/city_list");
		return mv;
	}
	
	/**
	 * 城市管理分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cityList")
	public ModelAndView cityList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//如果有多个form,设置第几个,从0开始
        page.setFormNo(1);
        page.setPd(pd);
        List<PageData> cityList = cityService.listPdPageCity(page);
        pd.put("isActive2","1");
        mv.addObject("pd",pd);
		mv.addObject("cityList", cityList);
		mv.addObject("city_name", pd.get("city_name"));
		mv.setViewName("system/city/city_list");
		return mv;
	}
	
	/**
	 * 区县分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "countyList")
	public ModelAndView countyList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//如果有多个form,设置第几个,从0开始
        page.setFormNo(2);
        page.setPd(pd);
        List<PageData> countyList = cityService.listPdPageCounty(page);
        pd.put("isActive3","1");
        mv.addObject("pd",pd);
		mv.addObject("countyList", countyList);
		mv.addObject("county_name", pd.get("county_name"));
		mv.setViewName("system/city/city_list");
		return mv;
	}
	
	/**
	 * 城市公司分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "cityitemsubbranchList")
	public ModelAndView cityitemsubbranchList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//如果有多个form,设置第几个,从0开始
        page.setFormNo(3);
        page.setPd(pd);
        List<PageData> cityDeptList = cityService.listcityitemsubbranch(page);
        pd.put("isActive4","1");
        mv.addObject("pd",pd);
		mv.addObject("cityDeptList", cityDeptList);
		mv.addObject("departmentname", pd.get("departmentname"));
		mv.setViewName("system/city/city_list");
		return mv;
	}
	
	/**
     * 跳到添加省份页面
     *
     * @return
     */
    @RequestMapping("/goAddProvince")
    public ModelAndView goAddProvince() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/city/province_edit");
        mv.addObject("msg", "addProvince");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");

        mv.addObject("userpds", pds);
        return mv;
    }
    
    /**
     * 添加省份
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "addProvince")
	public ModelAndView addProvince() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			//省份名称是否存在重复
			List<PageData> list = cityService.existsProvinceName(pd);
			if (list.isEmpty()) {
				cityService.provinceAdd(pd);
				mv.addObject("msg", "success");
	    	}
		}catch(Exception e){
			e.printStackTrace();
			mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
		}
		
		mv.addObject("id", "AddProvince");
		mv.addObject("form", "provinceForm");
	    mv.setViewName("save_result");
		return mv;
	}
    
    /**
     * 跳到省份编辑页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goEditProvince")
    public ModelAndView goEditProvince() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> provinceList = cityService.findProvinceById(pd);
        mv.setViewName("system/city/province_edit");
        mv.addObject("pd", provinceList.get(0));
        mv.addObject("msg", "editProvince");
        return mv;
    }
    
    /**
     * 编辑省份
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editProvince")
    public ModelAndView editProvince() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	//省份名称是否存在重复
		List<PageData> list = cityService.existsProvinceName(pd);
    	if(list.isEmpty()){
    		cityService.provinceUpdate(pd);
    		mv.addObject("id", "EditProvince");
    		mv.addObject("form", "provinceForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "editProvince");
            mv.addObject("pd", pd);
            mv.setViewName("system/city/province_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    
    /**
     * 删除省份
     *
     */
    @RequestMapping("/delProvince")
    @ResponseBody
    public Object delProvince() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
        	List<PageData> provinceList = cityService.findAllCityByProvinceId(pd);
        	if(provinceList.isEmpty()){
        		cityService.provinceDeleteById(pd);;
                map.put("msg", "success");

            }else{
                map.put("msg", "failed");
                map.put("err", "省份下还有城市,不能删除");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    
    /**
     * 跳到添加城市页面
     *
     * @return
     * @throws Exception 
     */
    @RequestMapping("/goAddCity")
    public ModelAndView goAddCity() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> provinceList = cityService.findAllProvince();
        mv.setViewName("system/city/city_edit");
        mv.addObject("msg", "addCity");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        mv.addObject("provinceList",provinceList);
        mv.addObject("userpds", pds);
        return mv;
    }
    
    /**
     * 添加城市
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "addCity")
	public ModelAndView addCity() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			//城市名称是否存在重复
			List<PageData> list = cityService.existsCityName(pd);
			if (list.isEmpty()) {
				cityService.cityAdd(pd);
				mv.addObject("msg", "success");
	    	}
		}catch(Exception e){
			e.printStackTrace();
			mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
		}
		
		mv.addObject("id", "AddCity");
		mv.addObject("form", "cityForm");
	    mv.setViewName("save_result");
		return mv;
	}
    
    /**
     * 跳到城市编辑页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goEditCity")
    public ModelAndView goEditCity() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> provinceList = cityService.findAllProvince();
        List<PageData> cityList = cityService.findCityById(pd);
        mv.setViewName("system/city/city_edit");
        mv.addObject("pd", cityList.get(0));
        mv.addObject("provinceList", provinceList);
        mv.addObject("msg", "editCity");
        return mv;
    }
    
    /**
     * 编辑城市
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editCity")
    public ModelAndView editCity() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	//城市名称是否存在重复
		List<PageData> list = cityService.existsCityName(pd);
    	if(list.isEmpty()){
    		cityService.cityUpdate(pd);
    		mv.addObject("id", "EditCity");
    		mv.addObject("form", "cityForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "editCity");
            mv.addObject("pd", pd);
            mv.setViewName("system/city/city_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    
    /**
     * 删除城市
     *
     */
    @RequestMapping("/delCity")
    @ResponseBody
    public Object delCity() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
        	List<PageData> cityList = cityService.findAllCountyByCityId(pd);
        	if(cityList.isEmpty()){
        		cityService.cityDeleteById(pd);;
                map.put("msg", "success");

            }else{
                map.put("msg", "failed");
                map.put("err", "城市下还有区县,不能删除");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    
    /**
     * 跳到添加区县页面
     *
     * @return
     * @throws Exception 
     */
    @RequestMapping("/goAddCounty")
    public ModelAndView goAddCounty() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> cityList = cityService.findCityById(pd);
        mv.setViewName("system/city/county_edit");
        mv.addObject("msg", "addCounty");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        mv.addObject("cityList",cityList);
        mv.addObject("userpds", pds);
        return mv;
    }
    
    /**
     * 跳到城市公司页面
     *
     * @return
     * @throws Exception 
     */
    @RequestMapping("/goAddcitydept")
    public ModelAndView goAddcitydept() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> cityList = cityService.findCityById(pd);
        List<PageData> deptList = cityService.findDeptById(pd);
        mv.setViewName("system/city/citydept_edit");
        mv.addObject("msg", "addcitydept");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        mv.addObject("cityList",cityList);
        mv.addObject("deptList",deptList);
        mv.addObject("userpds", pds);
        return mv;
    }
    
    /**
     * 添加城市公司
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "addcitydept")
	public ModelAndView addcitydept() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			//城市和公司的对应关系是否存在重复
			List<PageData> list = cityService.existsCityDeptName(pd);
			if (list.isEmpty()) {
				cityService.cityDeptAdd(pd);
				System.out.println("添加成功");
				mv.addObject("msg", "success");
	    	}
		}catch(Exception e){
			e.printStackTrace();
			mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
		}
		
		mv.addObject("id", "addcitydept");
		mv.addObject("form", "citydeptForm");
	    mv.setViewName("save_result");
		return mv;
	}
	
	  /**
     * 编辑公司管辖区域页面
     *
     * @return
     * @throws Exception 
     */
    @RequestMapping("/goEditcitydept")
    public ModelAndView goEditcitydept() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> cityList = cityService.findCityById(pd);
        List<PageData> deptList = cityService.findDeptById(pd);
        mv.setViewName("system/city/citydept_edit");
        mv.addObject("msg", "editcitydept");
        mv.addObject("pd", pd);
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        mv.addObject("cityList",cityList);
        mv.addObject("deptList",deptList);
        mv.addObject("userpds", pds);
        return mv;
    }
    
    
    /**
     * 编辑公司管辖区域
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editcitydept")
    public ModelAndView editcitydept() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	//区县名称是否存在重复
    	List<PageData> list = cityService.existsCityDeptName(pd);
    	if(list.isEmpty()){
    		cityService.cityDeptAdd(pd);
    		mv.addObject("id", "editcitydept");
    		mv.addObject("form", "citydeptForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("id", "editcitydept");
    		mv.addObject("form", "citydeptForm");
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
            
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    /**
     * 添加区县
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "addCounty")
	public ModelAndView addCounty() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			//区县名称是否存在重复
			List<PageData> list = cityService.existsCountyName(pd);
			if (list.isEmpty()) {
				cityService.countyAdd(pd);
				mv.addObject("msg", "success");
	    	}
		}catch(Exception e){
			e.printStackTrace();
			mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
		}
		
		mv.addObject("id", "AddCounty");
		mv.addObject("form", "countyForm");
	    mv.setViewName("save_result");
		return mv;
	}
    
    /**
     * 跳到区县编辑页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goEditCounty")
    public ModelAndView goEditCounty() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> cityList = cityService.findCityById(null);
        List<PageData> countyList = cityService.findCountyById(pd);
        mv.setViewName("system/city/county_edit");
        mv.addObject("pd", countyList.get(0));
        mv.addObject("cityList", cityList);
        mv.addObject("msg", "editCounty");
        return mv;
    }
    
    /**
     * 编辑区县
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editCounty")
    public ModelAndView editCounty() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	//区县名称是否存在重复
		List<PageData> list = cityService.existsCountyName(pd);
    	if(list.isEmpty()){
    		cityService.countyUpdate(pd);
    		mv.addObject("id", "EditCounty");
    		mv.addObject("form", "countyForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "editCounty");
            mv.addObject("pd", pd);
            mv.setViewName("system/city/county_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    
    /**
     * 删除区县
     *
     */
    @RequestMapping("/delCounty")
    @ResponseBody
    public Object delCounty() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
        	
    		cityService.countyDeleteById(pd);
            map.put("msg", "success");

            
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 删除城市公司对应关系
     *
     */
    @RequestMapping("/delcitydept")
    @ResponseBody
    public Object delcitydept() {
        Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        try {
        	
    		cityService.citydeptDeleteById(pd);
            map.put("msg", "success");

            
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
	@RequestMapping(value = "findAllCityByProvinceId")
	@ResponseBody
	public Object findAllCityByProvinceId() throws Exception{
		JSONArray result = new JSONArray();
		PageData pd = this.getPageData();
		List<PageData> cityList = cityService.findAllCityByProvinceId(pd);
		result.addAll(cityList);
		return result;
	}
	
	@RequestMapping(value = "findAllCountyByCityId")
	@ResponseBody
	public Object findAllCountyByCityId() throws Exception{
		JSONArray result = new JSONArray();
		PageData pd = this.getPageData();
		List<PageData> countyList = cityService.findAllCountyByCityId(pd);
		result.addAll(countyList);
		return result;
	}
	
	 /**
		 *导出到Excel 
		 */
		@RequestMapping(value="toExcel")
		public ModelAndView toExcel(){
			PageData pd = this.getPageData();
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				//省份导出
				if(pd.get("type").equals("1")){
					titles.add("省份编号");
					titles.add("省份名称");
					dataMap.put("titles", titles);
					List<PageData> itemList = cityService.findAllProvince();
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).get("id").toString());
						vpd.put("var2", itemList.get(i).getString("name"));
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}else if(pd.get("type").equals("2")){
					//城市导出
					titles.add("城市编号");
					titles.add("城市名称");
					titles.add("省份ID");
					dataMap.put("titles", titles);
					List<PageData> itemList = cityService.findAllCityByProvinceId(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).get("id").toString());
						vpd.put("var2", itemList.get(i).getString("name"));
						vpd.put("var3", itemList.get(i).get("province_id").toString());
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}else if(pd.get("type").equals("3")){
					//区县导出
					titles.add("区县编号");
					titles.add("区县名称");
					titles.add("城市ID");
					dataMap.put("titles", titles);
					List<PageData> itemList = cityService.findAllCountyByCityId(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).get("id").toString());
						vpd.put("var2", itemList.get(i).getString("name"));
						vpd.put("var3", itemList.get(i).get("city_id").toString());
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}else if(pd.get("type").equals("4")){
					//区县导出
					titles.add("公司名称");
					titles.add("城市名称");
					dataMap.put("titles", titles);
					List<PageData> itemList = cityService.findAllCityDeptId(pd);
					List<PageData> varList = new ArrayList<PageData>();
					for(int i = 0; i < itemList.size(); i++){
						PageData vpd = new PageData();
						vpd.put("var1", itemList.get(i).get("departmentname").toString());
						vpd.put("var2", itemList.get(i).getString("cityname"));
						varList.add(vpd);
					}
					dataMap.put("varList", varList);
					ObjectExcelView erv = new ObjectExcelView();
					mv = new ModelAndView(erv, dataMap);
				}
				
				
			}catch(Exception e){
				logger.error(e.getMessage(), e);
			}
			return mv;
		}
		
		/**
		 *导入Excel到数据库 
		 */
		@RequestMapping(value="importExcel")
		@ResponseBody
		public Object importExcel(@RequestParam(value = "file") MultipartFile file){
			Map<String, Object> map = new HashMap<String, Object>();
			PageData pd = this.getPageData();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					//保存错误信息集合
	    			List<PageData> allErrList = new ArrayList<PageData>();
	    			//导入全部失败（true）
					boolean allErr=true;
					PageData pds = new PageData();
					//省份导入
					if(pd.get("type").equals("1")){
						List<PageData> errList = new ArrayList<PageData>();
						for(int i = 0;i<listPd.size();i++)
						{
						    //根据省份name获取省份信息
							String name =listPd.get(i).getString("var0");
							PageData provincePd=new PageData();
							provincePd.put("name", name);
							if(name==null || name.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "省份名称不能为空!");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
							else
							{
								PageData province=cityService.findProvinceByName(provincePd);
								if(province!=null)
								{
									//保存具体的字段的错误信息
					        		PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "省份名称重复!");
			    	        		errPd.put("errCol", "1");
			    	        		errPd.put("errRow", i+1);
			    	        		errList.add(errPd);
								}
							}
							//如果不存在错误执行保存操作
							if(errList.size()==0)
							{
								allErr = false;
								pds.put("name",name);//
								//保存省份名称至数据库
								cityService.provinceAdd(pds);
							}
							else
							{
								for(PageData dataPd : errList){
				        			allErrList.add(dataPd);
				        		}
							}
						}
						
					}else if(pd.get("type").equals("2")){
						List<PageData> errList = new ArrayList<PageData>();
						for(int i = 0;i<listPd.size();i++){
							String CityName = listPd.get(i).getString("var0");//城市名称
							String provinceName =listPd.get(i).getString("var1");//省份名称
							PageData province = null;
							PageData city = null;
							//判断城市名称是否为空
							if(CityName==null || CityName.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "城市名称不能为空");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							//判断省份名称是否为空
							if(provinceName==null || provinceName.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "省份名称不能为空");
		    	        		errPd.put("errCol", "2");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							else
							{
								//根据省份name获取省份信息
								PageData provincePd=new PageData();
								provincePd.put("name", provinceName);
								province=cityService.findProvinceByName(provincePd);
								if(province==null)
								{
									PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "省份名称不存在");
			    	        		errPd.put("errCol", "2");
			    	        		errPd.put("errRow", "第"+(i+1)+"行");
			    	        		errList.add(errPd);
								}
								else
								{
									//根据城市name获取城市信息
									PageData cityPd=new PageData();
									cityPd.put("name", CityName);
									cityPd.put("province_id", province.get("id").toString());
									city=cityService.findCityByName(cityPd);
									if(city!=null)
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "城市名称重复");
				    	        		errPd.put("errCol", "1");
				    	        		errPd.put("errRow", "第"+(i+1)+"行");
				    	        		errList.add(errPd);
									}
								}
							}
							
							if(errList.size()==0)
							{
								allErr = false;
								pds.put("province_id", province.get("id").toString());
								pds.put("name",CityName);
								//保存城市名称至数据库
								cityService.cityAdd(pds);
							}
							else
							{
								for(PageData dataPd : errList){
				        			allErrList.add(dataPd);
				        		}
							}
						}
					}else if(pd.get("type").equals("3")){
						List<PageData> errList = new ArrayList<PageData>();
						for(int i = 0;i<listPd.size();i++){
							String countyName=listPd.get(i).getString("var0");//区县名称
							String name=listPd.get(i).getString("var1");//城市名称
							PageData city=null;
							PageData county=null;
							//判断区县名称是否为空
							if(countyName==null || countyName.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "区县名称不能为空");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							//判断城市名称是否为空
							if(name == null || name.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "城市名称不能为空");
		    	        		errPd.put("errCol", "2");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							else
							{
								//根据城市name获取城市信息
								PageData cityPd=new PageData();
								cityPd.put("name", name);
								city=cityService.findCityByName2(cityPd);
							    if(city==null)
							    {
							    	PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "城市名称不存在");
			    	        		errPd.put("errCol", "2");
			    	        		errPd.put("errRow", "第"+(i+1)+"行");
			    	        		errList.add(errPd);
							    }
							    else
							    {
							    	//根据城市id和区县name获取信息
									PageData countyPd=new PageData();
									countyPd.put("countyName", countyName);
									countyPd.put("city_id", city.get("id").toString());
									county=cityService.findCountyByName(countyPd);
									if(county!=null)
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "区县名称重复");
				    	        		errPd.put("errCol", "1");
				    	        		errPd.put("errRow", "第"+(i+1)+"行");
				    	        		errList.add(errPd);
									}
							    }
							}
							
							if(errList.size()==0)
							{
								allErr = false;
								pds.put("city_id", city.get("id").toString());//
								pds.put("name", countyName);//
								//保存省份名称至数据库
								cityService.countyAdd(pds);
							}
							else
							{
								for(PageData dataPd : errList){
				        			allErrList.add(dataPd);
				        		}
							}
						}
					}else if(pd.get("type").equals("4")){
						List<PageData> errList = new ArrayList<PageData>();
						for(int i = 0;i<listPd.size();i++){
							String countyName=listPd.get(i).getString("var0");//公司名称
							String name=listPd.get(i).getString("var1");//城市名称
							PageData city=null;
							PageData department=null;
							PageData county=null;
							//判断区县名称是否为空
							if(countyName==null || countyName.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "公司名称不能为空");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							//判断城市名称是否为空
							if(name == null || name.equals(""))
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "城市名称不能为空");
		    	        		errPd.put("errCol", "2");
		    	        		errPd.put("errRow", "第"+(i+1)+"行");
		    	        		errList.add(errPd);
							}
							else
							{
								//根据城市name获取城市信息
								PageData cityPd=new PageData();
								cityPd.put("name", name);
								city=cityService.findCityByName2(cityPd);
								//根据城市countyName获取公司信息  select * from tb_department;
								PageData departmentPd=new PageData();
								departmentPd.put("countyName", countyName);
								department=cityService.findCityByName3(departmentPd);

							    if(city==null||department==null)
							    {
							    	PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "城市、公司名称不存在");
			    	        		errPd.put("errCol", "2");
			    	        		errPd.put("errRow", "第"+(i+1)+"行");
			    	        		errList.add(errPd);
							    }
							    else
							    {
							    	//根据城市id和区县name获取信息
									PageData countyPd=new PageData();
									countyPd.put("dept_id", department.get("id").toString());
									countyPd.put("city_id", city.get("id").toString());
									List<PageData> list = cityService.existsCityDeptName(countyPd);
									if(!list.isEmpty())
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "城市、公司名称重复");
				    	        		errPd.put("errCol", "1");
				    	        		errPd.put("errRow", "第"+(i+1)+"行");
				    	        		errList.add(errPd);
									}
							    }
							}
							
							if(errList.size()==0)
							{
								allErr = false;
								pds.put("city_id", city.get("id").toString());//
								pds.put("dept_id", department.get("id").toString());//
								//保存省份名称至数据库
								cityService.cityDeptAdd(pds);
							}
							else
							{
								for(PageData dataPd : errList){
				        			allErrList.add(dataPd);
				        		}
							}
						}
					}
					
					//↑↑↑----------导入完成------------↑↑↑
					//判断总错误数
					if(allErrList.size()==0){
		    			map.put("msg", "success");
					}else{
						if(allErr){
							//导入全部失败
		        			map.put("msg", "allErr");
						}else{
							//部分导入成功，部分导入失败
							map.put("msg", "error");
						}
						//执行完操作之后抛出报错集合
		    			String errStr = "";
		    			errStr += "总错误:"+allErrList.size();
		    			for(PageData forPd : allErrList){
		    				errStr += "\n错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
		    			}
		    			map.put("errorUpload", errStr);
					}
					
		    	}else{
		    		map.put("msg", "exception");
		    		map.put("errorMsg", "上传失败,没有数据！");
		    	}
			}catch(Exception e){
				logger.error(e.getMessage(), e);
				map.put("msg", "exception");
				map.put("errorUpload", "系统错误，请稍后重试！");
			}
			return JSONObject.fromObject(map);
		}
}

