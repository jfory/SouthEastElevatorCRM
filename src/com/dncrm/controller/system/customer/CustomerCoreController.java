package com.dncrm.controller.system.customer;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.region.RegionService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.dncrm.entity.system.User;

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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/customerCore")
@Controller
public class CustomerCoreController extends BaseController {
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
    //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();

    /**
     * 显示列表
     *
     * @return
     */
    @RequestMapping("/listCustomerCore")
    public ModelAndView listCustomerCore(Page page) {
        ModelAndView mv = this.getModelAndView();
        try {
        	PageData pd = this.getPageData();
        	mv.setViewName("system/customer/customer_core_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            /*List<PageData> customerList = customerService.listPageCustomerCore(page);*/
            List<String> userList = getRoleSelect();
            String roleType = getRoleType();
            pd.put("userList", userList);
            pd.put("roleType", roleType);
	        page.setPd(pd);
            List<PageData> customerList = customerService.listPageCustomerCoreByRole(page);
            if (customerList.size() > 0) {
                mv.addObject("customerList", customerList);
            }else{
                mv.addObject("customerList", "");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    
    /**
     * 跳到编辑页面
     *
     * @return
     */
    @RequestMapping("/goEditCustomerCore")
    public ModelAndView goEditCustomerOrg()throws Exception {
    	ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
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
        //加载集采负责人
        List<PageData> collectors = customerService.findCustomerContactCore();
        mv.addObject("collectors",collectors);
        mv.addObject("operateType",pd.get("operateType"));
        pd = customerService.findById(pd);
        pd = customerService.findByPd(pd);
        mv.setViewName("system/customer/customer_core_edit");
        mv.addObject("msg", "editCustomerCore");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 跳到新增页面
     *
     * @return
     */
    @RequestMapping("/goAddCustomerCore")
    public ModelAndView goAddCustomerCore()throws Exception {
    	ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
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

        
        //加载集采负责人
        List<PageData> collectors = customerService.findCustomerContactCore();
        mv.addObject("collectors",collectors);
        
      //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        
        if(pds!=null) {
        	pd.put("collector", pds.getString("USER_ID"));
        	pd.put("collector_phone", pds.getString("PHONE"));
        	pd.put("collector_time", DateUtil.getDay());
        }
        
        mv.setViewName("system/customer/customer_core_edit");
        mv.addObject("msg", "saveCustomerCore");
        mv.addObject("operateType","add");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 保存新增
     *
     */
    @RequestMapping("/saveCustomerCore")
    public ModelAndView saveCustomerCore() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	//放入添加操作人
        	pd.put("input_user", getUser().getUSER_ID());
        	//放入主键id
        	pd.put("customer_id", get32UUID());
        	//放入生成编号
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        	String customer_no = "KZ"+((int)((Math.random()*9+1)*100000)+"");
        	pd.put("customer_no", customer_no);
            customerService.saveCustomer(pd,"Core");
            mv.addObject("msg", "success");

        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
        }
        mv.addObject("id", "EditCustomerCore");
        mv.addObject("form", "CustomerCoreForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     *保存修改 
     */
    @RequestMapping("/editCustomerCore")
    public ModelAndView editCustomerCore(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        try {
        	pd.put("input_user", getUser().getUSER_ID());
        	customerService.editCustomer(pd, "Core");
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "修改失败！");
        }
        mv.addObject("id", "EditCustomerCore");
        mv.addObject("form", "CustomerCoreForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     *  删除一条数据
     */
    @RequestMapping("/delCustomerCore")
    @ResponseBody
    public Object delCustomerCore(){
    	Map<String,Object> map = new HashMap<String,Object>();
    	PageData pd = this.getPageData();
    	String deleteType = "Core";
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
    @RequestMapping("/delAllCustomerCore")
    @ResponseBody
    public Object delAllCustomerCore(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	String deleteType="Core";
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String customer_ids = (String) pd.get("customer_ids");
            for (String customer_id : customer_ids.split(",")) {
            	pd.put("customer_id",  customer_id);
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
    @RequestMapping(value="visitCustomerCore")
	public ModelAndView visitCustomerCore(Page page) throws Exception{
    	ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		/*if(pd.containsKey("goway")){
			if(pd.get("goway").toString().equals("menu")){
				pd.put("customer_id", "");
				pd.put("customer_name", "");
				pd.put("customer_type", "all");
				mv.addObject("goway", "menu");
			}
		}*/
        page.setPd(pd);
		List<PageData> customerVisitList = customerService.listCustomerVisit(page);
		mv.setViewName("system/customer/customer_visit_list");
		mv.addObject("customerVisitList",customerVisitList);
		mv.addObject("add_customer_id",pd.getString("customer_id"));
		mv.addObject("add_customer_name",pd.getString("customer_name"));
		mv.addObject("add_customer_type","Core");
		mv.addObject("pd",pd);
		mv.addObject("page",page);
		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		return mv;
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
     * 获取权限
     *
     * @return
     */
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
/* ===============================用户================================== */
}
