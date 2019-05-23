package com.dncrm.controller.system.production;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.dncrm.service.system.production.ProductionService;

@RequestMapping("/production")
@Controller
public class ProductionController extends BaseController {
	@Resource(name = "productionService")
	private ProductionService productionService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;

	/**
	 * 显示基本信息（一排）
	 *
	 * @return
	 */
	@RequestMapping("/productionOne")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> productionList = productionService.listPdPageProduction(page);
			if (!productionList.isEmpty()) {
				for (PageData con : productionList) {
					String production_key = con.getString("production_key");
					if (production_key != null && !"".equals(production_key)) {
						WorkFlow workFlow = new WorkFlow();
						Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
								.active().singleResult();
						if (task != null) {
							con.put("task_id", task.getId());
							con.put("task_name", task.getName());
						}
					}
				}
			}
			mv.setViewName("system/production/one_item_list");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 显示基本信息（二排）
	 *
	 * @return
	 */
	@RequestMapping("/productionTwo")
	public ModelAndView productionTow(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> productionList = productionService.listPdPageTow(page);
			if (!productionList.isEmpty()) {
				for (PageData con : productionList) {
					String production_key = con.getString("production_key");
					if (production_key != null && !"".equals(production_key)) {
						WorkFlow workFlow = new WorkFlow();
						Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
								.active().singleResult();
						if (task != null) {
							con.put("task_id", task.getId());
							con.put("task_name", task.getName());
						}
					}
				}
			}
			mv.setViewName("system/production/tow_item_list");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 跳到创建二排单
	 * 
	 * @return
	 */
	@RequestMapping("/goAddSTow")
	public ModelAndView goAddSTow() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/production/tow_produ_edit");
		mv.addObject("msg", "saveSTow");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 保存新增二排单
	 * 
	 * @return
	 */
	@RequestMapping("/saveSTow")
	public ModelAndView saveSTow() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ('T' + time + number);
		// --------流程相关
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		String processDefinitionKey = "";
		String plan_state = "0";
		String state = null;
		String elevatorName = null;
		try {
			pd = this.getPageData();
			state = pd.getString("special_state");//是否是特批电梯
			elevatorName = pd.getString("elevator_id");
			List<PageData> straList = null;
			String production_key = "";
			if (state.equals("0")) { //0代表 不是特批电梯
				straList = productionService.Production_key(getPage());
			} else {
				if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯和扶梯
				{
					production_key = "SpecialRoutine";// 常规梯和扶梯流程id
					pd.put("production_key", production_key);// 流程的key
					straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
				} else if (elevatorName.equals("2")) // 家用梯
				{
					production_key = "SpecialDomestic";// 家用梯流程id
					pd.put("production_key", production_key); // 流程的key
					straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
				} else if (elevatorName.equals("3")) // 特种梯
				{
					production_key = "SpecialParticular";// 特种梯流程id
					pd.put("production_key", production_key);// 流程的key
					straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
				}
			}
			// 查询流程是否存在
			if (straList != null) {
				pd.put("pro_uuid", UUID.randomUUID().toString());
				pd.put("approval", 0); // 流程状态 0代表待启动
				pd.put("production_key", "Production"); // 流程的key
				pd.put("requester_id", USER_ID); // 录入信息请求启动的用户ID
				pd.put("pro_no", pro_no);
				pd.put("plan_state", plan_state);
				pd.put("special_state", state);// 是不是特批电梯
				productionService.saveSTow(pd); // 保存基本信息
				mv.addObject("msg", "success");
			} else {
				mv.addObject("msg", "流程不存在");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
			e.printStackTrace();
		}
		// -----流程相关
		try {
			if (state.equals("0")) {
				processDefinitionKey = "Production";
			} else {
				if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯和 扶梯
				{
					processDefinitionKey = "SpecialRoutine";
				} else if (elevatorName.equals("2")) // 家用梯
				{
					processDefinitionKey = "SpecialDomestic";
				} else if (elevatorName.equals("3")) // 特种梯
				{
					processDefinitionKey = "SpecialParticular";
				}
			}
			WorkFlow workFlow = new WorkFlow();
			IdentityService identityService = workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId = pd.get("pro_uuid");
			String businessKey = "tb_production_towrow.pro_uuid." + uuId;
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance = null; // 流程1
			if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,
						businessKey, variables);
			}
			if (proessInstance != null) {
				pd.put("production_key", proessInstance.getId());
			} else {
				productionService.delTowfindById(pd);// 删除信息
				mv.addObject("msg", "failed");
				mv.addObject("err", "保存失败！");
			}
			productionService.editSTow(pd); // 修改基本信息 --
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "流程不存在！");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 跳到创建一排单
	 * 
	 * @return
	 */
	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/production/one_produ_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 保存新增一排单
	 * 
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ('Y'+time + number);
		// --------流程相关
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		String processDefinitionKey = "";
		String plan_state = "0"; //排产状态  0.未添加到排产计划  1.已添加到排产计划
		pd = this.getPageData();
		String elevatorID=pd.getString("elevator_id");
		try {
			// 根据梯种   查询相应  流程是否存在
			List<PageData> straList = null ;
			if(elevatorID.equals("1") || elevatorID.equals("4"))//1.常规梯 || 4.扶梯
			{
				pd.put("production_key", "OneGeneralProduction");//常规流程key（扶梯共用）
				straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
			}
			else if(elevatorID.equals("2"))//2.家用梯
			{
				pd.put("production_key", "OneDomesticProduction");//家用流程key
				straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
			}
			else if(elevatorID.equals("3"))//3.特种梯
			{
				pd.put("production_key", "OneSpecialProduction");//特种流程key
				straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
			}
			else 
			{
				mv.addObject("msg", "电梯种类有误！");
			}
			
			if (straList != null) {
				pd.put("pro_uuid", UUID.randomUUID().toString());
				pd.put("approval", 0); // 流程状态 0代表待启动
				/*pd.put("production_key", "Production");*/
				pd.put("requester_id", USER_ID); // 录入信息请求启动的用户ID
				pd.put("pro_no", pro_no);
				pd.put("plan_state", plan_state);
				pd.put("special_state", 0);// 是不是特批电梯 0代表不是
				productionService.saveS(pd); // 保存基本信息
				mv.addObject("msg", "success");
			} else {
				mv.addObject("msg", "流程不存在");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
			e.printStackTrace();
		}
		// -----流程相关
		try {
			//*******************常规梯  排产流程
			if(elevatorID.equals("1") || elevatorID.equals("4"))
			{
				processDefinitionKey = "OneGeneralProduction";
				WorkFlow workFlow = new WorkFlow();
				IdentityService identityService = workFlow.getIdentityService();
				identityService.setAuthenticatedUserId(USER_ID);
				Object uuId = pd.get("pro_uuid");
				String businessKey = "tb_production_onerow.pro_uuid." + uuId;
				Map<String, Object> variables = new HashMap<String, Object>();
				variables.put("user_id", USER_ID);
				ProcessInstance proessInstance = null; // 流程1
				if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
					proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
				}
				if (proessInstance != null) {
					pd.put("production_key", proessInstance.getId());
				} else {
					productionService.delfindById(pd);// 删除信息
					mv.addObject("msg", "failed");
					mv.addObject("err", "保存失败！");
				}
			}
			else if(elevatorID.equals("2"))
			{
				processDefinitionKey = "OneDomesticProduction";
				WorkFlow workFlow = new WorkFlow();
				IdentityService identityService = workFlow.getIdentityService();
				identityService.setAuthenticatedUserId(USER_ID);
				Object uuId = pd.get("pro_uuid");
				String businessKey = "tb_production_onerow.pro_uuid." + uuId;
				Map<String, Object> variables = new HashMap<String, Object>();
				variables.put("user_id", USER_ID);
				ProcessInstance proessInstance = null; // 流程1
				if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
					proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
				}
				if (proessInstance != null) {
					pd.put("production_key", proessInstance.getId());
				} else {
					productionService.delfindById(pd);// 删除信息
					mv.addObject("msg", "failed");
					mv.addObject("err", "保存失败！");
				}
			}
			else if(elevatorID.equals("3"))
			{
				processDefinitionKey = "OneSpecialProduction";
				WorkFlow workFlow = new WorkFlow();
				IdentityService identityService = workFlow.getIdentityService();
				identityService.setAuthenticatedUserId(USER_ID);
				Object uuId = pd.get("pro_uuid");
				String businessKey = "tb_production_onerow.pro_uuid." + uuId;
				Map<String, Object> variables = new HashMap<String, Object>();
				variables.put("user_id", USER_ID);
				ProcessInstance proessInstance = null; // 流程1
				if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
					proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
				}
				if (proessInstance != null) {
					pd.put("production_key", proessInstance.getId());
				} else {
					productionService.delfindById(pd);// 删除信息
					mv.addObject("msg", "failed");
					mv.addObject("err", "保存失败！");
				}
			}else{mv.addObject("err", "梯种不存在！");}
			
			productionService.editS(pd); // 修改基本信息
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "流程不存在！");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
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
			pd = productionService.findProById(pd);
			mv.setViewName("system/production/one_produ_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 跳到编辑页面（二排）
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goEditSTow")
	public ModelAndView goEditSTow() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = productionService.findSpetowById(pd);
			mv.setViewName("system/production/tow_produ_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editSTow");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存编辑（二排）
	 *
	 * @return
	 */
	@RequestMapping("/editSTow")
	public ModelAndView editSTow() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			productionService.editSTow(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditItem");
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
		try {
			pd = this.getPageData();
			productionService.editS(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 启动流程（二排）
	 * 
	 * @return
	 */
	@RequestMapping(value = "/applytow")
	@ResponseBody
	public Object applyTow() {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<>();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID"); // 当前登录用户的ID
			String production_key = pd.getString("production_key"); // 流程Key
			// 如果流程存在就启动流程
			if (production_key != null && !"".equals(production_key)) {
				WorkFlow workFlow = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
						.singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
				// 签收任务
				workFlow.getTaskService().claim(task.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
				pd.put("approval", 1); // 流程状态 1代表流程启动,等待审核
				productionService.upProTowApproval(pd);// 更新流程状态
				workFlow.getTaskService().complete(task.getId());
				// 获取下一个任务的信息
				Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
						.singleResult();
				map.put("task_name", tasks.getName());
				map.put("status", "1");
			}
			if ((production_key != null && !"".equals(production_key))) {
				map.put("status", "3");
			}
			map.put("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			map.put("msg", "failed");
			map.put("err", "系统错误");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 启动流程（一排）
	 * 
	 * @return
	 */
	@RequestMapping(value = "/apply")
	@ResponseBody
	public Object apply() {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<>();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID"); // 当前登录用户的ID
			String production_key = pd.getString("production_key"); // 流程Key
			// 如果流程存在就启动流程
			if (production_key != null && !"".equals(production_key)) {
				WorkFlow workFlow = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
						.singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
				// 签收任务
				workFlow.getTaskService().claim(task.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
				pd.put("approval", 1); // 流程状态 1代表流程启动,等待审核
				productionService.updateProApproval(pd);// 更新流程状态
				workFlow.getTaskService().complete(task.getId());
				// 获取下一个任务的信息
				Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(production_key)
						.singleResult();
				map.put("task_name", tasks.getName());
				map.put("status", "1");
			}
			if ((production_key != null && !"".equals(production_key))) {
				map.put("status", "3");
			}
			map.put("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			map.put("msg", "failed");
			map.put("err", "系统错误");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 重新提交申请（二排）
	 *
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/restartTow")
	@ResponseBody
	public Object restartTow() {
		Map map = new HashMap();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 签收任务
			List<PageData> agents = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id"); // 流程id
			String user_id = pds.getString("USER_ID");
			workFlow.getTaskService().claim(task_id, user_id);
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("action", "重新提交");
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			// 处理任务
			workFlow.getTaskService().complete(task_id);
			// 更新业务数据的状态
			pd.put("approval", 1);
			productionService.upProTowApproval(pd);// 更新流程状态
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "重新提交失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 重新提交申请（一排）
	 *
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/restartAgent")
	@ResponseBody
	public Object restartAgent() {
		Map map = new HashMap();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 签收任务
			List<PageData> agents = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id"); // 流程id
			String user_id = pds.getString("USER_ID");
			workFlow.getTaskService().claim(task_id, user_id);
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("action", "重新提交");
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			// 处理任务
			workFlow.getTaskService().complete(task_id);
			// 更新业务数据的状态
			pd.put("approval", 1);
			productionService.updateProApproval(pd);// 更新流程状态
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "重新提交失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 显示待我处理的（一排）
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/productionOneAudit")
	public ModelAndView listPendingContractor(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/production/productionOne_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			List<PageData> stras = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			// 等待处理的任务
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			//常规梯  流程  任务数量
			List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneGeneralProduction").orderByTaskCreateTime().desc().active().list();
			
			//常规梯  任务详细信息
			List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneGeneralProduction").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
			for (Task task : toHandleList) {
				PageData stra1 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra1.put(info[1], info[2]);
					stra1 = productionService.findByuuId(stra1); // 根据uuid查询信息
					if(stra1==null)
					{
						continue;
					}
					stra1.put("task_name", task.getName());
					stra1.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra1.put("type", "1");// 待处理
					} else {
						stra1.put("type", "0");// 待签收
					}
				}
				stras.add(stra1);
			}
			
			//家用梯  流程  任务数量
			List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneDomesticProduction").orderByTaskCreateTime().desc().active().list();
			
			//家用梯  任务详细信息
			List<Task> toHandleList2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneDomesticProduction").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
			for (Task task : toHandleList2) {
				PageData stra2 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra2.put(info[1], info[2]);
					stra2 = productionService.findByuuId(stra2); // 根据uuid查询信息
					if(stra2==null)
					{
						continue;
					}
					stra2.put("task_name", task.getName());
					stra2.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra2.put("type", "1");// 待处理
					} else {
						stra2.put("type", "0");// 待签收
					}
				}
				stras.add(stra2);
			}
			
			
			//特种梯  流程  任务数量
			List<Task> toHandleListCount3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneSpecialProduction").orderByTaskCreateTime().desc().active().list();
			
			//特种梯  任务详细信息
			List<Task> toHandleList3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("OneSpecialProduction").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
			for (Task task : toHandleList3) {
				PageData stra3 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra3.put(info[1], info[2]);
					stra3 = productionService.findByuuId(stra3); // 根据uuid查询信息
					if(stra3==null)
					{
						continue;
					}
					stra3.put("task_name", task.getName());
					stra3.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra3.put("type", "1");// 待处理
					} else {
						stra3.put("type", "0");// 待签收
					}
				}
				stras.add(stra3);
			}
			
			
			// 设置分页数据
			int totalResult = toHandleListCount.size()+toHandleListCount2.size()+toHandleListCount3.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(stras.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(1);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			pd.put("count", toHandleListCount.size());
			pd.put("isActive2", "1");
			mv.addObject("pd", pd);
			mv.addObject("stras", stras);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 显示待我处理的（二排）
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/productionTowAudit")
	public ModelAndView listPendingTow(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/production/productionTow_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			List<PageData> stras = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			// 等待处理的任务
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("Production").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("Production").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList) {
				PageData stra = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findTowByuuId(stra); // 根据uuid查询信息
					if(stra==null)
					{
						continue;
					}
					stra.put("task_name", task.getName());
					stra.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra.put("type", "1");// 待处理
					} else {
						stra.put("type", "0");// 待签收
					}
				}
				stras.add(stra);
			}
			// 设置分页数据
			int totalResult = toHandleListCount.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(stras.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(1);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			pd.put("count", toHandleListCount.size());
			pd.put("isActive2", "1");
			mv.addObject("pd", pd);
			mv.addObject("stras", stras);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 请求跳转查看页面（二排）
	 * 
	 * @param con_id
	 * @return
	 */
	@RequestMapping(value = "/toViewTow")
	public ModelAndView toViewTow(String agent_id) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = productionService.findProtowById(pd);
			mv.setViewName("system/production/tow_produ_view");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 请求跳转查看页面（一排）
	 * 
	 * @param con_id
	 * @return
	 */
	@RequestMapping(value = "/toView")
	public ModelAndView toView(String agent_id) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = productionService.findProById(pd);
			mv.setViewName("system/production/one_produ_view");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 签收任务(一排)
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/claim")
	@ResponseBody
	public Object claim() {
		Map map = new HashMap();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			workFlow.getTaskService().claim(task_id, user_id);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "签收失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 签收任务（二排）
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/claimTow")
	@ResponseBody
	public Object claimTow() {
		Map map = new HashMap();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			workFlow.getTaskService().claim(task_id, user_id);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "签收失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 跳到办理任务页面（二排）
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goHandStraTow")
	public ModelAndView goHandleAgentTow() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/production/tow_produ_handle");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳到办理任务页面(一排)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goHandStra")
	public ModelAndView goHandleAgent() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/production/one_produ_handle");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 办理任务（二排）
	 * 
	 * @return
	 */
	@RequestMapping("/handleAgentTow")
	public ModelAndView handleAgentTow() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 办理任务
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			Map<String, Object> variables = new HashMap<String, Object>();
			boolean isApproved = false;
			boolean isEnd = false;
			String action = pd.getString("action");
			@SuppressWarnings("unused")
			int status;
			if (action.equals("approve")) {
				Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
				if (task.getTaskDefinitionKey().equals("ConstituentCompanyManager")) // 分子公司总经理节点
				{
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.upProTowApproval(pd); // 更新流程状态
				} else {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					productionService.upProTowApproval(pd);// 更新流程状态
				}
			} else if (action.equals("reject")) {
				status = 4;// 被驳回
				pd.put("approval", 4); // 流程状态 4代表 被驳回
				variables.put("approved", false);
				productionService.upProTowApproval(pd);// 更新流程状态
			}
			String comment = (String) pd.get("comment");
			if (isApproved) {
				variables.put("action", "批准");
			} else {
				variables.put("action", "驳回");
			}
			if (isEnd) {
				variables.put("action", "通过,流程结束！");
			}
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			workFlow.getTaskService().addComment(task_id, null, comment);
			workFlow.getTaskService().complete(task_id, variables);
			mv.addObject("msg", "success");
		} catch (Exception e) {
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
	 * 办理任务(一排)
	 * 
	 * @return
	 */
	@RequestMapping("/handleAgent")
	public ModelAndView handleAgent() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 办理任务
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			Map<String, Object> variables = new HashMap<String, Object>();
			boolean isApproved = false;
			boolean isEnd = false;
			String action = pd.getString("action");
			@SuppressWarnings("unused")
			int status;
			if (action.equals("approve")) {
				Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
				if (task.getTaskDefinitionKey().equals("ConstituentCompanyManager")) // 分子公司总经理节点
				{
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.updateProApproval(pd);// 更新流程状态
				} else {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					productionService.updateProApproval(pd);// 更新流程状态
				}
			} else if (action.equals("reject")) {
				status = 4;// 被驳回
				pd.put("approval", 4); // 流程状态 4代表 被驳回
				variables.put("approved", false);
				productionService.updateProApproval(pd);// 更新流程状态
			}
			String comment = (String) pd.get("comment");
			if (isApproved) {
				variables.put("action", "批准");
			} else {
				variables.put("action", "驳回");
			}
			if (isEnd) {
				variables.put("action", "通过,流程结束！");
			}
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			workFlow.getTaskService().addComment(task_id, null, comment);
			workFlow.getTaskService().complete(task_id, variables);
			mv.addObject("msg", "success");
		} catch (Exception e) {
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
	 * 显示我已经处理的合同审核（二排）
	 *
	 * @return
	 */
	@RequestMapping("/listDoneStraTow")
	public ModelAndView listDoneTow(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/production/productionTow_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			WorkFlow workFlow = new WorkFlow();
			// 已处理的任务
			List<PageData> strates = new ArrayList<>();
			List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("Production")
					.orderByTaskCreateTime().desc().list();
			// 移除重复的
			List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
			HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();
			for (HistoricTaskInstance instance : historicTaskInstances) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			@SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
			while (iter.hasNext()) {
				@SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
				list.add((HistoricTaskInstance) entry.getValue());
			}
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			int listCount = (list.size() <= maxResults ? list.size() : maxResults);
			// 从分页参数开始
			for (int i = firstResult; i < listCount; i++) {
				HistoricTaskInstance historicTaskInstance = list.get(i);
				PageData stra = new PageData();
				String processInstanceId = historicTaskInstance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findTowByuuId(stra); // 根据uuid查询信息
					if(stra==null)
					{
						continue;
					}
					// 检查申请者是否是本人,如果是,跳过
					if (stra.getString("requester_id").equals(USER_ID))
						continue;
					// 查询当前流程是否还存在
					List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery()
							.processInstanceId(processInstanceId).list();
					if (stra != null) {
						if (runing == null || runing.size() <= 0) {
							stra.put("isRuning", 0);
						} else {
							stra.put("isRuning", 1);
							// 正在运行,查询当前的任务信息
							Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
									.singleResult();
							stra.put("task_name", task.getName());
							stra.put("task_id", task.getId());
						}
					}
					strates.add(stra);
				}
			}
			// 设置分页数据
			int totalResult = list.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(strates.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(2);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			WorkFlow workflow = new WorkFlow();
			List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.orderByTaskCreateTime().desc().active().list();
			pd.put("count", toHandleListCount.size());
			pd.put("isActive3", "1");
			mv.addObject("pd", pd);
			mv.addObject("strates", strates);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 显示我已经处理的排产审核（一排）
	 * 
	 * @return
	 */
	@RequestMapping("/listDoneStra")
	public ModelAndView listDoneContractor(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/production/productionOne_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			WorkFlow workFlow = new WorkFlow();
			// 已处理的任务
			List<PageData> strates = new ArrayList<>();
			//常规梯 已处理的任务
			List<HistoricTaskInstance> historicTaskInstances1 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("OneGeneralProduction")
					.orderByTaskCreateTime().desc().list();
			//家用梯 已处理的任务
			List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("OneDomesticProduction")
					.orderByTaskCreateTime().desc().list();
			//特种梯 已处理的任务
			List<HistoricTaskInstance> historicTaskInstances3 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("OneSpecialProduction")
					.orderByTaskCreateTime().desc().list();
			
			
			List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
			HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();
			// 移除   常规梯   重复的
			for (HistoricTaskInstance instance : historicTaskInstances1) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 移除   家用梯   重复的
			for (HistoricTaskInstance instance : historicTaskInstances2) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 移除   特种梯   重复的
			for (HistoricTaskInstance instance : historicTaskInstances3) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			
			@SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
			while (iter.hasNext()) {
				@SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
				list.add((HistoricTaskInstance) entry.getValue());
			}
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			int listCount = (list.size() <= maxResults ? list.size() : maxResults);
			// 从分页参数开始
			for (int i = firstResult; i < listCount; i++) {
				HistoricTaskInstance historicTaskInstance = list.get(i);
				PageData stra = new PageData();
				String processInstanceId = historicTaskInstance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findByuuId(stra); // 根据uuid查询信息
					if(stra==null)
					{
						continue;
					}
					// 检查申请者是否是本人,如果是,跳过
					if (stra.getString("requester_id").equals(USER_ID))
						continue;
					// 查询当前流程是否还存在
					List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery()
							.processInstanceId(processInstanceId).list();
					if (stra != null) {
						if (runing == null || runing.size() <= 0) {
							stra.put("isRuning", 0);
						} else {
							stra.put("isRuning", 1);
							// 正在运行,查询当前的任务信息
							Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
									.singleResult();
							stra.put("task_name", task.getName());
							stra.put("task_id", task.getId());
						}
					}
					strates.add(stra);
				}
			}
			// 设置分页数据
			int totalResult = list.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(strates.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(2);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			WorkFlow workflow = new WorkFlow();
			List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.orderByTaskCreateTime().desc().active().list();
			pd.put("count", toHandleListCount.size());
			pd.put("isActive3", "1");
			mv.addObject("pd", pd);
			mv.addObject("strates", strates);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/*
	 * ===============================分割线(特批相关内容)===============================
	 * ===
	 */

	/**
	 * 显示全部报价完成的项目
	 *
	 * @return
	 */
	@RequestMapping("/special")
	public ModelAndView speciallistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			page.setPd(pd);
			List<PageData> itemList = productionService.speciallistPage(page);
			mv.setViewName("system/special/one_special_item");
			mv.addObject("itemList", itemList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 根据项目ID查询所属项目的电梯信息
	 *
	 * @return
	 */
	@RequestMapping("/elevatorDetails")
	public ModelAndView elevatorDetailsllistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		try {
			page.setPd(pd);
			List<PageData> productionList = productionService.elevatorlistPage(page);
			if (!productionList.isEmpty()) {
				for (PageData con : productionList) {
					String special_key = con.getString("production_key");
					if (special_key != null && !"".equals(special_key)) {
						WorkFlow workFlow = new WorkFlow();
						Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(special_key).active()
								.singleResult();
						if (task != null) {
							con.put("task_id", task.getId());
							con.put("task_name", task.getName());
						}
					}
				}
			}
			mv.setViewName("system/special/one_special_elevator");
			mv.addObject("productionList", productionList);
			mv.addObject("page", page);
			mv.addObject("pd", pd);
			mv.addObject("stra_name", pd.get("stra_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 显示待我处理得任务（特批任务）
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/OneSpecialApproval")
	public ModelAndView listOneSpecial(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/special/specialOne_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			List<PageData> stras = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			// 等待处理的任务
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			// 家用梯流程
			List<Task> toHandleListCount1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialDomestic").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialDomestic").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList1) {
				PageData stra = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findByuuId(stra); // 根据uuid查询信息
                    if(stra==null)
                    {
                    	continue;
                    }
					stra.put("task_name", task.getName());
					stra.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra.put("type", "1");// 待处理
					} else {
						stra.put("type", "0");// 待签收
					}
				}
				stras.add(stra);
			}
			// 常规梯流程
			List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialRoutine").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialRoutine").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList2) {
				PageData stra2 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra2.put(info[1], info[2]);
					stra2 = productionService.findByuuId(stra2); // 根据uuid查询信息
					stra2.put("task_name", task.getName());
					stra2.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra2.put("type", "1");// 待处理
					} else {
						stra2.put("type", "0");// 待签收
					}
				}
				stras.add(stra2);
			}
			// 特种梯流程
			List<Task> toHandleListCount3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialParticular").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialParticular").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList3) {
				PageData stra3 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra3.put(info[1], info[2]);
					stra3 = productionService.findByuuId(stra3); // 根据uuid查询信息
					stra3.put("task_name", task.getName());
					stra3.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra3.put("type", "1");// 待处理
					} else {
						stra3.put("type", "0");// 待签收
					}
				}
				stras.add(stra3);
			}

			// 设置分页数据
			int totalResult = toHandleListCount1.size() + toHandleListCount2.size() + toHandleListCount3.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(stras.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(1);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			pd.put("count", totalResult);
			pd.put("isActive2", "1");
			mv.addObject("pd", pd);
			mv.addObject("stras", stras);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 跳转到创建特批页面
	 * 
	 * @return
	 */
	@RequestMapping("/AddSpecial")
	public ModelAndView AddSpecial() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/special/one_special_edit");
		mv.addObject("msg", "specialEdit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 保存新增特批排产
	 * 
	 * @return
	 */
	@RequestMapping("/specialEdit")
	public ModelAndView specialEdit() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000);
		String pro_no = ("S" + time + number);
		// --------流程相关
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		String processDefinitionKey = "";
		String plan_state = "0";
		pd = this.getPageData();
		String elevatorName = pd.getString("elevator_id");
		try {
			List<PageData> straList = null;
			if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯 和
																		// 扶梯
			{
				String production_key = "SpecialRoutine";// 常规梯和扶梯流程id
				pd.put("production_key", production_key);
				pd.put("production_key", "SpecialRoutine"); // 流程的key
				straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
			} else if (elevatorName.equals("2")) // 家用梯
			{
				String production_key = "SpecialDomestic";// 家用梯流程id
				pd.put("production_key", production_key);
				pd.put("production_key", "SpecialDomestic"); // 流程的key
				straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
			} else if (elevatorName.equals("3")) // 特种梯
			{
				String production_key = "SpecialParticular";// 特种梯流程id
				pd.put("production_key", production_key);
				pd.put("production_key", "SpecialParticular"); // 流程的key
				straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
			}
			// 查询流程是否存在
			if (straList != null) {
				pd.put("pro_uuid", UUID.randomUUID().toString());
				pd.put("approval", 0); // 流程状态 0代表待启动
				pd.put("requester_id", USER_ID); // 录入信息请求启动的用户ID
				pd.put("pro_no", pro_no);
				pd.put("plan_state", plan_state);// 排产计划状态0代表还未添加到排产计划
				pd.put("special_state", 1);// 是否是特批电梯 1代表是特批电梯
				productionService.saveS(pd); // 保存基本信息
				mv.addObject("msg", "success");
			} else {
				mv.addObject("msg", "流程不存在");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
			e.printStackTrace();
		}
		// -----流程相关
		try {
			if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯 和
																		// 扶梯
			{
				processDefinitionKey = "SpecialRoutine";
			} else if (elevatorName.equals("2")) // 家用梯
			{
				processDefinitionKey = "SpecialDomestic";
			} else if (elevatorName.equals("3")) // 特种梯
			{
				processDefinitionKey = "SpecialParticular";
			}
			WorkFlow workFlow = new WorkFlow();
			IdentityService identityService = workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId = pd.get("pro_uuid");
			String businessKey = "tb_production_onerow.pro_uuid." + uuId;
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance = null; // 流程1
			if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,
						businessKey, variables);
			}
			if (proessInstance != null) {
				pd.put("production_key", proessInstance.getId());
			} else {
				productionService.delfindById(pd);// 删除信息
				mv.addObject("msg", "failed");
				mv.addObject("err", "保存失败！");
			}
			productionService.editS(pd); // 修改基本信息
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "流程不存在！");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 启动流程
	 * 
	 * @return
	 */
	@RequestMapping(value = "/applySpecial")
	@ResponseBody
	public Object applySpecial() {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<>();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID"); // 当前登录用户的ID
			String special_key = pd.getString("production_key"); // 流程Key
			// 如果流程存在就启动流程
			if (special_key != null && !"".equals(special_key)) {
				WorkFlow workFlow = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(special_key).singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
				// 签收任务
				workFlow.getTaskService().claim(task.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
				pd.put("approval", 1); // 流程状态 1代表流程启动,等待审核
				productionService.updateProApproval(pd);// 更新流程状态
				workFlow.getTaskService().complete(task.getId());
				// 获取下一个任务的信息
				Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(special_key).singleResult();
				map.put("task_name", tasks.getName());
				map.put("status", "1");
			}
			if ((special_key != null && !"".equals(special_key))) {
				map.put("status", "3");
			}
			map.put("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			map.put("msg", "failed");
			map.put("err", "系统错误");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 请求跳转查看页面
	 * 
	 * @param con_id
	 * @return
	 */
	@RequestMapping(value = "/toViewSpecial")
	public ModelAndView toViewSpecial(String agent_id) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = productionService.findProById(pd);
			mv.setViewName("system/special/one_special_view");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 办理任务
	 * 
	 * @return
	 */
	@RequestMapping("/goSpecial")
	public ModelAndView goSpecial() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 办理任务
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			Map<String, Object> variables = new HashMap<String, Object>();
			boolean isApproved = false;
			boolean isEnd = false;
			String action = pd.getString("action");
			@SuppressWarnings("unused")
			int status;
			if (action.equals("approve")) {
				Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
				if (task.getTaskDefinitionKey().equals("DomesticManager")) // 家用梯工厂总经理
				{
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.updateProApproval(pd);// 更新流程状态
				} else if (task.getTaskDefinitionKey().equals("ParticularManager")) {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.updateProApproval(pd);// 更新流程状态
				} else if (task.getTaskDefinitionKey().equals("RoutineManager")) {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.updateProApproval(pd);// 更新流程状态
				} else {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					productionService.updateProApproval(pd);// 更新流程状态
				}
			} else if (action.equals("reject")) {
				status = 4;// 被驳回
				pd.put("approval", 4); // 流程状态 4代表 被驳回
				variables.put("approved", false);
				productionService.updateProApproval(pd);// 更新流程状态
			}
			String comment = (String) pd.get("comment");
			if (isApproved) {
				variables.put("action", "批准");
			} else {
				variables.put("action", "驳回");
			}
			if (isEnd) {
				variables.put("action", "通过,流程结束！");
			}
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			workFlow.getTaskService().addComment(task_id, null, comment);
			workFlow.getTaskService().complete(task_id, variables);
			mv.addObject("msg", "success");
		} catch (Exception e) {
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
	 * 跳到办理任务页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goHandleSpecial")
	public ModelAndView goHandleSpecial() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/special/one_special_handle");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 跳到办理任务页面(二排特批)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goHandleTowSpecial")
	public ModelAndView goHandleTowSpecial() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/special/tow_special_handle");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 重新提交申请
	 *
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/restartSpecial")
	@ResponseBody
	public Object restartSpecial() {
		Map map = new HashMap();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 签收任务
			List<PageData> agents = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id"); // 流程id
			String user_id = pds.getString("USER_ID");
			workFlow.getTaskService().claim(task_id, user_id);
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("action", "重新提交");
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			// 处理任务
			workFlow.getTaskService().complete(task_id);
			// 更新业务数据的状态
			pd.put("approval", 1);
			productionService.updateProApproval(pd);// 更新流程状态
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "重新提交失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 显示我已经处理的合同审核（一排特批）
	 *
	 * @return
	 */
	@RequestMapping("/listSpecial")
	public ModelAndView listSpecial(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/special/specialOne_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			WorkFlow workFlow = new WorkFlow();
			// 已处理的任务(家用梯流程)
			List<PageData> strates = new ArrayList<>();
			List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialDomestic")
					.orderByTaskCreateTime().desc().list();
			// 移除重复的
			List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
			HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();
			for (HistoricTaskInstance instance : historicTaskInstances) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 已处理的任务（常规梯流程）
			List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialRoutine")
					.orderByTaskCreateTime().desc().list();
			for (HistoricTaskInstance instance : historicTaskInstances2) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 已处理的任务（特种梯流程）
			List<HistoricTaskInstance> historicTaskInstances3 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialParticular")
					.orderByTaskCreateTime().desc().list();
			for (HistoricTaskInstance instance : historicTaskInstances3) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			@SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
			while (iter.hasNext()) {
				@SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
				list.add((HistoricTaskInstance) entry.getValue());
			}
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			int listCount = (list.size() <= maxResults ? list.size() : maxResults);
			// 从分页参数开始
			for (int i = firstResult; i < listCount; i++) {
				HistoricTaskInstance historicTaskInstance = list.get(i);
				PageData stra = new PageData();
				String processInstanceId = historicTaskInstance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findByuuId(stra); // 根据uuid查询信息
					if(stra==null)
					{
						continue;
					}
					// 检查申请者是否是本人,如果是,跳过
					if (stra.getString("requester_id").equals(USER_ID))
						continue;
					// 查询当前流程是否还存在
					List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery()
							.processInstanceId(processInstanceId).list();
					if (stra != null) {
						if (runing == null || runing.size() <= 0) {
							stra.put("isRuning", 0);
						} else {
							stra.put("isRuning", 1);
							// 正在运行,查询当前的任务信息
							Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
									.singleResult();
							stra.put("task_name", task.getName());
							stra.put("task_id", task.getId());
						}
					}
					strates.add(stra);
				}
			}
			// 设置分页数据
			int totalResult = list.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(strates.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(2);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			WorkFlow workflow = new WorkFlow();
			List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.orderByTaskCreateTime().desc().active().list();
			pd.put("count", toHandleListCount.size());
			pd.put("isActive3", "1");
			mv.addObject("pd", pd);
			mv.addObject("strates", strates);
			mv.addObject("userpds", pds);
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
	@RequestMapping("/goEditSpecial")
	public ModelAndView goEditSpecial() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = productionService.findSpetowById(pd);
			mv.setViewName("system/special/one_special_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editSpecial");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存编辑
	 *
	 * @return
	 */
	@RequestMapping("/editSpecial")
	public ModelAndView editSpecial() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			productionService.upSpecialfindById(pd); // 保存编辑
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	// =========================(二排 特批)===============================
	/**
	 * 启动流程
	 * 
	 * @return
	 */
	@RequestMapping(value = "/applytowSpecial")
	@ResponseBody
	public Object applytowSpecial() {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<>();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID"); // 当前登录用户的ID
			String special_key = pd.getString("production_key"); // 流程Key
			// 如果流程存在就启动流程
			if (special_key != null && !"".equals(special_key)) {
				WorkFlow workFlow = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(special_key).singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
				// 签收任务
				workFlow.getTaskService().claim(task.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
				pd.put("approval", 1); // 流程状态 1代表流程启动,等待审核
				productionService.upProTowApproval(pd);// 更新流程状态
				workFlow.getTaskService().complete(task.getId());
				// 获取下一个任务的信息
				Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(special_key).singleResult();
				map.put("task_name", tasks.getName());
				map.put("status", "1");
			}
			if ((special_key != null && !"".equals(special_key))) {
				map.put("status", "3");
			}
			map.put("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			map.put("msg", "failed");
			map.put("err", "系统错误");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 显示待我处理得任务（特批任务）
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/TowSpecialApproval")
	public ModelAndView TowSpecialApproval(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/special/specialTow_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			List<PageData> stras = new ArrayList<>();
			WorkFlow workFlow = new WorkFlow();
			// 等待处理的任务
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			// 家用梯流程
			List<Task> toHandleListCount1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialDomestic").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialDomestic").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList1) {
				PageData stra = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findTowByuuId(stra); // 根据uuid查询信息
                    if(stra==null)
                    {
                    	continue;
                    }
					stra.put("task_name", task.getName());
					stra.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra.put("type", "1");// 待处理
					} else {
						stra.put("type", "0");// 待签收
					}
				}
				stras.add(stra);
			}
			// 常规梯流程
			List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialRoutine").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialRoutine").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList2) {
				PageData stra2 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra2.put(info[1], info[2]);
					stra2 = productionService.findTowByuuId(stra2); // 根据uuid查询信息
					stra2.put("task_name", task.getName());
					stra2.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra2.put("type", "1");// 待处理
					} else {
						stra2.put("type", "0");// 待签收
					}
				}
				stras.add(stra2);
			}
			// 特种梯流程
			List<Task> toHandleListCount3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialParticular").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialParticular").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList3) {
				PageData stra3 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra3.put(info[1], info[2]);
					stra3 = productionService.findTowByuuId(stra3); // 根据uuid查询信息
					stra3.put("task_name", task.getName());
					stra3.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						stra3.put("type", "1");// 待处理
					} else {
						stra3.put("type", "0");// 待签收
					}
				}
				stras.add(stra3);
			}

			// 设置分页数据
			int totalResult = toHandleListCount1.size() + toHandleListCount2.size() + toHandleListCount3.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(stras.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(1);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			pd.put("count", totalResult);
			pd.put("isActive2", "1");
			mv.addObject("pd", pd);
			mv.addObject("stras", stras);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 办理任务（二排特批）
	 * 
	 * @return
	 */
	@RequestMapping("/goSpecialTow")
	public ModelAndView goSpecialTow() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			// 办理任务
			WorkFlow workFlow = new WorkFlow();
			String task_id = pd.getString("task_id");
			String user_id = pds.getString("USER_ID");
			Map<String, Object> variables = new HashMap<String, Object>();
			boolean isApproved = false;
			boolean isEnd = false;
			String action = pd.getString("action");
			@SuppressWarnings("unused")
			int status;
			if (action.equals("approve")) {
				Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
				if (task.getTaskDefinitionKey().equals("DomesticManager")) // 家用梯工厂总经理
				{
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.upProTowApproval(pd);// 更新流程状态
				} else if (task.getTaskDefinitionKey().equals("ParticularManager")) {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.upProTowApproval(pd);// 更新流程状态
				} else if (task.getTaskDefinitionKey().equals("RoutineManager")) {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 2); // 流程状态 2代表流程结束
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					isEnd = true;
					productionService.upProTowApproval(pd);// 更新流程状态
				} else {
					status = 2; // 已完成
					int type = 1;
					pd.put("approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					variables.put("type", type);
					isApproved = true;
					productionService.upProTowApproval(pd);// 更新流程状态
				}
			} else if (action.equals("reject")) {
				status = 4;// 被驳回
				pd.put("approval", 4); // 流程状态 4代表 被驳回
				variables.put("approved", false);
				productionService.upProTowApproval(pd);// 更新流程状态
			}
			String comment = (String) pd.get("comment");
			if (isApproved) {
				variables.put("action", "批准");
			} else {
				variables.put("action", "驳回");
			}
			if (isEnd) {
				variables.put("action", "通过,流程结束！");
			}
			// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
			workFlow.getTaskService().setVariablesLocal(task_id, variables);
			Authentication.setAuthenticatedUserId(user_id);
			workFlow.getTaskService().addComment(task_id, null, comment);
			workFlow.getTaskService().complete(task_id, variables);
			mv.addObject("msg", "success");
		} catch (Exception e) {
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
	 * 显示我已经处理的合同审核（一排特批）
	 *
	 * @return
	 */
	@RequestMapping("/TowlistSpecial")
	public ModelAndView TowlistSpecial(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			PageData pds = new PageData();
			pds = (PageData) session.getAttribute("userpds");
			String USER_ID = pds.getString("USER_ID");
			page.setPd(pds);
			mv.setViewName("system/special/specialTow_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			WorkFlow workFlow = new WorkFlow();
			// 已处理的任务(家用梯流程)
			List<PageData> strates = new ArrayList<>();
			List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialDomestic")
					.orderByTaskCreateTime().desc().list();
			// 移除重复的
			List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
			HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();
			for (HistoricTaskInstance instance : historicTaskInstances) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 已处理的任务（常规梯流程）
			List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialRoutine")
					.orderByTaskCreateTime().desc().list();
			for (HistoricTaskInstance instance : historicTaskInstances2) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 已处理的任务（特种梯流程）
			List<HistoricTaskInstance> historicTaskInstances3 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialParticular")
					.orderByTaskCreateTime().desc().list();
			for (HistoricTaskInstance instance : historicTaskInstances3) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			@SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
			while (iter.hasNext()) {
				@SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
				list.add((HistoricTaskInstance) entry.getValue());
			}
			// 设置分页数据
			int firstResult;// 开始游标
			int maxResults;// 结束游标
			int showCount = page.getShowCount();// 默认为10
			int currentPage = page.getCurrentPage();// 默认为0
			if (currentPage == 0) {// currentPage为0时，页面第一次加载或者刷新
				firstResult = currentPage;// 从0开始
				currentPage += 1;// 当前为第一页
				maxResults = showCount;
			} else {
				firstResult = showCount * (currentPage - 1);
				maxResults = firstResult + showCount;
			}
			int listCount = (list.size() <= maxResults ? list.size() : maxResults);
			// 从分页参数开始
			for (int i = firstResult; i < listCount; i++) {
				HistoricTaskInstance historicTaskInstance = list.get(i);
				PageData stra = new PageData();
				String processInstanceId = historicTaskInstance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					stra.put(info[1], info[2]);
					stra = productionService.findTowByuuId(stra); // 根据uuid查询信息
					if(stra==null)
					{
						continue;
					}
					// 检查申请者是否是本人,如果是,跳过
					if (stra.getString("requester_id").equals(USER_ID))
						continue;
					// 查询当前流程是否还存在
					List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery()
							.processInstanceId(processInstanceId).list();
					if (stra != null) {
						if (runing == null || runing.size() <= 0) {
							stra.put("isRuning", 0);
						} else {
							stra.put("isRuning", 1);
							// 正在运行,查询当前的任务信息
							Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
									.singleResult();
							stra.put("task_name", task.getName());
							stra.put("task_id", task.getId());
						}
					}
					strates.add(stra);
				}
			}
			// 设置分页数据
			int totalResult = list.size();
			if (totalResult <= showCount) {
				page.setTotalPage(1);
			} else {
				int count = Integer.valueOf(totalResult / showCount);
				int mod = totalResult % showCount;
				if (mod > 0) {
					count = count + 1;
				}
				page.setTotalPage(count);
			}
			page.setTotalResult(totalResult);
			page.setCurrentResult(strates.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(2);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			WorkFlow workflow = new WorkFlow();
			List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.orderByTaskCreateTime().desc().active().list();
			pd.put("count", toHandleListCount.size());
			pd.put("isActive3", "1");
			mv.addObject("pd", pd);
			mv.addObject("strates", strates);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
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
				titles.add("一排UUID");
				titles.add("一排编号");
				titles.add("项目编号");
				titles.add("项目名称");
				titles.add("订金是否到账");
				titles.add("流程状态");
				titles.add("合同文本");
				titles.add("排产资料");
				titles.add("评审资料");
				titles.add("日期");
				titles.add("流程key");
				titles.add("录入人");
				titles.add("电梯编号");
				titles.add("排产状态");
				titles.add("是否是特批电梯");
				dataMap.put("titles", titles);
				
				List<PageData> itemList = productionService.findProductionOneList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("pro_uuid"));
					vpd.put("var2", itemList.get(i).getString("pro_no"));
					vpd.put("var3", itemList.get(i).getString("item_name"));//项目编号
					vpd.put("var4", itemList.get(i).getString("ItemName"));//项目名称
					String is_subscription=itemList.get(i).getString("is_subscription");
					vpd.put("var5", is_subscription.equals("1")?"是":"否");
					String approval=itemList.get(i).getString("approval");
					if(approval.equals("0"))
					{
						vpd.put("var6", "待启动");
					}
					else if(approval.equals("1"))
					{
						vpd.put("var6", "审核中");
					}
					else if(approval.equals("2"))
					{
						vpd.put("var6", "已完成");
					}
					else if(approval.equals("3"))
					{
						vpd.put("var6", "已取消");
					}
					else if(approval.equals("4"))
					{
						vpd.put("var6", "被驳回");
					}
					vpd.put("var7", itemList.get(i).getString("contract_text"));
					vpd.put("var8", itemList.get(i).getString("production_datum"));
					vpd.put("var9", itemList.get(i).getString("appraisal_datum"));
					
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
					String str = df.format(itemList.get(i).get("signedTime"));
					vpd.put("var10", str);
					vpd.put("var11", itemList.get(i).getString("production_key"));
					vpd.put("var12", itemList.get(i).getString("requester_id"));
					vpd.put("var13", itemList.get(i).getString("elevator_no"));
					String plan_state=itemList.get(i).getString("plan_state");
					vpd.put("var14", plan_state.equals("0")?"未排产":"已排产");
					String special_state=itemList.get(i).getString("special_state");
					vpd.put("var15", special_state.equals("0")?"否":"是");
					
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
		 *导入Excel到数据库 （一排）
		 */
		@RequestMapping(value="importExcel")
		@ResponseBody
		public Object importExcel(@RequestParam(value = "file") MultipartFile file){
			Map<String, Object> map = new HashMap<String, Object>();
			try{
				if(file!=null && !file.isEmpty())
				{
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					
					 //保存总错误信息集合
	    			List<PageData> allErrList = new ArrayList<PageData>();
	    			//导入全部失败（true）
					boolean allErr=true;
					PageData pd = new PageData();
					for(int i = 0;i<listPd.size();i++)
					{
						//保存错误信息集合
		    			List<PageData> errList = new ArrayList<PageData>();
						
						//根据项目name获取id和no
		    			PageData item=new PageData();
		    			PageData itemPd=new PageData();
						String item_name=listPd.get(i).getString("var0");
						if(item_name==null || item_name.equals(""))
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "项目名称不能为空!");
	    	        		errPd.put("errCol", "1");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						else
						{
							itemPd.put("item_name", item_name);
							item=productionService.findItemByName(itemPd);
							if(item==null)
							{
								//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "所属项目不存在!");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
						
						//根据电梯编号---进行相关检验
						String production_key = null;
						String elevatorID=null;
						PageData elevatorPd=new PageData();
						PageData elevator =new PageData();
						String processDefinitionKey = "";
						String elevator_no=listPd.get(i).getString("var6");
						if(elevator_no==null || elevator_no.equals(""))
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "电梯编号不能为空!");
	    	        		errPd.put("errCol", "7");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						else
						{
							
							elevatorPd.put("elevator_no", elevator_no);
							elevator=productionService.findElevatorDetailsByNO(elevatorPd);
							if(elevator==null)
							{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "电梯不存在!");
		    	        		errPd.put("errCol", "7");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
							else
							{
								  // 流程---------相关验证
						        pd = this.getPageData();
								List<PageData> straList = null ;
								elevatorID=elevator.get("elevator_id").toString();
								if(elevatorID.equals("1") || elevatorID.equals("4"))//1.常规梯 || 4.扶梯
								{
									production_key="OneGeneralProduction";//常规流程key（扶梯共用）
									pd.put("production_key", production_key);
									straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
									if (straList == null) 
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "流程不存在不能导入数据!");
				    	        		errPd.put("errCol", "2");
				    	        		errPd.put("errRow", i+1);
				    	        		errList.add(errPd);
									} 
								}
								else if(elevatorID.equals("2"))//2.家用梯
								{
									production_key="OneDomesticProduction";//家用流程key
									pd.put("production_key", production_key);
									straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
									if (straList == null) 
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "流程不存在不能导入数据!");
				    	        		errPd.put("errCol", "2");
				    	        		errPd.put("errRow", i+1);
				    	        		errList.add(errPd);
									} 
								}
								else if(elevatorID.equals("3"))//3.特种梯
								{
									production_key="OneSpecialProduction";//特种流程key
									pd.put("production_key", production_key);
									straList= productionService.OneProductionKEY(pd);// 查询流程是否存在
									if (straList == null) 
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "流程不存在不能导入数据!");
				    	        		errPd.put("errCol", "2");
				    	        		errPd.put("errRow", i+1);
				    	        		errList.add(errPd);
									} 
									
								}
							}
							//根据电梯编号获取排产信息
							PageData production=productionService.findProductionOnerowByNO(elevatorPd);
							if(production!=null)
							{
								//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "该电梯已经安排排产");
		    	        		errPd.put("errCol", "");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
							
						}
						
						//排产款---------相关验证
						String is_subscription=listPd.get(i).getString("var1");
						String is_subscription2=null;
						if(is_subscription==null || is_subscription.equals(""))
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "排产款是否到账不能为空");
	    	        		errPd.put("errCol", "2");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						else
						{
							if(is_subscription.equals("是"))
					        {
								is_subscription2="1";//
					        }
					        else if(is_subscription.equals("否"))
					        {
					        	is_subscription2="2";
					        }
					        else
					        {
					        	//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "填写的参数错误!");
		    	        		errPd.put("errCol", "2");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
					        }
						}
						//日期验证
				        String signedTime = listPd.get(i).getString("var5");
				        if(signedTime==null || signedTime.equals(""))
				        {
				        	PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "日期不能为空!");
	    	        		errPd.put("errCol", "6");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
				        }
						
						if(errList.size()==0)
						{
							//生成排产编号
							Date dt = new Date();
							SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
							String time = matter1.format(dt);
							int number = (int) ((Math.random() * 9 + 1) * 100000);
							String pro_no = ('Y'+time + number);
							//获取当前系统登录人ID
							Subject currentUser = SecurityUtils.getSubject();
							Session session = currentUser.getSession();
							PageData pds = new PageData();
							pds = (PageData) session.getAttribute("userpds");
							String USER_ID = pds.getString("USER_ID");
							
							pd.put("pro_uuid", UUID.randomUUID().toString());//
					        pd.put("pro_no", pro_no);//
					        pd.put("item_id", item.get("item_id").toString());//
					        pd.put("item_no", item.get("item_no").toString());//
					        pd.put("is_subscription",is_subscription2);//排产款
					        pd.put("approval", "0");//流程状态
					        pd.put("contract_text", listPd.get(i).getString("var2"));//
					        pd.put("production_datum", listPd.get(i).getString("var3"));//
					        pd.put("appraisal_datum",  listPd.get(i).getString("var4"));//
					        pd.put("signedTime",  listPd.get(i).getString("var5"));//
					        pd.put("production_key",production_key);//流程key
					        pd.put("requester_id",USER_ID);//录入人ID
					        pd.put("elevator_no", elevator.get("no").toString());//
					        pd.put("plan_state", "0");//排产状态
					        pd.put("special_state","0");//是否特批
			                //***********保存至数据库
						     productionService.saveS(pd);
					       
					        // -----****************************流程相关
							if(elevatorID.equals("1") || elevatorID.equals("4"))
							{
								processDefinitionKey = "OneGeneralProduction";
								WorkFlow workFlow = new WorkFlow();
								IdentityService identityService = workFlow.getIdentityService();
								identityService.setAuthenticatedUserId(USER_ID);
								Object uuId = pd.get("pro_uuid");
								String businessKey = "tb_production_onerow.pro_uuid." + uuId;
								Map<String, Object> variables = new HashMap<String, Object>();
								variables.put("user_id", USER_ID);
								ProcessInstance proessInstance = null; // 流程1
								if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
									proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
								}
								if (proessInstance != null) {
									pd.put("production_key", proessInstance.getId());
								} 
							}
							else if(elevatorID.equals("2"))
							{
								processDefinitionKey = "OneDomesticProduction";
								WorkFlow workFlow = new WorkFlow();
								IdentityService identityService = workFlow.getIdentityService();
								identityService.setAuthenticatedUserId(USER_ID);
								Object uuId = pd.get("pro_uuid");
								String businessKey = "tb_production_onerow.pro_uuid." + uuId;
								Map<String, Object> variables = new HashMap<String, Object>();
								variables.put("user_id", USER_ID);
								ProcessInstance proessInstance = null; // 流程1
								if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
									proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
								}
								if (proessInstance != null) {
									pd.put("production_key", proessInstance.getId());
								} 
							}
							else if(elevatorID.equals("3"))
							{
								processDefinitionKey = "OneSpecialProduction";
								WorkFlow workFlow = new WorkFlow();
								IdentityService identityService = workFlow.getIdentityService();
								identityService.setAuthenticatedUserId(USER_ID);
								Object uuId = pd.get("pro_uuid");
								String businessKey = "tb_production_onerow.pro_uuid." + uuId;
								Map<String, Object> variables = new HashMap<String, Object>();
								variables.put("user_id", USER_ID);
								ProcessInstance proessInstance = null; // 流程1
								if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
									proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,businessKey, variables);
								}
								if (proessInstance != null) {
									pd.put("production_key", proessInstance.getId());
								} 
							}
							productionService.editS(pd); // 修改基本信息
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
		    		map.put("errorMsg", "上传失败,没有数据！");
		    	}
			}catch(Exception e){
				logger.error(e.getMessage(), e);
				map.put("msg", "exception");
				map.put("errorUpload", "系统错误，请稍后重试！");
			}
			return JSONObject.fromObject(map);
		}
		
		
	//二排  -------------------	
		 /**
		 *导出到Excel 
		 */
		@RequestMapping(value="toExcel2")
		public ModelAndView toExcel2(){
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("二排UUID");
				titles.add("二排编号");
				titles.add("项目编号");
				titles.add("项目名称");
				titles.add("排产款是否到账");
				titles.add("流程状态");
				titles.add("排产资料");
				titles.add("客户确认函");
				titles.add("土建勘测报告");
				titles.add("项目名称确认");
				titles.add("最终用户名称确认");
				titles.add("日期");
				titles.add("流程key");
				titles.add("录入人");
				titles.add("电梯编号");
				titles.add("排产状态");
				titles.add("是否是特批电梯");
				dataMap.put("titles", titles);
				List<PageData> itemList = productionService.findProductionTowList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("pro_uuid"));
					vpd.put("var2", itemList.get(i).getString("pro_no"));
					vpd.put("var3", itemList.get(i).getString("item_name"));//项目编号
					vpd.put("var4", itemList.get(i).getString("ItemName"));//项目名称
					String is_subscription=itemList.get(i).getString("is_subscription");
					vpd.put("var5", is_subscription.equals("1")?"是":"否");
					String approval=itemList.get(i).getString("approval");
					if(approval.equals("0"))
					{
						vpd.put("var6", "待启动");
					}
					else if(approval.equals("1"))
					{
						vpd.put("var6", "审核中");
					}
					else if(approval.equals("2"))
					{
						vpd.put("var6", "已完成");
					}
					else if(approval.equals("3"))
					{
						vpd.put("var6", "已取消");
					}
					else if(approval.equals("4"))
					{
						vpd.put("var6", "被驳回");
					}
					vpd.put("var7", itemList.get(i).getString("production_datum"));
					vpd.put("var8", itemList.get(i).getString("contract_text"));
					vpd.put("var9", itemList.get(i).getString("appraisal_datum"));
					vpd.put("var10", itemList.get(i).getString("customerName"));
					vpd.put("var11", itemList.get(i).getString("ultimatelyUserName"));
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
					String str = df.format(itemList.get(i).get("signedTime"));
					vpd.put("var12", str);
					vpd.put("var13", itemList.get(i).getString("production_key"));
					vpd.put("var14", itemList.get(i).getString("requester_id"));
					vpd.put("var15", itemList.get(i).getString("elevator_no"));
					String plan_state=itemList.get(i).getString("plan_state");
					vpd.put("var16", plan_state.equals("0")?"未排产":"已排产");
					String special_state=itemList.get(i).getString("special_state");
					vpd.put("var17", special_state.equals("0")?"否":"是");
					
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
		 *导入Excel到数据库 (二排)
		 */
		@RequestMapping(value="importExcel2")
		@ResponseBody
		public Object importExcel2(@RequestParam(value = "file") MultipartFile file){
			Map<String, Object> map = new HashMap<String, Object>();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					
					//保存全部错误信息集合
    			    List<PageData> allErrList  = new ArrayList<PageData>();
    			    //导入全部失败（true）
				    boolean allErr=true;
					PageData pd = new PageData();
					for(int i = 0;i<listPd.size();i++)
					{
						//保存错误信息集合
	    			    List<PageData> errList = new ArrayList<PageData>();
						//根据项目name获取id和no
						PageData itemPd=new PageData();
						PageData item=new PageData();
						String item_name=listPd.get(i).getString("var0");
                        if(item_name==null && item_name.equals(""))
                        {
                            PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "项目名称不能为空");
	    	        		errPd.put("errCol", "1");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
                        }
                        else
                        {
							itemPd.put("item_name", item_name);
							item=productionService.findItemByName(itemPd);
							if(item==null)
							{
								//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "所属项目不存在");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
                        }

						//根据电梯编号获取电梯信息
                        PageData elevatorPd=new PageData();
                        PageData elevator=new PageData();
						String elevator_no=listPd.get(i).getString("var8");
						if(elevator_no==null && elevator_no.equals(""))
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "电梯编号不能为空");
	    	        		errPd.put("errCol", "9");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						else
						{
							elevatorPd.put("elevator_no", elevator_no);
							elevator=productionService.findElevatorDetailsByNO(elevatorPd);
							if(elevator==null)
							{
								//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "电梯不存在");
		    	        		errPd.put("errCol", "9");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
							else
							{
								//根据电梯编号 获取排产信息
								PageData production=productionService.findProductionTowrowByNO(elevatorPd);
								if(production!=null)
								{
									//保存具体的字段的错误信息
					        		PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "该电梯已经安排排产");
			    	        		errPd.put("errCol", "");
			    	        		errPd.put("errRow", i+1);
			    	        		errList.add(errPd);
								}
							}
						}
						
						//获取文档中 电梯是不是特批电梯
						String is_state=listPd.get(i).getString("var9");
						String state = null;
						if(is_state!=null && !is_state.equals(""))
						{
							if(listPd.get(i).getString("var9").equals("否"))
							{
								state="0";
							}
							else if(listPd.get(i).getString("var10").equals("是"))
							{
								state="1";
							}
							else
							{
								//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "填写的参数错误!");
		    	        		errPd.put("errCol", "10");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
						
						//排产款是否到账  -----验证
						String is_subscription=listPd.get(i).getString("var1");
						if(is_subscription==null || is_subscription.equals(""))
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "排产款是否到账不能为空!");
	    	        		errPd.put("errCol", "2");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						else
						{
							if(is_subscription.equals("是"))
				        	{
				        		pd.put("is_subscription", "1");
				        	}
				        	else if(is_subscription.equals("否"))
				        	{
				        		pd.put("is_subscription", "2");
				        	}
				        	else
				        	{
				        		//保存具体的字段的错误信息
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "填写的参数错误!");
		    	        		errPd.put("errCol", "2");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
				        	}
						}
			        	
						//流程相关验证
						String elevatorName = elevator.get("elevator_id").toString();//电梯梯种
						String processDefinitionKey = "";
						List<PageData> straList = null;
						if (state.equals("0")) 
						{
							straList = productionService.Production_key(getPage());
						}
						else 
						{
							if(elevatorName!=null && !elevatorName.equals(""))
							{
								if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯和扶梯
								{
									String production_key = "SpecialRoutine";// 常规梯和扶梯流程id
									pd.put("production_key", production_key);
									pd.put("production_key", "SpecialRoutine"); // 流程的key
									straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
								} 
								else if (elevatorName.equals("2")) // 家用梯
								{
									String production_key = "SpecialDomestic";// 家用梯流程id
									pd.put("production_key", production_key);
									pd.put("production_key", "SpecialDomestic"); // 流程的key
									straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
								} 
								else if (elevatorName.equals("3")) // 特种梯
								{
									String production_key = "SpecialParticular";// 特种梯流程id
									pd.put("production_key", production_key);
									pd.put("production_key", "SpecialParticular"); // 流程的key
									straList = productionService.Special_key(pd); // 根据梯种查询流程是否存在
								}
							}
							
						}
						
						if(straList==null)
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "流程不存在，不能导入数据!");
	    	        		errPd.put("errCol", "");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
						//项目名称确认------验证
                         String customerName= listPd.get(i).getString("var5");
                         if(customerName==null || customerName.equals(""))
                         {
                             PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "项目名称确认不能为空!");
	    	        		 errPd.put("errCol", "6");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
                         }
                         //最终用户确认------验证
                         String ultimatelyUserName= listPd.get(i).getString("var6");
                         if(ultimatelyUserName==null || ultimatelyUserName.equals(""))
                         {
                             PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "最终用户确认不能为空!");
	    	        		 errPd.put("errCol", "7");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
                         }
						//-----------------字段检验结束
						
						if(errList.size()==0)
						{
							//生成二排排产编号
							Date dt = new Date();
							SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
							String time = matter1.format(dt);
							int number = (int) ((Math.random() * 9 + 1) * 100000);
							String pro_no = ('T' + time + number);
							// --------流程相关
							Subject currentUser = SecurityUtils.getSubject();
							Session session = currentUser.getSession();
							PageData pds = new PageData();
							pds = (PageData) session.getAttribute("userpds");
							String USER_ID = pds.getString("USER_ID");
							
							pd.put("pro_uuid", UUID.randomUUID().toString());
				        	pd.put("pro_no",pro_no);
				        	pd.put("item_id", item.getString("item_id"));
				        	pd.put("item_no", item.getString("item_no"));
				        	pd.put("approval",0);//流程状态
				        	pd.put("production_datum", listPd.get(i).getString("var2"));//
				        	pd.put("contract_text", listPd.get(i).getString("var3"));//
				        	pd.put("appraisal_datum", listPd.get(i).getString("var4"));//
				        	pd.put("customerName", listPd.get(i).getString("var5"));//
				        	pd.put("ultimatelyUserName",  listPd.get(i).getString("var6"));//
				        	pd.put("signedTime",  listPd.get(i).getString("var7"));//
				        	pd.put("production_key", "Production");//流程实例 key
				        	pd.put("requester_id", USER_ID);//录入人
				        	pd.put("elevator_no", listPd.get(i).getString("var8"));//
				        	pd.put("plan_state", 0);//排产状态  0未安排排产   1已安排排产
				        	pd.put("special_state", state);//是不特批电梯
				        	
				        	//保存基础数据
				        	productionService.saveSTow(pd);
				        	
				        	// -----流程相关
							try {
								if (state.equals("0")) {
									processDefinitionKey = "Production";
								} else {
									if (elevatorName.equals("1") || elevatorName.equals("4")) // 常规梯和 扶梯
									{
										processDefinitionKey = "SpecialRoutine";
									} else if (elevatorName.equals("2")) // 家用梯
									{
										processDefinitionKey = "SpecialDomestic";
									} else if (elevatorName.equals("3")) // 特种梯
									{
										processDefinitionKey = "SpecialParticular";
									}
								}
								WorkFlow workFlow = new WorkFlow();
								IdentityService identityService = workFlow.getIdentityService();
								identityService.setAuthenticatedUserId(USER_ID);
								Object uuId = pd.get("pro_uuid");
								String businessKey = "tb_production_towrow.pro_uuid." + uuId;
								Map<String, Object> variables = new HashMap<String, Object>();
								variables.put("user_id", USER_ID);
								ProcessInstance proessInstance = null; // 流程1
								if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
									proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey,
											businessKey, variables);
								}
								if (proessInstance != null) {
									pd.put("production_key", proessInstance.getId());
								} else {
									productionService.delTowfindById(pd);// 删除信息
									map.put("errorMsg", "上传失败");
								}
								
								
								if(errList.size()==0)
					        	{
									productionService.editSTow(pd); // 修改基本信息 --
									map.put("msg", "success");
					        	}
								
							} catch (Exception e) {
								logger.error(e.getMessage(), e);
								map.put("msg", "exception");
								map.put("errorMsg", "上传失败，生成流程实例失败！");
							}
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
		    		map.put("errorMsg", "上传失败,没有数据！");
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
