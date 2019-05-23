package com.dncrm.controller.system.customer;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URLDecoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dndt.qixin.Company;
import com.dndt.qixin.QiXinImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.houses.HousesService;
import com.dncrm.service.system.region.RegionService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.SelectByRole;
import com.dncrm.util.echarts.Echarts;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.github.abel533.echarts.json.GsonOption;
/**
 * 类名：CustomerController
 * 创建人：Arisu
 * 创建日期：2016年8月18日
 */
@Controller
@RequestMapping(value="/customer")
public class CustomerController extends BaseController {
	
	@Resource(name="customerService")
	private CustomerService customerService;
	@Resource(name="sysUserService")
	private sysUserService sysUserService;
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	@Resource(name="regionService")
	private RegionService regionService;
	@Resource(name="cityService")
	private CityService cityService;
	@Resource(name="housesService")
	private HousesService housesService;
	

    //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
	
	/**
	 *显示用户列表 
	 * @throws Exception 
	 */
	@RequestMapping(value="listAllCustomer")
	public ModelAndView listCustomer(Page page) throws Exception{
		
		/*SelectByRole sbr = new SelectByRole();
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());*/
		List<String> userList = getRoleSelect();
		Integer roleType = Integer.parseInt(getRoleType());
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		//将当前登录人添加至列表查询条件
		pd.put("input_user", getUser().getUSER_ID());
		pd.put("userList", userList);
		pd.put("roleType", roleType);
        page.setPd(pd);
		//List<PageData> customerList = customerService.listCustomer(page);
        List<PageData> customerList = customerService.listCustomerByRole(page);
		mv.setViewName("system/customer/customer_list");
		mv.addObject("customerList",customerList);
		mv.addObject("pd",pd);
		mv.addObject("page",page);
		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		return mv;
	}
	
	/**
	 *跳转至新增页面 
	 * @throws Exception 
	 */
	@RequestMapping(value="goAddCustomer")
	public ModelAndView goAddCustomer() throws Exception{
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        //加载地区列表
        List<PageData> regions = regionService.listAllRegions();
        JSONArray regionsObject =  JSONArray.fromObject(regions);
       //加载省份
		List<PageData> provinceList=cityService.findAllProvince();
		mv.addObject("provinceList", provinceList);
		//加载城市
		List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
		mv.addObject("cityList", cityList);
		//加载郡县
		List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
		mv.addObject("coundtyList", coundtyList);
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
        /*//加载所属公司列表
        List<PageData> companys = customerService.findAllCustomerCompany();
        JSONArray companysObject = JSONArray.fromObject(companys);*/
        //加载战略客户集团
        List<PageData> cores = customerService.listCoreCustomer();
        mv.addObject("cores", cores);
        //加载跟进业务员
        mv.addObject("respond",getUser());
        //加载集采负责人
        List<PageData> collectors = customerService.findCustomerContactCore();
        mv.addObject("collectors",collectors);
        //加载普通客户类型
        List<PageData> ordinarys = customerService.findOrdinaryTypeList();
        mv.addObject("ordinarys", ordinarys);
        //加载客户行业
        List<PageData> trades = customerService.findTradeTypeList();
        mv.addObject("trades", trades);
        //加载楼盘信息
        List<PageData> houseList = housesService.findHouseNoAndName();
        mv.addObject("houseList", houseList);
        
        mv.setViewName("system/customer/customer_edit");
        mv.addObject("msg", "saveCustomer");
        mv.addObject("input_user",getUser().getUSER_ID());
        mv.addObject("operateType","add");
        /*mv.addObject("regions",regionsObject);*/
        /*mv.addObject("companys",companysObject);*/
        mv.addObject("pd", pd);
        return mv;
	}
	
