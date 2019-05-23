package com.dncrm.controller.system.sysAgent;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.houses.HousesService;
import com.dncrm.service.system.rating.RatingService;
import com.dncrm.service.system.region.RegionService;
import com.dncrm.service.system.sysAgent.SysAgentService;
import com.dncrm.service.system.sysLog.SysLogService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.*;
import com.dncrm.util.echarts.Echarts;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.github.abel533.echarts.json.GsonOption;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping(value = "/sysAgent")
public class SysAgentController extends BaseController{

	@Resource(name = "sysAgentService")
    private SysAgentService sysAgentService;
	
	@Resource(name = "regionService")
	private RegionService regionService;
	@Resource(name = "sysUserService")
	private sysUserService sysUserService;
	@Resource(name = "sysLogService")
	private SysLogService sysLogService;
	@Resource(name="customerService")
	private CustomerService customerService;
	@Resource(name = "cityService")
	private CityService cityService;
	@Resource(name = "ratingService")
	private RatingService ratingService;
	@Resource(name = "departmentService")
	private DepartmentService departmentService;
	@Resource(name = "housesService")
	private HousesService housesService;
	
	public static SimpleDateFormat sdf = new SimpleDateFormat();
	
	 //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
	 /**
     * 显示代理商列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/agentList")
    public ModelAndView list(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        //shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
        try {
            PageData pd = this.getPageData();
            List<String> userList = getRoleSelect();
            String roleType = getRoleType();
            pd.put("userList", userList);
            pd.put("roleType", roleType);
            mv.addObject("agent_area", pd.get("agent_area"));
            mv.addObject("agent_company", pd.get("agent_company"));
            mv.addObject("agent_applyuser", pd.get("agent_applyuser"));
            mv.addObject("agent_category", pd.get("agent_category"));
            mv.addObject("agent_constructor", pd.get("agent_constructor"));
           // 类别:0,普通、1,核心、2,战略联盟、3,战略联盟二级、4,东南尚升二级
            if (pd.getString("agent_category") != null) {
				if (pd.getString("agent_category").equals("普通")) {
					pd.put("agent_category", "0");
				}
				else if (pd.getString("agent_category").equals("核心")) {
					pd.put("agent_category", "1");
				}
				else if(pd.getString("agent_category").equals("战略联盟")) {
					pd.put("agent_category", "2");
				}
				else if (pd.getString("agent_category").equals("战略联盟二级")) {
					pd.put("agent_category", "3");
				}
				else if (pd.getString("agent_category").equals("东南尚升二级")) {
					pd.put("agent_category", "4");
				}
				else if (pd.getString("agent_category").equals("小业主代理商")) {
					pd.put("agent_category", "5");
				}
			}
            //是否有安装资质(1,是;2否)
            if (pd.getString("agent_constructor") != null) {
				if (pd.get("agent_constructor").equals("是")) {
					pd.put("agent_constructor", 1);
				}
				else if(pd.get("agent_constructor").equals("否")) {
					pd.put("agent_constructor", 2);
				}
			}
            page.setPd(pd);
            List<PageData> agentList = sysAgentService.listPdPageAgent(page);
            if(!agentList.isEmpty()){
            	for(PageData agent : agentList){
            		String agent_instance_id = agent.getString("agent_instance_id");
            		String contractor_instance_id = agent.getString("contractor_instance_id");
            		if(agent_instance_id!=null && !"".equals(agent_instance_id)){
            			WorkFlow workFlow = new WorkFlow();
            			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(agent_instance_id).active().singleResult();
            			if(task!=null){
            				agent.put("task_id",task.getId());
            				agent.put("task_name",task.getName());
            			}
            		}
            		if(contractor_instance_id!=null && !"".equals(contractor_instance_id)){
            			WorkFlow workFlow2 = new WorkFlow();
            			Task task2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(contractor_instance_id).active().singleResult();
            			if(task2!=null){
	            			agent.put("task_id2",task2.getId());
	        				agent.put("task_name2",task2.getName());
            			}
            		}
            	}
            }
            
           
            
            mv.addObject("agentList", agentList);
            mv.addObject("page", page);
            mv.addObject("agent_name", pd.get("agent_name"));
            mv.addObject("description", pd.get("description"));
//            pd.clear();
            mv.setViewName("system/agent/agent");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

        return mv;
    }
    
    /**
     * 显示分包商列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/contractorList")
    public ModelAndView contractorList(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        //shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		
        try {
            PageData pd = this.getPageData();
            List<String> userList = getRoleSelect();
            String roleType = getRoleType();
            pd.put("userList", userList);
            pd.put("roleType", roleType);
            mv.addObject("agent_area", pd.get("agent_area"));
            mv.addObject("agent_company", pd.get("agent_company"));
            mv.addObject("agent_applyuser", pd.get("agent_applyuser"));
            mv.addObject("agent_category", pd.get("agent_category"));
            mv.addObject("agent_constructor", pd.get("agent_constructor"));
           // 类别:0,普通、1,核心、2,战略联盟、3,战略联盟二级、4,东南尚升二级
            if (pd.getString("agent_category") != null) {
				if (pd.getString("agent_category").equals("普通")) {
					pd.put("agent_category", "0");
				}
				else if (pd.getString("agent_category").equals("核心")) {
					pd.put("agent_category", "1");
				}
				else if (pd.getString("agent_category").equals("战略联盟")) {
					pd.put("agent_category", "2");
				}
				else if (pd.getString("agent_category").equals("战略联盟二级")) {
					pd.put("agent_category", "3");
				}
				else if (pd.getString("agent_category").equals("东南尚升二级")) {
					pd.put("agent_category", "4");
				}
				else if (pd.getString("agent_category").equals("小业主代理商")) {
					pd.put("agent_category", "5");
				}
			}
            //是否有安装资质(1,是;2否)
            if (pd.getString("agent_constructor") != null) {
				if (pd.get("agent_constructor").equals("是")) {
					pd.put("agent_constructor", 1);
				}
				else if (pd.get("agent_constructor").equals("否")) {
					pd.put("agent_constructor", 2);
				}
			}
            page.setPd(pd);
            /*List<PageData> agentList = sysAgentService.listPdPageContractor(page);*/
            List<PageData> agentList = sysAgentService.listPdPageContractorByRole(page);
            if(!agentList.isEmpty()){
            	for(PageData agent : agentList){
            		String agent_instance_id = agent.getString("agent_instance_id");
            		String contractor_instance_id = agent.getString("contractor_instance_id");
            		if(agent_instance_id!=null && !"".equals(agent_instance_id)){
            			WorkFlow workFlow = new WorkFlow();
            			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(agent_instance_id).active().singleResult();
            			if(task!=null){
            				agent.put("task_id",task.getId());
            				agent.put("task_name",task.getName());
            			}
            		}
            		if(contractor_instance_id!=null && !"".equals(contractor_instance_id)){
            			WorkFlow workFlow2 = new WorkFlow();
            			Task task2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(contractor_instance_id).active().singleResult();
            			if(task2!=null){
            				agent.put("task_id2",task2.getId());
            				agent.put("task_name2",task2.getName());
            				
            			}
            		}
            	}
            }
            
           
            
            mv.addObject("agentList", agentList);
            mv.addObject("page", page);
            mv.addObject("agent_name", pd.get("agent_name"));
            mv.addObject("description", pd.get("description"));
            mv.setViewName("system/agent/contractor");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

