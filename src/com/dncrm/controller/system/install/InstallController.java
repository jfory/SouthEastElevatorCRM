package com.dncrm.controller.system.install;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.activiti.engine.IdentityService;
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
import com.dncrm.service.system.install.InstallService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.sysAgent.SysAgentService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;


/**
 *创建人:arisu
 *创建时间:2016/11/30
 *类名:InstallController
 *描述:安装管理 
 */
@RequestMapping("/install")
@Controller
public class InstallController extends BaseController {
	
	@Resource(name="installService")
	private InstallService installService;
	@Resource(name="itemService")
	private ItemService itemService;
	@Resource(name="sysAgentService")
	private SysAgentService sysAgentService;
	
	/**
	 *列表 
	 */
	@RequestMapping(value="installList")
	public ModelAndView installList(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> installList = installService.findInstallList(page);
			mv.addObject("installList", installList);
			mv.setViewName("system/install/install_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *跳转新增 
	 */
	@RequestMapping(value="goAddInstall")
	public ModelAndView goAddInstall(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> itemList = itemService.findItemList();
			List<PageData> agentList = sysAgentService.findAgentListWithInstall();
			mv.addObject("itemList", itemList);
			mv.addObject("agentList", agentList);
			mv.addObject("operateType", "add");
			mv.addObject("msg", "saveInstall");
			mv.setViewName("system/install/install_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *保存新增 
	 */
	@RequestMapping(value="saveInstall")
	public ModelAndView saveInstall(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("status", "1");//信息采集
			installService.saveInstall(pd);
			mv.addObject("msg", "success");
			mv.addObject("id", "EditInstall");
			mv.addObject("form", "InstallForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *跳转修改 
	 */
	@RequestMapping(value="goEditInstall")
	public ModelAndView goEditInstall(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd = installService.findInstallById(pd);
			List<PageData> itemList = itemService.findItemList();
			List<PageData> agentList = sysAgentService.findAgentListWithInstall();
			mv.addObject("itemList", itemList);
			mv.addObject("agentList", agentList);
			mv.addObject("pd", pd);
			mv.addObject("operateType", "edit");
			mv.addObject("msg", "editInstall");
			mv.setViewName("system/install/install_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *删除 
	 */
	@RequestMapping(value="delInstall")
	@ResponseBody
	public Object delInstall(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			installService.deleteInstall(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *保存修改 
	 */
	@RequestMapping(value="editInstall")
	public ModelAndView editInstall(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("msg", "success");
			mv.addObject("id", "EditInstall");
			mv.addObject("form", "InstallForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *列表待收货信息 
	 */
	@RequestMapping(value="shipmentsList")
	public ModelAndView shipmentsList(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			/*List<PageData> consigneeList = installService.findConsigneeList(item_id);*/
			List<PageData> shipmentsList = installService.findShipmentsList(item_id);
			mv.addObject("item_id", item_id);
			mv.addObject("active", "1");
			mv.addObject("shipmentsList", shipmentsList);
			mv.setViewName("system/install/receive_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *列表已收货信息 
	 */
	@RequestMapping(value="receiveList")
	public ModelAndView receiveList(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			List<PageData> receiveList = installService.findReceiveList(item_id);
			mv.addObject("item_id", item_id);
			mv.addObject("active", "2");
			mv.addObject("receiveList", receiveList);
			mv.setViewName("system/install/receive_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *列表箱子 
	 */
	@RequestMapping(value="unboxList")
	public ModelAndView unboxList(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String receive_id = pd.get("receive_id").toString();
			List<PageData> encasementList = installService.findEncasementListByReceive(receive_id);
			mv.addObject("receive_id", receive_id);
			mv.addObject("encasementList", encasementList);
			mv.setViewName("system/install/unbox_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *收货
	 */
	@RequestMapping(value="shipments")
	@ResponseBody
	public Object shipments(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("state", "2");
			//更新发货状态
			installService.updateShipmentsState(pd);
			//向接货表增加记录
			String shipmentsId = pd.get("shipments_id").toString();
			PageData receivePd = new PageData();
			receivePd.put("item_id", pd.get("item_id").toString());
			receivePd.put("shipments_id", shipmentsId);
			receivePd.put("send_user", "");
			receivePd.put("recv_user", getUser().getUSER_ID());
			receivePd.put("status", "");
			receivePd.put("descript", "");
			installService.saveReceive(receivePd);
			//关联箱子和收货id
			String receiveId = receivePd.get("id").toString();
			PageData updatePd = new PageData();
			updatePd.put("shipments_id", shipmentsId);
			updatePd.put("receive_id", receiveId);
			installService.updateEncasementReceive(updatePd);
			
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *查看收货信息 
	 */
	@RequestMapping(value="selReceive")
	public ModelAndView selReceive(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String shipments_id = pd.get("shipments_id").toString();
			List<PageData> encasementList = installService.findEncasementListByShipments(shipments_id);
			mv.addObject("shipments_id", shipments_id);
			mv.addObject("encasementList", encasementList);
			mv.setViewName("system/install/unbox_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *开箱确认 
	 */
	@RequestMapping(value="unboxInfo")
	public ModelAndView unboxInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String encasement_id = pd.get("encasement_id").toString();
			pd = installService.findEncasement(encasement_id);
			mv.addObject("pd", pd);
			mv.setViewName("system/install/unbox_info");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *开箱报告,生成清单 
	 */
	@RequestMapping(value="saveUnboxInfo")
	public ModelAndView saveUnboxInfo(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String is_defect = pd.get("is_defect").toString();
			pd.put("recv_id", pd.get("receive_id").toString());
			pd.put("unbox_user", getUser().getUSER_ID());
			pd.put("remark", "");
			if(is_defect.equals("1")){//有缺损
				pd.put("status", "0");//新增开箱报告
			}else if(is_defect.equals("0")){//无缺损
				pd.put("status", "2");//开箱报告完成
			}
			installService.saveUnbox(pd);
			mv.addObject("msg", "success");
			mv.addObject("id", "UnboxInfo");
			mv.addObject("form", "UnboxForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
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
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"Install/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "Install/" + ffile + "/" + fileName);
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
    
    //补件处理部分
    
    /**
     *列表补件申请 
     */
    @RequestMapping(value="supplement")
    public ModelAndView supplement(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		String USER_ID = getUser().getUSER_ID();
    		List<PageData> supplementList = installService.findSupplementList(USER_ID);
    		mv.addObject("supplementList", supplementList);
    		mv.setViewName("system/install/supplement");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *跳转到新增补件申请 
     */
    @RequestMapping(value="goAddSupplement")
    public ModelAndView goAddSupplement(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		PageData pd = new PageData();
    		pd.put("is_defect", "1");
    		pd.put("status", "0");
    		pd.put("USER_ID", getUser().getUSER_ID());
    		List<PageData> unboxList = installService.findUnboxSupplement(pd);
    		mv.addObject("unboxList", unboxList);
    		mv.addObject("msg", "saveSupplement");
    		mv.setViewName("system/install/supplement_edit");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *保存新增补件申请 
     */
    @RequestMapping(value="saveSupplement")
    public ModelAndView saveSupplement(){
    	ModelAndView mv = new ModelAndView();
    	try{
    		PageData pd = new PageData();
    		pd = this.getPageData();
    		String USER_ID = getUser().getUSER_ID();
    		pd.put("status", "0");
    		pd.put("instance", "");
    		pd.put("USER_ID", USER_ID);
    		installService.saveSupplement(pd);
    		
    		String unbox_id = pd.get("unbox_id").toString();
    		PageData updPd = new PageData();
    		updPd.put("status", "1");
    		if(unbox_id.lastIndexOf(",")>-1){
    			for(String unboxId : unbox_id.split(",")){
    	    		updPd.put("id", unboxId);
    	    		installService.updateUnboxStatus(updPd);
    			}
    		}else{
	    		updPd.put("id", unbox_id);
	    		installService.updateUnboxStatus(updPd);
    		}
    		
    		mv.addObject("id", "EditSupplement");
    		mv.addObject("form", "SupplementForm1");
    		mv.addObject("msg", "success");
    		mv.setViewName("save_result");
    	}catch(Exception e){
    		mv.addObject("msg", "faild");
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *提交申请 
     */
    @RequestMapping(value="startApply")
    @ResponseBody
    public Object startApply(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		PageData pd = new PageData();
    		pd = this.getPageData();
    		String id = pd.get("id").toString();
    		String USER_ID = getUser().getUSER_ID();
    		String unbox_id = pd.get("unbox_id").toString();
    		String factoryType  = getFactoryTypeByBoxId(unbox_id);
    		if(factoryType!=null){
    			WorkFlow workFlow = new WorkFlow();
    			ProcessInstance proessInstance=null; 
    			String processDefinitionKey = "supplement";
        		IdentityService identityService = workFlow.getIdentityService();
        		identityService.setAuthenticatedUserId(USER_ID);
        		String businessKey = "tb_supplement.id."+id;
        		//设置变量
        		Map<String,Object> variables = new HashMap<String,Object>();
            	variables.put("action", "提交申请");
        		variables.put("user_id", USER_ID);
        		if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
        			proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
        		}
        		if(proessInstance!=null){
        			Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(proessInstance.getId()).singleResult();
        			//设置任务角色
                	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                	//签收任务
                	workFlow.getTaskService().claim(task.getId(), USER_ID);
                	//设置流程变量
                	variables.put("action", "提交申请");
                	workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
                	workFlow.getTaskService().complete(task.getId(),variables);
        			pd.put("instance_id", proessInstance.getId());
        			pd.put("status", "1");
        			installService.updateSupplementInstance(pd);
            		map.put("msg", "success");
        		}
    		}
    	}catch(Exception e){
    		map.put("msg", "faild");
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /**
     *列表待处理
     */
    @RequestMapping(value="listSupplementPend")
    public ModelAndView listSupplementPend(Page page){
    	ModelAndView mv = new ModelAndView();
    	try{

			List<PageData> supplements = new ArrayList<PageData>();
    		String USER_ID = getUser().getUSER_ID();
    		WorkFlow workFlow = new WorkFlow();
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
            List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("supplement").orderByTaskCreateTime().desc().active().list();
            List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("supplement").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
            for (Task task : toHandleList) {
                PageData supplement = new PageData();
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                    String[] info = businessKey.split("\\.");
                    supplement.put(info[1],info[2]);
                    supplement = installService.findSupplementById(supplement);
                    supplement.put("task_name",task.getName());
                    supplement.put("task_id",task.getId());
                    if(task.getAssignee()!=null){
                    	supplement.put("type","1");//待处理
                    }else{
                    	supplement.put("type","0");//待签收
                    }
                }
                supplements.add(supplement);
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
            page.setCurrentResult(supplements.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            //待处理任务的count
            PageData pd = new PageData();
            pd.put("count",toHandleListCount.size());
            mv.addObject("pd", pd);
    		mv.addObject("active", "2");
    		mv.addObject("supplements", supplements);
    		mv.setViewName("system/install/supplement");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
	 *签收任务 
	 */
	@RequestMapping(value="claim")
	@ResponseBody
	public Object claim(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			WorkFlow workFlow = new WorkFlow();
			pd = this.getPageData();
			String USER_ID = getUser().getUSER_ID();
			String task_id = pd.get("task_id").toString();
            workFlow.getTaskService().claim(task_id,USER_ID);
            map.put("msg", "success");
		}catch(Exception e){
            map.put("msg", "faild");
            map.put("err", "签收失败");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转办理意见页面 
	 */
	@RequestMapping(value="goHandleTask")
	public ModelAndView goHandleTask(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("pd", pd);
			mv.setViewName("system/install/supplement_handle");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存办理意见 
	 */
	@RequestMapping(value="handleTask")
	public ModelAndView handelTask(){
		ModelAndView mv = new ModelAndView();
		try{
			WorkFlow workFlow = new WorkFlow();
            Map<String,Object> variables = new HashMap<String ,Object>();
			PageData pd = new PageData();
			PageData updatePd = new PageData();
			pd = this.getPageData();
			String USER_ID = getUser().getUSER_ID();
			String id = pd.get("id").toString();
			String task_id = pd.get("task_id").toString();
			String action = pd.get("action").toString();
			String comment = pd.get("comment").toString();
			if("pass".equals(action)){//批准
				variables.put("factoryTaskStatus", true);
				
				//更新开箱报告状态为2 -完成
				updatePd.put("id", id);
				updatePd.put("status", "2");
				installService.updateUnboxStatusBySupplement(updatePd);
				
			}else if("reject".equals(action)){//驳回
				variables.put("factoryTaskStatus", false);
				
				//更新开箱报告状态为0 -新增
				updatePd.put("id", id);
				updatePd.put("status", "0");
				installService.updateUnboxStatusBySupplement(updatePd);
			}
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(USER_ID);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
			
			mv.addObject("msg", "success");
			mv.addObject("id", "HandleTask");
			mv.addObject("form", "SupplementForm2");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
    
    /**
     *根据箱子编号获取对应的工厂 
     */
    public String getFactoryTypeByBoxId(String unbox_id){
    	String factoryType = "";
    	try{
    		factoryType = installService.findFactoryTypeByBoxId(unbox_id);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return factoryType;
    }
    
    
    /**
	 *列表可以进行安装的信息
	 */
	@RequestMapping(value="installElevatorList")
	public ModelAndView installElevatorList(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			List<PageData> installList = installService.findInstallElevator(item_id);
			mv.addObject("item_id", item_id);
			mv.addObject("active", "1");
			mv.addObject("installList", installList);
			mv.setViewName("system/install/install");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *列表该项目已安装信息 
	 */
	@RequestMapping(value="installedElevatorList")
	public ModelAndView installedElevatorList(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			List<PageData> installedList = installService.findInstallDetailsByItemId(item_id);
			mv.addObject("item_id", item_id);
			mv.addObject("active", "2");
			mv.addObject("installedList", installedList);
			mv.setViewName("system/install/install");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
    
	/**
	 *录入自检信息 
	 */
	@RequestMapping(value="selfcheckReport")
	public ModelAndView selfcheckReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String id = pd.get("id").toString();
			String models_id = pd.get("models_id").toString();
			String checkJson = installService.findCheckJsonByModelsId(models_id);
			checkJson = checkJson.replace("\"", "'");
			mv.addObject("details_id", id);
			mv.addObject("checkJson", checkJson);
			mv.setViewName("system/install/selfcheck_report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
    
	
	/**
	 *保存自检报告 
	 */
	@RequestMapping(value="saveSelfCheck")
	public ModelAndView saveSelfCheck(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData updatePd = new PageData();
			PageData pd = new PageData();
			pd = this.getPageData();
			String USER_ID  = getUser().getUSER_ID();
			pd.put("check_json", pd.get("saveJson").toString());
			pd.put("USER_ID", USER_ID);
			installService.saveStandardQC(pd);
			
			//更新开箱报告状态为3
			updatePd.put("status", "3");
			updatePd.put("details_id", pd.get("details_id").toString());
			installService.updateUnboxStatusByDetails(updatePd);
			
			mv.addObject("msg", "success");
			mv.addObject("id", "SelfcheckReport");
			mv.addObject("form", "DetailsForm1");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *提交调试申请 
	 */
	@RequestMapping(value="addAdjust")
	@ResponseBody
	public Object addAdjust(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			//封装自检调试申请的pd
			pd.put("status", "0");//自检调试申请
			pd.put("USER_ID", getUser().getUSER_ID());
			String elevator_id = pd.get("elevator_id").toString();
			if(elevator_id.equals("1")||elevator_id.equals("4")){
				pd.put("factory", "e08ff1b9-22d4-4f42-8987-b66d9e3d81e7");
			}else if(elevator_id.equals("2")){
				pd.put("factory", "1a50a203-93a5-483a-a18d-26843ce0e9df");
			}else if(elevator_id.equals("3")){
				pd.put("factory", "f36ab4d6-517d-4477-a0ad-ad46f0d988ff");
			}
			
			map.put("msg", "success");
			installService.saveAdjustApply(pd);
			
			//修改开箱表status 30 : 调试申请中
			String type = pd.get("type").toString();
			PageData updPd = new PageData();
			updPd.put("details_id", pd.get("details_id").toString());
			if(type.equals("1")){//自检调试申请
				updPd.put("status", "30");
			}else if(type.equals("2")){//厂检调试申请
				updPd.put("status", "50");
			}
			installService.updateUnboxStatusByDetails(updPd);
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 列表调试申请
	 */
	@RequestMapping(value="listAdjustApply")
	public ModelAndView listAdjustApply(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> adjustApplys = installService.findAdjustApplyList();
			mv.addObject("adjustApplys", adjustApplys);
			mv.addObject("active", "1");
			mv.setViewName("system/install/adjust_apply_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *列表已办理的调试申请 
	 */
	@RequestMapping(value="listAdjustApplyDone")
	public ModelAndView listAdjustApplyDone(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> adjustApplysDone = installService.findAdjustApplyListDone();
			
			mv.addObject("adjustApplysDone", adjustApplysDone);
			mv.addObject("active", "2");
			mv.setViewName("system/install/adjust_apply_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到列表标准规格页面 
	 */
	@RequestMapping(value="listStandard")
	public ModelAndView listStd(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> stdList = installService.findStandard(page);
			
			mv.addObject("stdList", stdList);
			mv.setViewName("system/install/std_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *签收调试申请 
	 */
	@RequestMapping(value="claimAdjustApply")
	public Object claimAdjustApply(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("status", "1");//1签收
			String USER_ID = getUser().getUSER_ID();
			pd.put("USER_ID", USER_ID);
			installService.claimAdjustApply(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转到办理调试申请页面 
	 */
	@RequestMapping(value="toHandleAdjustApply")
	public ModelAndView toHandleAdjustApply(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("pd", pd);
			mv.setViewName("system/install/adjust_apply_handle");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *办理调试申请 
	 */
	@RequestMapping(value="handleAdjustApply")
	public ModelAndView handleAdjustApply(){
		ModelAndView mv = new ModelAndView();
		try{
			String status = "";
			PageData pd = new PageData();
			pd = this.getPageData();
			String action = pd.get("action").toString();
			if(action.equals("pass")){
				status = "2";
			}else if(action.equals("reject")){
				status = "0";
			}
			pd.put("status", status);
			installService.updateAjustApplyStatus(pd);
			mv.addObject("msg", "success");
			mv.addObject("id", "toHandle");
			mv.addObject("from", "adjustApplyForm1");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到派工信息页面 
	 */
	@RequestMapping(value="toWorkAdjust")
	public ModelAndView toWorkAdjust(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> userList = installService.findUserList();
			mv.addObject("type", pd.get("type").toString());
			mv.addObject("apply_id", pd.get("id").toString());
			mv.addObject("userList", userList);
			mv.setViewName("system/install/adjust_work");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存派工信息 
	 */
	@RequestMapping(value="saveWorkAdjust")
	public ModelAndView saveWorkAdjust(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			installService.saveWorkAdjust(pd);
			String work_id = pd.get("id").toString();
			//修改申请单状态为3,已派工
			PageData updPd = new PageData();
			updPd.put("id", pd.get("apply_id").toString());
			updPd.put("status", "3");
			installService.updateAjustApplyStatus(updPd);
			String status = "";
			String type = pd.get("type").toString();
			if(type.equals("1")){//更新开箱报告状态为4,填写调试报告
				status = "4";
			}else if(type.equals("2")){//更新开箱报告状态为6,填写厂检报告
				status = "6";
			}
			updPd.put("work_id", work_id);
			updPd.put("status", status);
			installService.updateUnboxStatusByWork(updPd);
			
			mv.addObject("msg", "success");
			mv.addObject("id", "toWork");
			mv.addObject("for", "adjustWorkForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到派工调试报告 
	 */
	@RequestMapping(value="toAdjustReport")
	public ModelAndView toAdjustReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			//pd.type   1:自检派工调试类型,2:厂检派工调试类型
			String details_id = pd.get("details_id").toString();
			String models_id = installService.findModelsIdByDetails(details_id);
			//查出派工id,跳转到此次派工的录入调试报告页面
			String workId = installService.findWorkIdByApplyAndDetails(pd);
			String checkJson = installService.findCheckJsonByModelsId(models_id);
			mv.addObject("pd", pd);
			mv.addObject("work_id", workId);
			mv.addObject("checkJson", checkJson);
			mv.addObject("msg", "saveAdjustReport");
			mv.setViewName("system/install/adjust_report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存调试报告 
	 */
	@RequestMapping(value="saveAdjustReport")
	public ModelAndView saveAdjustReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("check_json", pd.get("saveJson").toString());
			pd.put("USER_ID", getUser().getUSER_ID());
			installService.saveAdjustReport(pd);
			PageData updPd = new PageData();
			String status = "";
			String type = pd.get("type").toString();
			if(type.equals("1")){//更新到状态为5,可以提交厂检申请
				status = "5";
			}else if(type.equals("2")){//更新到状态为7,厂检报告完成
				status = "7";
			}
			//更新开箱报告状态
			updPd.put("status", status);
			updPd.put("work_id", pd.get("work_id").toString());
			installService.updateUnboxStatusByWork(updPd);
			mv.addObject("id", "AdjustReport");
			mv.addObject("form", "DetailsForm2");
			mv.addObject("msg", "success");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}

	
	/**
	 *跳转到新增标准规格页面
	 */
	@RequestMapping(value="goAddStandard")
	public ModelAndView goAddStandard(){
		ModelAndView mv = new ModelAndView();
		try{
			
			mv.addObject("msg", "saveStandard");
			mv.setViewName("system/install/std_setting");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存标准规格信息 
	 */
	@RequestMapping(value="saveStandard")
	public ModelAndView saveStandard(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			installService.saveStandard(pd);
			mv.addObject("id", "EditStandard");
			mv.addObject("form","StandardForm");
			mv.addObject("msg", "success");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *根据梯种类型给梯型列表赋值 
	 */
	@RequestMapping(value="setModelList")
	@ResponseBody
	public Object setModelList(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			 pd = this.getPageData();
			 String elevator_id = pd.get("elevator_id").toString();
			 List<PageData> modelsList = installService.findModelsListByElevatorType(elevator_id);
			 map.put("modelsList", modelsList);
			 map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 添加整改信息
	 */
	@RequestMapping(value="addCorrect")
	@ResponseBody
	public Object addCorrect(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("init", "0");//0标记为初始化记录
			installService.saveCorrectDefault(pd);
			//更新unbox状态
			String status = pd.get("status").toString();
			PageData updPd = new PageData();
			updPd.put("details_id", pd.get("details_id").toString());
			if(status.equals("0")){//不需整改
				updPd.put("status", "71");//开箱状态 71 : 等待政府验收
			}else if(status.equals("1")){//整改
				updPd.put("status", "70");//开箱状态 70 : 整改中
			}
			installService.updateUnboxStatusByDetails(updPd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *整改信息列表 
	 */
	@RequestMapping(value="listCorrect")
	public ModelAndView listCorrect(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> correctList = installService.findCorrectList(page);
			mv.addObject("active", "1");
			mv.addObject("correctList", correctList);
			mv.setViewName("system/install/correct_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *已整改信息列表 
	 */
	@RequestMapping(value="listCorrectDone")
	public ModelAndView listCorrectDone(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> correctDoneList = installService.findCorrectDoneList(page);
			mv.addObject("active", "2");
			mv.addObject("correctDoneList", correctDoneList);
			mv.setViewName("system/install/correct_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到新增整改报告 
	 */
	@RequestMapping(value="toAddCorrectReport")
	public ModelAndView toAddCorrectReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("correct_id", pd.get("id").toString());
			mv.addObject("details_id", pd.get("details_id").toString());
			mv.addObject("msg", "saveCorrectReport");
			mv.setViewName("system/install/correct_report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
    
	/**
	 *保存整改报告 
	 */
	@RequestMapping(value="saveCorrectReport")
	public ModelAndView saveCorrectReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			installService.saveCorrectReport(pd);
			//修改init状态
			PageData updatePd = new PageData();
			updatePd.put("id", pd.get("correct_id").toString());
			updatePd.put("init", "1");
			installService.updateCorrectInit(updatePd);
			//整改完成时,开箱状态改为 71 : 等待政府验收
			PageData updPd = new PageData();
			updPd.put("details_id", pd.get("details_id").toString());
			updPd.put("status", "71");
			installService.updateUnboxStatusByDetails(updPd);
			mv.addObject("active", "1");
			mv.addObject("msg", "success");
			mv.addObject("id", "correctReport");
			mv.addObject("form", "CorrectForm1");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *政府验收结果 
	 */
	@RequestMapping(value="govAccept")
	@ResponseBody
	public Object govAccept(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			//init为0 重新进入整改环节,init为2 政府验收通过
			String init = pd.get("init").toString();
			installService.updateCorrectInit(pd);
			PageData updPd = new PageData();
			updPd.put("details_id", pd.get("details_id").toString());
			if(init.equals("0")){//init为0,整改状态status改为 1 : 需要整改
				pd.put("status", "1");
				installService.updateCorrectStatus(pd);
				//验收未通过,更新开箱状态为 70 : 整改中
				updPd.put("status", "70");
			}else if(init.equals("2")){
				//验收通过,更新开箱状态为 72 : 已验收
				updPd.put("status", "72");
			}
			installService.updateUnboxStatusByDetails(updPd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("faild", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转到政府验收报告 
	 */
	@RequestMapping(value="goAddGovAcceptReport")
	public ModelAndView goAddGovAcceptReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			mv.addObject("msg", "saveGovAcceptReport");
			mv.addObject("details_id",pd.get("details_id").toString());
			mv.addObject("currect_id",pd.get("id").toString());
			mv.setViewName("system/install/gov_accept_report");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存政府验收报告
	 */
	@RequestMapping(value="saveGovAcceptReport")
	public ModelAndView saveGovAcceptReport(){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			installService.saveGovAccept(pd);
			//init改为3 政府验收报告已录入
			PageData updatePd = new PageData();
			updatePd.put("id", pd.get("currect_id").toString());
			updatePd.put("init", "3");
			installService.updateCorrectInit(updatePd);
			mv.addObject("active", "2");
			mv.addObject("msg", "success");
			mv.addObject("id", "govAcceptReport");
			mv.addObject("form", "CorrectForm2");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
		
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

}