	/**
	 *跳转至修改页面 
	 * @throws Exception 
	 */
	@RequestMapping(value="goEditCustomer")
	public ModelAndView goEditCustomer() throws Exception{
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        PageData newPd  = new PageData();
        pd = this.getPageData();
        /*//加载地区列表
        List<PageData> regions = regionService.listAllRegions();
        JSONArray regionsObject =  JSONArray.fromObject(regions);*/
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
        }
        parentDepartments.clear();
        /*//加载所属公司列表
        List<PageData> companys = customerService.findAllCustomerCompany();
        JSONArray companysObject = JSONArray.fromObject(companys);*/
        //加载楼盘信息
        List<PageData> houseList = housesService.findHouseNoAndName();
        mv.addObject("houseList", houseList);
        //加载战略客户集团
        List<PageData> cores = customerService.listCoreCustomer();
        mv.addObject("cores", cores);
      //加载普通客户类型
        List<PageData> ordinarys = customerService.findOrdinaryTypeList();
        mv.addObject("ordinarys", ordinarys);
        //加载客户行业
        List<PageData> trades = customerService.findTradeTypeList();
        mv.addObject("trades", trades);
        //加载跟进业务员
        List<PageData> responds = customerService.findCustomerRespondDeveloper();
        //加载集采负责人
        List<PageData> collectors = customerService.findCustomerContactCore();
        mv.addObject("responds",responds);
        mv.addObject("collectors",collectors);
        //判断决策层是否为空
        if(pd.get("customer_type")=="Developer"||"Developer".equals(pd.get("customer_type"))){
            String decisionFlag2 = customerService.isDecisionNull(pd, "2");
            String decisionFlag3 = customerService.isDecisionNull(pd, "3");
            mv.addObject("decisionFlag2",decisionFlag2);
            mv.addObject("decisionFlag3",decisionFlag3);
        }
        mv.addObject("operateType",pd.get("operateType"));
        pd = customerService.findById(pd);
        pd = customerService.findByPd(pd);
        //加载已关联的楼盘信息
        String houseNos = pd.containsKey("house_no")?pd.get("house_no").toString():"";
        List<String> houses = new ArrayList<String>();
        if(houseNos.lastIndexOf(",")>-1){
        	for(String houseNo : houseNos.split(",")){
        		houses.add(houseNo);
        	}
        }else{
        	houses.add(houseNos);
        }
        mv.addObject("houses", houses);
        mv.setViewName("system/customer/customer_edit");
        mv.addObject("msg", "editCustomer");
        mv.addObject("customer_update_type",pd.getString("customer_type"));
        mv.addObject("editType",pd.getString("customer_type"));
        /*mv.addObject("regions", regionsObject);*/
        /*mv.addObject("companys", companysObject);*/
        mv.addObject("pd", pd);
        return mv;
	}
	
	/**
	 *修改区域节点时改变归属分公司节点列表 
	 */
	@RequestMapping(value="getBranchCompany")
	@ResponseBody
	public Object getBranchCompany(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//加载所属子公司列表
			List<PageData> branch = new ArrayList<PageData>();//所属区域全部分公司
	    	List<PageData> branch1 = departmentService.findAllBranchNodeByParentId(pd);
	    	List<PageData> branch2 = new ArrayList<PageData>();//2级
	    	List<PageData> branch3 = new ArrayList<PageData>();//3级
	    	branch.addAll(branch1);
	    	if(branch1.size()>0){//如果1级有分子公司获取二级分子公司
	    		for(PageData pda:branch1)
		    	{
		    		PageData parentPd=new PageData();
		    		parentPd.put("parentId", pda.getString("id"));
		    		List<PageData> branch_a=departmentService.findAllBranchNodeByParentId(parentPd);
		    		if(branch_a.size()>0){
		    			branch.addAll(branch_a);
		    			branch2.addAll(branch_a);
		    		}
		    	}
	    	}
	    	if(branch2.size()>0){//如果2级有分子公司获取3级分子公司
	    		for(PageData pda:branch2)
		    	{
		    		PageData parentPd=new PageData();
		    		parentPd.put("parentId", pda.getString("id"));
		    		List<PageData> branch_b=departmentService.findAllBranchNodeByParentId(parentPd);
		    		if(branch_b.size()>0){
		    			branch.addAll(branch_b);
		    			branch3.addAll(branch_b);
		    		}
		    	}
	    	}
	    	
	    	//获取所有区域节点和父级节点
	    	List<PageData> branchs = getNodeLists(branch);
	    	if (branchs.size() > 0) {
	        		//构建多叉数
	        		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
	        		MultipleTree tree = new MultipleTree();
	        		dataList = ConvertPageDataToList.make(branchs);
	        		Node node = tree.makeTreeWithOderNo(dataList, 1);
	        		map.put("branchs", node.toString());
	    	}else{
	    		map.put("branchs", branchs.toString());
	    	}
	    	parentDepartments.clear();
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *点击区域输入框节点查询该节点是否是区域节点 
	 * @throws Exception 
	 */
	@RequestMapping(value="/checkAreaNode")
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
	 *点击区域输入框节点查询该节点是否是所属公司节点 
	 * @throws Exception 
	 */
	@RequestMapping("/checkSubCompanyNode")
	@ResponseBody
	public Object checkSubCompanyNode(@RequestParam(value = "id") String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd.put("id", id);
		pd = departmentService.getDepartmentById(pd).get(0);
		if(((String)pd.get("type")).equals("10")){
			map.put("msg", "success");
		}else{
			map.put("msg", "faild");
		}
		JSONObject obj = JSONObject.fromObject(map);
		return obj;
	}
	
	/**
     * 保存新增
     *
     */
    @RequestMapping("/saveCustomer")
    public ModelAndView saveCustomer() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String addType = pd.getString("customer_add_type");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String customer_no = "KP"+((int)((Math.random()*9+1)*100000)+"");
        try {
        	if("Person".equals(addType)){	//添加个人客户
        		pd.put("input_user", getUser().getUSER_ID());
        		pd.put("customer_type", addType);
        		pd.put("customer_id", get32UUID());
        		pd.put("customer_no", customer_no);
        		customerService.saveCustomerPerson(pd);
        	}else{
	        	//放入添加操作人
	        	pd.put("input_user", getUser().getUSER_ID());
	        	//将当前登录人放入跟进业务员,集采负责人
	        	pd.put("respond_salesman_ordinary", getUser().getUSER_ID());
	        	pd.put("respond_salesman_merchant", getUser().getUSER_ID());
	        	pd.put("collector_core", getUser().getUSER_ID());
	        	//放入主键id
	        	pd.put("customer_id", get32UUID());
	        	//放入生成编号
	        	pd.put("customer_no", customer_no);
	            customerService.saveCustomer(pd,addType==null?"Ordinary":addType);
            }
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
        }
        mv.addObject("id", "EditCustomer");
        mv.addObject("form", "CustomerForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     *保存修改 
     */
    @RequestMapping("/editCustomer")
    public ModelAndView editCustomer(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        String updateType = pd.getString("customer_update_type");
        try {
        	//放入最后修改人
        	pd.put("modified_by", getUser().getUSER_ID());
        	customerService.editCustomer(pd, updateType);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "修改失败！");
        }
        mv.addObject("id", "EditCustomer");
        mv.addObject("form", "CustomerForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     *  删除一条数据
     */
    @RequestMapping("/delCustomer")
    @ResponseBody
    public Object delCustomer(){
    	Map<String,Object> map = new HashMap<String,Object>();
    	PageData pd = this.getPageData();
    	String deleteType = pd.getString("customer_delete_type");
    	Page page = this.getPage();
    	try {
        	page.setPd(pd);
			customerService.deleteCustomer(pd, deleteType);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *  批量删除数据
     */
    @RequestMapping("/delAllCustomer")
    @ResponseBody
    public Object delAllCustomer(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	String deleteType;
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String customer_ids = (String) pd.get("customer_ids");
            for (String customer_id : customer_ids.split(",")) {
            	/*deleteType = customer_id.replaceAll("\\d+", "");
                pd.put("customer_id",  customer_id.replaceAll("\\D+", ""));*/
            	deleteType = customer_id.substring(0,customer_id.lastIndexOf("_"));
            	pd.put("customer_id",  customer_id.substring(customer_id.lastIndexOf("_")+1,customer_id.length()));
                customerService.deleteCustomer(pd, deleteType);
                pd.remove("customer_id");
            }
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
        }

        return JSONObject.fromObject(map);
    }
    
    /**
     * 跳转至拜访记录页面
     * @throws Exception 
     *
     */
    @RequestMapping(value="visitCustomer")
	public ModelAndView visitCustomer(Page page) throws Exception{
    	ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		if(pd.containsKey("goway")){
			if(pd.get("goway").toString().equals("menu")){
				pd.put("customer_id", "");
				pd.put("customer_name", "");
				pd.put("customer_type", "all");
				mv.addObject("goway", "menu");
			}
		}
        page.setPd(pd);
		List<PageData> customerVisitList = customerService.listCustomerVisit(page);
		mv.setViewName("system/customer/customer_visit_list");
		mv.addObject("customerVisitList",customerVisitList);
		mv.addObject("add_customer_id",pd.getString("customer_id"));
		mv.addObject("add_customer_name",pd.getString("customer_name"));
		mv.addObject("add_customer_type",pd.getString("customer_type"));
		mv.addObject("pd",pd);
		mv.addObject("page",page);
		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		return mv;
	}
    
    /**
	 *跳转至新增拜访记录页面 
     * @throws Exception 
	 */
	@RequestMapping(value="goAddCustomerVisit")
	public ModelAndView goAddCustomerVisit() throws Exception{
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/customer/customer_visit_edit");
        List<PageData> visitCustomerList = new ArrayList<PageData>();
        String customer_type = pd.getString("add_customer_type");
        pd.put("customer_type", customer_type);
        if("Ordinary".equals(customer_type)){
        	visitCustomerList = customerService.listOrdinaryCustomer();
        }
        if("Merchant".equals(customer_type)){
        	visitCustomerList = customerService.listMerchantCustomer();
        }
        if("Core".equals(customer_type)){
        	visitCustomerList = customerService.listCoreCustomer();
        }
        List<PageData> sysUserList = sysUserService.findAllUserNotAdmin();
        mv.addObject("sysUserList",sysUserList);
        mv.addObject("coreCustomerList",visitCustomerList);
        mv.addObject("msg", "saveCustomerVisit");
        mv.addObject("operateType", "add");
        mv.addObject("pd", pd);
        return mv;
	}
	
	/**
	 * menu菜单新增拜访记录时查询所选中的客户类型
	 * @throws Exception 
	 */
	@RequestMapping(value="getCustomerList")
	@ResponseBody
	public Object getCustomerList(
				@RequestParam String visit_customer_type
			) throws Exception{
		List<PageData> customerList = new ArrayList<PageData>();
		if("Ordinary".equals(visit_customer_type)){
			customerList = customerService.listOrdinaryCustomer();
		}else if("Merchant".equals(visit_customer_type)){
			customerList = customerService.listMerchantCustomer();
		}else if("Core".equals(visit_customer_type)){
			customerList = customerService.listCoreCustomer();
		}
		JSONArray.fromObject(customerList);
		if(customerList.size()>0){
			return JSONArray.fromObject(customerList);
		}else{
			return "";
		}
	}
	
	/**
	 *跳转至修改拜访记录页面 
     * @throws Exception 
	 */
	@RequestMapping(value="goEditCustomerVisit")
	public ModelAndView goEditCustomerVisit() throws Exception{
		ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        List<PageData> sysUserList = sysUserService.findAllUserNotAdmin();
        mv.addObject("editCustomerName", pd.get("visit_customer_name").toString());
        pd = customerService.findCustomerVisitById(pd);
        pd.put("customer_type", pd.get("visit_customer_type").toString());
        String[] members = pd.getString("visit_member").split(",");
        mv.addObject("members", members);
        mv.setViewName("system/customer/customer_visit_edit");
        mv.addObject("msg", "editCustomerVisit");
        mv.addObject("sysUserList", sysUserList);
        mv.addObject("operateType", "edit");
        mv.addObject("pd", pd);
        return mv;
	}
	
	/**
     * 保存新增拜访
	 * @throws Exception 
     *
     */
    @RequestMapping("/saveCustomerVisit")
    public ModelAndView saveCustomerVisit() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            customerService.saveCustomerVisit(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
        }
        mv.addObject("id","EditCustomerVisit");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 保存新增拜访
	 * @throws Exception 
     *
     */
    @RequestMapping("/editCustomerVisit")
    public ModelAndView editCustomerVisit() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            customerService.updateCustomerVisitById(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
        }
        mv.addObject("id","EditCustomerVisit");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     *  删除一条拜访记录
     */
    @RequestMapping("/delCustomerVisit")
    @ResponseBody
    public Object delCustomerVisit(){
    	Map<String,Object> map = new HashMap<String,Object>();
    	PageData pd = this.getPageData();
    	Page page = this.getPage();
    	try {
        	page.setPd(pd);
			customerService.deleteCustomerVisitById(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *  批量删除拜访记录
     */
    @RequestMapping("/delAllCustomerVisit")
    @ResponseBody
    public Object delAllCustomerVisit(){
    	Map<String, Object> map = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String visit_ids = (String) pd.get("visit_ids");
            for (String visit_id : visit_ids.split(",")) {
            	pd.put("visit_id", visit_id);
                customerService.deleteCustomerVisitById(pd);
                pd.remove("visit_id");
            }
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
        }

        return JSONObject.fromObject(map);
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
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"Customer/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "Customer/" + ffile + "/" + fileName);
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }
    /**
     * 下载文件
     * @throws Exception 
     */
    @RequestMapping(value = "/down")
    public void downExcel(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String downFile = request.getParameter("downFile");
        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + downFile, downFile);
    }
    
    
    
    /**
     * 下载数据模板
     */
    @RequestMapping(value = "/DataModel")
    public void DataModel(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String url =URLDecoder.decode(request.getParameter("url"),"UTF-8");
    	String downFile = null;
    	String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource(""))+ "../../").replaceAll("file:/", "").replaceAll("%20", " ").trim();
    	downFile =path+url;
    	String name="数据模板.xls";
        FileDownload.fileDownload(response,downFile, name);
    }

	/**
     *检测输入客户名称 
     */
    @RequestMapping(value="/checkName")
    @ResponseBody
    public Object checkCustomerName() throws Exception{
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String, String> map = new HashMap<String, String>();
    	boolean flag = false;
    	if(pd.getString("operateType").equals("add")){
        	flag = customerService.checkCustomerName(pd);
    	}else if(pd.getString("operateType").equals("edit")){
    		flag = customerService.checkCustomerOldName(pd);
    	}
    	if(flag){
    		map.put("msg", "success");
    	}else{
    		map.put("msg", "error");
    	}
    	return JSONObject.fromObject(map);
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
     *获取指定节点列表 
     * @throws Exception 
     */
    public List<PageData> getNodeLists(List<PageData> pds) throws Exception{
    	for(PageData pd : pds){
    		getAllParentDepartments(pd);
    		parentDepartments.add(pd);
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
     *跳转到客户报表页面 
     */
    @RequestMapping(value="reportInfo")
	public ModelAndView reportInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			mv.setViewName("system/report/report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
    
    /**
	 *根据选择类型生成报表数据
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
			String year = pd.get("yearOption").toString();
			String xAxisName = "";
			String yAxisName = "(Num)";
			if(type.equals("year")){
				PageData dataPd = new PageData();
				dataPd.put("year", year);
				list = customerService.customerYearNum(dataPd);
				xAxisName="(年)";
			}else if(type.equals("month")){
				list = customerService.customerMonthNum(year);
				//option = echarts.setXAxisMonth(option);
				xAxisName="(月份)";
			}else if(type.equals("quarter")){
				list = customerService.customerQuarterNum(year);
				//option = echarts.setXAxisQuarter(option);
				xAxisName="(季度)";
			}
			Map<String, String> legendMap = new HashMap<String, String>();
			legendMap.put("category", "date");
			legendMap.put("战略客户", "coreNum");
			legendMap.put("小业主", "merchantNum");
			legendMap.put("开发商", "ordinaryNum");
			option = echarts.setOption(list, legendMap);
			echarts.setYAxisName(option, yAxisName);
			echarts.setXAxisName(option, xAxisName);
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		System.out.println(option.toString());
		return option.toString();
	}
    
    
    /**
     *获取报表统计条件查询的年份列表 
     */
    @RequestMapping(value="findReportYearList")
    @ResponseBody
    public Object findReportYearList(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<String> yearList = new ArrayList<String>();
    	try{
    		int minYear = customerService.findMinYearCustomer();
    		int maxYear = Integer.parseInt(new SimpleDateFormat("yyyy").format(new Date()));
    		for(int i = minYear;i<=maxYear;i++){
    			yearList.add(i+"");
    		}
    		map.put("yearList", yearList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *普通客户
     *导出到Excel 
     */    
    @RequestMapping(value="toExcelOrdinary")
    public ModelAndView toExcel(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			/*titles.add("客户id");*/
			titles.add("客户编号");
			titles.add("客户名称");
			titles.add("客户类型");
			titles.add("客户类型外键");
			titles.add("客户行业外键");
			titles.add("客户状态");
			titles.add("客户归属区域");
			titles.add("客户企业");
			titles.add("客户企业地址");
			titles.add("客户企业性质");
			titles.add("客户企业电话");
			titles.add("客户企业邮箱");
			titles.add("客户企业传真");
			titles.add("客户企业邮编");
			titles.add("客户企业税号");
			titles.add("客户企业开户银行");
			titles.add("银行账号");
			titles.add("客户联系人");
			titles.add("联系人职位");
			titles.add("联系人电话");
			titles.add("联系人邮件");
			titles.add("营业执照号码");
			titles.add("法人代表");
			titles.add("员工人数");
			titles.add("项目资金来源");
			titles.add("经营内容及业绩");
			titles.add("经营状况");
			titles.add("决策层1");
			titles.add("姓名1");
			titles.add("职位1");
			titles.add("电话1");
			titles.add("性别1");
			titles.add("年龄1");
			titles.add("教育背景1");
			titles.add("嗜好1");
			titles.add("生日1");
			titles.add("决策层2");
			titles.add("姓名2");
			titles.add("职位2");
			titles.add("电话2");
			titles.add("性别2");
			titles.add("年龄2");
			titles.add("教育背景2");
			titles.add("嗜好2");
			titles.add("生日2");
			titles.add("决策层3");
			titles.add("姓名3");
			titles.add("职位3");
			titles.add("电话3");
			titles.add("性别3");
			titles.add("年龄3");
			titles.add("教育背景3");
			titles.add("嗜好3");
			titles.add("生日3");
			titles.add("目前关系描述");
			titles.add("客户等级");
			titles.add("客户信用等级");
			titles.add("跟进业务员");
			titles.add("启用标志");
			titles.add("备注");
			titles.add("最后修改人");
			titles.add("最后修改时间");
			titles.add("录入时间");
			titles.add("录入人");
			/*titles.add("省份");
			titles.add("城市");
			titles.add("郡县");*/
			/*titles.add("是否核心客户");*/
			titles.add("客户归属分子公司");
			dataMap.put("titles", titles);
			
			/*List<PageData> ordinaryList = customerService.findCustomerOrdinaryList();*/
			List<PageData> ordinaryList = customerService.findCustomerOrdinaryToExcel();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < ordinaryList.size(); i++){
				PageData vpd = new PageData();
				/*vpd.put("var1", ordinaryList.get(i).getString("customer_id"));*/
				vpd.put("var1", ordinaryList.get(i).getString("customer_no"));
				vpd.put("var2", ordinaryList.get(i).getString("customer_name"));
				/*vpd.put("var4", ordinaryList.get(i).getString("customer_type"));*/
				vpd.put("var3", "普通客户");
				vpd.put("var4", ordinaryList.get(i).getString("customer_ordinary_type"));
				vpd.put("var5", ordinaryList.get(i).getString("customer_trade_excel"));
				vpd.put("var6", ordinaryList.get(i).getString("customer_status"));
				vpd.put("var7", ordinaryList.get(i).getString("customer_area_excel"));
				vpd.put("var8", ordinaryList.get(i).getString("customer_company_excel"));
				vpd.put("var9", ordinaryList.get(i).getString("company_address"));
				vpd.put("var10", ordinaryList.get(i).getString("company_property"));
				vpd.put("var11", ordinaryList.get(i).getString("company_phone"));
				vpd.put("var12", ordinaryList.get(i).getString("company_email"));
				vpd.put("var13", ordinaryList.get(i).getString("company_fax"));
				vpd.put("var14", ordinaryList.get(i).getString("company_postcode"));
				vpd.put("var15", ordinaryList.get(i).getString("company_tax"));
				vpd.put("var16", ordinaryList.get(i).getString("company_bank"));
				vpd.put("var17", ordinaryList.get(i).getString("bank_no"));
				vpd.put("var18", ordinaryList.get(i).getString("customer_contact"));
				vpd.put("var19", ordinaryList.get(i).getString("contact_duty"));
				vpd.put("var20", ordinaryList.get(i).getString("contact_phone"));
				vpd.put("var21", ordinaryList.get(i).getString("contact_email"));
				vpd.put("var22", ordinaryList.get(i).getString("business_license"));
				vpd.put("var23", ordinaryList.get(i).getString("legal_represent"));
				vpd.put("var24", ordinaryList.get(i).getString("employee_num"));
				vpd.put("var25", ordinaryList.get(i).getString("found_source"));
				vpd.put("var26", ordinaryList.get(i).getString("business_and_scope"));
				vpd.put("var27", ordinaryList.get(i).getString("business_status"));
				vpd.put("var28", ordinaryList.get(i).getString("decision_make1"));
				vpd.put("var29", ordinaryList.get(i).getString("dm_name1"));
				vpd.put("var30", ordinaryList.get(i).getString("dm_duty1"));
				vpd.put("var31", ordinaryList.get(i).getString("dm_phone1"));
				vpd.put("var32", ordinaryList.get(i).getString("dm_sex1"));
				vpd.put("var33", ordinaryList.get(i).getString("dm_age1"));
				vpd.put("var34", ordinaryList.get(i).getString("dm_edubg1"));
				vpd.put("var35", ordinaryList.get(i).getString("dm_hobby1"));
				vpd.put("var36", ordinaryList.get(i).getString("dm_birthday1"));
				vpd.put("var37", ordinaryList.get(i).getString("decision_make2"));
				vpd.put("var38", ordinaryList.get(i).getString("dm_name2"));
				vpd.put("var39", ordinaryList.get(i).getString("dm_duty2"));
				vpd.put("var40", ordinaryList.get(i).getString("dm_phone2"));
				vpd.put("var41", ordinaryList.get(i).getString("dm_sex2"));
				vpd.put("var42", ordinaryList.get(i).getString("dm_age2"));
				vpd.put("var43", ordinaryList.get(i).getString("dm_edubg2"));
				vpd.put("var44", ordinaryList.get(i).getString("dm_hobby2"));
				vpd.put("var45", ordinaryList.get(i).getString("dm_birthday2"));
				vpd.put("var46", ordinaryList.get(i).getString("decision_make3"));
				vpd.put("var47", ordinaryList.get(i).getString("dm_name3"));
				vpd.put("var48", ordinaryList.get(i).getString("dm_duty3"));
				vpd.put("var49", ordinaryList.get(i).getString("dm_phone3"));
				vpd.put("var50", ordinaryList.get(i).getString("dm_sex3"));
				vpd.put("var51", ordinaryList.get(i).getString("dm_age3"));
				vpd.put("var52", ordinaryList.get(i).getString("dm_edubg3"));
				vpd.put("var53", ordinaryList.get(i).getString("dm_hobby3"));
				vpd.put("var54", ordinaryList.get(i).getString("dm_birthday3"));
				vpd.put("var55", ordinaryList.get(i).getString("relation_descript"));
				vpd.put("var56", ordinaryList.get(i).getString("customer_ratings"));
				vpd.put("var57", ordinaryList.get(i).getString("credit_ratings"));
				vpd.put("var58", ordinaryList.get(i).getString("respond_salesman_excel"));
				vpd.put("var59", ordinaryList.get(i).getString("start_flag").equals("0")?"未启用":"已启用");
				vpd.put("var60", ordinaryList.get(i).getString("remark"));
				vpd.put("var61", ordinaryList.get(i).getString("modified_by_excel"));
				vpd.put("var62", ordinaryList.get(i).getString("modified_date"));
				vpd.put("var63", ordinaryList.get(i).getString("input_date"));
				vpd.put("var64", ordinaryList.get(i).getString("input_user_excel"));
				/*vpd.put("var66", ordinaryList.get(i).getString("province_id"));
				vpd.put("var67", ordinaryList.get(i).getString("city_id"));
				vpd.put("var68", ordinaryList.get(i).getString("county_id"));
				vpd.put("var69", ordinaryList.get(i).getString("is_core"));
				vpd.put("var70", ordinaryList.get(i).getString("customer_branch"));*/
				/*vpd.put("var66", ordinaryList.get(i).getString("is_core").equals("true")?"是":"否");*/
				vpd.put("var65", ordinaryList.get(i).getString("customer_branch_excel"));
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
    /*
     * 小业主导出
     */
    @RequestMapping(value="toExcelMerchant")
    public ModelAndView toExcelMerchant(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
    		List<String> titles = new ArrayList<String>();
    		/*titles.add("客户id");*/
    		titles.add("客户编号");
    		titles.add("客户类型");
    		titles.add("客户名称");
    		titles.add("客户爱好");
    		titles.add("客户生日");
    		titles.add("客户公司");
    		titles.add("客户等级");
    		titles.add("客户项目描述");
    		titles.add("客户联系人");
    		titles.add("联系人电话");
    		titles.add("联系方式");
    		titles.add("联系人地址");
    		titles.add("紧急联系人1");
    		titles.add("联系电话1");
    		titles.add("紧急联系人2");
    		titles.add("联系电话2");
    		titles.add("跟进业务员");
    		titles.add("服务人员");
    		titles.add("项目来源");
    		titles.add("型号规格");
    		titles.add("配置");
    		titles.add("效果图");
    		titles.add("价格");
    		titles.add("代理商公司");
    		titles.add("代理商公司名称");
    		titles.add("代理商品牌");
    		titles.add("代理商级别");
    		titles.add("代理商性质");
    		titles.add("备注");
    		titles.add("最后修改人");
    		titles.add("最后修改时间");
    		titles.add("客户状态");
    		titles.add("录入时间");
    		titles.add("录入人");
    		/*titles.add("是否核心客户");*/
    		titles.add("客户单位");
    		titles.add("客户邮箱");
    		titles.add("客户楼盘信息");
    		dataMap.put("titles", titles);
    		List<PageData> merchantList = customerService.findCustomerMerchantList();
    		List<PageData> varList = new ArrayList<PageData>();
    		for(int i=0; i< merchantList.size(); i++){
    			PageData vpd = new PageData();
    			/*vpd.put("var1", merchantList.get(i).getString("customer_id"));*/
    			vpd.put("var1", merchantList.get(i).getString("customer_no"));
    			vpd.put("var2", "小业主");
    			vpd.put("var3", merchantList.get(i).getString("customer_name"));
    			vpd.put("var4", merchantList.get(i).getString("customer_hobby"));
    			vpd.put("var5", merchantList.get(i).getString("customer_birthday"));
    			vpd.put("var6", merchantList.get(i).getString("customer_company_excel"));
    			vpd.put("var7", merchantList.get(i).getString("customer_ratings"));
    			vpd.put("var8", merchantList.get(i).getString("customer_project"));
    			vpd.put("var9", merchantList.get(i).getString("customer_contact"));
    			vpd.put("var10", merchantList.get(i).getString("contact_phone"));
    			vpd.put("var11", merchantList.get(i).getString("contact_way"));
    			vpd.put("var12", merchantList.get(i).getString("contact_address"));
    			vpd.put("var13", merchantList.get(i).getString("contact_emergency_one"));
    			vpd.put("var14", merchantList.get(i).getString("em_one_phone"));
    			vpd.put("var15", merchantList.get(i).getString("contact_emergency_two"));
    			vpd.put("var16", merchantList.get(i).getString("em_two_phone"));
    			vpd.put("var17", merchantList.get(i).getString("respond_salesman_excel"));
    			vpd.put("var18", merchantList.get(i).getString("service_man_excel"));
    			vpd.put("var19", merchantList.get(i).getString("project_source"));
    			vpd.put("var20", merchantList.get(i).getString("type_specifiaction"));
    			vpd.put("var21", merchantList.get(i).getString("config"));
    			vpd.put("var22", merchantList.get(i).getString("design_sketch"));
    			vpd.put("var23", merchantList.get(i).getString("price"));
    			vpd.put("var24", merchantList.get(i).getString("agent_company"));
    			vpd.put("var25", merchantList.get(i).getString("agent_name"));
    			vpd.put("var26", merchantList.get(i).getString("agent_brand"));
    			vpd.put("var27", merchantList.get(i).getString("agent_ratings"));
    			vpd.put("var28", merchantList.get(i).getString("agent_property"));
    			vpd.put("var29", merchantList.get(i).getString("remark"));
    			vpd.put("var30", merchantList.get(i).getString("modified_by_excel"));
    			vpd.put("var31", merchantList.get(i).getString("modified_date"));
    			vpd.put("var32", merchantList.get(i).getString("customer_status"));
    			vpd.put("var33", merchantList.get(i).getString("input_date"));
    			vpd.put("var34", merchantList.get(i).getString("input_user_excel"));
    			/*if( merchantList.get(i).getString("is_core").equals("1")){
    				vpd.put("var35","是");
    			}else{
    				vpd.put("var35","否");
    			}*/
    			vpd.put("var35", merchantList.get(i).getString("customer_org"));
    			vpd.put("var36", merchantList.get(i).getString("customer_email"));
    			vpd.put("var37", merchantList.get(i).getString("houses_no_excel"));
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
    /*
     * 战略客户导出
     */
    @RequestMapping(value="toExcelCore")
    public ModelAndView toExcelCore(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
    		List<String> titles = new ArrayList<String>();
    		/*titles.add("客户id");*/
    		titles.add("客户编号");
    		titles.add("客户类型");
    		titles.add("集采负责人");
    		titles.add("集采人电话");
    		titles.add("集采时间");
    		titles.add("关键人姓名1");
    		titles.add("关键人职务1");
    		titles.add("关键人电话1");
    		titles.add("关键人姓名2");
    		titles.add("关键人职务2");
    		titles.add("关键人电话2");
    		titles.add("是否曾经有合作项目");
    		titles.add("当前是否有合作项目");
    		titles.add("合作项目");
    		titles.add("项目进展状态");
    		titles.add("是否战略合作");
    		titles.add("战略合作协议");
    		titles.add("战略合作期限");
    		titles.add("协议台量");
    		titles.add("合同金额");
    		titles.add("客户名称");
    		titles.add("客户公司");
    		titles.add("录入时间");
    		titles.add("录入人");
    		titles.add("最后修改人");
    		titles.add("最后修改时间");
    		titles.add("客户等级");
    		dataMap.put("titles", titles);
    		List<PageData> coreList = customerService.findCustomerCoreList();
    		List<PageData> varList = new ArrayList<PageData>();
    		for(int i=0; i< coreList.size(); i++){
    			PageData vpd = new PageData();
    			/*vpd.put("var1", coreList.get(i).getString("customer_id"));*/
    			vpd.put("var1", coreList.get(i).getString("customer_no"));
    			vpd.put("var2", "战略客户");
    			vpd.put("var3", coreList.get(i).getString("collector_excel"));
    			vpd.put("var4", coreList.get(i).getString("collector_phone"));
    			vpd.put("var5", coreList.get(i).get("collector_time").toString());
    			vpd.put("var6", coreList.get(i).getString("keyperson_name1"));
    			vpd.put("var7", coreList.get(i).getString("keyperson_duty1"));
    			vpd.put("var8", coreList.get(i).getString("keyperson_phone1"));
    			vpd.put("var9", coreList.get(i).getString("keyperson_name2"));
    			vpd.put("var10", coreList.get(i).getString("keyperson_duty2"));
    			vpd.put("var11", coreList.get(i).getString("keyperson_phone2"));
    			vpd.put("var12", coreList.get(i).getString("has_cooperate_pro").equals("0")?"否":"是");
    			vpd.put("var13", coreList.get(i).getString("now_cooperate_pro").equals("0")?"否":"是");
    			vpd.put("var14", coreList.get(i).getString("cooperate_pro_id_excel"));
    			vpd.put("var15", coreList.get(i).getString("pro_status"));
    			vpd.put("var16", coreList.get(i).getString("is_core_cooperate").equals("0")?"否":"是");
    			vpd.put("var17", coreList.get(i).getString("core_cooperate_agre"));
    			vpd.put("var18", coreList.get(i).getString("core_cooperate_date"));
    			vpd.put("var19", coreList.get(i).getString("core_cooperate_num"));
    			vpd.put("var20", coreList.get(i).getString("core_coopaerate_money"));
    			vpd.put("var21", coreList.get(i).getString("customer_name"));
    			vpd.put("var22", coreList.get(i).getString("customer_company_excel"));
    			vpd.put("var23", coreList.get(i).getString("input_date"));
    			vpd.put("var24", coreList.get(i).getString("input_user_excel"));
    			vpd.put("var25", coreList.get(i).getString("modified_by_excel"));
    			vpd.put("var26", coreList.get(i).getString("modified_date"));
    			String level =coreList.get(i).getString("customer_level");
    			if(level!=null && level.equals("A")){
    				vpd.put("var27","100强");
    			}else if(level!=null && level.equals("B")){
    				vpd.put("var27","500强");
    			}else if(level!=null && level.equals("C")){
    				vpd.put("var27","地方性");
    			}else{
    				vpd.put("var27","");
    			}
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
    
    @RequestMapping(value="toExcelVisit")
    public ModelAndView toExcelVisit(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = this.getPageData();
    	String customer_id = pd.get("customer_id").toString();
    	try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
    		List<String> titles = new ArrayList<String>();
    		titles.add("拜访记录id");
    		titles.add("拜访目的");
    		titles.add("拜访客户");
    		titles.add("拜访类型");
    		titles.add("拜访公司");
    		titles.add("拜访方式");
    		titles.add("拜访参与成员");
    		titles.add("拜访反馈");
    		titles.add("拜访日期");
    		titles.add("拜访信息添加日期");
    		titles.add("拜访跟进计划");
    		
    		dataMap.put("titles", titles);
    		List<PageData> visitList = customerService.findCustomerVisitForExcel(customer_id);
    		List<PageData> varList = new ArrayList<PageData>();
    		for(int i=0; i< visitList.size(); i++){
    			PageData vpd = new PageData();
    			vpd.put("var1", visitList.get(i).get("visit_id").toString());
    			vpd.put("var2", visitList.get(i).getString("visit_aims"));
    			vpd.put("var3", visitList.get(i).getString("visit_customer_id"));
    			vpd.put("var4", visitList.get(i).getString("visit_customer_type"));
    			vpd.put("var5", visitList.get(i).getString("visit_company"));
    			vpd.put("var6", visitList.get(i).getString("visit_way"));
    			vpd.put("var7", visitList.get(i).getString("visit_member"));
    			vpd.put("var8", visitList.get(i).getString("visit_feedback"));
    			vpd.put("var9", visitList.get(i).getString("visit_date"));
    			vpd.put("var10", visitList.get(i).getString("input_date"));
    			vpd.put("var11", visitList.get(i).getString("respond_plan"));
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
    @RequestMapping(value="importExcelOrdinary")
    @ResponseBody
    public Object importExcelOrdinary(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			//保存错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//判断字段状态
    			Boolean flag;
    			//判断是否是所有行都有错误
    			Boolean allErr = true;
    			for(int i= 0;i<listPd.size();i++){
        			List<PageData> errList = new ArrayList<PageData>();
    				//放入主键
    				pd.put("customer_id", this.get32UUID());
    				//放入编号
    				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	        	String customer_no = "DN"+"C"+sdf.format(new Date()).toString()+((int)((Math.random()*9+1)*100000)+"");
    	        	pd.put("customer_no", customer_no);
    	        	//-------------检测客户名称开始-------------------------
    	        	String customer_name = listPd.get(i).getString("var0");
    	        	flag = customerService.checkExistOname(customer_name);
    	        	if(customer_name.equals("")||customer_name==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称不能为空!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称重复!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("customer_name", listPd.get(i).getString("var0"));
    	        	}
    	        	pd.put("customer_type", "Ordinary");
    	        	//------------检测客户类型开始-------------------------
    	        	String customer_ordinary_type = listPd.get(i).getString("var1");
    	        	flag = customerService.checkOrdinary(customer_ordinary_type);
    	        	if(customer_ordinary_type.equals("")||customer_ordinary_type==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户类型不能为空!");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(!flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户类型不存在!");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("customer_ordinary_type", customerService.findTradeId(customer_ordinary_type));
    	        	}
    	        	//------------检测客户行业开始--------------------------
    	        	String customer_trade = listPd.get(i).getString("var2");
    	        	flag = customerService.checkTrade(customer_trade);
    	        	if(customer_trade.equals("")||customer_trade==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户行业不能为空!");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(!flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户行业不存在!");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("customer_trade", customerService.findOrdinaryId(customer_trade));
    	        	}
    	        	//----------检测区域
    	        	String customer_area = listPd.get(i).getString("var3");
    	        	pd.put("customer_area", customerService.findDepartmentId(customer_area));
    	        	pd.put("customer_company", customerService.findDepartmentId(listPd.get(i).getString("var4")));
    	        	pd.put("company_address", listPd.get(i).getString("var5"));
    	        	pd.put("company_property", listPd.get(i).getString("var6"));
    	        	pd.put("company_phone", listPd.get(i).getString("var7"));
    	        	pd.put("company_email", listPd.get(i).getString("var8"));
    	        	pd.put("company_fax", listPd.get(i).getString("var9"));
    	        	pd.put("company_tax", listPd.get(i).getString("var10"));
    	        	pd.put("company_bank", listPd.get(i).getString("var11"));
    	        	pd.put("bank_no", listPd.get(i).getString("var12"));
    	        	pd.put("customer_contact", listPd.get(i).getString("var13"));
    	        	pd.put("contact_duty", listPd.get(i).getString("var14"));
    	        	pd.put("contact_phone", listPd.get(i).getString("var15"));
    	        	pd.put("contact_email", listPd.get(i).getString("var16"));
    	        	pd.put("legal_represent", listPd.get(i).getString("var17"));
    	        	pd.put("employee_num", listPd.get(i).getString("var18"));
    	        	pd.put("business_and_scope", listPd.get(i).getString("var19"));
    	        	pd.put("business_status", listPd.get(i).getString("var20"));
    	        	pd.put("decision_make1", listPd.get(i).getString("var21"));
    	        	pd.put("dm_name1", listPd.get(i).getString("va22"));
    	        	pd.put("dm_duty1", listPd.get(i).getString("va23"));
    	        	pd.put("dm_phone1", listPd.get(i).getString("var24"));
    	        	pd.put("dm_sex1", listPd.get(i).getString("var25"));
    	        	pd.put("dm_age1", listPd.get(i).getString("var26"));
    	        	pd.put("dm_edubg1", listPd.get(i).getString("var27"));
    	        	pd.put("dm_hobby1", listPd.get(i).getString("var28"));
    	        	pd.put("dm_birthday1", listPd.get(i).getString("var29"));
    	        	pd.put("decision_make2", listPd.get(i).getString("var30"));
    	        	pd.put("dm_name2", listPd.get(i).getString("va31"));
    	        	pd.put("dm_duty2", listPd.get(i).getString("var32"));
    	        	pd.put("dm_phone2", listPd.get(i).getString("var33"));
    	        	pd.put("dm_sex2", listPd.get(i).getString("var34"));
    	        	pd.put("dm_age2", listPd.get(i).getString("var35"));
    	        	pd.put("dm_edubg2", listPd.get(i).getString("var36"));
    	        	pd.put("dm_hobby2", listPd.get(i).getString("var37"));
    	        	pd.put("dm_birthday2", listPd.get(i).getString("var38"));
    	        	pd.put("decision_make3", listPd.get(i).getString("var39"));
    	        	pd.put("dm_name3", listPd.get(i).getString("va40"));
    	        	pd.put("dm_duty3", listPd.get(i).getString("var41"));
    	        	pd.put("dm_phone3", listPd.get(i).getString("var42"));
    	        	pd.put("dm_sex3", listPd.get(i).getString("var43"));
    	        	pd.put("dm_age3", listPd.get(i).getString("var44"));
    	        	pd.put("dm_edubg3", listPd.get(i).getString("var45"));
    	        	pd.put("dm_hobby3", listPd.get(i).getString("var46"));
    	        	pd.put("dm_birthday3", listPd.get(i).getString("var47"));
    	        	pd.put("relation_descript", listPd.get(i).getString("var48"));
    	        	pd.put("customer_ratings", listPd.get(i).getString("var49"));
    	        	pd.put("credit_ratings", listPd.get(i).getString("var50"));
    	        	String start_flag =  listPd.get(i).getString("var51");
    	        	if(start_flag.equals("启用")){
        	        	pd.put("start_flag", "1");
    	        	}else if(start_flag.equals("禁用")){
        	        	pd.put("start_flag", "0");
    	        	}
    	        	pd.put("remark", listPd.get(i).getString("var52"));
    	        	pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
    	        	pd.put("input_user", getUser().getUSER_ID());
    	        	String is_core = listPd.get(i).getString("var53");
	        		if(is_core.equals("是")){
	    	        	pd.put("is_core", "true");
	    	        }else if(is_core.equals("否")){
	    	        	pd.put("is_core", "true");
	    	        }else{
	    	        	pd.put("is_core", "");
	    	        }
    	        	pd.put("customer_branch", customerService.findDepartmentId(listPd.get(i).getString("var54")));
    	        	//保存至数据库
    	        	if(errList.size()==0){
    	        		allErr = false;
        	        	customerService.saveOrdinaryImportExcel(pd);
    	        	}else{
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
    			}
    			if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
            			map.put("msg", "allErr");
    				}else{
    					map.put("msg", "error");
    				}
        			String errStr = "共出错"+allErrList.size()+"行\n";
        			for(PageData forPd : allErrList){
        				errStr += "错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			errStr += "总错误:"+allErrList.size();
        			map.put("errorUpload", errStr);
    			}
    		}else{
    			map.put("errorUpload", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
    	}
    	return JSONObject.fromObject(map);
    }
    @RequestMapping(value="importExcelMerchant")
    @ResponseBody
    public Object importExcelMerchant(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			//保存错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//判断字段状态
    			Boolean flag;
    			Boolean allErr = true;;
    			for(int i= 0;i<listPd.size();i++){
        			List<PageData> errList = new ArrayList<PageData>();
    				//放入主键
    				pd.put("customer_id", this.get32UUID());
    				//放入编号
    				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	        	String customer_no = "DN"+"C"+sdf.format(new Date()).toString()+((int)((Math.random()*9+1)*100000)+"");
    	        	pd.put("customer_no", customer_no);
    	        	pd.put("customer_type", "Merchant");
    	        	String customer_name = listPd.get(i).getString("var0");
    	        	flag = customerService.checkExistMname(customer_name);
    	        	if(customer_name.equals("")||customer_name==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称不能为空!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称重复!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("customer_name", customer_name);
    	        	}
    	        	pd.put("contact_phone", listPd.get(i).getString("var1"));
    	        	String houses_no = listPd.get(i).getString("var2");
    	        	if((!houses_no.equals(""))&&houses_no!=null){
        	        	pd.put("houses_no", customerService.findHousesNo(houses_no));
    	        	}
    	        	pd.put("customer_ratings", listPd.get(i).getString("var3"));
    	        	pd.put("customer_birthday", listPd.get(i).getString("var4"));
    	        	pd.put("customer_org", listPd.get(i).getString("var5"));
    	        	pd.put("customer_email", listPd.get(i).getString("var6"));
    	        	pd.put("contact_address", listPd.get(i).getString("var7"));
    	        	pd.put("customer_company", customerService.findDepartmentId(listPd.get(i).getString("var8")));
    	        	pd.put("contact_emergency_one", listPd.get(i).getString("var9"));
    	        	pd.put("em_one_phone", listPd.get(i).getString("var10"));
    	        	pd.put("contact_emergency_two", listPd.get(i).getString("var11"));
    	        	pd.put("em_two_phone", listPd.get(i).getString("var12"));
    	        	pd.put("remark", listPd.get(i).getString("var13"));
    	        	pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
    	        	pd.put("input_user", getUser().getUSER_ID());
    	        	//保存至数据库
    	        	if(errList.size()==0){
    	        		allErr = false;
        	        	customerService.saveMerchantImportExcel(pd);
    	        	}else{
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
    			}
    			if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
            			map.put("msg", "allErr");
    				}else{
    					map.put("msg", "error");
    				}
        			String errStr = "共出错"+allErrList.size()+"行\n";
        			for(PageData forPd : allErrList){
        				errStr += "错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			errStr += "总错误:"+allErrList.size();
        			map.put("errorUpload", errStr);
    			}
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
    	}
    	return JSONObject.fromObject(map);
    }
    @RequestMapping(value="importExcelCore")
    @ResponseBody
    public Object importExcelCore(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			//保存错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//判断字段状态
    			Boolean flag;
    			//判断是否是所有行都有错误
    			Boolean allErr = true;
    			for(int i= 0;i<listPd.size();i++){
        			List<PageData> errList = new ArrayList<PageData>();
    				//放入主键
    				pd.put("customer_id", this.get32UUID());
    				//放入编号
    				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	        	String customer_no = "DN"+"C"+sdf.format(new Date()).toString()+((int)((Math.random()*9+1)*100000)+"");
    	        	pd.put("customer_no", customer_no);
    	        	pd.put("customer_type", "Core");
    	        	String customer_name = listPd.get(i).getString("var0");
    	        	flag = customerService.checkExistCname(customer_name);
    	        	if(customer_name.equals("")||customer_name==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称不能为空!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "客户名称重复!");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("customer_name", customer_name);
    	        	}
    	        	pd.put("customer_level", listPd.get(i).getString("var1"));
    	        	
    	        	String collector = listPd.get(i).getString("var2");
    	        	flag = customerService.checkExistCollector(collector);
    	        	if(collector.equals("")||collector==null){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "集采负责人不能为空!");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else if(!flag){
    	    			//保存具体的字段的错误信息
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "集采负责人填写的用户不存在!");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("collector", customerService.findUserId(collector));
    	        	}
    	        	String collector_time = listPd.get(i).getString("var3");
    	        	if(collector_time.equals("")||collector_time==null){
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "集采时间不能为空!");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("collector_time", collector_time);
    	        	}
    	        	String collector_phone = listPd.get(i).getString("var4");
    	        	if(collector_phone.equals("")||collector_phone==null){
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "集采负责人联系电话不能为空!");
    	        		errPd.put("errCol", "5");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("collector_phone", collector_phone);
    	        	}
    	        	pd.put("keyperson_name1", listPd.get(i).getString("var5"));
    	        	pd.put("keyperson_duty1", listPd.get(i).getString("var6"));
    	        	pd.put("keyperson_phone1", listPd.get(i).getString("var7"));
    	        	pd.put("keyperson_name2", listPd.get(i).getString("var8"));
    	        	pd.put("keyperson_duty2", listPd.get(i).getString("var9"));
    	        	pd.put("keyperson_phone2", listPd.get(i).getString("var10"));
    	        	String has_cooperate_pro = listPd.get(i).getString("var11");
    	        	if(has_cooperate_pro.equals("")||has_cooperate_pro==null){
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "是否曾经有过项目合作栏目不能为空!");
    	        		errPd.put("errCol", "12");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("has_cooperate_pro", has_cooperate_pro.equals("是")?"1":"0");
    	        	}
    	        	String now_cooperate_pro = listPd.get(i).getString("var12");
    	        	if(now_cooperate_pro.equals("")||now_cooperate_pro==null){
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "当前是否有项目合作栏目不能为空!");
    	        		errPd.put("errCol", "13");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("now_cooperate_pro", now_cooperate_pro.equals("是")?"1":"0");
    	        	}
    	        	String is_core_cooperate = listPd.get(i).getString("var13");
    	        	if(is_core_cooperate.equals("")||is_core_cooperate==null){
    	    			PageData errPd = new PageData();
    	        		errPd.put("errMsg", "是否战略合作栏目不能为空!");
    	        		errPd.put("errCol", "14");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
    	        	}else{
        	        	pd.put("is_core_cooperate", is_core_cooperate.equals("是")?"1":"0");
    	        	}
    	        	pd.put("core_cooperate_date", listPd.get(i).getString("var14"));
    	        	pd.put("core_cooperate_num", listPd.get(i).getString("var15"));
    	        	pd.put("core_cooperate_money", listPd.get(i).getString("var16"));
    	        	pd.put("input_date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
    	        	pd.put("input_user", getUser().getUSER_ID());
    	        	//保存至数据库
    	        	if(errList.size()==0){
    	        		allErr = false;
        	        	customerService.saveCoreImportExcel(pd);
    	        	}else{
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
    			}
    			if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
            			map.put("msg", "allErr");
    				}else{
    					map.put("msg", "error");
    				}
        			String errStr = "共出错"+allErrList.size()+"行\n";
        			for(PageData forPd : allErrList){
        				errStr += "错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			errStr += "总错误:"+allErrList.size();
        			map.put("errorUpload", errStr);
    			}
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
    	}
    	return JSONObject.fromObject(map);
    }
    
    @RequestMapping(value="importExcelVisit")
    @ResponseBody
    public Object importExcelVisit(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	        	pd.put("visit_aims", listPd.get(i).getString("var0"));
    	        	pd.put("visit_customer_id", listPd.get(i).getString("var1"));
    	        	pd.put("visit_customer_type", listPd.get(i).getString("var2"));
    	        	pd.put("visit_company", listPd.get(i).getString("var3"));
    	        	pd.put("visit_way", listPd.get(i).getString("var4"));
    	        	pd.put("visit_member", listPd.get(i).getString("var5"));
    	        	pd.put("visit_feedback", listPd.get(i).getString("var6"));
    	        	pd.put("visit_date", listPd.get(i).getString("var7"));
    	        	pd.put("input_date", sdf.format(new Date()));
    	        	pd.put("respond_plan", listPd.get(i).getString("var8"));
    	        	//保存至数据库
    	        	customerService.saveCustomerVisitImportExcel(pd);
    			}
    			map.put("msg", "success");
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }

	@RequestMapping(value="getQixinbaoCompany")
	@ResponseBody
	public Object getQixinbaoCompany(){
		JSONArray result = new JSONArray();
		QiXinImpl qiXin=new QiXinImpl();
		try{
			PageData pd = this.getPageData();
			List<Company> destinList =qiXin.getCompanysByKeyword(pd.getString("searchKey"));
			result.addAll(destinList);

			Company cp=new Company();
			cp.getTelephone();
			cp.getCompanyKind();
			cp.getOperName();
			cp.getCompanyAddress();
			cp.getBusinessLienceNum();

			return result;
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return result;
	}
    
    
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    /* ===============================用户================================== */
    /* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
    /* ===============================用户查询权限================================== */
}
