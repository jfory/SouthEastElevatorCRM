package com.dncrm.controller.system.contract;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contract.ContractService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.offer.OfferService;
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
import com.github.abel533.echarts.json.GsonOption;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPRow;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.itextpdf.text.Phrase;

@RequestMapping("/contract")
@Controller
public class ContractController extends BaseController {
	@Resource(name = "contractService")
	private ContractService contractService;
	@Resource(name = "itemService")
	private ItemService itemService;
	@Resource(name = "offerService")
	private OfferService offerService;

	/**
	 * 显示列表
	 * 
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@RequestMapping("/contract")
	public ModelAndView listItem(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		SelectByRole sbr = new SelectByRole();
 		List<String> userList = sbr.findUserList(USER_ID);
 		//将当前登录人添加至列表查询条件
 		pd.put("input_user", getUser().getUSER_ID());
 		pd.put("userList", userList);
		page.setPd(pd);
		try {
			/*List<PageData> itemList = contractService.listPageAllItem(page);*/   //查询项目信息
       	 	List<PageData> itemList = contractService.listPageAllItemByRole(page);
			if (!itemList.isEmpty()) {
				for (PageData con : itemList) {
					String con_process_key = con.getString("con_process_key");
					String con_special_key = con.getString("con_special_key");
					if (con_process_key != null && !"".equals(con_process_key)) {
						WorkFlow workFlow = new WorkFlow();
						List<Task> task1 = workFlow.getTaskService().createTaskQuery()
								.processInstanceId(con_process_key).active().list();
						if (task1 != null && task1.size() > 0) {
							for (Task task : task1) {
								con.put("task_id", task.getId());
								con.put("task_name", task.getName());
							}
						}
					}
					if (con_special_key != null && !"".equals(con_special_key)) {
						WorkFlow workFlow1 = new WorkFlow();
						List<Task> task2 = workFlow1.getTaskService().createTaskQuery()
								.processInstanceId(con_special_key).active().list();
						if (task2 != null && task2.size() > 0) {
							for (Task task : task2) {
								con.put("task_id1", task.getId());
								con.put("task_name1", task.getName());
							}
						}
					}
				}
			}
			mv.setViewName("system/contract/con_item_list");
			mv.addObject("itemList", itemList);
			mv.addObject("con_name", pd.get("con_name"));
			mv.addObject("description", pd.get("description"));
			mv.addObject("pd", pd);
			mv.addObject("page", page);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return mv;
	}

	/*
	 * 删除一条合同信息
	 */
	@RequestMapping("/delContract")
	@ResponseBody
	public Object delContract() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			contractService.delContract(pd);
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
			String con_ids = (String) pd.get("con_ids");
			for (String con_id : con_ids.split(",")) {
				pd.put("con_id", con_id);
				contractService.delContract(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 跳到添加页面
	 * 
	 * @return
	 */
	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/contract/contract_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
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
			pd = contractService.findContractById(pd);
			mv.setViewName("system/contract/contract_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 跳到选择合同模版页面
	 * 
	 * @return
	 */
	@RequestMapping("/Download")
	public ModelAndView Download() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("system/contract/contract_masterplate");
		mv.addObject("msg", "masterplate");
		mv.addObject("id", "EditItem");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳到合同模版页面
	 * 
	 * @return
	 */
	@RequestMapping("/masterplate")
	public ModelAndView masterplate() {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		String masterplate_no = pd.getString("id");
		PageData kehu = this.getPageData(); //客户pd
		PageData pdelev = new PageData(); // 电梯信息pd
		List<PageData> listelev = new ArrayList<>();//电梯信息List
		try {
			pd = contractService.findContractById(pd);//查询合同信息和项目信息
			String item_id = pd.getString("item_id");
			PageData pdItem = new PageData();
			pdItem = contractService.findByItem_Id(pd);
			String type = pdItem.getString("customer_type"); // 客户类型
			String kehu_id = pdItem.getString("customer_id"); // 客户编号
			kehu.put("kehu_id", kehu_id); // 给pd客户的编号
			pdelev.put("item_id", item_id);// 添加项目id
			listelev = contractService.findByElev(pdelev);
			if (type.equals("Ordinary")) {
				kehu = contractService.findByOrdinary(kehu);
			} else if (type.equals("Merchant")) {
				kehu = contractService.findByMerchant(kehu);
			} else if (type.equals("Core")) {
				kehu = contractService.findByCore(kehu);
			}
			if (masterplate_no.equals("1")) {
				mv.setViewName("system/contract/masterplate_1");
			} else if (masterplate_no.equals("2")) {
				mv.setViewName("system/contract/masterplate_2");
			} else {
				mv.setViewName("system/contract/masterplate_3");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// mv.addObject("msg", "masterplate");
		mv.addObject("id", "EditMoban");
		mv.addObject("pd", pd);
		mv.addObject("kehu", kehu);
		mv.addObject("listelev", listelev);
		return mv;
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
		// 获取年月日
		Date dt = new Date();
		SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
		String time = matter1.format(dt);
		int number = (int) ((Math.random() * 9 + 1) * 100000); // 生成随机6位数字
		String con_id = ("SO" + time + number); // 拼接为合同编号
		// 获取系统时间
		String df = DateUtil.getTime().toString();
		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		String processDefinitionKey1 = ""; // 流程1
		String processDefinitionKey2 = ""; // 流程2
		PageData pds = new PageData();
		pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		try {
			List<PageData> conprocess = contractService.ConProcessKey(getPage()); // 查询常规梯流程是否存在
			List<PageData> SpecialKey = contractService.SpecialKey(getPage()); // 查询特种梯流程是否存在
			pd = this.getPageData();
			pd.put("modified_time", df); // 录入时间
			pd.put("con_id", con_id); // 拼接好的编号添加到pd
			pd.put("requester_id", USER_ID); // 录入信息请求启动的用户ID
			pd.put("con_uuid", UUID.randomUUID().toString());
			pd.put("con_approval", 0); // 流程状态 0代表还没有启动流程
			pd.put("is_subscription", 2);//定金是否到账，默认为2（否）
			pd.put("con_state", 2);//合同生效状态，默认为2（未生效）
			String Special = pd.getString("Special");// 获取特种梯
			String General = pd.getString("General");// 获取常规梯
			if (Special.equals("no") && General.equals("yes")) {
				String con = "GeneralContract"; // 常规流程的key
				pd.put("con_process_key", con);
				String con1 = "SpecialContract"; // 特种流程的key
				pd.put("con_special_key", con1);
				if (conprocess != null && SpecialKey != null) {
					contractService.saveS(pd); // 保存单元基本信息
					mv.addObject("msg", "success");
				} else {
					mv.addObject("msg", "流程不存在");
				}
				processDefinitionKey1 = "GeneralContract"; // 常规 流程的KEY
				processDefinitionKey2 = "SpecialContract"; // 特种 流程的KEY
			} else if (Special.equals("no")) {
				String con1 = "SpecialContract"; // 特种流程的key
				pd.put("con_special_key", con1);
				pd.put("con_process_key", "");
				if (SpecialKey != null) {
					contractService.saveS(pd); // 保存单元基本信息
					mv.addObject("msg", "success");
				} else {
					mv.addObject("msg", "流程不存在");
				}
				processDefinitionKey2 = "SpecialContract"; // 特种 流程的KEY
			} else if (General.equals("yes")) {
				String con = "GeneralContract"; // 常规流程的key
				pd.put("con_process_key", con);
				pd.put("con_special_key", "");
				if (conprocess != null) {
					contractService.saveS(pd); // 保存单元基本信息
					mv.addObject("msg", "success");
				} else {
					mv.addObject("msg", "流程不存在");
				}
				processDefinitionKey1 = "GeneralContract"; // 常规 流程的KEY
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
			e.printStackTrace();
		}
		try {
			// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
			WorkFlow workFlow = new WorkFlow();
			IdentityService identityService = workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId = pd.get("con_uuid");
			String businessKey = "tb_contract.con_uuid." + uuId;
			// 设置变量
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user_id", USER_ID);
			ProcessInstance proessInstance1 = null; // 流程1
			ProcessInstance proessInstance2 = null; // 流程2
			if (processDefinitionKey1 != null && !"".equals(processDefinitionKey1)) {
				proessInstance1 = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey1,
						businessKey, variables);
			}
			if (processDefinitionKey2 != null && !"".equals(processDefinitionKey2)) {
				proessInstance2 = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey2,
						businessKey, variables);
			}
			if (proessInstance1 != null) {
				pd.put("con_process_key", proessInstance1.getId());
			}
			if (proessInstance2 != null) {
				pd.put("con_special_key", proessInstance2.getId());
			}
			contractService.editS(pd);
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
			String con_process_key = pd.getString("con_process_key"); // 常规合同评审流程
			String con_special_key = pd.getString("con_special_key"); // 特种合同评审流程
			// 如存在key启动常规合同评审流程
			if (con_process_key != null && !"".equals(con_process_key)) {
				WorkFlow workFlow = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(con_process_key)
						.singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
				// 签收任务
				workFlow.getTaskService().claim(task.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
				pd.put("con_approval", 1); // 常规流程状态 1代表流程启动,等待审核
				contractService.updateConApproval(pd);
				workFlow.getTaskService().complete(task.getId());
				// 获取下一个任务的信息
				Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(con_process_key)
						.singleResult();
				map.put("task_name", tasks.getName());
				map.put("status", "1");
			}
			if (con_special_key != null && !"".equals(con_special_key)) {
				WorkFlow workFlow2 = new WorkFlow();
				// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
				workFlow2.getIdentityService().setAuthenticatedUserId(USER_ID);
				Task task2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(con_special_key)
						.singleResult();
				Map<String, Object> variables = new HashMap<String, Object>();
				// 设置任务角色
				workFlow2.getTaskService().setAssignee(task2.getId(), USER_ID);
				// 签收任务
				workFlow2.getTaskService().claim(task2.getId(), USER_ID);
				// 设置流程变量
				variables.put("action", "提交申请");
				workFlow2.getTaskService().setVariablesLocal(task2.getId(), variables);
				pd.put("con_approval", 1); // 常规流程状态 1代表流程启动,等待审核
				contractService.updateConApproval(pd);
				workFlow2.getTaskService().complete(task2.getId());
				// 获取下一个任务的信息
				Task tasks2 = workFlow2.getTaskService().createTaskQuery().processInstanceId(con_special_key)
						.singleResult();
				map.put("task_name", tasks2.getName());
				map.put("status", "2");
			}
			if ((con_process_key != null && !"".equals(con_process_key))) {
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
	 * 显示待我处理的合同
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/contractAudit")
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
			mv.setViewName("system/contract/contract_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			List<PageData> agents = new ArrayList<>();
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
					.processDefinitionKey("GeneralContract").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("GeneralContract").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList) {
				PageData agent = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					agent.put(info[1], info[2]);
					agent = contractService.findContractByuuId(agent);
					agent.put("task_name", task.getName());
					agent.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						agent.put("type", "1");// 待处理
					} else {
						agent.put("type", "0");// 待签收
					}
				}
				agents.add(agent);
			}
			List<Task> toHandleListCount1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialContract").orderByTaskCreateTime().desc().active().list();
			List<Task> toHandleList1 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
					.processDefinitionKey("SpecialContract").orderByTaskCreateTime().desc().active()
					.listPage(firstResult, maxResults);
			for (Task task : toHandleList1) {
				PageData agent1 = new PageData();
				String processInstanceId = task.getProcessInstanceId();
				ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
						.processInstanceId(processInstanceId).active().singleResult();
				String businessKey = processInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					agent1.put(info[1], info[2]);
					agent1 = contractService.findContractByuuId(agent1);
					agent1.put("task_name", task.getName());
					agent1.put("task_id", task.getId());
					if (task.getAssignee() != null) {
						agent1.put("type", "1");// 待处理
					} else {
						agent1.put("type", "0");// 待签收
					}
				}
				agents.add(agent1);
			}
			// 设置分页数据
			int totalResult = toHandleListCount.size() + toHandleListCount1.size();
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
			page.setCurrentResult(agents.size());
			page.setCurrentPage(currentPage);
			page.setShowCount(showCount);
			page.setEntityOrField(true);
			// 如果有多个form,设置第几个,从0开始
			page.setFormNo(1);
			page.setPageStrForActiviti(page.getPageStrForActiviti());
			// 待处理任务的count
			pd.put("count", toHandleListCount.size() + toHandleListCount1.size());
			pd.put("isActive2", "1");
			mv.addObject("pd", pd);
			mv.addObject("agents", agents);
			mv.addObject("userpds", pds);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 签收任务
	 *
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
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
			// 签收任务
			List<PageData> agents = new ArrayList<>();
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

	public String nametype; // 控制流程走向（营销管理部，合同评审分派）
	public String binding; // 控制绑定工号按钮的出现

	/**
	 * 跳到合同办理任务页面
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goHandleAgent")
	public ModelAndView goHandleAgent() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		if (nametype != null && nametype != "") {
			int type = 1;
			pd.put("type", type);
		}
		if (binding != null && binding != "") {
			int binding = 1;
			pd.put("binding", binding);
		}
		mv.setViewName("system/contract/contract_handle");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 请求跳转查看页面
	 * 
	 * @param con_id
	 * @return
	 */
	@RequestMapping(value = "/toView")
	public ModelAndView toView(String agent_id) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = contractService.findContractById(pd);
			mv.setViewName("system/contract/contract_View");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
			List<PageData> offerList = contractService.offerlistPage(getPage());// 加载报价信息
			mv.addObject("offerList", offerList);
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
			String node = pd.getString("node");
			String user_id = pds.getString("USER_ID");
			Map<String, Object> variables = new HashMap<String, Object>();
			boolean isApproved = false;
			boolean parallel = false;// 并行节点 是否通过
			String action = pd.getString("action");
			@SuppressWarnings("unused")
			int status;
			Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
			if (action.equals("approve")) {
				if (task.getTaskDefinitionKey().equals("CreditControlDepartment")) {
					nametype = null;
					pd.put("con_approval", 2); // 流程状态 2代表已完成
					variables.put("approved", true);
					isApproved = true;
					contractService.updateConApproval(pd);
				} else if (task.getTaskDefinitionKey().equals("AreaProjectManager")) // 区工程经理节点
				{
					pd.put("con_approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					isApproved = true;
					nametype = "yes";
					contractService.updateConApproval(pd);
				} else if (task.getTaskDefinitionKey().equals("MarketingAdministrativeDepartment")) // 营销管理部节点
				{
					pd.put("con_approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					isApproved = true;
					binding = "yes";
					contractService.updateConApproval(pd);
				} else if (task.getTaskDefinitionKey().equals("ContractReviewAssign")) // 合同评审分派节点
				{
					pd.put("con_approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					isApproved = true;
					binding = "yes";
					contractService.updateConApproval(pd);
				} else {
					nametype = null;
					binding = null;
					status = 1; // 审核中
					pd.put("con_approval", 1); // 流程状态 1代表审核中
					variables.put("approved", true);
					variables.put("parallel", true);
					variables.put("type", node);
					isApproved = true;
					contractService.updateConApproval(pd);
				}
				// ———————————驳回———————————————————
			} else if (action.equals("reject")) {
				pd.put("task_id", task_id);
				PageData itemList = contractService.specialID(pd);
				if (itemList != null) {
					status = 4;// 被驳回
					pd.put("special_approval", 4); // 流程状态 4代表 被驳回
					variables.put("approved", false);
					variables.put("parallel", parallel);
					contractService.updateConApproval2(pd);
				}
				status = 4;// 被驳回
				pd.put("con_approval", 4); // 流程状态 4代表 被驳回
				variables.put("approved", false);
				variables.put("parallel", parallel);
				contractService.updateConApproval(pd);
			}
			String comment = (String) pd.get("comment");
			if (isApproved) {
				variables.put("action", "批准");
			} else {
				variables.put("action", "驳回");
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
	 * 重新提交申请
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
			String task_id1 = pd.getString("task_id"); // 流程id
			String task_id2 = pd.getString("task_id1"); // 流程id
			String user_id = pds.getString("USER_ID");
			if (task_id1.equals("NO")) {

			} else {
				String task_id = task_id1;
				workFlow.getTaskService().claim(task_id, user_id);
				Map<String, Object> variables = new HashMap<String, Object>();
				variables.put("action", "重新提交");
				// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
				workFlow.getTaskService().setVariablesLocal(task_id, variables);
				Authentication.setAuthenticatedUserId(user_id);
				// 处理任务
				workFlow.getTaskService().complete(task_id);
			}
			if (task_id2.equals("NO")) {

			} else {
				String task_id = task_id2;
				workFlow.getTaskService().claim(task_id, user_id);
				Map<String, Object> variables = new HashMap<String, Object>();
				variables.put("action", "重新提交");
				// 使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
				workFlow.getTaskService().setVariablesLocal(task_id, variables);
				Authentication.setAuthenticatedUserId(user_id);
				// 处理任务
				workFlow.getTaskService().complete(task_id);
			}
			// 更新业务数据的状态
			pd.put("con_approval", 1);
			contractService.updateConApproval(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
			map.put("err", "重新提交失败");
			logger.error(e.toString(), e);
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 显示我已经处理的合同审核
	 *
	 * @return
	 */
	@RequestMapping("/listDoneContractor")
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
			mv.setViewName("system/contract/contract_list");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			WorkFlow workFlow = new WorkFlow();
			// 已处理的任务
			List<PageData> dleaves = new ArrayList<>();
			List<HistoricTaskInstance> historicTaskInstances1 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("GeneralContract")
					.orderByTaskCreateTime().desc().list();
			// 特种梯流程 已处理任务
			List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService()
					.createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("SpecialContract")
					.orderByTaskCreateTime().desc().list();
			// 移除重复的
			List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
			HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();
			// 常规
			for (HistoricTaskInstance instance : historicTaskInstances1) {
				String processInstanceId = instance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				map.put(businessKey, instance);
			}
			// 特种
			for (HistoricTaskInstance instance : historicTaskInstances2) {
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
				PageData agent = new PageData();
				String processInstanceId = historicTaskInstance.getProcessInstanceId();
				HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService()
						.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String businessKey = historicProcessInstance.getBusinessKey();
				if (!StringUtils.isEmpty(businessKey)) {
					// leave.leaveId.
					String[] info = businessKey.split("\\.");
					agent.put(info[1], info[2]);
					agent = contractService.findContractByuuId(agent);
					// 检查申请者是否是本人,如果是,跳过
					if (agent.getString("requester_id").equals(USER_ID))
						continue;
					// 查询当前流程是否还存在
					List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery()
							.processInstanceId(processInstanceId).list();
					if (agent != null) {
						if (runing == null || runing.size() <= 0) {
							agent.put("isRuning", 0);
						} else {
							agent.put("isRuning", 1);
							// 正在运行,查询当前的任务信息
							Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
									.singleResult();
							agent.put("task_name", task.getName());
							agent.put("task_id", task.getId());
						}
					}
					dleaves.add(agent);
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
			page.setCurrentResult(dleaves.size());
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
			mv.addObject("dleaves", dleaves);
			mv.addObject("userpds", pds);
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
	@RequestMapping("/editS")
	public ModelAndView editS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String df = DateUtil.getTime().toString(); // 获取系统时间
		try {
			pd = this.getPageData();
			pd.put("modified_time", df); // 修改时间
			contractService.editS(pd); // 保存修改之后的合同基本信息
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败！");
			e.printStackTrace();
		}
		mv.addObject("id", "EditItem");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 根据项目id查询项目信息
	 * 
	 * @return
	 */
	@RequestMapping("/checkedoffer")
	@ResponseBody
	public JSONObject checkedcomp(@RequestParam(value = "item_no") String item_no) {
		JSONObject result = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = contractService.findItemById(pd); // 项目信息
			result.put("offer", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return result;
	}

	/**
	 * 绑定电梯工号
	 * 
	 * @return
	 */
	@RequestMapping("/binding")
	@ResponseBody
	public Object binding() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = contractService.findContractById(pd); // 根据合同编号查询项目信息
			List<PageData> elevatorJobNo = contractService.createElevatorJobNo(pd);// 调用绑定工号方法
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 异步上传
	 * 
	 * @param file
	 * @return
	 */
	@RequestMapping(value = "/upload")
	@ResponseBody
	public Object upload(@RequestParam(value = "file") MultipartFile file) {
		String ffile = DateUtil.getDay(), fileName = "";
		JSONObject result = new JSONObject();
		if (file != null && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE) + "houses/" + ffile;// 文件上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
			result.put("success", true);
			result.put("filePath", "houses/" + ffile + "/" + fileName); // houses是存放上传的文件的文件夹
		} else {
			result.put("errorMsg", "上传失败");
		}
		return result;
	}

	/**
	 * 下载文件
	 */
	@RequestMapping(value = "/down")
	public void downExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String downFile = request.getParameter("downFile");
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + downFile, downFile);
	}

	
	/* ===============================报表================================== */
	@RequestMapping(value = "contractInfo")
	public ModelAndView reportInfo() {
		ModelAndView mv = new ModelAndView();
		try {
			mv.setViewName("system/contract/contractInfo");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return mv;
	}

	/**
	 * set by month
	 */
	@RequestMapping(value = "setByType", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public Object setByType() {
		PageData pd = new PageData();
		GsonOption option = new GsonOption();
		Echarts echarts = new Echarts();
		try {
			pd = this.getPageData();
			List<PageData> list = new ArrayList<PageData>();
			String type = pd.get("type").toString();
			String itemStatus = pd.get("itemStatus").toString();
			String xAxisName = "";
			String yAxisName = "num";
			if (itemStatus.equals("1")) {
				if (type.equals("year")) {
					list = contractService.ContractYearNum();
					xAxisName = "(年)";
				} else if (type.equals("month")) {
					String year = new SimpleDateFormat("yyyy").format(new Date());
					list = contractService.ContractMonthNum(year);
					echarts.setXAxisMonth(option);
					xAxisName = "(月份)";
				} else if (type.equals("quarter")) {
					String year = new SimpleDateFormat("yyyy").format(new Date());
					list = contractService.ContractQuarterNum(year);
					echarts.setXAxisQuarter(option);
					xAxisName = "(季度)";
				}
				Map<String, String> legendMap = new HashMap<String, String>();
				legendMap.put("category", "date");
				legendMap.put("合同数量", "conNum");
				/*
				 * legendMap.put("东南安装", "cellNumDN001"); legendMap.put("对手安装",
				 * "cellNum");
				 */
				option = echarts.setOption(list, legendMap);
				echarts.setYAxisName(option, yAxisName);
				echarts.setXAxisName(option, xAxisName);
			} else if (itemStatus.equals("2")) {
				if (type.equals("year")) {
					list = contractService.ContractYearStatusNum();
					xAxisName = "(年)";
				} else if (type.equals("month")) {
					String year = new SimpleDateFormat("yyyy").format(new Date());
					list = contractService.ContractMonthStatusNum(year);
					echarts.setXAxisMonth(option);
					xAxisName = "(月份)";
				} else if (type.equals("quarter")) {
					String year = new SimpleDateFormat("yyyy").format(new Date());
					list = contractService.ContractQuarterStatusNum(year);
					echarts.setXAxisQuarter(option);
					xAxisName = "(季度)";
				}
				Map<String, String> legendMap = new HashMap<String, String>();
				legendMap.put("category", "date");
				legendMap.put("审核通过", "StatusPass");
				legendMap.put("正在审核", "StatusUnderway");
				/* legendMap.put("对手安装", "cellNum"); */
				option = echarts.setOption(list, legendMap);
				echarts.setYAxisName(option, yAxisName);
				echarts.setXAxisName(option, xAxisName);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return option.toString();
	}

	/**
	 * 导出到Excel
	 */
	@RequestMapping(value = "toExcel")
	public ModelAndView toExcel() {
		ModelAndView mv = new ModelAndView();
		try {
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("合同UUID");
			titles.add("合同编号");
			titles.add("合同名称");
			titles.add("是否包含安装");
			titles.add("项目名称");
			titles.add("项目内容");
			titles.add("合同金额");
			titles.add("付款方式");
			titles.add("工期");
			titles.add("合同类型");
			titles.add("合同状态");
			titles.add("附件");
			titles.add("备注");
			titles.add("合同结束时间");
			titles.add("甲方");
			titles.add("甲方地址");
			titles.add("法定代表人");
			titles.add("委托代理人");
			titles.add("电话");
			titles.add("传真");
			titles.add("开户银行");
			titles.add("帐号");
			titles.add("签订日期");
			titles.add("乙方");
			titles.add("地址");
			titles.add("法定代表人");
			titles.add("委托代理人");
			titles.add("电话");
			titles.add("传真");
			titles.add("开户银行");
			titles.add("帐号");
			titles.add("录入时间");
			titles.add("招投标文件");
			titles.add("价格审核表");
			titles.add("非标单");
			titles.add("土建表");
			titles.add("技术规格表");
			titles.add("常规流程KEY");
			titles.add("特种流程KEY");
			titles.add("流程状态");
			titles.add("录入人");
			titles.add("订金是否到账");
			titles.add("合同生效状态");
			titles.add("设备合同文本");
			titles.add("安装合同文本");
			titles.add("安装价格");
			titles.add("安装条款");
			dataMap.put("titles", titles);

			List<PageData> itemList = contractService.findContractList();
			List<PageData> varList = new ArrayList<PageData>();
			for (int i = 0; i < itemList.size(); i++) {
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("con_uuid"));
				vpd.put("var2", itemList.get(i).getString("con_id"));
				vpd.put("var3", itemList.get(i).getString("con_name"));
				String is_=itemList.get(i).getString("con_is_contained");
				vpd.put("var4", is_.equals("1")?"是":"否");
				vpd.put("var5", itemList.get(i).getString("item_name"));
				vpd.put("var6", itemList.get(i).getString("item_content"));
				vpd.put("var7", itemList.get(i).getString("item_money"));
				vpd.put("var8", itemList.get(i).getString("con_Payment"));
				vpd.put("var9", itemList.get(i).getString("con_Duration"));
				vpd.put("var10", itemList.get(i).getString("con_type"));
				vpd.put("var11", itemList.get(i).getString("con_status"));
				vpd.put("var12", itemList.get(i).getString("con_adjunct"));
				vpd.put("var13", itemList.get(i).getString("con_remarks"));

				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 定义格式，不显示毫秒
				String str = df.format(itemList.get(i).get("con_EndTime"));

				vpd.put("var14", str);
				vpd.put("var15", itemList.get(i).getString("owner"));
				vpd.put("var16", itemList.get(i).getString("ow_address"));
				vpd.put("var17", itemList.get(i).getString("ow_representative"));
				vpd.put("var18", itemList.get(i).getString("ow_entrusted"));
				vpd.put("var19", itemList.get(i).getString("ow_phone"));
				vpd.put("var20", itemList.get(i).getString("ow_faxes"));
				vpd.put("var21", itemList.get(i).getString("ow_bank"));
				vpd.put("var22", itemList.get(i).getString("ow_accounts"));
				String str2 = df.format(itemList.get(i).get("ow_SignedTime"));
				vpd.put("var23", str2);
				vpd.put("var24", itemList.get(i).getString("second"));
				vpd.put("var25", itemList.get(i).getString("se_address"));
				vpd.put("var26", itemList.get(i).getString("se_representative"));
				vpd.put("var27", itemList.get(i).getString("se_entrusted"));
				vpd.put("var28", itemList.get(i).getString("se_phone"));
				vpd.put("var29", itemList.get(i).getString("se_faxes"));
				vpd.put("var30", itemList.get(i).getString("se_bank"));
				vpd.put("var31", itemList.get(i).getString("se_accounts"));
				String str3 = df.format(itemList.get(i).get("modified_time"));
				vpd.put("var32", str3);
				vpd.put("var33", itemList.get(i).getString("con_bidding"));
				vpd.put("var34", itemList.get(i).getString("con_tariff"));
				vpd.put("var35", itemList.get(i).getString("con_standard"));
				vpd.put("var36", itemList.get(i).getString("con_build"));
				vpd.put("var37", itemList.get(i).getString("con_technology"));
				vpd.put("var38", itemList.get(i).getString("con_process_key"));
				vpd.put("var39", itemList.get(i).getString("con_special_key"));
				String con_approval=itemList.get(i).getString("con_approval");
				if(con_approval.equals("0")){vpd.put("var40", "待启动");}
				else if(con_approval.equals("1")){vpd.put("var40", "审核中");}
				else if(con_approval.equals("2")){vpd.put("var40", "已完成");}
				else if(con_approval.equals("3")){vpd.put("var40", "已取消");}
				else if(con_approval.equals("4")){vpd.put("var40", "被驳回");}
				vpd.put("var41", itemList.get(i).getString("requester_id"));
				String is_subscription=itemList.get(i).getString("is_subscription");
				vpd.put("var42", is_subscription.equals("1")?"是":"否");
				String con_state=itemList.get(i).getString("con_state");
				vpd.put("var43", con_state.equals("1")?"已生效":"未生效");
				vpd.put("var44", itemList.get(i).getString("facility_contract"));
				vpd.put("var45", itemList.get(i).getString("install_contract"));
				vpd.put("var46", itemList.get(i).getString("install_price"));
				vpd.put("var47", itemList.get(i).getString("install_clause"));
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return mv;
	}

	/**
	 * 导入Excel到数据库
	 */
	@RequestMapping(value = "importExcel")
	@ResponseBody
	public Object importExcel(@RequestParam(value = "file") MultipartFile file) 
	{
		Map<String, Object> map = new HashMap<String, Object>();
		try 
		{
			if (file != null && !file.isEmpty()) 
			{
				String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
				String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
				//保存总错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				for (int i = 0; i < listPd.size(); i++) 
				{
					
					String processDefinitionKey1 = ""; // 流程1
					String processDefinitionKey2 = ""; // 流程2
					
					//保存错误信息集合
	    			List<PageData> errList = new ArrayList<PageData>();	
					// 获取系统时间
					String df = DateUtil.getTime().toString();
					Date dt = new Date();
					SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
					String time = matter1.format(dt);
					int number = (int) ((Math.random() * 9 + 1) * 100000); // 生成随机6位数字
					String con_id = ("SO" + time + number); // 拼接为合同编号
				    //获取当前登入人id
					Subject currentUser = SecurityUtils.getSubject();
					Session session = currentUser.getSession();
					PageData pds = new PageData();
					pds = (PageData) session.getAttribute("userpds");
					String USER_ID = pds.getString("USER_ID");
					
					//----------------字段检验开始----------------
					//项目名称-------检验
					PageData ItemPd1=new PageData();
					PageData ItemPd2=new PageData();
					String item_name= listPd.get(i).getString("var2");
					if(item_name!=null && !item_name.equals(""))
					{
						ItemPd1.put("item_name", item_name);
						ItemPd2=contractService.findItemByName(ItemPd1);
						if(ItemPd2!=null)
						{
							if(ItemPd2.getString("con_item_no")!=null || !ItemPd2.getString("con_item_no").equals(""))
							{
					        	PageData errPd = new PageData();
			 	        		errPd.put("errMsg", "该项目已创建合同!");
			 	        		errPd.put("errCol", "3");
			 	        		errPd.put("errRow", i+1);
			 	        		errList.add(errPd);
							}
						}
						else
						{
							PageData errPd = new PageData();
		 	        		errPd.put("errMsg", "项目不存在！");
		 	        		errPd.put("errCol", "3");
		 	        		errPd.put("errRow", i+1);
		 	        		errList.add(errPd);	
						}
					}
					else
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "项目名称不能为空！");
	 	        		errPd.put("errCol", "3");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);	
					}
					
					//合同名称----------检验
					String con_name=listPd.get(i).getString("var0");
					if(con_name==null || con_name.equals(""))
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "合同名称不能为空！");
	 	        		errPd.put("errCol", "1");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);	
					}
					
					//是否包含安装-------检验
					String con_is_contained=listPd.get(i).getString("var1");
					String con_is_contained2 = null;
					if(con_is_contained==null || con_is_contained.equals(""))
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "是否包含安装不能为空！");
	 	        		errPd.put("errCol", "2");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);	
					}
					else
					{
						if(con_is_contained.equals("是"))
						{
							con_is_contained2="1";
						}
						else if(con_is_contained.equals("否"))
						{
							con_is_contained2="2";
						}
						else
						{
				        	PageData errPd = new PageData();
		 	        		errPd.put("errMsg", "填写的参数错误！");
		 	        		errPd.put("errCol", "2");
		 	        		errPd.put("errRow", i+1);
		 	        		errList.add(errPd);	
						}
					}
					
					//合同结束时间------------检验
					String con_EndTime=listPd.get(i).get("var10").toString();
					if(con_EndTime==null || con_EndTime.equals(""))
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "合同 结束时间不能为空！");
	 	        		errPd.put("errCol", "11");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);	
					}
					//合同签订时间------------检验
					String ow_SignedTime=listPd.get(i).get("var19").toString();
					if(ow_SignedTime==null || ow_SignedTime.equals(""))
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "合同 签订时间不能为空！");
	 	        		errPd.put("errCol", "20");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);	
					}
					
					//流程------检验
					List<PageData> conprocess = contractService.ConProcessKey(getPage()); 
					List<PageData> SpecialKey = contractService.SpecialKey(getPage());
					if(conprocess==null || SpecialKey==null)
					{
						PageData errPd = new PageData();
	 	        		errPd.put("errMsg", "流程不存在不能进行导入！");
	 	        		errPd.put("errCol", "");
	 	        		errPd.put("errRow", i+1);
	 	        		errList.add(errPd);
					}
					//------------------字段检验结束----------------------
					
					if(errList.size()==0)
					{
						pd.put("con_uuid", UUID.randomUUID().toString());
						pd.put("con_id", con_id);
						pd.put("con_name", listPd.get(i).getString("var0"));
						pd.put("con_is_contained", con_is_contained2);
						pd.put("item_no",ItemPd2.getString("item_no"));
						pd.put("item_content", listPd.get(i).getString("var3"));
						pd.put("item_total", listPd.get(i).getString("var4"));
						pd.put("con_Payment", listPd.get(i).getString("var5"));
						pd.put("con_Duration", listPd.get(i).getString("var6"));
						pd.put("con_type", listPd.get(i).getString("var7"));
						pd.put("con_status", 0);//暂定
						pd.put("con_adjunct", listPd.get(i).getString("var8"));
						pd.put("con_remarks", listPd.get(i).getString("var9"));
						pd.put("con_EndTime", listPd.get(i).getString("var10"));
						pd.put("owner", listPd.get(i).getString("var11"));
						pd.put("ow_address", listPd.get(i).getString("var12"));
						pd.put("ow_representative", listPd.get(i).getString("var13"));
						pd.put("ow_entrusted", listPd.get(i).getString("var14"));
						pd.put("ow_phone", listPd.get(i).getString("var15"));
						pd.put("ow_faxes", listPd.get(i).getString("var16"));
						pd.put("ow_bank", listPd.get(i).getString("var17"));
						pd.put("ow_accounts", listPd.get(i).getString("var18"));
						pd.put("ow_SignedTime", listPd.get(i).getString("var19"));
						pd.put("second", listPd.get(i).getString("var20"));
						pd.put("se_address", listPd.get(i).getString("var21"));
						pd.put("se_representative", listPd.get(i).getString("var22"));
						pd.put("se_entrusted", listPd.get(i).getString("var23"));
						pd.put("se_phone", listPd.get(i).getString("var24"));
						pd.put("se_faxes", listPd.get(i).getString("var25"));
						pd.put("se_bank", listPd.get(i).getString("var26"));
						pd.put("se_accounts", listPd.get(i).getString("var27"));
						pd.put("modified_time",df);//录入时间
						pd.put("con_bidding", listPd.get(i).getString("var28"));
						pd.put("con_tariff", listPd.get(i).getString("var29"));
						pd.put("con_standard", listPd.get(i).getString("var30"));
						pd.put("con_build", listPd.get(i).getString("var31"));
						pd.put("con_technology", listPd.get(i).getString("var32"));
						pd.put("con_approval", 0);//流程状态
						pd.put("requester_id", USER_ID);
						pd.put("is_subscription", 2);//订金是否到账（1.是 2.否）
						pd.put("con_state", 2);//合同生效状态 （1.已生效 2.未生效）
						pd.put("facility_contract", listPd.get(i).getString("var33"));
						pd.put("install_contract", listPd.get(i).getString("var34"));
						pd.put("install_price", listPd.get(i).getString("var35"));
						pd.put("install_clause", listPd.get(i).getString("var36"));
						
						
						String Special=null; // 获取特种梯
						String General=null; // 获取常规梯
						//根据项目id获取该项目所拥有的电梯种类。
						pd.put("item_no", ItemPd2.getString("item_no"));//获取导入文档中的项目id
						PageData Itempd = contractService.findItemById(pd); // 项目信息
						String elevatorInfo=Itempd.getString("elevator_info");
						JSONArray jsonArray = JSONArray.fromObject(elevatorInfo);//转换为json
						for(int j=0;j<jsonArray.size();j++)
						{
							JSONObject jsonObject=jsonArray.getJSONObject(j);
							String a=jsonObject.getString("elevatorType");
							if(a.equals("3"))
							{
								Special="no";  //如果梯种包含3（特种梯）走特种梯流程
							}
							else 
							{
								General="yes";  //1 2 4 常规梯，家用梯，扶梯  都走常规流程
							}
					    }
						//根据项目所拥有的电梯种类来启动对应的流程
						if ("no".equals(Special) && "yes".equals(General)) 
						{
							String con = "GeneralContract"; // 常规流程的key
							pd.put("con_process_key", con);
							String con1 = "SpecialContract"; // 特种流程的key
							pd.put("con_special_key", con1);
							
							processDefinitionKey1 = "GeneralContract"; // 常规 流程的KEY
							processDefinitionKey2 = "SpecialContract"; // 特种 流程的KEY
						} 
						else if ("no".equals(Special)) 
						{
							String con1 = "SpecialContract"; // 特种流程的key
							pd.put("con_special_key", con1);
							pd.put("con_process_key", "");
							
							processDefinitionKey2 = "SpecialContract"; // 特种 流程的KEY	
						} 
						else if ("yes".equals(General)) 
						{
							String con = "GeneralContract"; // 常规流程的key
							pd.put("con_process_key", con);
							pd.put("con_special_key", "");
							processDefinitionKey1 = "GeneralContract"; // 常规 流程的KEY
						}
						
						allErr = false;
				    	//保存至数据库
				    	contractService.saveS(pd);
				    	
				    	//**********************生成流程实例
						try {
							// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
							WorkFlow workFlow = new WorkFlow();
							IdentityService identityService = workFlow.getIdentityService();
							identityService.setAuthenticatedUserId(USER_ID);
							Object uuId = pd.get("con_uuid");
							String businessKey = "tb_contract.con_uuid." + uuId;
							// 设置变量
							Map<String, Object> variables = new HashMap<String, Object>();
							variables.put("user_id", USER_ID);
							ProcessInstance proessInstance1 = null; // 流程1 实例key
							ProcessInstance proessInstance2 = null; // 流程2 实例key
							if (processDefinitionKey1 != null && !"".equals(processDefinitionKey1)) {
								proessInstance1 = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey1,
										businessKey, variables);
							}
							if (processDefinitionKey2 != null && !"".equals(processDefinitionKey2)) {
								proessInstance2 = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey2,
										businessKey, variables);
							}
							if (proessInstance1 != null) {
								pd.put("con_process_key", proessInstance1.getId());
							}
							if (proessInstance2 != null) {
								pd.put("con_special_key", proessInstance2.getId());
							}
							
						    allErr = false;
						    contractService.editS(pd);//修改
						} catch (Exception e) {
							map.put("errorMsg", "上传失败,流程存在问题！");
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
			}
			else
			{
				map.put("msg", "exception");
	    		map.put("errorMsg", "上传失败,没有数据！");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
		}
		return JSONObject.fromObject(map);
	}
	
	public class HeadFootInfoPdfPageEvent extends PdfPageEventHelper {
        //自定义传参数
		public String ban;    //参数  版本
		public String con;    //参数合同类型
        public PdfTemplate tpl;
        BaseFont bfTitle;

        //无参构造方法
        public HeadFootInfoPdfPageEvent() {
            super();
        }
        //无参构造方法
        public HeadFootInfoPdfPageEvent(String ban,String con) {
            super();
            this.ban=ban;
            this.con=con;
        } 
        
        public void onOpenDocument(PdfWriter writer, Document document) {
            tpl = writer.getDirectContent().createTemplate(100, 20);
        }
        //实现页眉和页脚的方法
        public void onEndPage(PdfWriter writer, Document document) {
            try {
                //String[] riqi = date.split("-");
            	String dn="东南电梯";
                PdfContentByte headAndFootPdfContent = writer.getDirectContent();
                headAndFootPdfContent.saveState();
                headAndFootPdfContent.beginText();
                //设置中文
                bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                headAndFootPdfContent.setFontAndSize(bfTitle, 10);
               
                //String imagepath="C:/dnlogo.png";
                String rootPath=getClass().getResource("/").getFile().toString();  
                File f = new File(rootPath+"com/dncrm/util/image/dnlogo.png");
                String url=f.toString();
                Image logo = Image.getInstance(url);
                logo.setAlignment(Image.ALIGN_CENTER); 
                logo.scaleToFit(50, 25); 
                logo.setAbsolutePosition(10, 805); 
                //文档页头信息设置  
                float x = document.top(-0);
                float x1 = document.top(-5);
                String a="________________________________________________________________________________________________________________________________________________________________";
               
                //页头信息左面  
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_LEFT,dn,document.left() + 1, x1, 0);
                //页头信息右面  
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_RIGHT,ban, document.right() - 1, x1, 0);
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_RIGHT,a, document.top() - 1, x, 0);
                //文档页脚信息设置  
                float y = document.bottom(-20);
                float y1 = document.bottom(-20);
                headAndFootPdfContent.addImage(logo);//logo
                //页脚信息左面  
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_LEFT, con, document.left() + 10, y, 0);
                //页脚信息右面  
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_RIGHT, "服务热线：400-828-8560", document.right() - 1, y, 0);
                //添加页码
                //页脚信息中间  
                headAndFootPdfContent.showTextAligned(PdfContentByte.ALIGN_CENTER,"第"+ document.getPageNumber(),
                        (document.right() + document.left()) / 2, y1, 0);
                //在每页结束的时候把“第x页”信息写道模版指定位置  
                headAndFootPdfContent.addTemplate(tpl, (document.right() + document.left()) / 2 + 15, y1);//定位“y页” 在具体的页面调试时候需要更改这xy的坐标  
                headAndFootPdfContent.endText();
                headAndFootPdfContent.restoreState();
            } catch (Exception de) {
                de.printStackTrace();
            }
        }

        public void onCloseDocument(PdfWriter writer, Document document) {
            //关闭document的时候获取总页数，并把总页数按模版写道之前预留的位置  
            tpl.beginText();
            tpl.setFontAndSize(bfTitle, 10);
            tpl.showText("页，共" + Integer.toString(writer.getPageNumber() - 1) + "页");
            tpl.endText();
            tpl.closePath();//sanityCheck();  
        }
       
    }
	
	// 生成pdf文件（定做合同）
	@RequestMapping("/transformPDF")
	@ResponseBody
	public Object transformPDf() throws DocumentException, IOException {
		PageData pd = new PageData();
		pd = this.getPageData();
		String con_id = pd.getString("con_id");
		String item_id = pd.getString("item_id");
		PageData kehu = new PageData();// 存放客户信息的 pd
		PageData pdelev = new PageData(); // 电梯信息pd
		List<PageData> listelev = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = contractService.findContractById(pd);// 根据合同编号查询合同信息和项目信息
			PageData pdItem = new PageData();
			pdItem = contractService.findByItem_Id(pd);
			String type = pdItem.getString("customer_type"); // 客户类型
			String kehu_id = pdItem.getString("customer_id"); // 客户编号
			kehu.put("kehu_id", kehu_id); // 给pd客户的编号
			if (type.equals("Ordinary")) {
				kehu = contractService.findByOrdinary(kehu);
			} else if (type.equals("Merchant")) {
				kehu = contractService.findByMerchant(kehu);
			} else if (type.equals("Core")) {
				kehu = contractService.findByCore(kehu);
			}
			// 电梯信息
			pdelev.put("item_id", item_id);// 添加项目id
			listelev = contractService.findByElev(pdelev);
			map.put("msg", "success"); 
		} catch (Exception e) {
			map.put("msg", "failed");
			e.printStackTrace();
		}
		Document doc = new Document();
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("C:\\itext3.pdf")); // 创建pdf文件
		BaseFont bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font title = new Font(bfTitle, 18, Font.BOLD);// 标题字体
		Font mintitle = new Font(bfTitle, 14, Font.NORMAL);// 小标题字体
		Font titleFont = new Font(bfTitle, 12, Font.NORMAL);// 内容字体
		
		String ban="DN/QR-HT-01   版次：02";  
		String con="设备定做合同";
		writer.setPageEvent(new HeadFootInfoPdfPageEvent(ban,con));//调用添加页眉页脚
		doc.open(); 
		Paragraph titleP = new Paragraph("电（扶）梯设备定作合同\n\n", title);
		titleP.setAlignment(titleP.ALIGN_CENTER);
		doc.add(titleP);
		PdfPTable table = new PdfPTable(2); // 创建表格对象 2代表两列
		// table.setBorderWidth(1);//边框宽度
		PdfPCell cell = new PdfPCell();
		table.setWidthPercentage(100);
		table.setWidthPercentage(100);
		// 第0行
		PdfPCell cell1 = new PdfPCell(new Phrase("合同编号：" + pd.getString("con_id"), titleFont));
		PdfPCell cell2 = new PdfPCell(new Phrase("项目名称：" + pd.getString("item_name"), titleFont));
		table.addCell(cell1);
		table.addCell(cell2);
		// 第1行
		/*
		 * PdfPCell cell3 = new PdfPCell(new Phrase(" ")); PdfPCell cell4 = new
		 * PdfPCell(new Phrase(" ")); cell3.setBorderWidth(0);
		 * cell4.setBorderWidth(0); table.addCell(cell3); table.addCell(cell4);
		 */
		// 添加第2行
		PdfPCell cell5 = new PdfPCell(new Phrase("定作方（甲方）", mintitle));
		PdfPCell cell6 = new PdfPCell(new Phrase("承揽方（乙方）", mintitle));
		cell5.setHorizontalAlignment(1);// 文本居中
		cell6.setHorizontalAlignment(1);// 文本居中
		cell5.setBorderWidth(0);
		cell6.setBorderWidth(0);
		table.addCell(cell5);
		table.addCell(cell6);
		// 添加第3行
		PdfPCell cell7 = new PdfPCell(new Phrase("定作方:" + kehu.getString("name"), titleFont));
		PdfPCell cell8 = new PdfPCell(new Phrase("单位名称:东南电梯股份有限公司", titleFont));
		cell7.setBorderWidth(0);
		cell8.setBorderWidth(0);
		table.addCell(cell7);
		table.addCell(cell8);
		// 添加第4行
		PdfPCell cell9 = new PdfPCell(new Phrase("公司地址: " + kehu.getString("address"), titleFont));
		PdfPCell cell10 = new PdfPCell(new Phrase("公司地址:江苏省吴江经济开发区交通北路6588号", titleFont));
		cell9.setBorderWidth(0);
		cell10.setBorderWidth(0);
		table.addCell(cell9);
		table.addCell(cell10);
		// 添加第5行
		PdfPCell cell11 = new PdfPCell(new Phrase("电话:" + kehu.getString("phone"), titleFont));
		PdfPCell cell12 = new PdfPCell(new Phrase("总机:0512-63038888", titleFont));
		cell11.setBorderWidth(0);
		cell12.setBorderWidth(0);
		table.addCell(cell11);
		table.addCell(cell12);
		// 添加第6行
		PdfPCell cell13 = new PdfPCell(new Phrase("传真:" + kehu.getString("fax"), titleFont));
		PdfPCell cell14 = new PdfPCell(new Phrase("传真:0512-63031582", titleFont));
		cell13.setBorderWidth(0);
		cell14.setBorderWidth(0);
		table.addCell(cell13);
		table.addCell(cell14);
		// 添加第7行
		PdfPCell cell15 = new PdfPCell(new Phrase("邮编:" + kehu.getString("postcode"), titleFont));
		PdfPCell cell16 = new PdfPCell(new Phrase("邮编:215200", titleFont));
		cell15.setBorderWidth(0);
		cell16.setBorderWidth(0);
		table.addCell(cell15);
		table.addCell(cell16);
		// 添加第8行
		PdfPCell cell17 = new PdfPCell(new Phrase("开户银行:" + kehu.getString("bank"), titleFont));
		PdfPCell cell18 = new PdfPCell(new Phrase("开户银行:中国建设银行吴江市支行", titleFont));
		cell17.setBorderWidth(0);
		cell18.setBorderWidth(0);
		table.addCell(cell17);
		table.addCell(cell18);
		// 添加第9行
		PdfPCell cell19 = new PdfPCell(new Phrase("银行帐号:" + kehu.getString("bank_no"), titleFont));
		PdfPCell cell20 = new PdfPCell(new Phrase("银行帐号:32201997636059000518", titleFont));
		cell19.setBorderWidth(0);
		cell20.setBorderWidth(0);
		table.addCell(cell19);
		table.addCell(cell20);
		// 添加第10行
		PdfPCell cell21 = new PdfPCell(new Phrase("税务登记号:" + kehu.getString("tax"), titleFont));
		PdfPCell cell22 = new PdfPCell(new Phrase("税务登记号:320584703659565", titleFont));
		cell21.setBorderWidth(0);
		cell22.setBorderWidth(0);
		table.addCell(cell21);
		table.addCell(cell22);
		// 添加第11行
		PdfPCell cell23 = new PdfPCell(new Phrase("联系人:" + kehu.getString("contact"), titleFont));
		PdfPCell cell24 = new PdfPCell(new Phrase("行号:", titleFont));
		cell23.setBorderWidth(0);
		cell24.setBorderWidth(0);
		table.addCell(cell23);
		table.addCell(cell24);
		// 添加第12行
		PdfPCell cell25 = new PdfPCell(new Phrase("联系方式:" + kehu.getString("contact_phone"), titleFont));
		PdfPCell cell26 = new PdfPCell(new Phrase("联系人:", titleFont));
		cell25.setBorderWidth(0);
		cell26.setBorderWidth(0);
		table.addCell(cell25);
		table.addCell(cell26);
		// 添加第13行
		PdfPCell cell27 = new PdfPCell(new Phrase(" ", titleFont));
		PdfPCell cell28 = new PdfPCell(new Phrase("联系方式:", titleFont));
		cell27.setBorderWidth(0);
		cell28.setBorderWidth(0);
		table.addCell(cell27);
		table.addCell(cell28);
		// 添加第14行
		PdfPCell cell29 = new PdfPCell(new Phrase(" ", titleFont));
		PdfPCell cell30 = new PdfPCell(new Phrase(" ", titleFont));
		cell29.setBorderWidth(0);
		cell30.setBorderWidth(0);
		table.addCell(cell29);
		table.addCell(cell30);
		// 添加第15行
		PdfPCell cell31 = new PdfPCell(new Phrase("甲方盖章:", titleFont));
		PdfPCell cell32 = new PdfPCell(new Phrase("乙方盖章:", titleFont));
		cell31.setBorderWidth(0);
		cell32.setBorderWidth(0);
		table.addCell(cell31);
		table.addCell(cell32);
		// 添加第16行
		PdfPCell cell33 = new PdfPCell(new Phrase("签字:", titleFont));
		PdfPCell cell34 = new PdfPCell(new Phrase("签字:", titleFont));
		cell33.setBorderWidth(0);
		cell34.setBorderWidth(0);
		table.addCell(cell33);
		table.addCell(cell34);
		// 添加第17行
		PdfPCell cell35 = new PdfPCell(new Phrase("_____年_____月_____日", titleFont));
		PdfPCell cell36 = new PdfPCell(new Phrase("_____年_____月_____日", titleFont));
		cell35.setBorderWidth(0);
		cell36.setBorderWidth(0);
		table.addCell(cell35);
		table.addCell(cell36);
		// 添加第18行
		/*
		 * PdfPCell cell37 = new PdfPCell(new Phrase(" ",titleFont)); PdfPCell
		 * cell38 = new PdfPCell(new Phrase(" ",titleFont));
		 * cell37.setBorderWidth(0); cell38.setBorderWidth(0);
		 * table.addCell(cell37); table.addCell(cell38);
		 */
		// 添加第19行
		PdfPCell cell39 = new PdfPCell(new Paragraph("合同设备最终用户及安装地点：", titleFont));
		cell39.setHorizontalAlignment(1);// 文本居中
		cell39.setColspan(2); // 跨列
		cell39.setBorderWidth(0);
		table.addCell(cell39);
		// 添加第20行
		PdfPCell cell40 = new PdfPCell(
				new Paragraph("最终用户/使用单位名称：____________________________________________________________", titleFont));
		cell40.setColspan(2);
		cell40.setBorderWidth(0);
		table.addCell(cell40);
		// 添加第21行
		PdfPCell cell41 = new PdfPCell(new Phrase("联系人：", titleFont));
		PdfPCell cell42 = new PdfPCell(new Phrase("联系电话：", titleFont));
		cell41.setBorderWidth(0);
		cell42.setBorderWidth(0);
		table.addCell(cell41);
		table.addCell(cell42);
		// 添加第22行
		PdfPCell cell43 = new PdfPCell(new Paragraph("安装地点：__________省__________市__________区/县", titleFont));
		cell43.setColspan(2);
		cell43.setBorderWidth(0);
		table.addCell(cell43);

		for (PdfPRow row : (ArrayList<PdfPRow>) table.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table);
		String one = "根据《中华人民共和国合同法》，经甲乙双方友好协商，一致同意签订本合同，并共同遵守。" + "\n" + "合同条款如下：";
		String one_1 = "第一条：合同货物描述、数量及价格（RMB，元）：" + "\n" + " ";
		doc.add(new Paragraph(one, titleFont));
		doc.add(new Paragraph(one_1, mintitle));

		PdfPTable table2 = new PdfPTable(7); // 创建表格对象 2代表两列
		// PdfPCell cell2 = new PdfPCell ();
		table2.setWidthPercentage(100);
		table2.setWidthPercentage(100);

		// 第一行
		table2.addCell(new Paragraph("序号", titleFont));
		table2.addCell(new Paragraph("产品名称", titleFont));
		table2.addCell(new Paragraph("型号", titleFont));
		table2.addCell(new Paragraph("梯种", titleFont));
		table2.addCell(new Paragraph("数量", titleFont));
		table2.addCell(new Paragraph("单价", titleFont));
		table2.addCell(new Paragraph("小计", titleFont));

		int j = 1;
		for (int i = 0; i < listelev.size(); i++) {
			PageData pdel = listelev.get(i);
			table2.addCell(new Paragraph("" + j, titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("product_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("models_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("elevator_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("num"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("total"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("xj"), titleFont));
			j++;
		}
		PdfPCell cell44 = new PdfPCell();
		cell44 = new PdfPCell(
				new Paragraph("合同设备总价（大写人民币）：                              (￥：             元)", titleFont));
		cell44.setColspan(7);
		table2.addCell(cell44);

		for (PdfPRow row : (ArrayList<PdfPRow>) table2.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table2);
		String two = "第二条：付款方式：";
		String two_1 = "    2.1甲方根据交提货周期长短，按下述约定付款：";
		String two_2 = "     1）第一期款：在本合同签订之日起7天内，甲方应向乙方支付本合同设备总价款的 30 %，计人民币（大写）：____________________元整（其中合同设备总价的20%作为合同定金）。若合同履行，则定金抵作本合同的货款。甲方逾期给付的，则合同的交货期予以顺延。";
		String two_3 = "     2）第二期款：甲方须在提货前 天之前，向乙方支付合同设备总价的 %，计人民币（大写）：____________________元整作为投产款。甲方逾期给付的，则合同的预定交货期予以顺延。"
				+ "\n"
				+ "     3）第三期款：在满足工厂生产周期的前提下，甲方须在约定的交货日期前15天之前，向乙方支付设备提货款，合同设备总价的 %，计人民币（大写）：____________________元整。乙方收到此款项后，根据本合同约定的交货周期安排发运。甲方逾期给付的，则合同的交货周期予以顺延。";
		String two_4 = "    2.2付款时注意事项：" + "\n" + "    支付定金和货款时，须注明付款单位名称；" + "\n"
				+ "    付款后，及时将支付凭证复印件传真给乙方授权代表人，以便及时确认；";
		String two_5 = "    2.3发票开具事项：" + "\n" + "    买断&出口项目：按出货后7天内开具；" + "\n" + "    其他项目：电梯安装完工验收合格后，一次性提供发票。";
		doc.add(new Paragraph(two, mintitle));
		doc.add(new Paragraph(two_1, titleFont));
		doc.add(new Paragraph(two_2, titleFont));
		doc.add(new Paragraph(two_3, titleFont));
		doc.add(new Paragraph(two_4, titleFont));
		doc.add(new Paragraph(two_5, titleFont));

		String three = "第三条：货物的交付：";
		String three_1 = "    3.1本合同设备预定交货期应为本合同签订、乙方收到甲方投产款以及技术确认、《土建布置图》及合同技术规格表等技术资料由客户签字盖章确认起____天。如未能满足前述条件，交货期顺延或另议。"
				+ "\n" + "    交货期如有变动，一方应提前书面通知，并经另一书面认可。甲方要求推迟交货时间/暂停供货的，应经乙方书面认可，由此产生的仓储费自约定交货时间起算。期间如有法定节假日，交货期顺延。";
		String three_2 = "    3.2设备的具体发货日期详见《发货确认函》确认。" + "\n" + "    3.3交货地点： 乙方工厂。" + "\n" + "    3.4交货方式：" + "\n"
				+ "    1）甲方自提：";
		String three_3 = "    甲方应按本合同约定，在付清全部应付设备款项后，提货人携带甲方自提委托书和本人身份证等有效证明，在本合同约定的交货期内前往乙方工厂提取合同设备。" + "\n"
				+ "  2）乙方代办运输：" + "\n" + "  甲方应明确以下收货信息，如收货信息错误导致乙方错发，乙方不承担相关责任。";
		String three_4 = "    收货单位：________________________________________ " + "\n"
				+ "    到(站)港：________________________________________" + "\n"
				+ "    接货地址：________________________________________" + "\n"
				+ "    邮编：________联系人：_______电话：________传真：________ ";
		String three_5 = "    3.5乙方应按照本合同约定的运输方式、收货单位发运合同设备。如甲方收货地址变更为不同省/市区域，因涉及服务便利性及区域差异，需由乙方对合同信息进行重新确认，产生的相关费用由甲方承担（如有）。如前述信息变更，甲方应在发运前7天及时书面通知乙方，否则乙方将按照本合同约定发运。 "
				+ "\n" + "    3.6如果甲方与乙方安装公司或乙方子公司就本项目签订的安装合同内约定安装款项须在合同设备发运前支付的，则合同设备将在乙方安装公司或乙方子公司收到该款项后才能发运。";
		doc.add(new Paragraph(three, mintitle));
		doc.add(new Paragraph(three_1, titleFont));
		doc.add(new Paragraph(three_2, titleFont));
		doc.add(new Paragraph(three_3, titleFont));
		doc.add(new Paragraph(three_4, titleFont));
		doc.add(new Paragraph(three_5, titleFont));

		String four = "第四条：货物的交付查验和保管：";
		String four_1 = "    4.1乙方可根据特殊情况，在征得甲方同意的条件下，将合同设备分批发运，以配合合同设备的安装和保证交付使用的时间。如因甲方原因分批发运的，对所发生的额外运输费及包装费，甲方应在合同设备发运前向乙方一次性结清。";
		String four_2 = "    4.2收货查验：" + "\n"
				+ "    甲方收到货物当日，应对货物箱数进行清点，并会同承运人对包装箱的完好或损坏状态进行确认，若发现包装箱缺少或损坏，应即时记录缺损情况，包括现场照片等资料，并要求运输部门出具有效证明，并在电梯设备到货之日起5日内以书面联系乙方，并协助乙方办理保险索赔事宜。否则乙方视为与甲方清点无误。";
		String four_3 = "    4.3保管：" + "\n" + "    甲方应提供具备防淋、防潮、防盗、防强光等存放货物所需的封闭空间，并对货物进行妥善保管，防止任何损蚀、损失和损害。";
		String four_4 = "    4.4 安装前查验：" + "\n"
				+ "    在包装箱完好无损的情况下，箱内货物有缺损由乙方负责补足、修理或更换；如未经乙方许可，甲方擅自开箱的，或者开箱前包装箱已经损坏，箱内货物有缺损的，包装箱数量与根据合同4.2条款约定清点的数量不一致的，乙方不承担责任。";
		doc.add(new Paragraph(four, mintitle));
		doc.add(new Paragraph(four_1, titleFont));
		doc.add(new Paragraph(four_2, titleFont));
		doc.add(new Paragraph(four_3, titleFont));
		doc.add(new Paragraph(four_4, titleFont));

		String five = "第五条：执行标准： 本公司产品执行标准：";
		String five_1 = "    5.1	GB 7588-2003 《电梯制造与安装安全规范》" + "\n" + "    5.2	GB 21240-2007 《液压电梯制造与安装安全规范》"
				+ "\n" + "    5.3	GB 16899-2011 《自动扶梯和自动人行道的制造与安装安全规范》";
		doc.add(new Paragraph(five, mintitle));
		doc.add(new Paragraph(five_1, titleFont));

		String six = "第六条：承诺和保证：";
		String six_1 = "    6.1乙方保证其出售的货物完全符合本合同的约定，并保证其所提供的货物是全新的，且有权出售。 ";
		String six_2 = "    6.2根据国务院（2003）第373号令《特种设备安全监察条例》的有关规定，电梯、扶梯、人行道等设备的安装必须由电梯制造单位或者其通过合同委托、同意的且依照本条例取得许可的单位进行。在签订本合同的同时，甲乙双方应签订本合同电（扶）梯设备的安装合同。若甲方不与乙方签订安装合同，或虽签约但后又违约自行安排乙方以外的其他方进行合同电（扶）梯设备的安装、调试、维护工作的，乙方只承担与本合同电（扶）梯设备原设计、制造相关的直接质量责任，除此以外其它任何质量和安全责任均由甲方承担，乙方将不承担免费保修保养责任。";
		String six_3 = "    6.3由乙方或乙方委托方负责安装的，在甲方遵守货物的保管、使用、安装、保养、维修条件下，本合同电（扶）梯设备的免费保修保养期为自设备安装完毕、政府验收合格之日起12个月或自乙方发运之日起18个月（以先到日期为准）。在此期间，如产品设备本身存在因乙方原因造成的质量缺陷，乙方应负责修理或免费更换相应零部件。若合同设备分批验收，质保期则分批计算。";
		String six_4 = "    如非由乙方或乙方委托方负责安装的产品，则乙方不承担免费保养责任，亦不承担因非乙方安装调试而引起的质量事故及责任，乙方只承担与产品原设计、制造相关的直接质量责任，除此以外其它任何质量和安全责任均由甲方承担。";
		doc.add(new Paragraph(six, mintitle));
		doc.add(new Paragraph(six_1, titleFont));
		doc.add(new Paragraph(six_2, titleFont));
		doc.add(new Paragraph(six_3, titleFont));
		doc.add(new Paragraph(six_4, titleFont));

		String seven = "第七条：违约责任： ";
		String seven_1 = "    7.1本合同生效后，如因乙方原因全部或部分解除合同，须向甲方双倍返还定金，同时须赔偿甲方直接经济损失；如因甲方原因全部或部分解除合同，乙方不退还定金，甲方同时须赔偿乙方直接经济损失。 ";
		String seven_2 = "    7.2如甲方未按期支付定金或货款，乙方可以顺延交付日期和/或调整合同总价，同时甲方每天应按延迟交付合同设备总金额的万分之三向乙方支付违约金（但违约金累积最高不超过合同总价的3%）；如甲方未按期支付定金或任何一期货款达三个月或以上的，乙方有权决定是否解除合同；如决定解除的，乙方应向甲方发出书面通知，本合同应视为因甲方原因于通知发出之日被解除，甲方应同时按上款规定承担违约责任。 ";
		String seven_3 = "    7.3乙方在合同交货期到期后一周内免费提供仓储；如甲方迟延付款超过一周，造成乙方无法交付货物的，甲方须向乙方支付仓储费（按电梯每台每天100元计算），并且在甲方付清到期货款和仓储费前将暂不交付货物。甲方其他原因（如甲方要求推迟交货时间并经乙方同意）造成乙方无法如期交付货物的，甲方亦应支付延期交货所产生的仓储费。如甲方推迟交货时间不确定的，应及时予以确定，如经乙方催告后仍不确定的，则乙方可按甲方原因解除合同处理，也可以要求甲方继续履行合同。";
		String seven_4 = "    7.4如乙方因自身单方面原因延期交货，应按延期天数向甲方支付每天合同总价万分之三的违约金（但违约金累积最高不超过合同总价的3%）；如乙方无理由延期交货达三个月的，除继续支付上述违约金外，甲方还有权决定是否解除合同；如决定解除的，甲方应向乙方发出书面通知，本合同应视为因乙方原因于通知发出之日被解除，乙方应同时按7.1条规定承担违约责任。 ";
		String seven_5 = "    7.5不可抗力事件应根据《中华人民共和国合同法》的要求进行处理。" + "\n" + "    7.6在甲方付清本合同款项之前，本合同电（扶）梯设备的所有权属乙方所有";
		doc.add(new Paragraph(seven, mintitle));
		doc.add(new Paragraph(seven_1, titleFont));
		doc.add(new Paragraph(seven_2, titleFont));
		doc.add(new Paragraph(seven_3, titleFont));
		doc.add(new Paragraph(seven_4, titleFont));
		doc.add(new Paragraph(seven_5, titleFont));

		String eight = "第八条：争议的解决：";
		String eight_1 = "    因执行本合同而引起的一切争议，由双方通过友好协商解决；协商不成时合同任一方均可向原告所在地法院提起诉讼。";
		doc.add(new Paragraph(eight, mintitle));
		doc.add(new Paragraph(eight_1, titleFont));

		String nine = "第九条：其他： ";
		String nine_1 = "    9.1 本合同自双方签署且甲方支付合同约定的定金后生效。" + "\n"
				+ "    9.2本合同所有条款均为打印文字。本合同文本不得随意涂改；若需修改，须经甲、乙双方协商达成一致意见，并经双方签字盖章确认后视为有效。";
		String nine_2 = "    9.3本合同附件（《土建布置图》、《电梯合同技术规格表》，或《自动扶梯合同技术规格表》及《自动人行道合同技术规格表》等），为本合同不可分割的组成部分，与本合同具有同等的法律效力，双方签字盖章后视为有效。如果因甲方设计、土建结构变更，则《土建布置图》（井道及机房布置图）须经双方盖章确认后有效，时间以双方确认的最后一份为准。在甲乙双方确认《土建布置图》（井道及机房布置图）及《合同设备技术规格表》、合同生效后，甲方设计、土建结构发生变更，则甲方需承担因变更而产生的相关费用。";
		String nine_3 = "    9.4在本合同签定后，合同中如有未尽事宜或合同履行过程中有相关内容需加以补充或变更，双方需签署书面补充合同或变更合同。";
		String nine_4 = "    9.5本合同设备涉及的乙方知识产权，未经乙方许可，甲方不得为生产经营目的制造、使用、许诺销售、销售、进口其知识产权产品，或者使用其知识产权方法。";
		String nine_5 = "    9.6合同未涉及的违约事宜等条款，应按照《中华人民共和国合同法》相关规定处理。" + "\n" + "    9.7本合同壹式肆份，甲乙双方各执贰份，具有同等法律效力。";
		doc.add(new Paragraph(nine, mintitle));
		doc.add(new Paragraph(nine_1, titleFont));
		doc.add(new Paragraph(nine_2, titleFont));
		doc.add(new Paragraph(nine_3, titleFont));
		doc.add(new Paragraph(nine_4, titleFont));
		doc.add(new Paragraph(nine_5, titleFont));

		doc.close();
		
		return JSONObject.fromObject(map); 
	}

	// 生成pdf文件（安装合同）
	@RequestMapping("/transformPDF2")
	@ResponseBody
	public Object transformPDf2() throws DocumentException, IOException {
		PageData pd = new PageData();
		pd = this.getPageData();
		String con_id = pd.getString("con_id");
		String item_id = pd.getString("item_id");

		PageData kehu = new PageData();// 存放客户信息的 pd
		PageData pdelev = new PageData(); // 电梯信息pd
		List<PageData> listelev = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = contractService.findContractById(pd);// 根据合同编号查询合同信息和项目信息

			PageData pdItem = new PageData();
			pdItem = contractService.findByItem_Id(pd);
			String type = pdItem.getString("customer_type"); // 客户类型
			String kehu_id = pdItem.getString("customer_id"); // 客户编号

			kehu.put("kehu_id", kehu_id); // 给pd客户的编号
			if (type.equals("Ordinary")) {
				kehu = contractService.findByOrdinary(kehu);
			} else if (type.equals("Merchant")) {
				kehu = contractService.findByMerchant(kehu);
			} else if (type.equals("Core")) {
				kehu = contractService.findByCore(kehu);
			}

			// 电梯信息
			pdelev.put("item_id", item_id);// 添加项目id
			listelev = contractService.findByElev(pdelev);
			map.put("msg", "success");  
		} catch (Exception e) {
			e.printStackTrace();
			  map.put("msg", "failed"); 
		}

		Document doc = new Document();
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("C:\\itext4.pdf")); // 创建pdf文件
		BaseFont bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font title = new Font(bfTitle, 18, Font.BOLD);// 标题字体
		Font mintitle = new Font(bfTitle, 14, Font.NORMAL);// 小标题字体
		Font titleFont = new Font(bfTitle, 12, Font.NORMAL);// 内容字体

		String ban="DN/QR-HT-04  版次：02";  
		String con="设备安装合同";
		writer.setPageEvent(new HeadFootInfoPdfPageEvent(ban,con));//调用添加页眉页脚
		doc.open(); // 打开创建的pdf文件
		Paragraph titleP = new Paragraph("电（扶）梯设备安装合同\n\n", title);
		titleP.setAlignment(titleP.ALIGN_CENTER);
		doc.add(titleP);
		PdfPTable table = new PdfPTable(2); // 创建表格对象 2代表两列
		// table.setBorderWidth(1);//边框宽度
		PdfPCell cell = new PdfPCell();
		table.setWidthPercentage(100);
		table.setWidthPercentage(100);
		// 第0行
		PdfPCell cell1 = new PdfPCell(new Phrase("合同编号：" + pd.getString("con_id"), titleFont));
		PdfPCell cell2 = new PdfPCell(new Phrase("项目名称：" + pd.getString("item_name"), titleFont));
		table.addCell(cell1);
		table.addCell(cell2);
		// 添加第2行
		PdfPCell cell5 = new PdfPCell(new Phrase("定作方（甲方）", mintitle));
		PdfPCell cell6 = new PdfPCell(new Phrase("承揽方（乙方）", mintitle));
		cell5.setHorizontalAlignment(1);// 文本居中
		cell6.setHorizontalAlignment(1);// 文本居中
		cell5.setBorderWidth(0);
		cell6.setBorderWidth(0);
		table.addCell(cell5);
		table.addCell(cell6);
		// 添加第3行
		PdfPCell cell7 = new PdfPCell(new Phrase("单位名称:" + kehu.getString("name"), titleFont));
		PdfPCell cell8 = new PdfPCell(new Phrase("单位名称:东南电梯股份有限公司", titleFont));
		cell7.setBorderWidth(0);
		cell8.setBorderWidth(0);
		table.addCell(cell7);
		table.addCell(cell8);
		// 添加第4行
		PdfPCell cell9 = new PdfPCell(new Phrase("公司地址: " + kehu.getString("address"), titleFont));
		PdfPCell cell10 = new PdfPCell(new Phrase("公司地址:江苏省吴江经济开发区交通北路6588号", titleFont));
		cell9.setBorderWidth(0);
		cell10.setBorderWidth(0);
		table.addCell(cell9);
		table.addCell(cell10);
		// 添加第5行
		PdfPCell cell11 = new PdfPCell(new Phrase("电话:" + kehu.getString("phone"), titleFont));
		PdfPCell cell12 = new PdfPCell(new Phrase("总机:0512-63038888", titleFont));
		cell11.setBorderWidth(0);
		cell12.setBorderWidth(0);
		table.addCell(cell11);
		table.addCell(cell12);
		// 添加第6行
		PdfPCell cell13 = new PdfPCell(new Phrase("传真:" + kehu.getString("fax"), titleFont));
		PdfPCell cell14 = new PdfPCell(new Phrase("传真:0512-63031582", titleFont));
		cell13.setBorderWidth(0);
		cell14.setBorderWidth(0);
		table.addCell(cell13);
		table.addCell(cell14);
		// 添加第7行
		PdfPCell cell15 = new PdfPCell(new Phrase("邮编:" + kehu.getString("postcode"), titleFont));
		PdfPCell cell16 = new PdfPCell(new Phrase("邮编:215200", titleFont));
		cell15.setBorderWidth(0);
		cell16.setBorderWidth(0);
		table.addCell(cell15);
		table.addCell(cell16);
		// 添加第8行
		PdfPCell cell17 = new PdfPCell(new Phrase("开户银行:" + kehu.getString("bank"), titleFont));
		PdfPCell cell18 = new PdfPCell(new Phrase("开户银行:中国建设银行吴江市支行", titleFont));
		cell17.setBorderWidth(0);
		cell18.setBorderWidth(0);
		table.addCell(cell17);
		table.addCell(cell18);
		// 添加第9行
		PdfPCell cell19 = new PdfPCell(new Phrase("银行帐号:" + kehu.getString("bank_no"), titleFont));
		PdfPCell cell20 = new PdfPCell(new Phrase("银行帐号:32201997636059000518", titleFont));
		cell19.setBorderWidth(0);
		cell20.setBorderWidth(0);
		table.addCell(cell19);
		table.addCell(cell20);
		// 添加第10行
		PdfPCell cell21 = new PdfPCell(new Phrase("税务登记号:" + kehu.getString("tax"), titleFont));
		PdfPCell cell22 = new PdfPCell(new Phrase("税务登记号:320584703659565", titleFont));
		cell21.setBorderWidth(0);
		cell22.setBorderWidth(0);
		table.addCell(cell21);
		table.addCell(cell22);
		// 添加第11行
		PdfPCell cell23 = new PdfPCell(new Phrase("联系人:" + kehu.getString("contact"), titleFont));
		PdfPCell cell24 = new PdfPCell(new Phrase("联系人:", titleFont));
		cell23.setBorderWidth(0);
		cell24.setBorderWidth(0);
		table.addCell(cell23);
		table.addCell(cell24);
		// 添加第12行
		PdfPCell cell25 = new PdfPCell(new Phrase("联系方式:" + kehu.getString("contact_phone"), titleFont));
		PdfPCell cell26 = new PdfPCell(new Phrase("联系方式:", titleFont));
		cell25.setBorderWidth(0);
		cell26.setBorderWidth(0);
		table.addCell(cell25);
		table.addCell(cell26);
		// 添加第14行
		PdfPCell cell29 = new PdfPCell(new Phrase(" ", titleFont));
		PdfPCell cell30 = new PdfPCell(new Phrase(" ", titleFont));
		cell29.setBorderWidth(0);
		cell30.setBorderWidth(0);
		table.addCell(cell29);
		table.addCell(cell30);
		// 添加第15行
		PdfPCell cell31 = new PdfPCell(new Phrase("甲方法定代表或授权代表人签字:", titleFont));
		PdfPCell cell32 = new PdfPCell(new Phrase("乙方法定代表或授权代表人签字:", titleFont));
		cell31.setBorderWidth(0);
		cell32.setBorderWidth(0);
		table.addCell(cell31);
		table.addCell(cell32);

		PdfPCell cell3 = new PdfPCell(new Phrase("_______________________"));
		PdfPCell cell4 = new PdfPCell(new Phrase("_______________________"));
		cell3.setBorderWidth(0);
		cell4.setBorderWidth(0);
		table.addCell(cell3);
		table.addCell(cell4);
		// 添加第16行
		PdfPCell cell33 = new PdfPCell(new Phrase("签订日期_____年_____月_____日", titleFont));
		PdfPCell cell34 = new PdfPCell(new Phrase("签订日期_____年_____月_____日", titleFont));
		cell33.setBorderWidth(0);
		cell34.setBorderWidth(0);
		table.addCell(cell33);
		table.addCell(cell34);
		// 添加第17行
		PdfPCell cell35 = new PdfPCell(new Phrase("签约地点：", titleFont));
		PdfPCell cell36 = new PdfPCell(new Phrase("签约地点：", titleFont));
		cell35.setBorderWidth(0);
		cell36.setBorderWidth(0);
		table.addCell(cell35);
		table.addCell(cell36);
		// 添加第18行
		/*
		 * PdfPCell cell37 = new PdfPCell(new Phrase(" ",titleFont)); PdfPCell
		 * cell38 = new PdfPCell(new Phrase(" ",titleFont));
		 * cell37.setBorderWidth(0); cell38.setBorderWidth(0);
		 * table.addCell(cell37); table.addCell(cell38);
		 */
		// 添加第19行
		PdfPCell cell39 = new PdfPCell(new Paragraph("合同设备最终用户及安装地点：", titleFont));
		cell39.setHorizontalAlignment(1);// 文本居中
		cell39.setColspan(2); // 跨列
		cell39.setBorderWidth(0);
		table.addCell(cell39);
		// 添加第20行
		PdfPCell cell40 = new PdfPCell(
				new Paragraph("最终用户/使用单位名称：____________________________________________________________", titleFont));
		cell40.setColspan(2);
		cell40.setBorderWidth(0);
		table.addCell(cell40);
		// 添加第21行
		PdfPCell cell41 = new PdfPCell(new Phrase("联系人：", titleFont));
		PdfPCell cell42 = new PdfPCell(new Phrase("联系电话：", titleFont));
		cell41.setBorderWidth(0);
		cell42.setBorderWidth(0);
		table.addCell(cell41);
		table.addCell(cell42);
		// 添加第22行
		PdfPCell cell43 = new PdfPCell(new Paragraph("安装地点：______________________________________________", titleFont));
		cell43.setColspan(2);
		cell43.setBorderWidth(0);
		table.addCell(cell43);

		for (PdfPRow row : (ArrayList<PdfPRow>) table.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table);
		String one = "    双方按照政府部门相关法律法规及国务院《特种设备安全法》的规定，遵循公平，诚实和信用的原则，共同确定以下由乙方向甲方提供的产品安装服务内容条款。";
		String one_1 = "一、合同生效及终止";
		String one_2 = "    本合同经双方代表签字并盖章后生效，并将自动终止于本合同约定电（扶）梯验收合格及甲方支付完毕相应的安装费用。";
		String one_3 = "二、工程概况";
		String one_4 = "1、甲方将如下电（扶）梯安装工程委托乙方安装：" + "\n" + " ";
		doc.add(new Paragraph(one, titleFont));
		doc.add(new Paragraph(one_1, mintitle));
		doc.add(new Paragraph(one_2, titleFont));
		doc.add(new Paragraph(one_3, mintitle));
		doc.add(new Paragraph(one_4, titleFont));

		PdfPTable table2 = new PdfPTable(7); // 创建表格对象 2代表两列
		// PdfPCell cell2 = new PdfPCell ();
		table2.setWidthPercentage(100);
		table2.setWidthPercentage(100);

		// 第一行
		table2.addCell(new Paragraph("序号", titleFont));
		table2.addCell(new Paragraph("产品名称", titleFont));
		table2.addCell(new Paragraph("型号", titleFont));
		table2.addCell(new Paragraph("梯种", titleFont));
		table2.addCell(new Paragraph("数量", titleFont));
		table2.addCell(new Paragraph("单价", titleFont));
		table2.addCell(new Paragraph("小计", titleFont));

		int j = 1;
		for (int i = 0; i < listelev.size(); i++) {
			PageData pdel = listelev.get(i);
			table2.addCell(new Paragraph("" + j, titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("product_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("models_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("elevator_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("num"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("total"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("xj"), titleFont));
			j++;
		}
		PdfPCell cell45 = new PdfPCell();
		cell45 = new PdfPCell(new Paragraph("本合同安装调试/厂检总台数：             台", titleFont));
		cell45.setColspan(7);
		table2.addCell(cell45);

		PdfPCell cell44 = new PdfPCell();
		cell44 = new PdfPCell(new Paragraph("本合同安装调试/厂检费总金额（人民币）：             大写（人民币）：", titleFont));
		cell44.setColspan(7);
		table2.addCell(cell44);
		for (PdfPRow row : (ArrayList<PdfPRow>) table2.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table2);
		String a = "具体规格参数详见《电（扶）梯设备定作合同》中附件“产品技术规格表”。" + "\n"
				+ "2、 工程地址：______________________________________________________________";
		String b = "    甲方联系人：_______________联系电话：_______________传真：_______________" + "\n"
				+ "    乙方联系人：_______________联系电话：_______________传真：_______________";
		String c = "3、以上费用不包含甲方或总包方的配合费。";
		doc.add(new Paragraph(a, titleFont));
		doc.add(new Paragraph(b, titleFont));
		doc.add(new Paragraph(c, titleFont));
		String two = "三、安装费支付方式";
		String two_1 = "1、甲方在双方约定的安装开工日期前 10 天，向乙方支付安装费总额的 50 %，计人民币(大写)__________元整。在收到款项且确认工地具备安装条件后，乙方安排发运，并于货到工地及甲方通知后10天内进场安装。";
		String two_2 = "2、电（扶）梯安装调试完成，在通过政府部门验收合格后10日内， 甲方按照合同要求向乙方支付剩余的 50 ％安装费，计人民币(大写)__________元整，此款支付最迟不超过货到工地后4个月。乙方收到合同规定的款额后3日内与甲方办理电（扶）梯移交手续。 ";
		String two_3 = "3、如因甲方原因导致乙方不能及时安装，或电（扶）梯安装完毕后因甲方原因不及时申报验收，则设备发货之日起三个月满日即视为电（扶）梯设备已验收合格，甲方即应支付合同约定的相应款项。 ";
		String two_4 = "4、如甲方未按时支付前述安装验收款，即使免费保修期已经开始，乙方仍有权暂停免费维修保养责任。乙方对暂停期间电梯发生的故障或事故免责。 ";
		String two_5 = "付款时注意事项：";
		String two_6 = "    支付安装款时，须注明付款单位名称； " + "\n" + "    付款后及时将支付凭证复印件传真给乙方授权代表人，以便及时确认并安排电（扶）梯安装。";
		String two_7 = "发票开具事项：";
		String two_8 = "    验收项目：验收后一次性提供发票；";
		doc.add(new Paragraph(two, mintitle));
		doc.add(new Paragraph(two_1, titleFont));
		doc.add(new Paragraph(two_2, titleFont));
		doc.add(new Paragraph(two_3, titleFont));
		doc.add(new Paragraph(two_4, titleFont));
		doc.add(new Paragraph(two_5, mintitle));
		doc.add(new Paragraph(two_6, titleFont));
		doc.add(new Paragraph(two_7, mintitle));
		doc.add(new Paragraph(two_8, titleFont));

		String three = "四、土建要求";
		String three_1 = "    甲方的建筑土建必须符合建筑工程质量要求、《电（扶）梯设备定作合同》确定的土建总体布置图样和双方确认的设计土建技术要求。对于不符合项目，甲方应在约定期限内整改完毕，由于整改和拖延整改而产生的费用或损失，由甲方负责。";
		doc.add(new Paragraph(three, mintitle));
		doc.add(new Paragraph(three_1, titleFont));

		String four = "五、安装资格保证 ";
		String four_1 = "    按照国务院《特种设备安全法》规定，本合同所涉及的产品由乙方、或乙方下属_____子/分公司，或受乙方委托的具有安装资质并持有乙方开具项目委托书的单位实施安装。 ";
		doc.add(new Paragraph(four, mintitle));
		doc.add(new Paragraph(four_1, titleFont));

		String five = "六、安装施工方式、双方责任和配合事宜";
		String five_1 = "    甲乙双方约定以附件所确认的施工内容实施安装。为保证施工安全、质量和进度，甲乙双方配合事宜和责任义务如下：";
		doc.add(new Paragraph(five, mintitle));
		doc.add(new Paragraph(five_1, titleFont));

		String six = "1、甲方权利和义务：";
		String six_1 = "  1.1	就该项目授权本方人员与乙方人员进行工程交底，落实专门联系人，负责乙方与其他施工单位交叉作业时的协调工作。";
		String six_2 = "  1.2	甲方有权监督乙方的施工进度、施工质量、施工安全及人员持证上岗作业情况，发现问题及时通知乙方。";
		String six_3 = "  1.3	按照产品的《电（扶）梯土建布置图》和双方会签的《电（扶）梯现场交底备忘录》，对井道进行施工，提供完整清洁的施工现场、施工必须的水源、各楼层动力和照明电源、井道门洞防护设施和消费器材、通道照明、装饰面标高、电梯厅的轴线基准，井道和底坑须防止水源进入，机房门窗应完整、结实、防盗。在正式电源到位以前，提供机房的临时独立调试电源。正式电源应接至乙方指定的电源接入点。";
		String six_4 = "  1.4	负责由于甲方土建不符引起的井道整改，以及配合乙方进行土建封堵和修补工作。";
		String six_5 = "  1.5	及时通知乙方人员进行井道施工完工后的勘测，并由双方会同签定《电（扶）梯土建勘测表》以确认施工“符合《电（扶）梯土建布置图》《电（扶）梯现场交底备记录》要求”。 ";
		String six_6 = "  1.6	如甲方未能在设备发货日期 15 天之前完成符合要求的土建工作，则乙方可将开工日期调整。";
		String six_7 = "  1.7	甲方负责提供作业区附近具有消防、防盗措施和足够面积的卸货场地、运输通道和库房（可驻人看管），并负责施工现场的安全保卫以及工作时间之外对安装现场的监护、成品保护及施工材料、设备和工具的看护，以防遗失。如由于甲方原因，电（扶）梯发货后暂不开工，甲方需负责产品开箱前的货物保管；安装工程暂时停止的，甲方必须与乙方代表协商确认在此期间的设备保管责任。甲方应承担因甲方原因造成的乙方的误工损失，并顺延工期（见违约责任）。电（扶）梯产品未经厂检、验收合格并正式移交甲方之前，甲方不可擅自使用，否则由此产生的后果由甲方承担，且视为产品已由甲方验收合格，并开始计算质保期。";
		String six_8 = "  1.8	为保证施工安全和施工质量，甲方须给予乙方正常的施工周期。";
		String six_9 = "  1.9	为乙方提供施工便利条件，协助提供施工人员的就近食宿的生活方便。";
		String six_10 = "  1.10	免费提供安装施工期间所需的水、电源";
		String six_11 = "  1.11	在有关政府部门出具的开工文件所载日期之前且双方书面移交和接收电梯井道之 前，甲方应负责提供符合国家标准的厅门安全护栏。";
		String six_12 = "  1.12	在申请政府验收前，由甲方负责提供电梯机房到监控室等区域的通信电缆，并完成敷设工作。配合电梯制造单位做好电梯校验和调试工作，并保证电梯必须经过制造厂家的厂检。 ";
		String six_13 = "  1.13	按本合同的约定支付安装工程款项。";
		doc.add(new Paragraph(six, mintitle));
		doc.add(new Paragraph(six_1, titleFont));
		doc.add(new Paragraph(six_2, titleFont));
		doc.add(new Paragraph(six_3, titleFont));
		doc.add(new Paragraph(six_4, titleFont));
		doc.add(new Paragraph(six_5, titleFont));
		doc.add(new Paragraph(six_6, titleFont));
		doc.add(new Paragraph(six_7, titleFont));
		doc.add(new Paragraph(six_8, titleFont));
		doc.add(new Paragraph(six_9, titleFont));
		doc.add(new Paragraph(six_10, titleFont));
		doc.add(new Paragraph(six_11, titleFont));
		doc.add(new Paragraph(six_12, titleFont));
		doc.add(new Paragraph(six_13, titleFont));

		String seven = "2、乙方权利和义务：";
		String seven_1 = "  2.1在合同预约的开工期前，及时派此项目的工程项目经理会同甲方按标准对施工现场进行土建勘测，确认施工条件，提供咨询服务和提出整改要求，现场会签《电（扶）梯现场交底备忘录》和《电（扶）梯土建勘测报告》，参加现场施工协调会议，配合甲方建筑施工。 ";
		String seven_2 = "  2.2在开工进场前，会同甲方向当地政府部门提出开工许可申请。" + "\n" + "  2.3设备到货后会同甲方代表根据发运资料共同对设备包装完整性和装箱数量进行清点";
		String seven_3 = "  2.4在正常安装期间，负责保管库房内尚未安装的设备及部件。如由于甲方原因在施工中途不得不暂停施工，则必须与甲方协商确认在此期间的设备保管责任。";
		String seven_4 = "  2.5严格按照相关国家、行业或企业技术标准和质量规范，并遵守施工现场的各类规则制度，组织合格的安装人员实施安装、调试和验收作业，并达到合同约定的技术质量标准。";
		String seven_5 = "  2.6施工中产生的各类废弃物，由乙方按照当地环境管理法律法规及有关规定予以处理。" + "\n" + "  2.7负责安装质量的调试、厂检验收，配合政府部门完成验收工作。";
		String seven_6 = "  2.8	负责由于安装质量问题造成的二次检验的整改。" + "\n" + "  2.9	遵守施工现场的有关规章制度。" + "\n"
				+ "  2.10	参加现场施工协调会议，配合甲方建筑施工。";
		doc.add(new Paragraph(seven, mintitle));
		doc.add(new Paragraph(seven_1, titleFont));
		doc.add(new Paragraph(seven_2, titleFont));
		doc.add(new Paragraph(seven_3, titleFont));
		doc.add(new Paragraph(seven_4, titleFont));
		doc.add(new Paragraph(seven_5, titleFont));
		doc.add(new Paragraph(seven_6, titleFont));

		String eight = "七、安装预约和实施前的准备 ";
		String eight_1 = "  1、	双方预约于_____年_____月开工安装，预计施工周期为_____周。";
		String eight_2 = "  2、	在本合同签订后_____个工作日内，乙方即派人员到现场向甲方授权的施工人员进行交底，指导甲方进行电梯井道和机房等的施工以满足《电（扶）梯土建布置图》要求，交底完毕双方当场签订《电（扶）梯现场交底备忘录》。 ";
		String eight_3 = "  3、	甲方按照双方会签的《电（扶）梯现场交底备忘录》进行施工完毕后，及时通知乙方到现场进行土建勘测。如果土建勘测结果符合电（扶）梯的《电（扶）梯土建布置图》要求，则甲乙双方授权的人员当场会签《电（扶）梯土建勘测报告》；否则需要在勘测结果一栏注明需要整改的事项要求甲方再予整改，直到符合为止。（注：此《电（扶）梯土建勘测报告》最后会签符合要求的日期决定产品实际安装日期，请甲乙双方务必引以重视）。";
		String eight_4 = "  4、	乙方进场开工的条件应是产品到达现场、土建具备安装条件及甲方支付了本合同约定的款项及合同对应的《电（扶）梯设备定作合同》约定的款项。当满足以上条件后，双方再确定开工进场日期和竣工日期。";
		String eight_5 = "  5、	如因非乙方原因，造成乙方无法按照双方约定的安装工期计划进行施工安装、调试（如停电、土建延迟、井道准备工作延迟等），乙方对所造成的延期和误工不承担责任；若由此产生停工状态，甲方应承担乙方由于停工而造成的直接损失和费用。";
		String eight_6 = "  6、	甲方如要求变更安装日期，必须提前一个月书面通知到乙方，双方重新确定开工日期。若甲方要求终止安装的，应书面通知乙方。若已造成乙方损失，乙方有权不返还已收安装款或采取法律措施要求赔偿。";
		doc.add(new Paragraph(eight, mintitle));
		doc.add(new Paragraph(eight_1, titleFont));
		doc.add(new Paragraph(eight_2, titleFont));
		doc.add(new Paragraph(eight_3, titleFont));
		doc.add(new Paragraph(eight_4, titleFont));
		doc.add(new Paragraph(eight_5, titleFont));
		doc.add(new Paragraph(eight_6, titleFont));

		String nine = "八、甲方或乙方的责任及承担费用（确认以“√”表示） ";
		PdfPTable table3 = new PdfPTable(2); // 创建表格对象 2代表两列
		table3.setWidthPercentage(100);
		table3.setWidthPercentage(100);
		table3.setTotalWidth(new float[]{385,145});

		// 第1行
		PdfPCell cell_1 = new PdfPCell(new Phrase("责 任 内 容", mintitle));
		PdfPCell cell_2 = new PdfPCell(new Phrase("  甲方     乙方", titleFont));
		cell_2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_1.setBorderWidth(0);
		cell_2.setBorderWidth(0);
		table3.addCell(cell_1);
		table3.addCell(cell_2);
		// 第2行
		PdfPCell cell_3 = new PdfPCell(new Phrase("1．按照乙方要求完成电梯设备现场卸车及起吊。", titleFont));
		PdfPCell cell_4 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_4.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_3.setBorderWidth(0);
		cell_4.setBorderWidth(0);
		table3.addCell(cell_3);
		table3.addCell(cell_4);
		// 第3行
		PdfPCell cell_5 = new PdfPCell(new Phrase("2．提供符合国家标准及安全标准要求的安装平台", titleFont));
		PdfPCell cell_6 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_6.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_5.setBorderWidth(0);
		cell_6.setBorderWidth(0);
		table3.addCell(cell_5);
		table3.addCell(cell_6);
		// 第4行
		PdfPCell cell_7 = new PdfPCell(new Phrase("3．提供并安装井道永久照明，照明装置应符合国家标准的有关要求。", titleFont));
		PdfPCell cell_8 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_8.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_7.setBorderWidth(0);
		cell_8.setBorderWidth(0);
		table3.addCell(cell_7);
		table3.addCell(cell_8);
		// 第5行
		PdfPCell cell_9 = new PdfPCell(new Phrase("4．提供安装期间所需的水电费	", titleFont));
		PdfPCell cell_10 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_10.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_9.setBorderWidth(0);
		cell_10.setBorderWidth(0);
		table3.addCell(cell_9);
		table3.addCell(cell_10);
		// 第6行
		PdfPCell cell_11 = new PdfPCell(new Phrase("5．提供合格的机房高台爬梯及永久性护栏。", titleFont));
		PdfPCell cell_12 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_12.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_11.setBorderWidth(0);
		cell_12.setBorderWidth(0);
		table3.addCell(cell_11);
		table3.addCell(cell_12);
		// 第7行
		PdfPCell cell_13 = new PdfPCell(new Phrase("6. 五方通话调试工作", titleFont));
		PdfPCell cell_14 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_14.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_13.setBorderWidth(0);
		cell_14.setBorderWidth(0);
		table3.addCell(cell_13);
		table3.addCell(cell_14);
		// 第8行
		PdfPCell cell_15 = new PdfPCell(new Phrase("7．政府部门检验、验收费用", titleFont));
		PdfPCell cell_16 = new PdfPCell(new Phrase("  _____    _____", titleFont));
		cell_16.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell_15.setBorderWidth(0);
		cell_16.setBorderWidth(0);
		table3.addCell(cell_15);
		table3.addCell(cell_16);
		
		for (PdfPRow row : (ArrayList<PdfPRow>) table3.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(new Paragraph(nine, mintitle));
		doc.add(table3);
		
		String nine1 = "九、安装验收和支付 ";
		String nine2 = "  1、	电（扶）梯安装工程结束，由乙方单位质量部门根据相应标准验收合格后，书面通知甲方会同乙方共同验收。甲方在接到乙方递交的《电（扶）梯工程竣工移交通知单》后 7日内予以验收，在乙方的《安装验收报告》上签署是否合格意见；如甲方既未在前述7 日内提出工程确实存在不合格项目的有效证明，又拒绝在《电（扶）梯工程竣工移交通知单》上签署盖章，则乙方可视为甲方默认验收合格并已于前述7日期满之日在“电（扶）梯工程移交单”上签署盖章。";
		String nine3 = "  2、	设备需当地政府相关部门验收的，甲方应在乙方验收结束后三天内申报使用许可验收并承担相应费用。验收中存在的不合格项目，甲、乙双方根据合同中各自所承担的责任和义务分别予以整改合格。";
		String nine4 = "  3、	安装产品未经验收通过或未经乙方办理竣工移交手续之前，甲方不得自行使用该产品。否则甲方将承担因此引起的一切包括但不限于安全责任在内的法律后果 ";
		String nine5 = "  4、	乙方收到甲方付清了应付款项的有效凭证后办理移交手续，将产品、随机图册资料及相关证书报告交付给甲方。 ";
		doc.add(new Paragraph(nine1, mintitle));
		doc.add(new Paragraph(nine2, titleFont));
		doc.add(new Paragraph(nine3, titleFont));
		doc.add(new Paragraph(nine4, titleFont));
		doc.add(new Paragraph(nine5, titleFont));

		String ten = "十、执行标准 ";
		String ten_1 = "1、	本合同项下的电梯产品按GB7588-2003《电梯制造与安装安全规范》标准安装。 ";
		String ten_2 = "2、	本合同项下的家用电梯按照GB/T21739-2008《家用电梯制造与安装规范》，以及Q/320500DNDT002-2012 《家用电梯》标准安装。  ";
		String ten_3 = "3、	本合同项下的自动扶梯、自动人行道按GB16899-1997《自动扶梯和自动人行道的制造与安装安全规范》标准安装。  ";
		String ten_4 = "4、	本合同项下的液压梯按GB 21240-2007《液压梯制造与安装安全规范》标准安装。 " + "\n"
				+ "5、	本合同项下的杂物电梯按GB 25194-2010《杂物电梯制造与安装安全规范》标准安装。 ";
		String ten_5 = "6、	本合同项下的电梯按GB/T 10060-2011《电梯安装验收规范》安装验收。 " + "\n"
				+ "7、	本合同项下的电梯、自动扶梯、自动人行道，应按照TSG T7001-2009《电梯监督检验和定期检验规则》等，通过特种设备检验检测机构的监督检验后方能投入正式使用。";
		String ten_6 = "8、	产品使用之前，甲方应仔细阅读随机提供的《用户使用指南》以及国务院《特种设备安全法》，并遵照执行。 ";
		doc.add(new Paragraph(ten, mintitle));
		doc.add(new Paragraph(ten_1, titleFont));
		doc.add(new Paragraph(ten_2, titleFont));
		doc.add(new Paragraph(ten_3, titleFont));
		doc.add(new Paragraph(ten_4, titleFont));
		doc.add(new Paragraph(ten_5, titleFont));
		doc.add(new Paragraph(ten_6, titleFont));

		String eleven = "十一、质保期的服务";
		String eleven_1 = "1、	免费保修保养期：在甲方遵守货物的保管、使用、安装、保养、维修条件下，本合同设备的免费保修保养期为自设备安装完毕、政府验收合格之日起12个月或自乙方发运之日起18个月（以先到日期为准）。";
		String eleven_2 = "2、	在质量保证期内，如因乙方产品本身质量问题导致设备无法正常使用，乙方免费负责部件更换；因非乙方原因造成的设备损坏，由甲方承担责任和费用，乙方有偿提供所需更换部件及服务。";
		String eleven_3 = "3、	如甲方自行安排其他单位进行电（扶）梯安装、调试，乙方将不承担任何质量和安全责任，以及免费维修的责任及费用。";
		String eleven_4 = "4、	鉴于电（扶）梯设备所涉及的技术条件比较复杂，为确保运行质量，建议设备由乙方提供专业的维修保养服务。双方应及时签订《电梯设备保养合同》。签订后，乙方将提供完善的保养服务，并在保养期内提供优惠价格的配件。";
		doc.add(new Paragraph(eleven, mintitle));
		doc.add(new Paragraph(eleven_1, titleFont));
		doc.add(new Paragraph(eleven_2, titleFont));
		doc.add(new Paragraph(eleven_3, titleFont));
		doc.add(new Paragraph(eleven_4, titleFont));

		String twelve = "十二、保密条款 ";
		String twelve_1 = "甲方应对乙方提供给甲方的保密资料，负有保密义务，承担保密责任。甲方未经乙方书面同意不得向第三方公布，泄露或揭露任何保密资料或以其他方式使用保密资料。上述“保密资料”包括乙方的业务、雇员、客户、技术及科技方面的书面或其他形式的资料和信息（无论是否明确标明或注明是“保密资料”）。本保密条款下的义务及责任在本安装合同满期或终止后仍然有效。";
		doc.add(new Paragraph(twelve, mintitle));
		doc.add(new Paragraph(twelve_1, titleFont));

		String thirteen = "十三、价格调整 ";
		String thirteen_1 = "如果因为甲方原因造成实际安装日期距电梯到货日期超过12个月，或由于非乙方的原因造成安装停工期超过6个月则安装价格将作相应调整，并另行签署补充协议。";
		doc.add(new Paragraph(thirteen, mintitle));
		doc.add(new Paragraph(thirteen_1, titleFont));

		String fourteen = "十四、违约责任 ";
		String fourteen_1 = "1、	甲方未按约定支付安装工程款项，乙方有权顺延工期和/或调整合同金额，并且甲方应向乙方支付逾期付款的违约金，每日按逾期款项总金额的万分之三计算。 ";
		String fourteen_2 = "2、	甲方未按约定提供施工条件的，乙方有权顺延工期和/或调整合同金额：并且甲方每延迟一天应按合同总金额的万分之三（安装合同价格／工期）向乙方支付违约金，并承担乙方误工费（按每人每天100元计算）。若连续延误达七天，乙方有权撤回施工人员，甲方承担乙方的二次进场费以及来回的差旅费，期间的已安装/待安装的零部件由甲方保管。 ";
		String fourteen_3 = "3、	如任何一方未履行本合同项下的义务达三个月或以上的，另一方有权决定是否解除合同；如决定解除的，应书面通知对方，在这种情况下，合同应于通知发出之日解除，违约方应根据上文承担违约责任。";
		String fourteen_4 = "4、	如发生不可抗力事件按《中华人民共和国合同法》的有关规定处理。 ";
		doc.add(new Paragraph(fourteen, mintitle));
		doc.add(new Paragraph(fourteen_1, titleFont));
		doc.add(new Paragraph(fourteen_2, titleFont));
		doc.add(new Paragraph(fourteen_3, titleFont));
		doc.add(new Paragraph(fourteen_4, titleFont));

		String fifteen = "";
		String fifteen_1 = "1、	本合同签订时，需要对合同条款增加和更改的，双方应在“另行约定事项”中约定，经双方授权签署人签字并加盖公章后生效。";
		String fifteen_2 = "2、	本合同生效后，需要对原条款进行变更的，双方应另行签订“合同变更协议书”，经双方单位签字盖章后生效。";
		String fifteen_3 = "3、	以下文件及其他与本合同有关的协议均为本合同之附件，为本合同不可分割的组成部分，与本合同具有同等的法律效力。";
		String fifteen_4 = "a) ________________________ " + "\n" + "b) ________________________ ";
		String fifteen_5 = "4、	在安装过程中发生安全事故，由政府主管部门介入并作出事故鉴定结论，或在政府主管部门不介入时由双方共同委托有能力的第三方权威机构进行鉴定。双方的安全责任及法律责任根据鉴定结论而定。 ";
		String fifteen_6 = "5、	双方发生争议时，应先协商解决，协商不成，任何一方可依法向原告所在地的人民法院起诉。 " + "\n" + "6、	本合同正本一式肆份，双方各执贰份。";
		doc.add(new Paragraph(fifteen, mintitle));
		doc.add(new Paragraph(fifteen_1, titleFont));
		doc.add(new Paragraph(fifteen_2, titleFont));
		doc.add(new Paragraph(fifteen_3, titleFont));
		doc.add(new Paragraph(fifteen_4, titleFont));
		doc.add(new Paragraph(fifteen_5, titleFont));
		doc.add(new Paragraph(fifteen_6, titleFont));

		String sixteen = "十六、另行约定事项 ";
		doc.add(new Paragraph(sixteen, mintitle));

		doc.close();
	
		return JSONObject.fromObject(map);  
	}

	// 生成pdf文件（销售合同）
	@RequestMapping("/transformPDF3")
	@ResponseBody
	public Object transformPDf3() throws DocumentException, IOException {
		PageData pd = new PageData();
		pd = this.getPageData();
		String con_id = pd.getString("con_id");
		String item_id = pd.getString("item_id");

		PageData kehu = new PageData();// 存放客户信息的 pd
		PageData pdelev = new PageData(); // 电梯信息pd
		List<PageData> listelev = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = contractService.findContractById(pd);// 根据合同编号查询合同信息和项目信息

			PageData pdItem = new PageData();
			pdItem = contractService.findByItem_Id(pd);
			String type = pdItem.getString("customer_type"); // 客户类型
			String kehu_id = pdItem.getString("customer_id"); // 客户编号

			kehu.put("kehu_id", kehu_id); // 给pd客户的编号
			if (type.equals("Ordinary")) {
				kehu = contractService.findByOrdinary(kehu);
			} else if (type.equals("Merchant")) {
				kehu = contractService.findByMerchant(kehu);
			} else if (type.equals("Core")) {
				kehu = contractService.findByCore(kehu);
			}

			// 电梯信息
			pdelev.put("item_id", item_id);// 添加项目id
			listelev = contractService.findByElev(pdelev);
            
			map.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "failed");
		}

		Document doc = new Document();
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("C:\\itext5.pdf")); // 创建pdf文件
		BaseFont bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font title = new Font(bfTitle, 18, Font.BOLD);// 标题字体
		Font mintitle = new Font(bfTitle, 14, Font.NORMAL);// 小标题字体
		Font titleFont = new Font(bfTitle, 12, Font.NORMAL);// 内容字体

		String ban="DN/QR-HT-05（买断） 版次：01";  
		String con="设备销售合同 ";
		writer.setPageEvent(new HeadFootInfoPdfPageEvent(ban,con));//调用添加页眉页脚
		doc.open(); // 打开创建的pdf文件
		Paragraph titleP = new Paragraph("电（扶）梯设备销售合同\n\n", title);
		titleP.setAlignment(titleP.ALIGN_CENTER);
		doc.add(titleP);
		PdfPTable table = new PdfPTable(2); // 创建表格对象 2代表两列
		// table.setBorderWidth(1);//边框宽度
		PdfPCell cell = new PdfPCell();
		table.setWidthPercentage(100);
		table.setWidthPercentage(100);
		// 第0行
		PdfPCell cell1 = new PdfPCell(new Phrase("合同编号：" + pd.getString("con_id"), titleFont));
		PdfPCell cell2 = new PdfPCell(new Phrase("项目名称：" + pd.getString("item_name"), titleFont));
		table.addCell(cell1);
		table.addCell(cell2);
		// 第1行
		/*
		 * PdfPCell cell3 = new PdfPCell(new Phrase(" ")); PdfPCell cell4 = new
		 * PdfPCell(new Phrase(" ")); cell3.setBorderWidth(0);
		 * cell4.setBorderWidth(0); table.addCell(cell3); table.addCell(cell4);
		 */
		// 添加第2行
		PdfPCell cell5 = new PdfPCell(new Phrase("买方（甲方）", mintitle));
		PdfPCell cell6 = new PdfPCell(new Phrase("卖方（乙方）", mintitle));
		cell5.setHorizontalAlignment(1);// 文本居中
		cell6.setHorizontalAlignment(1);// 文本居中
		cell5.setBorderWidth(0);
		cell6.setBorderWidth(0);
		table.addCell(cell5);
		table.addCell(cell6);
		// 添加第3行
		PdfPCell cell7 = new PdfPCell(new Phrase("名称:" + kehu.getString("name"), titleFont));
		PdfPCell cell8 = new PdfPCell(new Phrase("名称:东南电梯股份有限公司", titleFont));
		cell7.setBorderWidth(0);
		cell8.setBorderWidth(0);
		table.addCell(cell7);
		table.addCell(cell8);
		// 添加第4行
		PdfPCell cell9 = new PdfPCell(new Phrase("地址: " + kehu.getString("address"), titleFont));
		PdfPCell cell10 = new PdfPCell(new Phrase("地址:江苏省吴江经济开发区交通北路6588号", titleFont));
		cell9.setBorderWidth(0);
		cell10.setBorderWidth(0);
		table.addCell(cell9);
		table.addCell(cell10);
		// 添加第5行
		PdfPCell cell11 = new PdfPCell(new Phrase("电话:" + kehu.getString("phone"), titleFont));
		PdfPCell cell12 = new PdfPCell(new Phrase("总机:0512-63038888", titleFont));
		cell11.setBorderWidth(0);
		cell12.setBorderWidth(0);
		table.addCell(cell11);
		table.addCell(cell12);
		// 添加第6行
		PdfPCell cell13 = new PdfPCell(new Phrase("传真:" + kehu.getString("fax"), titleFont));
		PdfPCell cell14 = new PdfPCell(new Phrase("传真:0512-63031582", titleFont));
		cell13.setBorderWidth(0);
		cell14.setBorderWidth(0);
		table.addCell(cell13);
		table.addCell(cell14);
		// 添加第7行
		PdfPCell cell15 = new PdfPCell(new Phrase("邮编:" + kehu.getString("postcode"), titleFont));
		PdfPCell cell16 = new PdfPCell(new Phrase("邮编:215200", titleFont));
		cell15.setBorderWidth(0);
		cell16.setBorderWidth(0);
		table.addCell(cell15);
		table.addCell(cell16);
		// 添加第8行
		PdfPCell cell17 = new PdfPCell(new Phrase("开户银行:" + kehu.getString("bank"), titleFont));
		PdfPCell cell18 = new PdfPCell(new Phrase("开户银行:中国建设银行吴江市支行", titleFont));
		cell17.setBorderWidth(0);
		cell18.setBorderWidth(0);
		table.addCell(cell17);
		table.addCell(cell18);
		// 添加第9行
		PdfPCell cell19 = new PdfPCell(new Phrase("银行帐号:" + kehu.getString("bank_no"), titleFont));
		PdfPCell cell20 = new PdfPCell(new Phrase("银行帐号:32201997636059000518", titleFont));
		cell19.setBorderWidth(0);
		cell20.setBorderWidth(0);
		table.addCell(cell19);
		table.addCell(cell20);
		// 添加第10行
		PdfPCell cell21 = new PdfPCell(new Phrase("税务登记号:" + kehu.getString("tax"), titleFont));
		PdfPCell cell22 = new PdfPCell(new Phrase("税务登记号:320584703659565", titleFont));
		cell21.setBorderWidth(0);
		cell22.setBorderWidth(0);
		table.addCell(cell21);
		table.addCell(cell22);
		// 添加第11行
		PdfPCell cell23 = new PdfPCell(new Phrase("联系人:" + kehu.getString("contact"), titleFont));
		PdfPCell cell24 = new PdfPCell(new Phrase("行号:", titleFont));
		cell23.setBorderWidth(0);
		cell24.setBorderWidth(0);
		table.addCell(cell23);
		table.addCell(cell24);
		// 添加第12行
		PdfPCell cell25 = new PdfPCell(new Phrase("联系方式:" + kehu.getString("contact_phone"), titleFont));
		PdfPCell cell26 = new PdfPCell(new Phrase("联系人:", titleFont));
		cell25.setBorderWidth(0);
		cell26.setBorderWidth(0);
		table.addCell(cell25);
		table.addCell(cell26);
		// 添加第13行
		PdfPCell cell27 = new PdfPCell(new Phrase(" ", titleFont));
		PdfPCell cell28 = new PdfPCell(new Phrase("联系方式:", titleFont));
		cell27.setBorderWidth(0);
		cell28.setBorderWidth(0);
		table.addCell(cell27);
		table.addCell(cell28);
		// 添加第14行
		PdfPCell cell29 = new PdfPCell(new Phrase(" ", titleFont));
		PdfPCell cell30 = new PdfPCell(new Phrase(" ", titleFont));
		cell29.setBorderWidth(0);
		cell30.setBorderWidth(0);
		table.addCell(cell29);
		table.addCell(cell30);
		// 添加第15行
		PdfPCell cell31 = new PdfPCell(new Phrase("甲方盖章:", titleFont));
		PdfPCell cell32 = new PdfPCell(new Phrase("乙方盖章:", titleFont));
		cell31.setBorderWidth(0);
		cell32.setBorderWidth(0);
		table.addCell(cell31);
		table.addCell(cell32);
		// 添加第16行
		PdfPCell cell33 = new PdfPCell(new Phrase("签字:______________", titleFont));
		PdfPCell cell34 = new PdfPCell(new Phrase("签字:______________", titleFont));
		cell33.setBorderWidth(0);
		cell34.setBorderWidth(0);
		table.addCell(cell33);
		table.addCell(cell34);
		// 添加第17行
		PdfPCell cell35 = new PdfPCell(new Phrase("_____年_____月_____日", titleFont));
		PdfPCell cell36 = new PdfPCell(new Phrase("_____年_____月_____日", titleFont));
		cell35.setBorderWidth(0);
		cell36.setBorderWidth(0);
		table.addCell(cell35);
		table.addCell(cell36);
		// 添加第18行
		/*
		 * PdfPCell cell37 = new PdfPCell(new Phrase(" ",titleFont)); PdfPCell
		 * cell38 = new PdfPCell(new Phrase(" ",titleFont));
		 * cell37.setBorderWidth(0); cell38.setBorderWidth(0);
		 * table.addCell(cell37); table.addCell(cell38);
		 */
		// 添加第19行
		PdfPCell cell39 = new PdfPCell(new Paragraph("合同设备最终用户及安装地点：", titleFont));
		cell39.setHorizontalAlignment(1);// 文本居中
		cell39.setColspan(2); // 跨列
		cell39.setBorderWidth(0);
		table.addCell(cell39);
		// 添加第20行
		PdfPCell cell40 = new PdfPCell(
				new Paragraph("最终用户/使用单位名称：____________________________________________________________", titleFont));
		cell40.setColspan(2);
		cell40.setBorderWidth(0);
		table.addCell(cell40);
		// 添加第21行
		PdfPCell cell41 = new PdfPCell(new Phrase("联系人：", titleFont));
		PdfPCell cell42 = new PdfPCell(new Phrase("联系电话：", titleFont));
		cell41.setBorderWidth(0);
		cell42.setBorderWidth(0);
		table.addCell(cell41);
		table.addCell(cell42);
		// 添加第22行
		PdfPCell cell43 = new PdfPCell(new Paragraph("安装地点：__________省__________市__________区/县", titleFont));
		cell43.setColspan(2);
		cell43.setBorderWidth(0);
		table.addCell(cell43);

		for (PdfPRow row : (ArrayList<PdfPRow>) table.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table);
		String one = "根据《中华人民共和国合同法》，经甲乙双方友好协商，一致同意签订本合同，并共同遵守。";
		String one_1 = "合同条款如下：";
		String one_3 = "第一条：合同货物描述、数量及价格（RMB，元）：" + "\n" + " ";
		doc.add(new Paragraph(one, titleFont));
		doc.add(new Paragraph(one_1, titleFont));
		doc.add(new Paragraph(one_3, mintitle));

		PdfPTable table2 = new PdfPTable(7); // 创建表格对象 2代表两列
		// PdfPCell cell2 = new PdfPCell ();
		table2.setWidthPercentage(100);
		table2.setWidthPercentage(100);

		// 第一行
		table2.addCell(new Paragraph("序号", titleFont));
		table2.addCell(new Paragraph("产品名称", titleFont));
		table2.addCell(new Paragraph("型号", titleFont));
		table2.addCell(new Paragraph("梯种", titleFont));
		table2.addCell(new Paragraph("数量", titleFont));
		table2.addCell(new Paragraph("单价", titleFont));
		table2.addCell(new Paragraph("小计", titleFont));

		int j = 1;
		for (int i = 0; i < listelev.size(); i++) {
			PageData pdel = listelev.get(i);
			table2.addCell(new Paragraph("" + j, titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("product_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("models_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("elevator_name"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("num"), titleFont));
			table2.addCell(new Paragraph("" + pdel.getString("total"), titleFont));
			table2.addCell(new Paragraph("" + pdel.get("xj"), titleFont));
			j++;
		}
		PdfPCell cell44 = new PdfPCell();
		cell2 = new PdfPCell(
				new Paragraph("合同设备总价（大写人民币）：                           (￥：               元)", titleFont));
		cell2.setColspan(7);
		table2.addCell(cell2);

		for (PdfPRow row : (ArrayList<PdfPRow>) table2.getRows()) {
			for (PdfPCell cells : row.getCells()) {
				if (cells != null) {
					cells.setPadding(10.0f);
				}
			}
		}
		doc.add(table2);
		String two = "第二条：付款方式：";
		String two_1 = "    2.1甲方根据交提货周期长短，按下述约定付款：";
		String two_2 = "     1）第一期款：在本合同签订之日起7天内，甲方应向乙方支付本合同设备总价款的 30 %，计人民币（大写）：____________________元整（其中合同设备总价的20%作为合同定金）。若合同履行，则定金抵作本合同的货款。甲方逾期给付的，则合同的交货期予以顺延。";
		String two_3 = "     2）第二期款：甲方须在提货前 天之前，向乙方支付合同设备总价的 %，计人民币（大写）：____________________元整作为投产款。甲方逾期给付的，则合同的预定交货期予以顺延。"
				+ "\n"
				+ "     3）第三期款：在满足工厂生产周期的前提下，甲方须在约定的交货日期前15天之前，向乙方支付设备提货款，合同设备总价的 %，计人民币（大写）：____________________元整。乙方收到此款项后，根据本合同约定的交货周期安排发运。甲方逾期给付的，则合同的交货周期予以顺延。";
		String two_4 = "    2.2付款时注意事项：" + "\n" + "    支付定金和货款时，须注明付款单位名称；" + "\n"
				+ "    付款后，及时将支付凭证复印件传真给乙方授权代表人，以便及时确认；";
		String two_5 = "    2.3发票开具事项：" + "\n" + "    买断&出口项目：按出货后7天内开具；";
		doc.add(new Paragraph(two, mintitle));
		doc.add(new Paragraph(two_1, titleFont));
		doc.add(new Paragraph(two_2, titleFont));
		doc.add(new Paragraph(two_3, titleFont));
		doc.add(new Paragraph(two_4, titleFont));
		doc.add(new Paragraph(two_5, titleFont));

		String three = "第三条：货物的交付：";
		String three_1 = "    3.1本合同设备预定交货期应为本合同签订、乙方收到甲方投产款以及技术确认、《土建布置图》及合同技术规格表等技术资料由客户签字盖章确认起____天。如未能满足前述条件，交货期顺延或另议。"
				+ "\n" + "    交货期如有变动，一方应提前书面通知，并经另一书面认可。甲方要求推迟交货时间/暂停供货的，应经乙方书面认可，由此产生的仓储费自约定交货时间起算。期间如有法定节假日，交货期顺延。";
		String three_2 = "    3.2设备的具体发货日期详见《发货确认函》确认。" + "\n" + "    3.3交货地点： 乙方工厂。" + "\n" + "    3.4交货方式：" + "\n"
				+ "    1）甲方自提：";
		String three_3 = "    甲方应按本合同约定，在付清全部应付设备款项后，提货人携带甲方自提委托书和本人身份证等有效证明，在本合同约定的交货期内前往乙方工厂提取合同设备。" + "\n"
				+ "  2）乙方代办运输：" + "\n" + "  甲方应明确以下收货信息，如收货信息错误导致乙方错发，乙方不承担相关责任。";
		String three_4 = "    收货单位：________________________________________ " + "\n"
				+ "    到(站)港：________________________________________" + "\n"
				+ "    接货地址：________________________________________" + "\n"
				+ "    邮编：________联系人：_______电话：________传真：________ ";
		String three_5 = "    3.5乙方应按照本合同约定的运输方式、收货单位发运合同设备。如甲方收货地址变更为不同省/市区域，因涉及服务便利性及区域差异，需由乙方对合同信息进行重新确认，产生的相关费用由甲方承担（如有）。如前述信息变更，甲方应在发运前7天及时书面通知乙方，否则乙方将按照本合同约定发运。 "
				+ "\n" + "    3.6如果甲方与乙方安装公司或乙方子公司就本项目签订的安装合同内约定安装款项须在合同设备发运前支付的，则合同设备将在乙方安装公司或乙方子公司收到该款项后才能发运。";
		doc.add(new Paragraph(three, mintitle));
		doc.add(new Paragraph(three_1, titleFont));
		doc.add(new Paragraph(three_2, titleFont));
		doc.add(new Paragraph(three_3, titleFont));
		doc.add(new Paragraph(three_4, titleFont));
		doc.add(new Paragraph(three_5, titleFont));

		String four = "第四条：货物的交付查验和保管：";
		String four_1 = "    4.1乙方可根据特殊情况，在征得甲方同意的条件下，将合同设备分批发运，以配合合同设备的安装和保证交付使用的时间。如因甲方原因分批发运的，对所发生的额外运输费及包装费，甲方应在合同设备发运前向乙方一次性结清。";
		String four_2 = "    4.2收货查验：" + "\n"
				+ "    甲方收到货物当日，应对货物箱数进行清点，并会同承运人对包装箱的完好或损坏状态进行确认，若发现包装箱缺少或损坏，应即时记录缺损情况，包括现场照片等资料，并要求运输部门出具有效证明，并在电梯设备到货之日起5日内以书面联系乙方，并协助乙方办理保险索赔事宜。否则乙方视为与甲方清点无误。";
		String four_3 = "    4.3保管：" + "\n" + "    甲方应提供具备防淋、防潮、防盗、防强光等存放货物所需的封闭空间，并对货物进行妥善保管，防止任何损蚀、损失和损害。";
		String four_4 = "    4.4 安装前查验：" + "\n"
				+ "    在包装箱完好无损的情况下，箱内货物有缺损由乙方负责补足、修理或更换；如未经乙方许可，甲方擅自开箱的，或者开箱前包装箱已经损坏，箱内货物有缺损的，包装箱数量与根据合同4.2条款约定清点的数量不一致的，乙方不承担责任。";
		doc.add(new Paragraph(four, mintitle));
		doc.add(new Paragraph(four_1, titleFont));
		doc.add(new Paragraph(four_2, titleFont));
		doc.add(new Paragraph(four_3, titleFont));
		doc.add(new Paragraph(four_4, titleFont));

		String five = "第五条：执行标准： 本公司产品执行标准：";
		String five_1 = "    5.1	GB 7588-2003 《电梯制造与安装安全规范》" + "\n" + "    5.2	GB 21240-2007 《液压电梯制造与安装安全规范》"
				+ "\n" + "    5.3	GB 16899-2011 《自动扶梯和自动人行道的制造与安装安全规范》";
		doc.add(new Paragraph(five, mintitle));
		doc.add(new Paragraph(five_1, titleFont));

		String six = "第六条：承诺和保证：";
		String six_1 = "    6.1乙方保证其出售的货物完全符合本合同的约定，并保证其所提供的货物是全新的，且有权出售。 ";
		String six_2 = "    6.2根据国务院（2003）第373号令《特种设备安全监察条例》的有关规定，电梯、扶梯、人行道等设备的安装必须由电梯制造单位或者其通过合同委托、同意的且依照本条例取得许可的单位进行。在签订本合同的同时，甲乙双方应签订本合同电（扶）梯设备的安装合同。若甲方不与乙方签订安装合同，或虽签约但后又违约自行安排乙方以外的其他方进行合同电（扶）梯设备的安装、调试、维护工作的，乙方只承担与本合同电（扶）梯设备原设计、制造相关的直接质量责任，除此以外其它任何质量和安全责任均由甲方承担，乙方将不承担免费保修保养责任。";
		doc.add(new Paragraph(six, mintitle));
		doc.add(new Paragraph(six_1, titleFont));
		doc.add(new Paragraph(six_2, titleFont));

		String seven = "第七条：违约责任： ";
		String seven_1 = "    7.1本合同生效后，如因乙方原因全部或部分解除合同，须向甲方双倍返还定金，同时须赔偿甲方直接经济损失；如因甲方原因全部或部分解除合同，乙方不退还定金，甲方同时须赔偿乙方直接经济损失。 ";
		String seven_2 = "    7.2如甲方未按期支付定金或货款，乙方可以顺延交付日期和/或调整合同总价，同时甲方每天应按延迟交付合同设备总金额的万分之三向乙方支付违约金（但违约金累积最高不超过合同总价的3%）；如甲方未按期支付定金或任何一期货款达三个月或以上的，乙方有权决定是否解除合同；如决定解除的，乙方应向甲方发出书面通知，本合同应视为因甲方原因于通知发出之日被解除，甲方应同时按上款规定承担违约责任。 ";
		String seven_3 = "    7.3乙方在合同交货期到期后一周内免费提供仓储；如甲方迟延付款超过一周，造成乙方无法交付货物的，甲方须向乙方支付仓储费（按电梯每台每天100元计算），并且在甲方付清到期货款和仓储费前将暂不交付货物。甲方其他原因（如甲方要求推迟交货时间并经乙方同意）造成乙方无法如期交付货物的，甲方亦应支付延期交货所产生的仓储费。如甲方推迟交货时间不确定的，应及时予以确定，如经乙方催告后仍不确定的，则乙方可按甲方原因解除合同处理，也可以要求甲方继续履行合同。";
		String seven_4 = "    7.4如乙方因自身单方面原因延期交货，应按延期天数向甲方支付每天合同总价万分之三的违约金（但违约金累积最高不超过合同总价的3%）；如乙方无理由延期交货达三个月的，除继续支付上述违约金外，甲方还有权决定是否解除合同；如决定解除的，甲方应向乙方发出书面通知，本合同应视为因乙方原因于通知发出之日被解除，乙方应同时按7.1条规定承担违约责任。 ";
		String seven_5 = "    7.5不可抗力事件应根据《中华人民共和国合同法》的要求进行处理。" + "\n" + "    7.6在甲方付清本合同款项之前，本合同电（扶）梯设备的所有权属乙方所有";
		doc.add(new Paragraph(seven, mintitle));
		doc.add(new Paragraph(seven_1, titleFont));
		doc.add(new Paragraph(seven_2, titleFont));
		doc.add(new Paragraph(seven_3, titleFont));
		doc.add(new Paragraph(seven_4, titleFont));
		doc.add(new Paragraph(seven_5, titleFont));

		String eight = "第八条：争议的解决：";
		String eight_1 = "    因执行本合同而引起的一切争议，由双方通过友好协商解决；协商不成时合同任一方均可向原告所在地法院提起诉讼。";
		doc.add(new Paragraph(eight, mintitle));
		doc.add(new Paragraph(eight_1, titleFont));

		String nine = "第九条：其他： ";
		String nine_1 = "    9.1 本合同自双方签署且甲方支付合同约定的定金后生效。" + "\n"
				+ "    9.2本合同所有条款均为打印文字。本合同文本不得随意涂改；若需修改，须经甲、乙双方协商达成一致意见，并经双方签字盖章确认后视为有效。";
		String nine_2 = "    9.3本合同附件（《土建布置图》、《电梯合同技术规格表》，或《自动扶梯合同技术规格表》及《自动人行道合同技术规格表》等），为本合同不可分割的组成部分，与本合同具有同等的法律效力，双方签字盖章后视为有效。如果因甲方设计、土建结构变更，则《土建布置图》（井道及机房布置图）须经双方盖章确认后有效，时间以双方确认的最后一份为准。在甲乙双方确认《土建布置图》（井道及机房布置图）及《合同设备技术规格表》、合同生效后，甲方设计、土建结构发生变更，则甲方需承担因变更而产生的相关费用。";
		String nine_3 = "    9.4在本合同签定后，合同中如有未尽事宜或合同履行过程中有相关内容需加以补充或变更，双方需签署书面补充合同或变更合同。";
		String nine_4 = "    9.5本合同设备涉及的乙方知识产权，未经乙方许可，甲方不得为生产经营目的制造、使用、许诺销售、销售、进口其知识产权产品，或者使用其知识产权方法。";
		String nine_5 = "    9.6合同未涉及的违约事宜等条款，应按照《中华人民共和国合同法》相关规定处理。" + "\n" + "    9.7本合同壹式肆份，甲乙双方各执贰份，具有同等法律效力。";
		doc.add(new Paragraph(nine, mintitle));
		doc.add(new Paragraph(nine_1, titleFont));
		doc.add(new Paragraph(nine_2, titleFont));
		doc.add(new Paragraph(nine_3, titleFont));
		doc.add(new Paragraph(nine_4, titleFont));
		doc.add(new Paragraph(nine_5, titleFont));

		Paragraph titleM = new Paragraph("设备调试细则\n\n", title);
		titleM.setAlignment(titleM.ALIGN_CENTER);
		doc.add(titleM);
		String Aone = "一、调试施工期";
		String Aone_1 = " 1、符合乙方内部调试、厂检要求和条件，按平均1台 / 三个工作日执行。";
		doc.add(new Paragraph(Aone, mintitle));
		doc.add(new Paragraph(Aone_1, titleFont));

		String Atow = "二、电梯调试相关的工作责任";
		String Atow_1 = " 1、甲方责任";
		String Atow_1_1 = " 1.1.甲方必须严格按照乙方的安装工艺、安装过程质量控制程序和现场安全程序完成安装及调试配合工作";
		String Atow_1_2 = " 1.2.	负责乙方调试期间与其它工程单位交叉作业时的协调工作。";
		String Atow_1_3 = " 1.3.	负责调试完工后土建部分的回填和装修工作。";
		String Atow_1_4 = " 1.4.	负责调试施工期间所需的水、电消耗。";
		String Atow_1_5 = " 1.5.	严格按乙方内部的调试前的要求具备调试条件，调试前双方进行检查，如果乙方认为检查结果满足要求，乙方才开始进行调试，否则调试员可以拒绝调试，并承担调试员的差旅费用、所耗费的人工费和相关的乙方财务管理费用。";
		String Atow_1_6 = " 1.6.	按照乙方现场调试规范及安全标准,要求甲方提供充足的调试配合人员配合乙方调试电梯设备，并达到乙方相关标准。";
		String Atow_1_7 = " 1.7.	甲方在工地管理的责任";
		String Atow_1_7_1 = "    1.7.1.人员配备要充足和固定。" + "\n" + "    1.7.2.施工计划要详细周密，并随时更新。" + "\n"
				+ "    1.7.3.施工前的准备工作要细致，特别是库房的准备和施工现场的查验。" + "\n" + "    1.7.4.	起吊工具的检验及工具和库房的专人管理。" + "\n"
				+ "    1.7.5.	开箱验件要仔细，并在开箱验货的2日内办妥相关缺失件的确认，并妥善保管配件。";
		String Atow_1_7_2 = "    1.7.6.专职安全员和质检员的配备, 并按乙方的安全和质量程序和要求严格执行，并承担相应的义务和责任。" + "\n"
				+ "    1.7.7.专职项目经理与客户的沟通要密切，防止误工的发生。";
		String Atow_1_8 = "1.8.对甲方在安装质量和安全的要求。";
		String Atow_1_8_1 = "    1.8.1.每道工序必须有专职检验员的签字认可。" + "\n" + "    1.8.2.每道工序前的风险评估必须由专职安全员的签字认可。" + "\n"
				+ "    1.8.3.申报调试前必须有专职质检员和项目经理的书面通知乙方。" + "\n" + "    1.8.4.要认真做好成品保护。" + "\n"
				+ "    1.8.5.对已经调试好的电梯要负全面的看护责任，若产生额外的再调试工作，甲方应承担乙方为此产生的相应差旅、工时和相关的财务管理费用。";
		String Atow1_9 = "1.9.甲方根据乙方厂检结果在一周时间内完成整改工作，如涉及需要二次检验，所产生的费用另行收取";
		doc.add(new Paragraph(Atow, mintitle));
		doc.add(new Paragraph(Atow_1, titleFont));
		doc.add(new Paragraph(Atow_1_1, titleFont));
		doc.add(new Paragraph(Atow_1_2, titleFont));
		doc.add(new Paragraph(Atow_1_3, titleFont));
		doc.add(new Paragraph(Atow_1_4, titleFont));
		doc.add(new Paragraph(Atow_1_5, titleFont));
		doc.add(new Paragraph(Atow_1_6, titleFont));
		doc.add(new Paragraph(Atow_1_7, titleFont));
		doc.add(new Paragraph(Atow_1_7_1, titleFont));
		doc.add(new Paragraph(Atow_1_7_2, titleFont));
		doc.add(new Paragraph(Atow_1_8, titleFont));
		doc.add(new Paragraph(Atow_1_8_1, titleFont));
		doc.add(new Paragraph(Atow1_9, titleFont));

		String Atwo2 = "2、乙方责任";
		String Atow2_1 = "2.1  调试、厂检过程中发现产品质量问题按乙方内部标准执行。根据到货箱单清点，所有设备缺错件必须在到货开箱后2天内及安装过程发生的错件不超过发运后的12个月经乙方检查确认后有效，否则甲方承担该问题产生的一切费用，包括事后甲方单方面提出的所有缺错件。";
		String Atow2_2 = "2.2  按照国家电梯安装规范和东南电梯的质量标准(按乙方安装部颁布的相关程序和标准执行，包含调试手册的要求)完成设备调试工作，并承担相应的责任。同时将安装部颁布的相关程序和标准，包含调试手册作为合同附件，以便双方作为履行依据。";
		String Atow2_3 = "2.3	遵守施工现场的有关规章制度。" + "\n" + "2.4  负责为乙方现场调试人员购买劳动保险和人身保险";

		String Atow3 = "3、	责任";
		String Atow3_1 = "    双方在此一致确认，甲方全权对电梯的安装质量及安装相关问题承担全部责任。乙方的责任仅限于按合同规定完成调试。乙方仅对调试错误而直接导致的问题承担相应责任，除此以外，乙方不承担任何责任。";
		doc.add(new Paragraph(Atwo2, titleFont));
		doc.add(new Paragraph(Atow2_1, titleFont));
		doc.add(new Paragraph(Atow2_2, titleFont));
		doc.add(new Paragraph(Atow2_3, titleFont));
		doc.add(new Paragraph(Atow3, titleFont));
		doc.add(new Paragraph(Atow3_1, titleFont));

		String Athree = "三、验收和移交";
		String Athree_1 = "1、	电梯安装、调试工作完成后，乙方根据国家电梯安装验收规范和东南电梯质量标准进行调试工作的检查。";
		String Athree_2 = "2、	在电梯调试完工后，甲方应向当地技术监督局提出验收申请并承担相关的费用。如因甲方原因达不到技术监督局规定的验收标准，或需延期申报验收时，甲方须向乙方支付相应的误工费用，具体费用见七条。";
		String Athree_3 = "3、	电梯经技术监督局验收，一旦合格，或者因甲方原因未达到验收标准，都应视为调试合同完成";
		doc.add(new Paragraph(Athree, mintitle));
		doc.add(new Paragraph(Athree_1, titleFont));
		doc.add(new Paragraph(Athree_2, titleFont));
		doc.add(new Paragraph(Athree_3, titleFont));

		String Afour = "四、其他事项";
		String Afour_1 = "1、	安装结束后进入调试工作，电梯及井道根据安装自检报告和调试员检查报告进行交接，双方的安全责任和义务按照国家有关标准和程序进行界定。";
		String Afour_2 = "2、	甲方在此确认，甲方已经了解并且认真研究了乙方内部的安装工艺、安装过程质量控制程序和现场安全程序等安装相关各项程序、标准和要求，并对这些要求的具体内容达到透彻和充分的理解，并确保能够满足和达到这些要求，确保电梯安装质量。甲方若发生违反《特种设备安全法》等法规的有关规定的行为，甲方自行承担因此所引发的全部责任和法律后果，如因此导致乙方承担责任或产生损失的，甲方自愿承担乙方须承担的包括民事责任、行政处罚责任在内的全部责任，并自愿赔偿乙方因此而产生的所有损失及相应费用，使乙方免于承担任何责任及免受任何损失。";
		String Afour_3 = "  （以下无正文）";
		doc.add(new Paragraph(Afour, mintitle));
		doc.add(new Paragraph(Afour_1, titleFont));
		doc.add(new Paragraph(Afour_2, titleFont));
		doc.add(new Paragraph(Afour_3, titleFont));

		doc.close();

		return JSONObject.fromObject(map);
	}

	/* ===============================用户================================== */
	public User getUser() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (User) session.getAttribute(Const.SESSION_USER);
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
}