        return mv;
    }
    
    /**
     * 请求跳转代理商新增页面
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd(){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    
    	try {
    		
			
    		//加载区域列表
        	List<PageData> area = departmentService.findAllAreaNode();
        	//获取所有区域节点和父级节点
        	List<PageData> areas = getNodeLists(area);
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
        	/*//加载所属子公司列表
        	List<PageData> subCompany = departmentService.findAllSubCompanyNode();
        	//获取所有区域节点和父级节点
        	List<PageData> subCompanys = getNodeLists(subCompany);
        	if (subCompanys.size() > 0) {
            		//构建多叉数
            		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            		MultipleTree tree = new MultipleTree();
            		dataList = ConvertPageDataToList.make(subCompanys);
            		Node node = tree.makeTreeWithOderNo(dataList, 1);
            		mv.addObject("subCompanys", node);
        	}else{
        		mv.addObject("subCompanys", subCompanys);
        	}
        	parentDepartments.clear();*/
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
           
            mv.addObject("ratingList", ratingList);
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityList);
            mv.addObject("coundtyList", coundtyList);
			mv.addObject("msg", "add");
			mv.addObject("HasSameKey", "false");
			mv.setViewName("system/agent/agent_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
     * 请求跳转分包商新增页面
     */
    @RequestMapping(value = "/toContractorAdd")
    public ModelAndView toContractorAdd(){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	try {
    		
    		//加载区域列表
        	List<PageData> area = departmentService.findAllAreaNode();
        	//获取所有区域节点和父级节点
        	List<PageData> areas = getNodeLists(area);
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
        	
        	//加载所属子公司列表
        	List<PageData> subCompany = departmentService.findAllSubCompanyNode();
        	//获取所有区域节点和父级节点
        	List<PageData> subCompanys = getNodeLists(subCompany);
        	if (subCompanys.size() > 0) {
            		//构建多叉数
            		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            		MultipleTree tree = new MultipleTree();
            		dataList = ConvertPageDataToList.make(subCompanys);
            		Node node = tree.makeTreeWithOderNo(dataList, 1);
            		mv.addObject("subCompanys", node);
        	}else{
        		mv.addObject("subCompanys", subCompanys);
        	}
        	parentDepartments.clear();
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
            mv.addObject("ratingList", ratingList);
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityList);
            mv.addObject("coundtyList", coundtyList);
			mv.addObject("msg", "add");
			mv.addObject("HasSameKey", "false");
			mv.setViewName("system/agent/contractor_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 请求跳转代理商编辑页面
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toEdit")
    public ModelAndView toEidt(String agent_id){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
			List<PageData> list = sysAgentService.findAgentById(agent_id);
			pd.put("province_id", list.get(0).get("province_id"));
			pd.put("city_id", list.get(0).get("city_id"));
			pd.put("county_id", list.get(0).get("county_id"));
			
			//加载区域列表
        	List<PageData> area = departmentService.findAllAreaNode();
        	//获取所有区域节点和父级节点
        	List<PageData> areas = getNodeLists(area);
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
        	//加载所属子公司列表
        	List<PageData> subCompany = departmentService.findAllSubCompanyNode();
        	//获取所有区域节点和父级节点
        	List<PageData> subCompanys = getNodeLists(subCompany);
        	if (subCompanys.size() > 0) {
            		//构建多叉数
            		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            		MultipleTree tree = new MultipleTree();
            		dataList = ConvertPageDataToList.make(subCompanys);
            		Node node = tree.makeTreeWithOderNo(dataList, 1);
            		mv.addObject("subCompanys", node);
        	}else{
        		mv.addObject("subCompanys", subCompanys);
        	}
        	parentDepartments.clear();
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
            mv.addObject("ratingList", ratingList);
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityList);
            mv.addObject("coundtyList", coundtyList);
			mv.addObject("HasSameKey", "false");
	        mv.addObject("msg", "edit");
	        mv.addObject("pd", list.get(0));
	        mv.setViewName("system/agent/agent_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 请求跳转分包商编辑页面
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toContractorEdit")
    public ModelAndView toContractorEdit(String agent_id){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	PageData pds = new PageData();
    	try {
			List<PageData> list = sysAgentService.findAgentById(agent_id);
			pds.put("province_id", list.get(0).get("province_id"));
			pds.put("city_id", list.get(0).get("city_id"));
			pds.put("county_id", list.get(0).get("county_id"));
			
			//加载区域列表
        	List<PageData> area = departmentService.findAllAreaNode();
        	//获取所有区域节点和父级节点
        	List<PageData> areas = getNodeLists(area);
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
        	
        	//加载所属子公司列表
        	List<PageData> subCompany = departmentService.findAllSubCompanyNode();
        	//获取所有区域节点和父级节点
        	List<PageData> subCompanys = getNodeLists(subCompany);
        	if (subCompanys.size() > 0) {
            		//构建多叉数
            		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
            		MultipleTree tree = new MultipleTree();
            		dataList = ConvertPageDataToList.make(subCompanys);
            		Node node = tree.makeTreeWithOderNo(dataList, 1);
            		mv.addObject("subCompanys", node);
        	}else{
        		mv.addObject("subCompanys", subCompanys);
        	}
        	parentDepartments.clear();
			//加载省份
			List<PageData> provinceList=cityService.findAllProvince();
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pds);
			//加载郡县
			List<PageData> coundtyList = cityService.findAllCountyByCityId(pds);
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
			
            mv.addObject("ratingList", ratingList);
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityList);
            mv.addObject("coundtyList", coundtyList);
			mv.addObject("HasSameKey", "false");
	        mv.addObject("msg", "editContractor");
	        mv.addObject("pd", list.get(0));
	        mv.setViewName("system/agent/contractor_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 请求跳转代理商查看页面
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toView")
    public ModelAndView toView(String agent_id){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
			List<PageData> list = sysAgentService.findAgentById(agent_id);
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
			mv.addObject("ratingList", ratingList);
			 mv.addObject("HasSameKey", "false");
	         mv.addObject("msg", "edit");
	         mv.addObject("pd", list.get(0));
	         mv.setViewName("system/agent/agent_view");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 营业执照号码是否存在重复
     * @param request
     * @return
     */
    @RequestMapping(value = "/existsLicenseNo")
    @ResponseBody
    public Object existsLicenseNo(HttpServletRequest request){
    	String agent_license_no = request.getParameter("agent_license_no");
    	PageData pd = this.getPageData();
    	pd.put("agent_license_no", agent_license_no);
    	JSONObject result = new JSONObject();
    	try {
			List<PageData> list = sysAgentService.existsLicenseNo(pd);
			if(list.isEmpty()){
				result.put("success", true);
			}else{
				result.put("errorMsg", "营业执照号码重复,请从新输入");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return result;
    }
    
    
    /**
	 * 判断代理商名称是否唯一
	 * @param binder
	 */
	@RequestMapping("/AgentName")
	@ResponseBody
	public Object AgentName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = sysAgentService.findAgentByName(pd);
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
     * 保存代理商
     * @throws Exception 
     */
    @RequestMapping(value = "/add")
    public ModelAndView add(HttpServletRequest request) throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	//shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		String processDefinitionKey = "";   //流程1
    	String processDefinitionKey2 = "";   //流程2
    	String agentType = pd.getString("agent_type");// 类型
    	String is_constructor = pd.getString("is_constructor"); //资质
    	String agent_id = pd.getString("agent_id"); //uuid
    	int type = 0;
    	PageData pds = new PageData();
    	pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
    	if(is_constructor.equals("1") &&(agentType.equals("1") || agentType.equals("2"))){//有安装资质
    		//获取区域类别   3和7代表工厂和子工厂  8代表区域
    		PageData departmentType = sysAgentService.findUserPositionAndDepartment(pds);
    		if(departmentType!=null){
    			if(departmentType.get("type").equals("3") || departmentType.get("type").equals("7")){
    				type = 2;
    			}else if(departmentType.get("type").equals("8")){
    				type = 1;
    			}else{
    				 //根据要求代理商信息 拿掉录入的条件，谁都可以录入 注释不做任何处理  fantasy
    	   			 /*mv.addObject("msg", "failed");
    	             mv.addObject("err", "你没有权限增加分包商！");
    	             mv.addObject("id", "AddAgent");
    	     		 mv.addObject("form", "agentForm");
    	             mv.setViewName("save_result");
    	         	 return mv;*/
    	    	}
    		}
    	}
		//自动生成编号
		String dateTime = DateUtil.getDays();
		int num = (int)((Math.random()*9+1)*100000);
		String agent_no = "DNA" + dateTime + num;
    	try{
    		pd.put("agent_no", agent_no);
	    	pd.put("agent_id", UUID.randomUUID().toString());
	    	pd.put("response_salesman", pds.get("NAME"));	
	    	pd.put("input_user", USER_ID);
	    	//营业执照号码是否存在重复
	    	List<PageData> list = sysAgentService.existsLicenseNo(pd);
	    	if (list.isEmpty()) {
	    		sysAgentService.agentAdd(pd);
	    		mv.addObject("msg", "success");
	    		//封装操作日志数据
	    		sysLogService.logAdd("add","测试-代理商管理-新增",pd.getString("agent_id"),"添加:"+pd.getString("agent_name"),request);
	    	}
    	}catch(Exception e){
    		mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
            e.printStackTrace();
    	}
    	try{
	    	//启动流程
	    	if(agentType.equals("1") && is_constructor.equals("1")){
    			processDefinitionKey = "agent";
    			processDefinitionKey2 = "contractor";
	    	}
	    	if(agentType.equals("1") && is_constructor.equals("2")){
    			processDefinitionKey = "agent";
    		}
	    	if(agentType.equals("2") && is_constructor.equals("1")){
    			processDefinitionKey2 = "contractor";
    			
    		}
    		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
    		WorkFlow workFlow = new WorkFlow();
    		WorkFlow workFlow2 = new WorkFlow();
    		IdentityService identityService = workFlow.getIdentityService();
    		identityService.setAuthenticatedUserId(USER_ID);
    		Object agentId = pd.get("agent_id");
    		String businessKey = "tb_agent.agent_id."+agentId;
    		//设置变量
    		Map<String,Object> variables = new HashMap<String,Object>();
    		variables.put("user_id", USER_ID);
    		variables.put("type", type);
    		ProcessInstance proessInstance=null; //流程1
    		ProcessInstance proessInstance2 = null; //流程2
    		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
    			proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
    		}
    		if(processDefinitionKey2!=null && !"".equals(processDefinitionKey2)){
    			proessInstance2 = workFlow2.getRuntimeService().startProcessInstanceByKey(processDefinitionKey2, businessKey, variables);
    		}
    		if(proessInstance !=null && proessInstance2!=null){
    			pd.put("agent_instance_id", proessInstance.getId());
    			pd.put("contractor_instance_id", proessInstance2.getId());
    		}else if(proessInstance !=null){
    			pd.put("agent_instance_id", proessInstance.getId());
    		}else if(proessInstance2!=null){
    			pd.put("contractor_instance_id", proessInstance2.getId());
    		}else {
    			sysAgentService.agentDeleteById(agent_id);
    			mv.addObject("msg", "failed");
    			mv.addObject("err", "保存失败！");
    		}
    		sysAgentService.agentUpdate(pd);
    	}catch(Exception e){
    		mv.addObject("msg", "failed");
            mv.addObject("err", "流程不存在！");
    	}
        mv.addObject("id", "AddAgent");
		mv.addObject("form", "agentForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
   
    
    /**
     * 启动流程
     * @return
     */
    @RequestMapping(value = "/apply")
    @ResponseBody
    public Object apply(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String,Object> map = new HashMap<>();
    	try{
    		//shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            
            
           
            String agent_instance_id = pd.getString("agent_instance_id");   //代理商
            String contractor_instance_id = pd.getString("contractor_instance_id");  //分包商
            //  如存在key启动代理商流程
            if(agent_instance_id!=null && !"".equals(agent_instance_id)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(agent_instance_id).singleResult();
            	Map<String,Object> variables = new HashMap<String,Object>();
            	//设置任务角色
            	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
            	//签收任务
            	workFlow.getTaskService().claim(task.getId(), USER_ID);
            	//设置流程变量
            	variables.put("action", "提交申请");
            	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
            	pd.put("agent_approval", 1);
            	sysAgentService.updateAgentApproval(pd);
            	workFlow.getTaskService().complete(task.getId());
            	//获取下一个任务的信息
                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(agent_instance_id).singleResult();
                map.put("task_name",tasks.getName());
                map.put("status", "1");
            }
            //如存在key启动分包商流程
            if(contractor_instance_id !=null && !"".equals(contractor_instance_id)){
            	 
            	 WorkFlow workFlow2 = new WorkFlow();
            	 
            	 // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	 workFlow2.getIdentityService().setAuthenticatedUserId(USER_ID);
            	 Task task2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(contractor_instance_id).singleResult();
            	 Map<String,Object> variables2 = new HashMap<String,Object>();
            	 //设置任务角色
            	 workFlow2.getTaskService().setAssignee(task2.getId(), USER_ID);
            	 //签收任务
            	 workFlow2.getTaskService().claim(task2.getId(), USER_ID);
            	 //设置流程变量
            	 variables2.put("action","提交申请");
            	 workFlow2.getTaskService().setVariables(task2.getId(), variables2);
            	 pd.put("contractor_approval", 1);
            	 sysAgentService.updateAgentApproval(pd);
            	 workFlow2.getTaskService().complete(task2.getId());
            	 //获取下一个任务的信息
            	 Task tasks2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(contractor_instance_id).singleResult();
            	 map.put("task_name2",tasks2.getName());
            	 map.put("status", "2");
            }
            
            if((agent_instance_id !=null && !"".equals(agent_instance_id))&& (contractor_instance_id !=null && !"".equals(contractor_instance_id))){
            	map.put("status", "3");
            }
            map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     * 显示待我处理的代理商
     * @param page
     * @return
     */
    @RequestMapping(value= "/listPendingAgent")
    public ModelAndView listPendingAgent(Page page){
    	  ModelAndView mv = this.getModelAndView();
          PageData pd = new PageData();
          pd = this.getPageData();
          
          try{
        	  //shiro管理的session
              Subject currentUser = SecurityUtils.getSubject();
              Session session = currentUser.getSession();

              PageData pds = new PageData();
              pds = (PageData) session.getAttribute("userpds");
              String USER_ID = pds.getString("USER_ID");
              page.setPd(pds);
              mv.setViewName("system/agent/agent_list");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              List<PageData> agents = new ArrayList<>();
              WorkFlow workFlow = new WorkFlow();
              // 等待处理的任务
              //设置分页数据
              int firstResult;//开始游标
              int maxResults;//结束游标
              int showCount = page.getShowCount();//默认为10
              int currentPage = page.getCurrentPage();//默认为0
              if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                  firstResult = currentPage;//从0开始
                  currentPage+=1;//当前为第一页
                  maxResults = showCount;
              }else{
                  firstResult = showCount*(currentPage-1);
                  maxResults = firstResult+showCount;
              }
              //List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("agent").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("agent").orderByTaskCreateTime().desc().active().list();
              for (Task task : toHandleList) {

                  PageData agent = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      agent.put(info[1],info[2]);
                      agent = sysAgentService.findById(agent);
                      if(agent != null) {
                    	  agent.put("task_name",task.getName());
                          agent.put("task_id",task.getId());
                          if(task.getAssignee()!=null){
                        	  agent.put("type","1");//待处理
                          }else{
                        	  agent.put("type","0");//待签收
                          }
                          agents.add(agent);
                      }
                      
                  }
              }
              //设置分页数据
              int totalResult = agents.size();
              if (totalResult<=showCount) {
                  page.setTotalPage(1);
              }else{
                  int count = Integer.valueOf(totalResult/showCount);
                  int  mod= totalResult%showCount;
                  if (mod>0) {
                      count =count+1;
                  }
                  page.setTotalPage(count);
              }
              page.setTotalResult(totalResult);
              page.setCurrentResult(agents.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(0);
              page.setPageStrForActiviti(page.getPageStrForActiviti());
              mv.addObject("page", null);
              //待处理任务的count
              pd.put("count",agents.size());

              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("agents", agents);
              mv.addObject("userpds", pds);
          }catch(Exception e){
        	  logger.error(e.toString(), e);
          }
          return mv;
    }
    
    /**
     * 显示待我处理的分包商
     * @param page
     * @return
     */
    @RequestMapping(value= "/listPendingContractor")
    public ModelAndView listPendingContractor(Page page){
    	  ModelAndView mv = this.getModelAndView();
          PageData pd = new PageData();
          pd = this.getPageData();
          
          try{
        	  //shiro管理的session
              Subject currentUser = SecurityUtils.getSubject();
              Session session = currentUser.getSession();

              PageData pds = new PageData();
              pds = (PageData) session.getAttribute("userpds");
              String USER_ID = pds.getString("USER_ID");
              page.setPd(pds);
              mv.setViewName("system/agent/contractor_list");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              List<PageData> agents = new ArrayList<>();
              WorkFlow workFlow = new WorkFlow();
              // 等待处理的任务
              //设置分页数据
              int firstResult;//开始游标
              int maxResults;//结束游标
              int showCount = page.getShowCount();//默认为10
              int currentPage = page.getCurrentPage();//默认为0
              if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                  firstResult = currentPage;//从0开始
                  currentPage+=1;//当前为第一页
                  maxResults = showCount;
              }else{
                  firstResult = showCount*(currentPage-1);
                  maxResults = firstResult+showCount;
              }
              List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("contractor").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("contractor").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
              for (Task task : toHandleList) {

                  PageData agent = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      agent.put(info[1],info[2]);
                      agent = sysAgentService.findById(agent);
                      if(agent != null) {
                    	  agent.put("task_name",task.getName());
                          agent.put("task_id",task.getId());
                          if(task.getAssignee()!=null){
                        	  agent.put("type","1");//待处理
                          }else{
                        	  agent.put("type","0");//待签收
                          }
                          agents.add(agent);
                      }
                  }
              }
              //设置分页数据
              int totalResult = toHandleListCount.size();
              if (totalResult<=showCount) {
                  page.setTotalPage(1);
              }else{
                  int count = Integer.valueOf(totalResult/showCount);
                  int  mod= totalResult%showCount;
                  if (mod>0) {
                      count =count+1;
                  }
                  page.setTotalPage(count);
              }
              page.setTotalResult(totalResult);
              page.setCurrentResult(agents.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(0);
              page.setPageStrForActiviti(page.getPageStrForActiviti());

              //待处理任务的count
              pd.put("count",toHandleListCount.size());

              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("agents", agents);
              mv.addObject("userpds", pds);
          }catch(Exception e){
        	  logger.error(e.toString(), e);
          }
          return mv;
    }
    
    /**
     * 签收任务
     *
     * @return
     */
    @RequestMapping("/claim")
    @ResponseBody
    public Object claim() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 签收任务
            List<PageData> agents = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","签收失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 跳到代理商办理任务页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandleAgent")
    public ModelAndView goHandleAgent() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        try {
			List<PageData> list = sysAgentService.findAgentById(pd.getString("agent_id"));
			//信用等级
			List<PageData> ratingList = ratingService.findAllRating();
			mv.addObject("ratingList", ratingList);
			pd.putAll(list.get(0));
            mv.addObject("historys",getViewHistory(pd.getString("agent_instance_id")));
		} catch (Exception e) {
			e.printStackTrace();
		}
        mv.setViewName("system/agent/agent_handle");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 跳到分包商办理任务页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandleContractor")
    public ModelAndView goHandleContractor() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("system/agent/contractor_handle");
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 处理代理商任务
     * @return
     */
    @RequestMapping("/handleAgent")
    public ModelAndView handleAgent(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        
        try{
        	 //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String,Object> variables = new HashMap<String ,Object>();
            boolean isApproved = false;
            String action = pd.getString("action");
            int status;
            if (action.equals("approve")){
                isApproved = true;
                //如果是hr审批
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
                if (task.getTaskDefinitionKey().equals("sellManageApproval")){
                    status = 2;//已完成
                    pd.put("agent_approval",2);
                    sysAgentService.updateAgentApproval(pd);
                }
            }else if(action.equals("reject")) {
                status = 4;//被驳回
                pd.put("agent_approval",4);
                sysAgentService.updateAgentApproval(pd);
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            variables.put("approved",isApproved);
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
            mv.addObject("msg", "success");
        }catch(Exception e){
        	 mv.addObject("msg", "failed");
             mv.addObject("err", "办理失败！");
             logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 处理分包商任务
     * @return
     */
    @RequestMapping("/handleContractor")
    public ModelAndView handleContractor(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        
        try{
        	 //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String,Object> variables = new HashMap<String ,Object>();
            //boolean isApproved = false;
            //类型   1.区域 2.工厂 3.通过
            int type = 0;
            
            String action = pd.getString("action");
            int status;
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            if (action.equals("approve")){
                //isApproved = true;
                
            	type=3;
                
                if (task.getTaskDefinitionKey().equals("FactoryGeneralManager")){
                    status = 2;//已完成
                    pd.put("contractor_approval",2);
                    sysAgentService.updateAgentApproval(pd);
                }
            }else if(action.equals("reject")) {
            	//获取实例ID
            	String contractor_instance_id =(String) sysAgentService.findById(pd).get("contractor_instance_id");
            	//获取variable启动ID
            	Object variableNum = workFlow.getRuntimeService().getVariable(contractor_instance_id, "user_id");
            	PageData userApplyId=new PageData();
            	userApplyId.put("USER_ID", variableNum);
            	//获取区域类别   3和7代表工厂和子工厂  8代表区域
        		PageData departmentType = sysAgentService.findUserPositionAndDepartment(userApplyId);
        		if(departmentType!=null){
        			if(departmentType.get("type").equals("3") || departmentType.get("type").equals("7")){
        				type = 2;
        			}else if(departmentType.get("type").equals("8")){
        				type = 1;
        			}
        		}
                
                status = 4;//被驳回
                pd.put("contractor_approval",4);
                sysAgentService.updateAgentApproval(pd);
            }
            String  comment = (String) pd.get("comment");
            if (type == 3){
                variables.put("action","批准");
            }else if(type == 2){
                variables.put("action","工厂驳回");
            }else if(type == 1){
            	variables.put("action", "区域驳回");
            }
            variables.put("type",type);
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
            mv.addObject("msg", "success");
        }catch(Exception e){
        	 mv.addObject("msg", "failed");
             mv.addObject("err", "办理失败！");
             logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 重新申请代理商
     *
     * @return
     */
    @RequestMapping("/restartAgent")
    @ResponseBody
    public Object restartAgent() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 签收任务
            List<PageData> agents = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);

            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);
            
          
        	//更新业务数据的状态
        	pd.put("agent_approval",1);
        	sysAgentService.updateAgentApproval(pd);
            
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 重新申请分包商
     *
     * @return
     */
    @RequestMapping("/restartContractor")
    @ResponseBody
    public Object restartContractor() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            // 签收任务
            List<PageData> agents = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id2");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id,user_id);

            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);
            
            
            
        	//更新业务数据的状态
        	pd.put("contractor_approval",1);
        	sysAgentService.updateAgentApproval(pd);
            
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     * 显示我已经处理的代理商
     *
     * @return
     */
    @RequestMapping("/listDoneAgent")
    public ModelAndView listDoneAgent(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/agent/agent_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务
            List<PageData> dleaves = new ArrayList<>();
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("agent").orderByTaskCreateTime().desc().list();
            //移除重复的
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            for (HistoricTaskInstance instance:historicTaskInstances
                 ) {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance)entry.getValue());
            }

            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage+=1;//当前为第一页
                maxResults = showCount;
            }else{
                firstResult = showCount*(currentPage-1);
                maxResults = firstResult+showCount;
            }
            //int listCount =(list.size()<=maxResults?list.size():maxResults);
            int listCount = list.size();
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData agent = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        agent.put(info[1],info[2]);
                        agent = sysAgentService.findById(agent);
                        //检查申请者是否是本人,如果是,跳过
                        if (agent == null || agent.getString("requester_id").equals(USER_ID))
                            continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (runing==null||runing.size()<=0){
                        	agent.put("isRuning",0);

                        }else{
                        	agent.put("isRuning",1);
                            //正在运行,查询当前的任务信息
                            Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                            agent.put("task_name",task.getName());
                            agent.put("task_id",task.getId());
                        }
                        dleaves.add(agent);
                }
            }

            //设置分页数据
            int totalResult = list.size();
            if (totalResult<=showCount) {
                page.setTotalPage(1);
            }else{
                int count = Integer.valueOf(totalResult/showCount);
                int  mod= totalResult%showCount;
                if (mod>0) {
                    count =count+1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(dleaves.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count",dleaves.size());

            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("dleaves", dleaves);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 显示我已经处理的分包商
     *
     * @return
     */
    @RequestMapping("/listDoneContractor")
    public ModelAndView listDoneContractor(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/agent/contractor_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务
            List<PageData> dleaves = new ArrayList<>();
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("contractor").orderByTaskCreateTime().desc().list();
            //移除重复的
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            for (HistoricTaskInstance instance:historicTaskInstances
                 ) {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance)entry.getValue());
            }

            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage+=1;//当前为第一页
                maxResults = showCount;
            }else{
                firstResult = showCount*(currentPage-1);
                maxResults = firstResult+showCount;
            }
            int listCount =(list.size()<=maxResults?list.size():maxResults);
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData agent = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        agent.put(info[1],info[2]);
                        agent = sysAgentService.findById(agent);
                        //检查申请者是否是本人,如果是,跳过
                        if (agent == null || agent.getString("requester_id").equals(USER_ID))
                        continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (agent!=null) {
                        	if (runing==null||runing.size()<=0){
                            	agent.put("isRuning",0);
                            }else{
                            	agent.put("isRuning",1);
                                //正在运行,查询当前的任务信息
                                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                                agent.put("task_name",task.getName());
                                agent.put("task_id",task.getId());
                            }
						}
                        dleaves.add(agent);
                }
            }

            //设置分页数据
            int totalResult = list.size();
            if (totalResult<=showCount) {
                page.setTotalPage(1);
            }else{
                int count = Integer.valueOf(totalResult/showCount);
                int  mod= totalResult%showCount;
                if (mod>0) {
                    count =count+1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(dleaves.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());

            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count",toHandleListCount.size());

            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("dleaves", dleaves);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
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
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"Agent/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "Agent/" + ffile + "/" + fileName);
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }
    
    /**
     * 编辑代理商
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	PageData pds = sysAgentService.findById(pd);
    	String agent_instance_id = (String) pds.get("agent_instance_id");
    	String contractor_instance_id = (String) pds.get("contractor_instance_id");
    	String agent_type = (String) pd.get("agent_type");
    	String is_constructor = (String) pd.get("is_constructor");
    	WorkFlow workFlow = new WorkFlow();
    	String processDefinitionKey = "";   //流程
    	//判断编辑时是否有安装资质  1.有  2.无
    	if(is_constructor.equals("1")){
    		//判断流程ID不存在
    		if(contractor_instance_id==null){
    			//shiro管理的session
    			Subject currentUser = SecurityUtils.getSubject();
    			Session session = currentUser.getSession();
    	    	pds = (PageData) session.getAttribute("userpds");
    			String USER_ID = pds.getString("USER_ID");
    			
    			//类别  1.区域  2.工厂 3.通过
    			int type = 0;
    			
	    		//获取区域类别   3和7代表工厂和子工厂  8代表区域
	    		PageData departmentType = sysAgentService.findUserPositionAndDepartment(pds);
	    		if(departmentType!=null){
	    			if(departmentType.get("type").equals("3") || departmentType.get("type").equals("7")){
	    				type = 2;
	    			}else if(departmentType.get("type").equals("8")){
	    				type = 1;
	    			}else{
	    	             mv.addObject("err", "你没有权限增加分包商！");
	    	     		 mv.addObject("HasSameKey", "true");
	    	             mv.addObject("msg", "edit");
	    	             mv.addObject("pd", pd);
	    	             mv.setViewName("system/agent/agent_edit");
	    	             mv.setViewName("save_result");
	    	         	 return mv;
	    	    	}
	    		}
	    		
	    		processDefinitionKey = "contractor";//分包商流程
	    		
	    		IdentityService identityService = workFlow.getIdentityService();
	    		identityService.setAuthenticatedUserId(USER_ID);
	    		Object agentId = pd.get("agent_id");
	    		String businessKey = "tb_agent.agent_id."+agentId;
	    		Map<String,Object> variables = new HashMap<String,Object>();
	    		variables.put("user_id", USER_ID);
	    		variables.put("type", type);
	    		ProcessInstance processInstance=null;//流程
	    		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
	    			processInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
	    		}
	    		if(processInstance!=null){
	    			pd.put("contractor_instance_id", processInstance.getId());
	    		}
    	    	
    		}else{
    			pd.put("contractor_instance_id", contractor_instance_id);
    		}
    	}else{
    		if(contractor_instance_id!=null && !"".equals(contractor_instance_id)){
    			workFlow.getRuntimeService().deleteProcessInstance(contractor_instance_id, "删除分包商业务数据,删除流程");
    			pd.put("contractor_instance_id", null);
    		}
    	}
    	pd.put("agent_instance_id", agent_instance_id);
    	//营业执照号码是否存在重复
    	List<PageData> list = sysAgentService.existsLicenseNo(pd);
    	if(list.isEmpty()){
    		sysAgentService.agentUpdate(pd);
    		mv.addObject("id", "EditAgent");
    		mv.addObject("form", "agentForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.setViewName("system/agent/agent_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    /**
     * 编辑分包商
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/editContractor")
    public ModelAndView editContractor() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	PageData pds = sysAgentService.findById(pd);
    	String agent_instance_id = (String) pds.get("agent_instance_id");
    	String contractor_instance_id = (String) pds.get("contractor_instance_id");
    	String agent_type = (String) pd.get("agent_type");
    	String is_constructor = (String) pd.get("is_constructor");
    	WorkFlow workFlow = new WorkFlow();
    	String processDefinitionKey = "";   //流程
    	//判断编辑时是否有安装资质  1.有  2.无
    	if(agent_type.equals("1")){
    		//判断流程ID不存在
    		if(agent_instance_id==null){
    			//shiro管理的session
    			Subject currentUser = SecurityUtils.getSubject();
    			Session session = currentUser.getSession();
    	    	pds = (PageData) session.getAttribute("userpds");
    			String USER_ID = pds.getString("USER_ID");
    			
    			//类别  1.区域  2.工厂 3.通过
    			int type = 0;
    			
	    		//获取区域类别   3和7代表工厂和子工厂  8代表区域
	    		PageData departmentType = sysAgentService.findUserPositionAndDepartment(pds);
	    		if(departmentType!=null){
	    			if(departmentType.get("type").equals("3") || departmentType.get("type").equals("7")){
	    				type = 2;
	    			}else if(departmentType.get("type").equals("8")){
	    				type = 1;
	    			}else{
	    	             mv.addObject("err", "你没有权限操作！");
	    	             mv.addObject("HasSameKey", "true");
	    	             mv.addObject("msg", "editContractor");
	    	             mv.addObject("pd", pd);
	    	             mv.setViewName("system/agent/contractor_edit");
	    	             mv.setViewName("save_result");
	    	         	 return mv;
	    	    	}
	    		}
	    		
	    		processDefinitionKey = "agent";//代理商流程
	    		
	    		IdentityService identityService = workFlow.getIdentityService();
	    		identityService.setAuthenticatedUserId(USER_ID);
	    		Object agentId = pd.get("agent_id");
	    		String businessKey = "tb_agent.agent_id."+agentId;
	    		Map<String,Object> variables = new HashMap<String,Object>();
	    		variables.put("user_id", USER_ID);
	    		variables.put("type", type);
	    		ProcessInstance processInstance=null;//流程
	    		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
	    			processInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
	    		}
	    		if(processInstance!=null){
	    			pd.put("agent_instance_id", processInstance.getId());
	    		}
    	    	
    		}else{
    			pd.put("agent_instance_id", agent_instance_id);
    		}
    	}else{
    		if(agent_instance_id!=null && !"".equals(agent_instance_id)){
    			workFlow.getRuntimeService().deleteProcessInstance(agent_instance_id, "删除代理商业务数据,删除流程");
    			pd.put("agent_instance_id", null);
    		}
    	}
    	pd.put("contractor_instance_id", contractor_instance_id);
    	
    	//营业执照号码是否存在重复
    	List<PageData> list = sysAgentService.existsLicenseNo(pd);
    	if(list.isEmpty()){
    		sysAgentService.agentUpdate(pd);
    		mv.addObject("id", "EditAgent");
    		mv.addObject("form", "agentForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "editContractor");
            mv.addObject("pd", pd);
            mv.setViewName("system/agent/contractor_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    /**
     * 删除代理商
     * @param agent_no
     * @param out
     * @return
     */
    @RequestMapping(value = "/del")
    public void delete(String agent_id,PrintWriter out){
    	try {
			List<PageData> list = sysAgentService.findAgentById(agent_id);
			PageData pd = list.get(0);
			//删除启动的流程
            WorkFlow workflow = new WorkFlow();
            WorkFlow workflow2 = new WorkFlow();
            String agent_instance_id =  (String)pd.get("agent_instance_id");
            String contractor_instance_id =  (String)pd.get("contractor_instance_id");
            if(agent_instance_id!=null && !"".equals(agent_instance_id)){
            	workflow.getRuntimeService().deleteProcessInstance(agent_instance_id, "删除代理商业务数据,删除流程");
            }
            if(contractor_instance_id!=null && !"".equals(contractor_instance_id)){
            	workflow2.getRuntimeService().deleteProcessInstance(contractor_instance_id, "删除分包商业务数据,删除流程");
            }
			sysAgentService.agentDeleteById(agent_id);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * 批量删除代理商
     * @return
     */
    @RequestMapping(value = "/delAll")
    @ResponseBody
    public Object deleteAll(){
    	Map<String,Object> map = new HashMap<String,Object>();
    	List<PageData> pdList = new ArrayList<PageData>();
    	PageData pd = new PageData();
    	//删除启动的流程
    	String agent_id="";
    	String agent_instance_id="";
    	String contractor_instance_id="";
    	String agent_approval = "";
    	String contractor_approval = "";
    	try {
	    	pd = this.getPageData();
	    	String DATA_IDS = pd.getString("DATA_IDS");
	    	if(!"".equals(DATA_IDS) && DATA_IDS!=null){
	    		//批量删除流程
	    		String[] ArrayDATA_IDS = DATA_IDS.split(",");
	    		for(int i=0;i<ArrayDATA_IDS.length;i++){
	    			agent_id =  ArrayDATA_IDS[i];
	    			List<PageData> list = new ArrayList<>();
	    			WorkFlow workflow = new WorkFlow();
	    		    WorkFlow workflow2 = new WorkFlow();
	    			list = sysAgentService.findAgentById(agent_id);
	    			agent_instance_id =  list.get(0).getString("agent_instance_id"); //获取代理商流程实例ID
	    			contractor_instance_id = list.get(0).getString("contractor_instance_id"); //获取分包商流程实例ID
	    			agent_approval = list.get(0).getString("agent_approval");  //获取代理商流程审核状态
	    			contractor_approval = list.get(0).getString("contractor_approval");  //获取分包商流程审核状态
	    			if(agent_instance_id!=null && !"".equals(agent_instance_id)){
	    				if(!agent_approval.equals("2") && !contractor_approval.equals("2")){
	    					workflow.getRuntimeService().deleteProcessInstance(agent_instance_id, "删除代理商业务数据,删除流程");
	    				}
	                }
	    			if(contractor_instance_id!=null && !"".equals(contractor_instance_id)){
	    				if(!contractor_approval.equals("2") && !agent_approval.equals("2")){
	    					workflow2.getRuntimeService().deleteProcessInstance(contractor_instance_id, "删除分包商业务数据,删除流程");
	    				}
	                }
	    		}
				sysAgentService.agentDeleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
	    	pdList.add(pd);
	    	map.put("list", pdList);
    	}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return AppUtil.returnObject(pd, map);
    }
    
    @RequestMapping(value = "/loadAgent")
    @ResponseBody
    public Object loadAgent(){
    	
    	PageData pd = this.getPageData();
    	PageData agentInfo = new PageData();
    	JSONObject result = new JSONObject();
    	try {
    		agentInfo = sysAgentService.findByName(pd);
    		if(agentInfo!=null){
    			Date start_time = (Date) agentInfo.get("start_time");
    			Date end_time = (Date) agentInfo.get("end_time");
    			String startTime = Tools.date2Str(end_time, "yyyy-MM-dd");
    			String endTime = Tools.date2Str(start_time, "yyyy-MM-dd");
    			agentInfo.put("start_time", startTime);
    			agentInfo.put("end_time", endTime);
    			result.put("agentInfo", agentInfo);
    			result.put("success", true);
    		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
    
    /**
	 *echarts报表 
	 */
	@RequestMapping(value="reportInfo")
	public ModelAndView reportInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			mv.setViewName("system/agent/report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
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
    		int minYear = sysAgentService.findMinYearItem();
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
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("代理商ID");
			titles.add("代理商编号");
			titles.add("代理商所属区域");
			titles.add("代理商所属分公司");
			titles.add("代理商名称");
			titles.add("代理商地址");
			titles.add("代理商联系人");
			titles.add("联系人职务");
			titles.add("联系人电话");
			titles.add("联系邮件");//10
			titles.add("协议指标");
			titles.add("代理商行业");
			titles.add("公司电话");
			titles.add("传真");
			titles.add("邮编");
			titles.add("法人代表");
			titles.add("开户银行");
			titles.add("帐号");
			titles.add("营业执照号码");
			titles.add("税号");//20
			titles.add("电子邮箱");
			titles.add("员工人数");
			titles.add("企业性质");
			titles.add("经营内容及业绩");
			titles.add("代理商资质");
			titles.add("安装资质");
			titles.add("信用等级");
			titles.add("启用标志");
			titles.add("跟进业务员");
			titles.add("备注");//30
			titles.add("修改人");
			titles.add("修改时间");
			titles.add("创建时间");
			titles.add("安装人数");
			titles.add("安装资质");
			titles.add("安装队人员资格证");
			titles.add("安装队人员保险");
			titles.add("安装业绩描述");
			titles.add("代理商审核状态");
			titles.add("分包商审核状态");//40
			titles.add("代理商流程实例Id");
			titles.add("分包商流程实例ID");
			titles.add("请求人ID");
			titles.add("省份");
			titles.add("城市");
			titles.add("郡/县");
			titles.add("地址全称");
			titles.add("附件");
			titles.add("类别");
			titles.add("有效时间from");//50
			titles.add("有效时间to");
			titles.add("录入人");
			titles.add("姓名");
			titles.add("身份证号");
			titles.add("操作证到期时间");
			titles.add("保险到期时间");
			titles.add("保险金额");
			
			dataMap.put("titles", titles);
			
			List<PageData> itemList = sysAgentService.findAgentList(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("agent_id"));
				vpd.put("var2", itemList.get(i).getString("agent_no"));
				vpd.put("var3", itemList.get(i).getString("dname"));//区域
				vpd.put("var4", itemList.get(i).getString("cname"));//所属公司
				vpd.put("var5", itemList.get(i).getString("agent_name"));
				vpd.put("var6", itemList.get(i).getString("agent_address"));
				vpd.put("var7", itemList.get(i).getString("agent_contact"));
				vpd.put("var8", itemList.get(i).getString("contact_title"));
				vpd.put("var9", itemList.get(i).getString("contact_phone"));
				vpd.put("var10", itemList.get(i).getString("contact_email"));
				
				vpd.put("var11", itemList.get(i).getString("protocol_index"));
				vpd.put("var12", itemList.get(i).getString("agent_industry"));
				vpd.put("var13", itemList.get(i).getString("agent_tel"));
				vpd.put("var14", itemList.get(i).getString("agent_fax"));
				vpd.put("var15", itemList.get(i).getString("agent_postcode"));
				vpd.put("var16", itemList.get(i).getString("legal_representative"));
				vpd.put("var17", itemList.get(i).getString("agent_bank_name"));
				vpd.put("var18", itemList.get(i).getString("agent_bank_account"));
				vpd.put("var19", itemList.get(i).getString("agent_license_no"));
				vpd.put("var20", itemList.get(i).getString("tax_no"));
				
				vpd.put("var21", itemList.get(i).getString("agent_email"));
				String employee_num=itemList.get(i).getString("employee_num");//员工人数
				if(employee_num.equals("0"))
				{
					vpd.put("var22", "0~50");
				}else if(employee_num.equals("1"))
				{
					vpd.put("var22", "50~100");
				}else if(employee_num.equals("2"))
				{
					vpd.put("var22", "100~500");
				}
				else if(employee_num.equals("3"))
				{
					vpd.put("var22", "500以上");
				}
				vpd.put("var23", itemList.get(i).getString("enterprise_property"));
				vpd.put("var24", itemList.get(i).getString("content_and_scope"));
				String agent_type=itemList.get(i).getString("agent_type");//是否有代理商资质
				vpd.put("var25", agent_type.equals("1")?"是":"否");
				String is_constructor=itemList.get(i).getString("is_constructor");//是否有安装资质
				vpd.put("var26", is_constructor.equals("1")?"是":"否");
				vpd.put("var27", itemList.get(i).getString("credit_ratings"));
				String is_acvtivated=itemList.get(i).getString("is_acvtivated");//启用标志
				vpd.put("var28", is_acvtivated.equals("1")?"是":"否");
				vpd.put("var29", itemList.get(i).getString("response_salesman"));
				vpd.put("var30", itemList.get(i).getString("agent_remark"));
				
				vpd.put("var31", itemList.get(i).getString("modified_by"));
				vpd.put("var32", itemList.get(i).getString("datetime_changed"));
				vpd.put("var33", itemList.get(i).getString("create_time"));
				vpd.put("var34", itemList.get(i).getString("constructor_employee_no"));
				vpd.put("var35", itemList.get(i).getString("constructor_qualification"));
				vpd.put("var36", itemList.get(i).getString("constructor_certification"));
				vpd.put("var37", itemList.get(i).getString("constructor_insurance"));
				vpd.put("var38", itemList.get(i).getString("constructor_description"));
				String agent_approval=itemList.get(i).getString("agent_approval");//代理商流程状态
				if(agent_approval.equals("0"))
				{
					vpd.put("var39", "待审核");
				}else if(agent_approval.equals("1"))
				{
					vpd.put("var39", "审核中");
				}else if(agent_approval.equals("2"))
				{
					vpd.put("var39", "已完成");
				}else if(agent_approval.equals("3"))
				{
					vpd.put("var39", "已取消");
				}else if(agent_approval.equals("4"))
				{
					vpd.put("var39", "被驳回");
				}
				String contractor_approval=itemList.get(i).getString("contractor_approval");//分包商流程状态
				if(contractor_approval.equals("0"))
				{
					vpd.put("var40", "待审核");
				}else if(contractor_approval.equals("1"))
				{
					vpd.put("var40", "审核中");
				}else if(contractor_approval.equals("2"))
				{
					vpd.put("var40", "已完成");
				}else if(contractor_approval.equals("3"))
				{
					vpd.put("var40", "已取消");
				}else if(contractor_approval.equals("4"))
				{
					vpd.put("var40", "被驳回");
				}
				vpd.put("var41", itemList.get(i).getString("agent_instance_id"));
				vpd.put("var42", itemList.get(i).getString("contractor_instance_id"));
				vpd.put("var43", itemList.get(i).getString("requester_id"));
				vpd.put("var44", itemList.get(i).getString("pname"));//省份
				vpd.put("var45", itemList.get(i).getString("lciname"));//城市
				vpd.put("var46", itemList.get(i).getString("lconame"));//区县
				vpd.put("var47", itemList.get(i).getString("address_name"));
				vpd.put("var48", itemList.get(i).getString("accessory"));
				String agent_category =itemList.get(i).getString("agent_category");//类别
				if(agent_category.equals("0"))
				{
					vpd.put("var49", "普通");
				}else if(agent_category.equals("1"))
				{
					vpd.put("var49", "核心");
				}else if(agent_category.equals("2"))
				{
					vpd.put("var49", "战略联盟");
				}else if(agent_category.equals("3"))
				{
					vpd.put("var49", "战略联盟二级");
				}else if(agent_category.equals("4"))
				{
					vpd.put("var49", "东南尚升二级");
				}
				vpd.put("var50", itemList.get(i).getString("start_time"));
				
				vpd.put("var51", itemList.get(i).getString("end_time"));
				vpd.put("var52", itemList.get(i).getString("input_user"));
				vpd.put("var53", itemList.get(i).getString("id_card_name"));
				vpd.put("var54", itemList.get(i).getString("id_card_no"));
				vpd.put("var55", itemList.get(i).getString("operation_ent_time"));
				vpd.put("var56", itemList.get(i).getString("insurance_ent_time"));
				vpd.put("var57", itemList.get(i).getString("insurance_price"));
				
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
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++){
					boolean boolAgent=true;
					//所属区域
					String customer_area_ordinary =listPd.get(i).getString("var0");
					PageData quyuPd=new PageData();
					quyuPd.put("Department_name", customer_area_ordinary);
					PageData quyu=housesService.findDepartmentByName(quyuPd);
					if(quyu!=null)
					{
						boolAgent=true;
					}
					else
					{
						boolAgent=false;
					}
					//所属公司
					String company_name=listPd.get(i).getString("var1");
					PageData gongsiPd=new PageData();
					gongsiPd.put("Department_name", company_name);
					PageData gongsi=sysAgentService.findDepartmentByName(gongsiPd);
					if(gongsi!=null)
					{
						boolAgent=true;
					}
					else
					{
						boolAgent=false;
					}
					
					//地址
					String province_name=listPd.get(i).getString("var34");
					String city_name=listPd.get(i).getString("var35");
					String county_name=listPd.get(i).getString("var36");
					PageData dizhiPd=new PageData();
					dizhiPd.put("province_name", province_name);
					dizhiPd.put("city_name", city_name);
					dizhiPd.put("county_name", county_name);
					PageData dizhi=housesService.findProvinceByName(dizhiPd);
					if(dizhi!=null)
					{
						boolAgent=true;
					}
					else
					{
						boolAgent=false;
					}
					if(boolAgent)
					{
						//获取系统时间
						String df=DateUtil.getTime().toString();
						//shiro管理的session
						//获取当前登录用户ID
				    	Subject currentUser = SecurityUtils.getSubject();
				    	Session session = currentUser.getSession();
				    	PageData pds = new PageData();
				    	pds = (PageData) session.getAttribute("userpds");
						String USER_ID = pds.getString("USER_ID");
						//自动生成编号
						String dateTime = DateUtil.getDays();
						int num = (int)((Math.random()*9+1)*100000);
						String agent_no = "DNA" + dateTime + num;
						
						String processDefinitionKey = "";   //流程1
				    	String processDefinitionKey2 = "";   //流程2
				    	String agentType = listPd.get(i).getString("var22");//是否有代理商资质
				    	String is_constructor =listPd.get(i).getString("var23"); //是否有安装资质
				    	String agent_id = UUID.randomUUID().toString(); //代理商UUID
						pd.put("agent_license_no", listPd.get(i).getString("var16"));//营业执照
				    	int type = 0;
				    	if(is_constructor.equals("1") &&(agentType.equals("1") || agentType.equals("2"))){
				    		//获取区域类别   3和7代表工厂和子工厂  8代表区域
				    		PageData departmentType = sysAgentService.findUserPositionAndDepartment(pds);
				    		if(departmentType!=null){
				    			if(departmentType.get("type").equals("3") || departmentType.get("type").equals("7")){
				    				type = 2;
				    			}else if(departmentType.get("type").equals("8")){
				    				type = 1;
				    			}else{
				    				map.put("errorMsg", "你没有权限增加分包商！");
				    	    	}
				    		}
				    	}
						pd.put("agent_id", agent_id);
			        	pd.put("agent_no", agent_no);
			        	pd.put("area_id", quyu.getString("id"));
			        	pd.put("company_id", gongsi.getString("id"));
			        	pd.put("agent_name",  listPd.get(i).getString("var2"));
			        	pd.put("agent_address",  listPd.get(i).getString("var3"));
			        	pd.put("agent_contact", listPd.get(i).getString("var4"));
			        	pd.put("contact_title", listPd.get(i).getString("var5"));
			        	pd.put("contact_phone",  listPd.get(i).getString("var6"));
			        	pd.put("contact_email",  listPd.get(i).getString("var7"));
			        	pd.put("protocol_index",  listPd.get(i).getString("var8"));//11
			        	
			        	pd.put("agent_industry",  listPd.get(i).getString("var9"));
			        	pd.put("agent_tel", listPd.get(i).getString("var10"));
			        	pd.put("agent_fax", listPd.get(i).getString("var11"));
			        	pd.put("agent_postcode",  listPd.get(i).getString("var12"));
			        	pd.put("legal_representative",  listPd.get(i).getString("var13"));
			        	pd.put("agent_bank_name",  listPd.get(i).getString("var14"));
			        	pd.put("agent_bank_account",  listPd.get(i).getString("var15"));
			        	pd.put("agent_license_no",  listPd.get(i).getString("var16"));
			        	pd.put("tax_no",  listPd.get(i).getString("var17"));
			        	pd.put("agent_email",  listPd.get(i).getString("var18"));
			        	String employee_num=listPd.get(i).getString("var19");//员工人数
			        	if(employee_num.equals("0~50"))
			        	{
			        		pd.put("employee_num","0");
			        	}else if(employee_num.equals("50~100"))
			        	{
			        		pd.put("employee_num","1");
			        	}else if(employee_num.equals("100~500"))
			        	{
			        		pd.put("employee_num","2");
			        	}else if(employee_num.equals("500以上"))
			        	{
			        		pd.put("employee_num","3");
			        	}else
			        	{
			        		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
			        	}
			        	pd.put("enterprise_property",  listPd.get(i).getString("var20"));
			        	pd.put("content_and_scope",  listPd.get(i).getString("var21"));
			        	String agent_type=listPd.get(i).getString("var22");//是否有代理商资质
			        	if(agent_type.equals("是"))
			        	{
			        		pd.put("agent_type","1");
			        	}else if(agent_type.equals("否"))
			        	{
			        		pd.put("agent_type","2");
			        	}else
			        	{
			        		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
			        	}
			        	
			        	String is_constructor2=listPd.get(i).getString("var23");//是否有安装资质
			        	if(is_constructor2.equals("是"))
			        	{
			        		pd.put("is_constructor","1");
			        	}else if(is_constructor2.equals("否"))
			        	{
			        		pd.put("is_constructor","2");
			        	}else
			        	{
			        		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
			        	}
			        	pd.put("credit_ratings",  listPd.get(i).getString("var24"));
			        	String is_acvtivated=listPd.get(i).getString("var25");//启用标志
			        	if(is_acvtivated.equals("是"))
			        	{
			        		pd.put("is_acvtivated","1");
			        	}else if(is_acvtivated.equals("否"))
			        	{
			        		pd.put("is_acvtivated","2");
			        	}else
			        	{
			        		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
			        	}
			        	pd.put("response_salesman", pds.get("NAME"));//跟进业务员
			        	pd.put("agent_remark",  listPd.get(i).getString("var26"));
			        	pd.put("modified_by",  listPd.get(i).getString("var27"));
			        	
			        	pd.put("datetime_changed",  listPd.get(i).getString("var28"));
			        	pd.put("create_time", df);//创建时间
			        	pd.put("constructor_employee_no",  listPd.get(i).getString("var29"));
			        	pd.put("constructor_qualification",  listPd.get(i).getString("var30"));
			        	pd.put("constructor_certification",  listPd.get(i).getString("var31"));
			        	pd.put("constructor_insurance",  listPd.get(i).getString("var32"));
			        	pd.put("constructor_description",  listPd.get(i).getString("var33"));
			        	pd.put("agent_approval", 0);//代理商流程状态
			        	pd.put("agent_instance_id","agent"); //代理商流程实例key
			   
			        	pd.put("agent_approval", 0);//分包商流程状态
			        	pd.put("agent_instance_id","contractor"); //分包商流程实例key
			        	pd.put("requester_id", USER_ID);//请求人
			        	
			        	pd.put("province_id",  dizhi.get("lprId"));//地址 省份
			        	pd.put("city_id", dizhi.get("lciId"));//城市
			        	pd.put("county_id", dizhi.get("lcoId"));//区县
			        	pd.put("address_name",  listPd.get(i).getString("var37"));
			        	pd.put("accessory",  listPd.get(i).getString("var38"));
			      
			        	String agent_category = listPd.get(i).getString("var39");//类别
						if(agent_category.equals("普通"))
						{
							pd.put("agent_category", "0");
						}else if(agent_category.equals("核心"))
						{
							pd.put("agent_category", "1");
						}else if(agent_category.equals("战略联盟"))
						{
							pd.put("agent_category", "2");
						}else if(agent_category.equals("战略联盟二级"))
						{
							pd.put("agent_category", "3");
						}else if(agent_category.equals("东南尚升二级"))
						{
							pd.put("agent_category", "4");
						}else
			        	{
			        		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
			        	}
			        	
			        	pd.put("input_user",USER_ID);//录入人
			        	pd.put("start_time",  listPd.get(i).getString("var40"));//有效时间from
			        	pd.put("end_time",  listPd.get(i).getString("var41"));//有效时间to
			        	
			        	pd.put("id_card_name",  listPd.get(i).getString("var42"));//分包商
			        	pd.put("id_card_no",  listPd.get(i).getString("var43"));//分包商
			        	pd.put("operation_ent_time",  listPd.get(i).getString("var44"));//分包商
			        	pd.put("insurance_ent_time",  listPd.get(i).getString("var45"));//分包商
			        	pd.put("insurance_price",  listPd.get(i).getString("var46"));//分包商
			        	
			        	//营业执照号码是否存在重复
				    	List<PageData> list = sysAgentService.existsLicenseNo(pd);
				    	if (list.isEmpty()) {
				    		//保存至数据库
				    		sysAgentService.agentAdd(pd);
				    		map.put("errorMsg", "succect");
				    	}
				    	else
				    	{
				    		map.put("msg2", "error");
			        		map.remove("msg");
			        		map.put("error", "在第"+(i+1)+"行，存在错误。");
			        		break;
				    	}
				    	//启动流程
				    	if(agentType.equals("1") && is_constructor.equals("1")){
			    			processDefinitionKey = "agent";
			    			processDefinitionKey2 = "contractor";
				    	}
				    	if(agentType.equals("1") && is_constructor.equals("2")){
			    			processDefinitionKey = "agent";
			    		}
				    	if(agentType.equals("2") && is_constructor.equals("1")){
			    			processDefinitionKey2 = "contractor";
			    			
			    		}
			    		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
			    		WorkFlow workFlow = new WorkFlow();
			    		WorkFlow workFlow2 = new WorkFlow();
			    		IdentityService identityService = workFlow.getIdentityService();
			    		identityService.setAuthenticatedUserId(USER_ID);
			    		Object agentId = pd.get("agent_id");
			    		String businessKey = "tb_agent.agent_id."+agentId;
			    		//设置变量
			    		Map<String,Object> variables = new HashMap<String,Object>();
			    		variables.put("user_id", USER_ID);
			    		variables.put("type", type);
			    		ProcessInstance proessInstance=null; //流程1
			    		ProcessInstance proessInstance2 = null; //流程2
			    		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
			    			proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			    		}
			    		if(processDefinitionKey2!=null && !"".equals(processDefinitionKey2)){
			    			proessInstance2 = workFlow2.getRuntimeService().startProcessInstanceByKey(processDefinitionKey2, businessKey, variables);
			    		}
			    		if(proessInstance !=null && proessInstance2!=null){
			    			pd.put("agent_instance_id", proessInstance.getId());
			    			pd.put("contractor_instance_id", proessInstance2.getId());
			    		}else if(proessInstance !=null){
			    			pd.put("agent_instance_id", proessInstance.getId());
			    		}else if(proessInstance2!=null){
			    			pd.put("contractor_instance_id", proessInstance2.getId());
			    		}else {
			    			sysAgentService.agentDeleteById(agent_id);
			    			map.put("errorMsg", "上传失败");
			    		}
			    		sysAgentService.agentUpdate(pd);//修改
			    		map.put("msg", "success");	
					}
					else
					{
						map.put("msg2", "error");
		        		map.remove("msg");
		        		map.put("error", "在第"+(i+1)+"行，存在错误。");
		        		break;
					}
		    		
					
				}
	    	}else{
	    		map.put("errorMsg", "上传失败");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
    
    /**
	 *放入json数据 
	 */
	@RequestMapping(value="setByType",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Object setByType(){
		GsonOption option = new GsonOption();
		PageData pd = new PageData();
		try{
			Echarts chart = new Echarts();
			pd = this.getPageData();
			List<PageData> list = new ArrayList<PageData>();
			String type = pd.get("type").toString();
			String agent_type = pd.get("agent_type").toString();
			String is_constructor = pd.get("is_constructor").toString();
			String year = pd.get("yearOption").toString();
			PageData dataPd = new PageData();
			dataPd.put("year", year);
			dataPd.put("agent_type", agent_type);
			dataPd.put("is_constructor", is_constructor);
			String xAxisName = "";
			String yAxisName = "(Num)";
			if(type.equals("year")){
				list = sysAgentService.agentYearNum(dataPd);
				xAxisName = "(年)";
			}else if(type.equals("month")){
				list = sysAgentService.agentMonthNum(dataPd);
				xAxisName = "(月)";
			}else if(type.equals("quarter")){
				list = sysAgentService.agentQuarterNum(dataPd);
				xAxisName = "(季)";
			}
			Map<String, String> legendMap = new HashMap<String, String>();
			legendMap.put("category", "date");
			legendMap.put("数量", "num");
			option = chart.setOption(list, legendMap);
			chart.setXAxisName(option, xAxisName);
			chart.setYAxisName(option, yAxisName);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		System.out.println(option.toString());
		return option.toString();
	}
    
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
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
    
    private List<Map> getViewHistory(String processInstanceId) throws Exception{
        WorkFlow workFlow = new WorkFlow();
        //获取历史instance记录
        List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().
                                                            processInstanceId(processInstanceId).list();

        List<Map> list = new ArrayList<>();
        for (HistoricTaskInstance historicTaskInstance:historicTaskInstances
                ) {
            Map<String ,Object> map = new HashMap<String,Object>();
            map.put("task_name",historicTaskInstance.getName());

            String claim_time = Tools.date2Str(historicTaskInstance.getClaimTime(),"yyyy-MM-dd HH:mm:ss");
            String complete_time = Tools.date2Str(historicTaskInstance.getEndTime(),"yyyy-MM-dd HH:mm:ss");
            map.put("claim_time",claim_time);
            map.put("complete_time",complete_time);
            if (historicTaskInstance.getAssignee()!=null){
                //获取用户信息
                String user_id = historicTaskInstance.getAssignee();
                PageData tmp = new PageData();
                tmp.put("USER_ID",user_id);
                tmp = sysUserService.findByUiId(tmp);
                if (tmp!=null&&tmp.getString("NAME")!=null){
                    String user_name = tmp.getString("NAME");
                    map.put("user_name",user_name);
                }
            }
            //获取comment
            List<Comment> comments =  workFlow.getTaskService().getTaskComments(historicTaskInstance.getId());
            String comment = "";
            for (Comment msg :
                    comments) {
                comment = msg.getFullMessage();
            }
            map.put("comment",comment);
            //获取变量
            List<HistoricVariableInstance> historicVariableInstances = workFlow.getHistoryService().createHistoricVariableInstanceQuery().taskId(historicTaskInstance.getId()).list();
            String action ="";
            for (HistoricVariableInstance historicVariableInstance :historicVariableInstances
                    ) {
                if (historicVariableInstance.getVariableName().equals("action")){
                    action = (String) historicVariableInstance.getValue();
                }
            }
            map.put("action",action);
            list.add(map);

        }
        return list;
    }
    
/* ===============================用户================================== */
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
}
