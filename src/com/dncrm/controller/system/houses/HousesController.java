package com.dncrm.controller.system.houses;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.cell.CellService;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.houses.HousesService;
import com.dncrm.util.*;
import com.dncrm.util.echarts.Echarts;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.github.abel533.echarts.json.GsonOption;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/houses")
@Controller
public class HousesController extends BaseController {
	@Resource(name = "housesService")
	private HousesService housesService;
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	@Resource(name="cityService")
	private CityService cityService;
	@Resource(name = "cellService")
	private CellService cellService;
	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;

	
	//保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
	
	
	/**
	 * 显示楼盘基本信息
	 *
	 * @return
	 */
	@RequestMapping("/houses")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		 //获取系统当前登陆人
		/*Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
	    String user_id=user.getUSERNAME();*/
	    Date dt=new Date();
	    SimpleDateFormat matter3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String thisTime= matter3.format(dt);//当前系统时间
		try {
			List<String> userList = new ArrayList<String>();
			userList = getRoleSelect();
			PageData pd = this.getPageData();
			
			Integer roleType = Integer.parseInt(getRoleType());
			pd.put("roleType", roleType);
			pd.put("userList", userList);
			pd.put("thisTime",thisTime );//系统当前时间
			page.setPd(pd);
			/*List<PageData> housesList = housesService.listPdPageHouses(page);*/
			List<PageData> housesList = housesService.listPdPageHousesByRole(page);
			if (!housesList.isEmpty()) {
				for (PageData hou : housesList) {
					ArrayList<Date> time=new ArrayList<Date>();
					ArrayList<Date> time_2=new ArrayList<Date>();
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					String delivery=hou.getString("delivery");//获取楼盘交房信息
					JSONArray jsonArray = JSONArray.fromObject(delivery);
                    for(int i=0;i<jsonArray.size();i++)
                    {
                    	JSONObject jsonObj = jsonArray.getJSONObject(i);
                    	String modified_time=jsonObj.getString("delivery_time");//获取交房时间
                    	Date date = sdf.parse(modified_time);
                    	
     					Calendar cal=Calendar.getInstance();
     					cal.setTime(sdf.parse(modified_time));
     					long time1=cal.getTimeInMillis();//交房时间
     					cal.setTime(sdf.parse(thisTime));
     					long time2=cal.getTimeInMillis();//系统当前时间
     					long between_days=(time1-time2)/(1000*3600*24);
     					if(between_days>0 && between_days<90)
     					{
     						time.add(date);
     					}
     					else
     					{
     						time_2.add(date);
     					}
                    }
                    Collections.sort(time);  //给交房日期排序从小到大
                    Collections.sort(time_2);//给交房日期排序从小到大
                    if(time.size()>0 && time_2.size()>0)
                    {
                    	hou.put("time",1);
                    	String delivery_time=sdf.format(time.get(0));  
                        hou.put("delivery_time",delivery_time);
                    }
                    else if(time.size()>0)
                    {
                    	hou.put("time",1);
                    	String delivery_time=sdf.format(time.get(0));  
                        hou.put("delivery_time",delivery_time);
                    }
                    else if(time_2.size()>0)
                    {
                    	int a=time_2.size()-1;
                    	hou.put("time",0);
                    	String delivery_time2=sdf.format(time_2.get(a));  
                        hou.put("delivery_time",delivery_time2);
                    }
                    else
                    {
                    	hou.put("time",0);
                        hou.put("delivery_time",null);
                    }
				}
			}
			mv.setViewName("system/houses/houses");
			mv.addObject("housesList", housesList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 跳到编辑页面
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goEditS")
	public ModelAndView goEditS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		try {
			//加载区域列表
	        List<PageData> area = departmentService.findAllAreaNode();
	        //获取所有区域节点和父级节点
	        List<PageData> areas = getAreaLists(area);
	        if (areas.size() > 0) {
	            //构建多叉数
	            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	            MultipleTree tree = new MultipleTree();
	            dataList = ConvertPageDataToList.make(areas);
	            Node node = tree.makeTreeWithOderNo(dataList, 1);
	            mv.addObject("areas", node);
	        }else{
	        	mv.addObject("areas", areas);
	        }
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			mv.addObject("coundtyList", coundtyList);
			//查询楼盘信息
			pd = housesService.findHousesById(pd);
			mv.setViewName("system/houses/houses_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
			List<PageData> typeList = housesService.housesTypeList(getPage()); // 加载楼盘类型
			mv.addObject("typeList", typeList);
			List<PageData> statusList = housesService.housesStatusList(getPage()); // 加载楼盘状态
			mv.addObject("statusList", statusList);
			List<PageData> ordinaryList = housesService.ordinarylistPage(getPage()); // 加载开发商信息
			mv.addObject("ordinaryList", ordinaryList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 *显示所属该楼盘的户型信息
	 * @return
	 */
	@RequestMapping("/houseType")
	public ModelAndView houseTypelistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> housetypeList = housesService.houseTypelistPage(page);
			mv.setViewName("system/houseType/houseType");
			mv.addObject("housetypeList", housetypeList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "houses");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 *显示所属该楼盘的单元信息
	 * @return
	 */
	@RequestMapping("/cell")
	public ModelAndView cellListPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> cellList = housesService.cellListPage(page);
			mv.setViewName("system/houses/houses_cell");
			mv.addObject("cellList", cellList);
			mv.addObject("pd", pd);
			/*mv.addObject("msg", "houses");*/
			mv.addObject("msg", "houseType");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 跳到单元添加页面 并且加载需要的数据到页面
	 * @return
	 */
	@RequestMapping("/goAddCell")
	public ModelAndView goAddCell() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		Date dt=new Date();
		SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	    String time= matter1.format(dt);
		int number=(int)((Math.random()*9+1)*100000);
		String cell_id=("DNC"+time+number);
		pd.put("cell_id", cell_id);
		pd.put("houses_id", pd.getString("houses_no"));
		mv.addObject("pd", pd);
		try { 
			List<PageData> houseTypeList = cellService.findhouseTypeById(pd);// 加载属于该楼盘的户型信息
			/*List<PageData> houseTypeList = cellService.houseTypelistPage(getPage());*/// 加载户型信息
			mv.addObject("houseTypeList", houseTypeList);
			List<PageData> housesList = cellService.listPdPageHouses(getPage());// 加载楼盘信息
			mv.addObject("housesList", housesList);
			List<PageData> wellList = cellService.welllistPage(getPage());// 加载井道信息
			mv.addObject("wellList", wellList);
		    List<PageData> competitorList = cellService.competitorList(getPage());// 加载竞争对手信息
			mv.addObject("competitorList", competitorList);
			List<PageData> merchantList = cellService.MerchantlistPage(getPage());// 加载小业主信息
			mv.addObject("merchantList", merchantList);
			mv.setViewName("system/cell/cell_edit");
			mv.addObject("msg", "saveS");
			mv.addObject("cell", "houses");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 * 跳到查看
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goEditSa")
	public ModelAndView goEditSa() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			mv.addObject("coundtyList", coundtyList);
			List<PageData> typeList = housesService.housesTypeList(getPage()); // 加载楼盘类型
			mv.addObject("typeList", typeList);
			List<PageData> statusList = housesService.housesStatusList(getPage()); // 加载楼盘状态
			mv.addObject("statusList", statusList);
			pd = housesService.findHousesById(pd);
			mv.setViewName("system/houses/houses_check");
			mv.addObject("pd", pd);
		
	} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}


	/**
	 * 跳到添加页面 并且加载需要的数据到页面
	 * 
	 * @return
	 */
	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		mv.setViewName("system/houses/houses_edit");
		mv.addObject("msg", "saveS");

		 Date dt=new Date();
	     SimpleDateFormat matter1=new SimpleDateFormat("yyyyMM");
	     String time= matter1.format(dt);
	    int number=(int)((Math.random()*9+1)*100);
	    String delivery_id=(time+number);
		pd.put("delivery_id", delivery_id);
		mv.addObject("pd", pd);
		try {
			//加载区域列表
	        List<PageData> area = departmentService.findAllAreaNode();
	        //获取所有区域节点和父级节点
	        List<PageData> areas = getAreaLists(area);
	        if (areas.size() > 0) {
	            //构建多叉数
	            List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	            MultipleTree tree = new MultipleTree();
	            dataList = ConvertPageDataToList.make(areas);
	            Node node = tree.makeTreeWithOderNo(dataList, 1);
	            mv.addObject("areas", node);
	        }else{
	        	mv.addObject("areas", areas);
	        }
	        parentDepartments.clear();
			List<PageData> typeList = housesService.housesTypeList(getPage()); // 加载楼盘类型
			mv.addObject("typeList", typeList);
			List<PageData> statusList = housesService.housesStatusList(getPage()); // 加载楼盘状态
			mv.addObject("statusList", statusList);
			List<PageData> ordinaryList = housesService.ordinarylistPage(getPage()); // 加载开发商信息（普通客户）
			mv.addObject("ordinaryList", ordinaryList);
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			mv.addObject("coundtyList", coundtyList);
			} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 删除一条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/delShop")
	@ResponseBody
	public Object delShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			housesService.deleteHouses(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 删除多条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/deleteAllS")
	@ResponseBody
	public Object delShops() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String houses_nos = (String) pd.get("houses_nos");
			for (String houses_no : houses_nos.split(",")) {
				pd.put("houses_no", houses_no);
				housesService.deleteHouses(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	
	
	/**
	 * 判断楼盘名称是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/HousesName")
	@ResponseBody
	public Object HousesName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = housesService.findHousesByName(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 * 判断楼盘地址是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/HousesAddress")
	@ResponseBody
	public Object HousesAddress() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = housesService.findHousesByAddress(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	
	

	/**
	 * 保存新增
	 *
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
	
		 //获取系统当前登陆人
		Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
	    String user_name=user.getUSERNAME();
	    String user_id=user.getUSER_ID();
	    
	    Date dt=new Date();
	    SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	    String time= matter1.format(dt);
	    int number=(int)((Math.random()*9+1)*100000);
	    String houses_no=("DNH"+time+number);
	    SimpleDateFormat matter3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String entering_time= matter3.format(dt);
	    //获取系统时间
		String df=DateUtil.getTime().toString();
		try {
			pd = this.getPageData();
			pd.put("modified_time", df);       
			pd.put("entering_time", entering_time);    //录入时间
			pd.put("modified_by", user_name);
			pd.put("houses_no", houses_no);
			pd.put("input_user", user_id);
			PageData shop = housesService.findHousesById(pd);
			if (shop != null) {// 判断门店编号
				mv.addObject("msg", "failed");
			} else {
				housesService.saveS(pd);   //保存楼盘基本信息 
				mv.addObject("msg", "success");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}

	/**
	 * 保存编辑
	 *
	 * @return
	 */
	@RequestMapping("/editS")
	public ModelAndView editS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		
		 Subject currentUser = SecurityUtils.getSubject();
         Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
	    String user_id=user.getUSERNAME();
		String df=DateUtil.getTime().toString();
	
		try {
			pd = this.getPageData();
			pd.put("modified_time", df);       //修改时间
			pd.put("modified_name", user_id);  //修改人
			PageData shop = housesService.findHousesById(pd);
			if (shop == null) {// 判断这个编号是否存在
				mv.addObject("msg", "failed");
			} else {
			housesService.editS(pd);
			mv.addObject("msg", "success");
			}
		} 
		catch (Exception e)
		{
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}

	
	 /**
		 * 根据开发商ID加载开发商详细信息 （客户中的 “普通客户”）
		 * @return
		 */
		@RequestMapping("/checkedcomp")
		@ResponseBody
		public JSONObject checkedcomp(@RequestParam(value = "customer_id")String customer_id) {
			JSONObject result = new JSONObject();
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				pd=  housesService.findcustomerOrdinaryById(pd);
				result.put("ordinary", pd);
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			return result;
		}

		
		 /**
		 * 加载开发商（客户中的 “普通客户”）
		 * @return
		 */
		@RequestMapping("/comp")
		@ResponseBody
		public JSONObject compList() {
			JSONObject result = new JSONObject();
			PageData pd = new PageData();
			try
			{
				List<PageData> ordinaryList = housesService.ordinarylistPage(getPage()); // 加载开发商信息
				result.put("ordinaryList", ordinaryList);
			}
			catch (Exception e) 
			{
				logger.error(e.toString(), e);
			}
			return result;
		}
		
	/**
	 *点击区域输入框节点查询该节点是否是区域节点 
	 * @throws Exception 
	 */
	@RequestMapping("/checkAreaNode")
	@ResponseBody
	public Object checkAreaNode(@RequestParam(value = "id") String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd.put("id", id);
		pd = departmentService.getDepartmentById(pd).get(0);
		if(((String)pd.get("type")).equals("8")){
			map.put("msg", "success");
		}else{
			map.put("msg", "faild");
		}
		JSONObject obj = JSONObject.fromObject(map);
		return obj;
	}
    
	
    /**
     *递归获取所有父节点 
     */
    public List<PageData> getAllParentDepartments(PageData pd)throws Exception{
    	PageData parentPd = departmentService.findAllParentDepartments(pd);
    	if(parentPd!=null){
    		parentDepartments.add(parentPd);
    		getAllParentDepartments(parentPd);
    	}
    	return parentDepartments;
    }

    /**
     *获取区域列表 
     * @throws Exception 
     */
    public List<PageData> getAreaLists(List<PageData> pds) throws Exception{
    	for(PageData pd : pds){
    		getAllParentDepartments(pd);
    		parentDepartments.add(pd);
    	}
    	return parentDepartments;
    }
  
    /**
     * 异步上传
     * @param file
     * @return
     */
    @RequestMapping(value = "/upload")
    @ResponseBody
    public Object upload(@RequestParam(value = "file") MultipartFile file){
    	String ffile=DateUtil.getDay(),fileName="";
    	JSONObject result = new JSONObject();
    	if(file!=null && !file.isEmpty()){
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"houses/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "houses/" + ffile + "/" + fileName);   //houses是存放上传的文件的文件夹
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }

	
    /**
     * 下载文件
     */
    @RequestMapping(value = "/down")
    public void downExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String downFile = request.getParameter("downFile");
        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + downFile, downFile);
    }

    
	/* ===============================报表统计================================*/
    @RequestMapping(value="housesInfo")
	public ModelAndView reportInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			mv.setViewName("system/houses/housesInfo");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
    
    
    /**
	 *set by month 
	 */
	@RequestMapping(value="setByType",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Object setByType(){
		PageData pd = new PageData();
		GsonOption option = new GsonOption();
		Echarts echarts = new Echarts();
		try{
			pd = this.getPageData();
			List<PageData> list = new ArrayList<PageData>();
			String type = pd.get("type").toString();
			String xAxisName = "";
			String yAxisName = "num";
			if(type.equals("year")){
				list = housesService.housesNum();
				xAxisName="(年)";
			}else if(type.equals("month")){
				String year = new SimpleDateFormat("yyyy").format(new Date());
				list = housesService.housesMonthNum(year);
				echarts.setXAxisMonth(option);
				xAxisName="(月份)";
			}else if(type.equals("quarter")){
				String year = new SimpleDateFormat("yyyy").format(new Date());
				list = housesService.housesQuarterNum(year);
				echarts.setXAxisQuarter(option);
				xAxisName="(季度)";
			}
			Map<String, String> legendMap = new HashMap<String, String>();
			legendMap.put("category", "date");
			legendMap.put("楼盘数量", "housesNum");
			legendMap.put("东南安装", "cellNumDN001");
			legendMap.put("对手安装", "cellNum");
			option = echarts.setOption(list, legendMap);
			echarts.setYAxisName(option, yAxisName);
			echarts.setXAxisName(option, xAxisName);
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return option.toString();
	}
	
	
	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("楼盘编号");
			titles.add("楼盘所属区域");
			titles.add("楼盘名称");
			titles.add("楼盘地址");
			titles.add("物业公司名称");
			titles.add("物业公司联系人");
			titles.add("物业公司电话");
			titles.add("物业公司传真");
			titles.add("物业公司邮箱");
			titles.add("物业公司邮编");
			titles.add("楼盘类型");
			titles.add("开发公司名称");
			titles.add("开发公司地址");
			titles.add("开发公司电话");
			titles.add("开发公司邮箱");
			titles.add("开发公司传真");
			titles.add("开发公司联系人");
			titles.add("开发公司联系人电话");
			titles.add("楼盘状态");
			titles.add("楼盘相关项目");
			titles.add("备注");
			titles.add("录入人");
			titles.add("录入时间");
			titles.add("服务网点");
			titles.add("所属省份");
			titles.add("所属城市");
			titles.add("所属区县");
			titles.add("详细地址");
			titles.add("楼盘效果图");
			titles.add("别墅数量");
			titles.add("修改人名称");
			titles.add("修改时间");
			titles.add("户数");
			titles.add("录入人ID");
			titles.add("楼盘风格");
			titles.add("楼盘交房序号");
			titles.add("楼盘交房信息");
			titles.add("是否有样板梯");
			dataMap.put("titles", titles);
			
			List<PageData> itemList = housesService.findHousesList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("houses_no"));
				vpd.put("var2", itemList.get(i).getString("dname"));
				vpd.put("var3", itemList.get(i).getString("houses_name"));
				vpd.put("var4", itemList.get(i).getString("houses_address"));
				vpd.put("var5", itemList.get(i).getString("houses_phone"));
				vpd.put("var6", itemList.get(i).getString("houses_contacts"));
				vpd.put("var7", itemList.get(i).getString("houses_con_phone"));
				vpd.put("var8", itemList.get(i).getString("houses_faxes"));
				vpd.put("var9", itemList.get(i).getString("houses_email"));
				vpd.put("var10", itemList.get(i).getString("houses_postcode"));
				vpd.put("var11", itemList.get(i).getString("type_name"));
				vpd.put("var12", itemList.get(i).getString("customer_name"));
				vpd.put("var13", itemList.get(i).getString("houses_dev_address"));
				vpd.put("var14", itemList.get(i).getString("houses_dev_phone"));
				vpd.put("var15", itemList.get(i).getString("houses_dev_email"));
				vpd.put("var16", itemList.get(i).getString("houses_dev_faxes"));
				vpd.put("var17", itemList.get(i).getString("houses_dev_contacts"));
				vpd.put("var18", itemList.get(i).getString("houses_dev_con_phone"));
				vpd.put("var19", itemList.get(i).getString("status_name"));
				vpd.put("var20", itemList.get(i).getString("houses_relevantProject"));
				vpd.put("var21", itemList.get(i).getString("remarks"));
				vpd.put("var22", itemList.get(i).getString("modified_by"));
				vpd.put("var23", itemList.get(i).getString("modified_time"));
				vpd.put("var24", itemList.get(i).getString("sales_point"));
				vpd.put("var25", itemList.get(i).getString("pname"));
				vpd.put("var26", itemList.get(i).getString("lciname"));
				vpd.put("var27", itemList.get(i).getString("lconame"));
				vpd.put("var28", itemList.get(i).getString("address_name"));
				vpd.put("var29", itemList.get(i).getString("house_type_img"));
				vpd.put("var30", itemList.get(i).getString("villadom_num"));
				vpd.put("var31", itemList.get(i).getString("modified_name"));
				vpd.put("var32", itemList.get(i).getString("entering_time"));
				vpd.put("var33", itemList.get(i).getString("households"));
				vpd.put("var34", itemList.get(i).getString("input_user"));
				String houses_style=itemList.get(i).getString("houses_style");
				if(houses_style.equals("1"))
				{
					vpd.put("var35", "法式");
				}else if(houses_style.equals("2"))
				{
					vpd.put("var35", "中式");
				}else if(houses_style.equals("3"))
				{
					vpd.put("var35", "欧式");
				}else if(houses_style.equals("4"))
				{
					vpd.put("var35", "现代");
				}else if(houses_style.equals("5"))
				{
					vpd.put("var35", "美式");
				}
				vpd.put("var36", itemList.get(i).getString("delivery_id"));
				vpd.put("var37",itemList.get(i).getString("delivery"));
				String is_templet=itemList.get(i).getString("is_templet");
				vpd.put("var38", is_templet.equals("0")?"是":"否");
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
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
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				
				//保存全部错误信息集合
    			List<PageData> allErrList  = new ArrayList<PageData>();
				PageData pd = new PageData();
				//导入全部失败（true）
				boolean allErr=true;
				for(int i = 0;i<listPd.size();i++)
				{
					boolean boolHouses=true;
					//保存本次for数据错误结合
					List<PageData> errList  = new ArrayList<PageData>();
					//所属区域-----------------验证
					String customer_area_ordinary =listPd.get(i).getString("var0");
					if(customer_area_ordinary==null || customer_area_ordinary.equals(""))
					{
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "区域不能为空！");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					else
					{
						PageData quyuPd=new PageData();
						quyuPd.put("Department_name", customer_area_ordinary);
						PageData quyu=housesService.findDepartmentByName(quyuPd);
						if(quyu!=null)
						{
							boolHouses=true;
				        	pd.put("customer_area_ordinary", quyu.get("id").toString());//区域
						}
						else
						{
							boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "区域不存在！");
	    	        		errPd.put("errCol", "1");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					
					//楼盘名称----------------验证
					PageData housesPd=new PageData();
					String houses_name =listPd.get(i).getString("var1");
					if(houses_name==null || houses_name.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "楼盘名称不能为空！");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					else
					{
					    PageData houses=new PageData();
					    houses.put("houses_name", houses_name);
						housesPd = housesService.findHousesByName(houses);
						if(housesPd==null)
						{
							boolHouses=true;
						}
						else
						{
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "楼盘名称已存在！");
	    	        		errPd.put("errCol", "2");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					
					//楼盘地址----------------验证
					PageData dizhi=new PageData();
					String province_name=listPd.get(i).getString("var21");
					String city_name=listPd.get(i).getString("var22");
					String county_name=listPd.get(i).getString("var23");
					if(province_name!=null && !province_name.equals("") && city_name!=null && !city_name.equals("") && county_name!=null && !county_name.equals(""))
					{
						PageData dizhiPd=new PageData();
						dizhiPd.put("province_name", province_name);
						dizhiPd.put("city_name", city_name);
						dizhiPd.put("county_name", county_name);
						dizhi=housesService.findProvinceByName(dizhiPd);
						if(dizhi!=null)
						{
							boolHouses=true;
						}
						else
						{
							boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "地址不存在！");
	    	        		errPd.put("errCol", "22-24");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					else
					{
						//保存具体的字段的错误信息
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "地址(省，市，区县)不能为空！");
    	        		errPd.put("errCol", "22-24");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//楼盘状态----------------验证
					PageData status=new PageData();
					String status_name=listPd.get(i).getString("var17");
					if(status_name!=null && !status_name.equals(""))
					{
						PageData statusPd=new PageData();
						statusPd.put("status_name", status_name);
						status=housesService.findHousesStatusByName(statusPd);
						if(status!=null)
						{
							boolHouses=true;
						}
						else
						{
							boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "楼盘状态不存在！");
	    	        		errPd.put("errCol", "18");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "楼盘状态不能为空！");
    	        		errPd.put("errCol", "18");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//别墅数量----------------验证
					String villadom_num=listPd.get(i).getString("var26");
					if(villadom_num==null || villadom_num.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "别墅数量不能为空！");
    	        		errPd.put("errCol", "27");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//交房日期----------------验证
					String delivery_id=listPd.get(i).getString("var31");
					String deliveryJSON=listPd.get(i).getString("var32");
					if(delivery_id==null || delivery_id.equals("") || deliveryJSON==null || deliveryJSON.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "交房序号和交房信息不能为空！");
    	        		errPd.put("errCol", "32-33");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//物业公司名称-------------验证
					String houses_phone= listPd.get(i).getString("var3");
					if(houses_phone==null || houses_phone.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "物业公司名称不能为空！");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//物业联系人 --------------验证
					String houses_contacts= listPd.get(i).getString("var4");
					if(houses_contacts==null || houses_contacts.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "物业联系人不能为空！");
    	        		errPd.put("errCol", "5");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//物业电话----------------验证
					String houses_con_phone= listPd.get(i).getString("var5");
					if(houses_con_phone==null || houses_con_phone.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "物业公司电话不能为空！");
    	        		errPd.put("errCol", "6");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//开发商公司名称-------------验证
					PageData kaifa=new PageData();
					String customer_name=listPd.get(i).getString("var10");
					if(customer_name!=null && !customer_name.equals(""))
					{
						PageData kaifaPd=new PageData();
						kaifaPd.put("customer_name", customer_name);
						kaifa =housesService.findOrdinaryByName(kaifaPd);
						if(kaifa!=null)
						{
							boolHouses=true;
						}
						else
						{
							boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "开发商不存在！");
	    	        		errPd.put("errCol", "11");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "开发商不能为空！");
    	        		errPd.put("errCol", "11");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//楼盘类型----------------验证
					PageData leixing=new PageData();
					String houses_type=listPd.get(i).getString("var9");
					if(houses_type!=null && !houses_type.equals(""))
					{
						PageData leixingPd=new PageData();
						leixingPd.put("houses_type", houses_type);
						leixing=housesService.findHousesTypeByName(leixingPd);
						if(leixing!=null)
						{
							boolHouses=true;
						}
						else
						{
							boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "楼盘类型不存在！");
	    	        		errPd.put("errCol", "10");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					//楼盘风格----------------验证
					String houses_style=listPd.get(i).getString("var30");
					if(houses_style!=null && !houses_style.equals(""))
					{
						if(houses_style.equals("法式"))
			        	{
			        		pd.put("houses_style", "1");
			        	}else if(houses_style.equals("中式"))
			        	{
			        		pd.put("houses_style", "2");
			        	}else if(houses_style.equals("欧式"))
			        	{
			        		pd.put("houses_style", "3");
			        	}
			        	else if(houses_style.equals("现代"))
			        	{
			        		pd.put("houses_style", "4");
			        	}else if(houses_style.equals("美式"))
			        	{
			        		pd.put("houses_style", "5");
			        	}else
			        	{
			        		//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "楼盘风格不存在！");
	    	        		errPd.put("errCol", "31");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
			        	}
					}
		        	//是否是样板梯----------------验证
					String is_templet=listPd.get(i).getString("var33");
					if(is_templet!=null && !is_templet.equals(""))
					{
						if(is_templet.equals("是"))
			        	{
			        		pd.put("is_templet", "0");
			        	}
			        	else if(is_templet.equals("否"))
			        	{
			        		pd.put("is_templet", "1");
			        	}
			        	else
			        	{
			        		//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "填写错误的参数，请填写是或否！");
	    	        		errPd.put("errCol", "34");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
			        	}
					}
		        	//以上验证楼盘相关字段---------- 结束
					
					//如果没有错误信息执行保存操作
					if(errList.size()==0)
					{
						 //获取系统当前登陆人
						Subject currentUser = SecurityUtils.getSubject();
				        Session session = currentUser.getSession();
						User user=(User) session.getAttribute(Const.SESSION_USER);
					    String user_id=user.getUSER_ID();
					    //生成楼盘编号
					    Date dt=new Date();
					    SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
					    String time= matter1.format(dt);
					    int number=(int)((Math.random()*9+1)*100000);
					    String houses_no=("DNH"+time+number);
					    //获取系统时间
						String df=DateUtil.getTime().toString();
						pd.put("houses_no", houses_no);
			        	pd.put("houses_name",listPd.get(i).getString("var1"));
			        	pd.put("houses_address", listPd.get(i).getString("var2"));
			        	pd.put("houses_phone", listPd.get(i).getString("var3"));
			        	pd.put("houses_contacts", listPd.get(i).getString("var4"));
			        	pd.put("houses_con_phone", listPd.get(i).getString("var5"));
			        	pd.put("houses_faxes", listPd.get(i).getString("var6"));
			        	pd.put("houses_email", listPd.get(i).getString("var7"));
			        	pd.put("houses_postcode", listPd.get(i).getString("var8"));
			        	pd.put("type_name", leixing.get("id").toString());//楼盘类型
			        	pd.put("houses_dev_name", kaifa.get("customer_id").toString());//开发商
			        	pd.put("houses_dev_address",listPd.get(i).getString("var11"));
			        	pd.put("houses_dev_phone", listPd.get(i).getString("var12"));
			        	pd.put("houses_dev_email", listPd.get(i).getString("var13"));
			        	pd.put("houses_dev_faxes", listPd.get(i).getString("var14"));
			        	pd.put("houses_dev_contacts", listPd.get(i).getString("var15"));
			        	pd.put("houses_dev_con_phone", listPd.get(i).getString("var16"));
			        	pd.put("status_name", status.get("id").toString());
			        	pd.put("houses_relevantProject", listPd.get(i).getString("var18"));
			        	pd.put("remarks", listPd.get(i).getString("var19"));
			        	pd.put("modified_by", user_id);//录入人
			        	pd.put("modified_time",df);//录入时间
			        	pd.put("sales_point", listPd.get(i).getString("var20"));
			        	pd.put("province_id", dizhi.get("lprId").toString());
			        	pd.put("city_id", dizhi.get("lciId").toString());
			        	pd.put("county_id", dizhi.get("lcoId").toString());
			        	pd.put("agent_address", listPd.get(i).getString("var24"));
			        	pd.put("house_type_img", listPd.get(i).getString("var25"));
			        	pd.put("villadom_num", listPd.get(i).getString("var26"));
			        	pd.put("modified_name", listPd.get(i).getString("var27"));
			        	pd.put("entering_time", listPd.get(i).getString("var28"));
			        	pd.put("households", listPd.get(i).getString("var29"));
			        	pd.put("input_user", user_id);//录入人ID
			        	pd.put("delivery_id", listPd.get(i).getString("var31"));
			        	pd.put("deliveryJSON", listPd.get(i).getString("var32"));
			        	
			        	allErr = false;
		        		//保存至数据库
					    housesService.saveS(pd);
					}
					else
		        	{
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}	
				}
				//↑↑↑----------循环结束------------↑↑↑
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
	    		map.put("errorUpload", "上传失败,没有数据！");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
		}
		return JSONObject.fromObject(map);
	}
	
	
	
	
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ========================================================================= */
    /* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        System.out.println("==================size: "+((List<String>)session.getAttribute(Const.SESSION_ROLE_SELECT)).size());
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
    /* ===============================用户查询权限================================== */
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    
    /* ===============================用户================================== */
}
