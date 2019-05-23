package com.dncrm.controller.system.nonstandrad;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.DictUtils;
import com.dncrm.common.WorkFlow;
import com.dncrm.common.aspect.Log;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Dict;
import com.dncrm.entity.Page;
import com.dncrm.entity.nonstandrad.NonStandrad;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.nonstandrad.NonStandradService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;
import com.dncrm.util.Tools;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/nonStandrad")
public class NonStandradController extends BaseController {
    @Resource(name="nonStandradService")
    private NonStandradService nonStandradService;

    @Resource(name="contractNewService")
    private ContractNewService contractNewService;

    @Resource(name="itemService")
    private ItemService itemService;

    @Resource(name="modelsService")
    private ModelsService modelsService;

    @Resource(name = "sysUserService")
    private com.dncrm.service.system.sysUser.sysUserService sysUserService;

    @Resource(name="e_offerService")
	private E_offerService e_offerService;

    /**
     * 显示全部非标信息
     * @param page
     * @return
     */
    @RequestMapping("/nonStandradList")
    public ModelAndView nonStandradList(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
		SelectByRole sbr = new SelectByRole();
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        String USER_ID = pds.getString("USER_ID");
        try {
        	/*List<String> userList = getRoleSelect();
            String roleType = getRoleType();
            pd.put("userList", userList);
            pd.put("roleType", roleType);*/
        	//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
            page.setPd(pd);
            List<PageData> nonList = nonStandradService.listPagenonStandradList(page);
            if(!nonList.isEmpty()){
                for(PageData con : nonList){
                    String instance_id = con.getString("instance_id");
                    if(instance_id!=null && !"".equals(instance_id)){
                        WorkFlow workFlow = new WorkFlow();
                        List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).active().list();
                        if(task!=null&& task.size()>0){
                            for(Task task1:task)
                            {
                                con.put("task_id",task1.getId());
                                con.put("task_name",task1.getName());
                            }
                        }
                    }
                }
            }
            //是否是财务角色
            mv.addObject("iscaiwurole", isCaiwuRole(USER_ID));
            
            mv.setViewName("system/nonStandrad/masterList");
            mv.addObject("nonstandradList", nonList);
            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    @RequestMapping("/preEditNonStandrad")
    public ModelAndView preEditNonStandrad(){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();
        try {
            String non_standrad_id =pd.getString("non_standrad_id");
            String operateType=pd.getString("operateType");
            //获取当前登陆用户信息
            Subject currentUser=SecurityUtils.getSubject();
            Session session=currentUser.getSession();
            PageData pds=new PageData();
            pds=(PageData) session.getAttribute("userpds");
            //获取当前登陆用户用户组信息
            if(non_standrad_id!=null&&!non_standrad_id.equals("")&&operateType!=null&&!operateType.equals("")){//进入查看或者编辑界面
                pd=nonStandradService.findNonStandradMasterById(pd);
                List<PageData> detailList=nonStandradService.listNonStandradDetailList(pd);
                mv.addObject("detailList",detailList);
                if(operateType.equals("edit")){
                    mv.addObject("msg","editNonStandrad");
                }else {
                	PageData qxcb=new PageData();
                	qxcb.put("process_definition_id", "nonStandrad:2:237504");
                	qxcb.put("user_id", pds.getString("USER_ID"));
                	List<PageData> pdss = nonStandradService.findDefinitionIdForUserId(qxcb);
                	if(pdss !=null && pdss.size() > 0 ) {
                		pd.put("isqxShow", "1");
                	}
                	
                    mv.addObject("msg","view");
                }
            }else{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                pd.put("operate_date",DateUtil.getTime());
                String USER_ID=pds.getString("USER_ID");
                pd.put("operate_name",pds.getString("NAME"));
                //项目信息
                PageData itempd=nonStandradService.findItemMsg(pd);
                if(itempd!=null){
                    pd.put("project_name",itempd.get("project_name"));
                    pd.put("project_address",itempd.get("project_address"));
                    pd.put("subsidiary_company",itempd.get("subsidiary_company"));
                    pd.put("project_area",itempd.get("project_area"));
                }

                PageData modelsPd = modelsService.findModelsById(pd);
                String codName = modelsPd.getString("models_name");
                pd.put("lift_name",codName);
                
                if("tezhong".equals(pd.getNoneNULLString("btype"))) {
                	String btypev = pd.getNoneNULLString("btypev");
                	PageData argPd = new PageData();
                	argPd.put("TEZHONG_ID", btypev);
                	argPd.put("XXCS_MASTER_ID", "");
    				List<PageData> tezhongArgs = e_offerService.findTezhongArgs(argPd);
    				pd.put("tezhongArgs", tezhongArgs);
                }

                mv.addObject("msg","saveNonStandrad");
            }
            mv.addObject("costread",getCostReadRight());
            mv.addObject("pd",pd);
            mv.setViewName("system/nonStandrad/editNonStandrad");
        }catch (Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    @RequestMapping("/caiwuPreEditNonStandrad")
    public ModelAndView caiwuPreEditNonStandrad(){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();
        try {
            String non_standrad_id =pd.getString("non_standrad_id");
            //获取当前登陆用户信息
            Subject currentUser=SecurityUtils.getSubject();
            Session session=currentUser.getSession();
            PageData pds=new PageData();
            pds=(PageData) session.getAttribute("userpds");
            String USER_ID=pds.getString("USER_ID");
            String iscaiwuRole = isCaiwuRole(USER_ID);
            //获取当前登陆用户用户组信息
            if(non_standrad_id!=null&&!non_standrad_id.equals("")&&"1".equals(iscaiwuRole)){//进入查看或者编辑界面
                pd=nonStandradService.findNonStandradMasterById(pd);
                List<PageData> detailList=nonStandradService.listNonStandradDetailList(pd);
                mv.addObject("detailList",detailList);
                mv.addObject("iscaiwurole", "1");
                mv.addObject("msg","caiwuEditNonStandrad");
            }
            mv.addObject("costread",getCostReadRight());
            mv.addObject("pd",pd);
            mv.setViewName("system/nonStandrad/caiwuEditNonStandrad");
        }catch (Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    //保存新增非标
    @RequestMapping("/saveNonStandrad")
    public ModelAndView saveNonStandrad(NonStandrad nonstandrad){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();

        Subject currentUser=SecurityUtils.getSubject();
        Session session=currentUser.getSession();
        PageData pds=new PageData();
        pds=(PageData) session.getAttribute("userpds");
        String USER_ID=pds.getString("USER_ID");
        //获取系统时间
        String df= DateUtil.getTime().toString();

        try {
            String subtype=pd.getString("subtype");
            pd.put("sequence_type","nonStandrad");
            String non_standrad_id="FB"+contractNewService.getSequence(pd).getString("billno");
            nonstandrad.setNon_standrad_id(non_standrad_id);
            nonstandrad.setOperate_id(USER_ID);
            nonstandrad.setNonUpload(pd.getString("NonUpload_json"));

            //-----------------生成流程相关
            String processDefinitionKey="nonStandrad";   //存放流程的key

            PageData offerPd=new PageData();
            offerPd.put("KEY", processDefinitionKey);


            //-----生成流程实例
            WorkFlow workFlow=new WorkFlow();
            IdentityService identityService=workFlow.getIdentityService();
            identityService.setAuthenticatedUserId(USER_ID);
            String businessKey="tb_non_standrad_master.non_standrad_id."+non_standrad_id;
            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("user_id", USER_ID);
            ProcessInstance proessInstance=null; //存放生成的流程实例id
            if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
            {
                proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
            }
            if(proessInstance!=null)
            {
                mv.addObject("msg", "success");
                nonstandrad.setInstance_id( proessInstance.getId());
                nonstandrad.setInstance_status("1");


                nonStandradService.saveDetail(nonstandrad);

                nonStandradService.saveMaster(nonstandrad);

                if(subtype!=null&&"1".equals(subtype)){//选择了提交         //当前登录用户的ID
                    String instance_id = proessInstance.getId();       //流程实例id
                    pd.put("non_standrad_id",non_standrad_id);
                    PageData nsPd=nonStandradService.findNonStandradMasterById(pd);
                    int lc = 0;
                    String ele_type=nsPd.getString("ele_type");

                    if (ele_type.equals("DT1")||
                            ele_type.equals("DT2")){//扶梯人行道
                        lc=3;
                    }else  if (ele_type.equals("DT3")||ele_type.equals("DT10")){//飞尚
                        lc=2;
                    }else {
                        lc=1;
                    }
                        Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                        //设置任务角色
                        workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                        //签收任务
                        workFlow.getTaskService().claim(task.getId(), USER_ID);
                        //设置流程变量
                        variables.put("action", "提交申请");
                        variables.put("approved", true);
                        variables.put("lc", lc);
                        String  comment = "批准";

                        workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
                        Authentication.setAuthenticatedUserId(USER_ID);
                        workFlow.getTaskService().addComment(task.getId(),null,comment);
                        workFlow.getTaskService().complete(task.getId(),variables);
                        pd.put("instance_status", 2);   //流程状态  2代表流程启动,等待审核
                        nonStandradService.updateMasterInstance(pd);//更新流程状态

                }
            }
            else
            {
                mv.addObject("msg", "failed");
                mv.addObject("err", "没有生成流程实例");
            }
            mv.addObject("id", "zhjView");
            //mv.addObject("form", "ItemForm");
            mv.setViewName("system/nonStandrad/save_result");
        }catch (Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    //保存修改非标
    @RequestMapping("/editNonStandrad")
    public ModelAndView editNonStandrad(NonStandrad nonstandrad){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();
        try {
            //修改附件上传
        	/*nonStandradService.updateMasterUTB(pd);
        	//
            nonStandradService.deleteDetail(nonstandrad);
            nonStandradService.saveDetail(nonstandrad);*/
        	
        	nonStandradService.updateNonStandrad(pd, nonstandrad);

            String subtype=pd.getString("subtype");
            WorkFlow workFlow=new WorkFlow();
        	if(subtype!=null&&"1".equals(subtype)){//选择了提交         //当前登录用户的ID
                String USER_ID=getUser().getUSER_ID();
        		Map<String,Object> variables = new HashMap<String,Object>();
                PageData nsPd=nonStandradService.findNonStandradMasterById(pd);
        		if(nsPd != null && StringUtils.isNoneBlank(nsPd.getString("non_standrad_id"))) {
        			if("1".equals(nsPd.getString("instance_status"))
            				|| "5".equals(nsPd.getString("instance_status"))) {
            			String non_standrad_id = nsPd.getString("non_standrad_id");
            			String instance_id = nsPd.getString("instance_id");
            			
                        pd.put("non_standrad_id",non_standrad_id);
                        int lc = 0;
                        String ele_type=nsPd.getString("ele_type");

                        if (ele_type.equals("DT1")||
                                ele_type.equals("DT2")){//扶梯人行道
                            lc=3;
                        }else  if (ele_type.equals("DT3")||ele_type.equals("DT10")){//飞尚
                            lc=2;
                        }else {
                            lc=1;
                        }
                        Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                        //设置任务角色
                        workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                        //签收任务
                        workFlow.getTaskService().claim(task.getId(), USER_ID);
                        //设置流程变量
                        variables.put("action", "提交申请");
                        if("5".equals(nsPd.getString("instance_status"))) {
                        	variables.put("action", "重新提交");
                        }
                        variables.put("approved", true);
                        variables.put("lc", lc);
                        String  comment = "批准";

                        workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
                        Authentication.setAuthenticatedUserId(USER_ID);
                        workFlow.getTaskService().addComment(task.getId(),null,comment);
                        workFlow.getTaskService().complete(task.getId(),variables);
                        pd.put("instance_status", 2);   //流程状态  2代表流程启动,等待审核
                        nonStandradService.updateMasterInstance(pd);//更新流程状态
        			}
        		}
            }
        	
            mv.addObject("msg","success");
            mv.addObject("id", "zhjView");
            mv.addObject("form", "shopForm");
            mv.setViewName("save_result");
        }catch (Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    @Log(module="delete", title="报价管理-非标申请管理-删除", ext_idTitle="?1",ext_idParam="non_standrad_id", ext_contentTitle="删除非标单号：?1",ext_contentParam="non_standrad_id")
    @RequestMapping("/delNonStandrad")
    @ResponseBody
    public Object delNonStandrad(){
        PageData pd=this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids={};
            if(pd.get("non_standrad_id")!=null){
                ids=pd.getString("non_standrad_id").split(",");
            }
            List<String> idslist=Arrays.asList(ids);

            pd.put("ids",idslist);


            nonStandradService.deleteBatchDetail(pd);

            nonStandradService.deleteBatchMaster(pd);


            map.put("msg", "success");
        }catch (Exception e){
            e.printStackTrace();

            map.put("msg", "failed");
        }

        return JSONObject.fromObject(map);
    }
    
  //财务保存修改非标
    @RequestMapping("/caiwuEditNonStandrad")
    public ModelAndView caiwuEditNonStandrad(NonStandrad nonstandrad){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();
        try {
            nonStandradService.updateDetail(nonstandrad);
            
            mv.addObject("msg","success");
            mv.addObject("id", "zhjView");
            mv.addObject("form", "shopForm");
            mv.setViewName("save_result");
        }catch (Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    
    /**
     * 调用全部非标信息
     * @param page
     * @return
     */
    @RequestMapping("/eOfferStandradList")
    public ModelAndView eOfferStandradList(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        String USER_ID = pds.getString("USER_ID");
        try {
            List<String> userList = getRoleSelect();
            String roleType = getRoleType();
            pd.put("userList", userList);
            pd.put("roleType", roleType);
            pd.put("instance_status",4);
            page.setPd(pd);
//            List<PageData> nonList = nonStandradService.listPagenonStandradList(page);
            List<PageData> nonList = nonStandradService.listTempPagenonStandradList(page);
            mv.setViewName("system/nonStandrad/eOfferMasterList");
            mv.addObject("nonstandradList", nonList);
            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 获取非标明细
     * @param
     * @return
     */
    @RequestMapping("/selNonstandradToBJC")
    @ResponseBody
    public Object selNonstandradToBJC() {
        ModelAndView mv = this.getModelAndView();
        JSONArray result = new JSONArray();
        PageData pd = this.getPageData();
        try {
            String[] ids={};
            if(pd.get("ids")!=null){
              ids=pd.getString("ids").split(",");
            }
            List<String> idslist=Arrays.asList(ids);

            pd.put("ids",idslist);
            List<PageData> detailList=nonStandradService.findDetailListForMasterId(pd);
            result.addAll(detailList);

            return result;
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return result;
    }

    /**
     * 启动流程
     * @return
     */
    @RequestMapping("/apply")
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
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String instance_id = pd.getString("instance_id");       //流程实例id

            PageData nsPd=nonStandradService.findNonStandradMasterById(pd);
            int lc = 0;
            String ele_type=nsPd.getString("ele_type");

            if (ele_type.equals("DT1")||
                    ele_type.equals("DT2")){//扶梯人行道
            lc=3;
            }else  if (ele_type.equals("DT3")||
                    ele_type.equals("DT10")){//飞尚
                lc=2;
            }else {
                lc=1;
            }


            // 如果流程的实例id存在，启动流程
            if(instance_id!=null && !"".equals(instance_id)){
            	if("1".equals(nsPd.getString("instance_status"))) {
            		
            		WorkFlow workFlow = new WorkFlow();
                    // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
                    workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
                    Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                    Map<String,Object> variables = new HashMap<String,Object>();
                    //设置任务角色
                    workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                    //签收任务
                    workFlow.getTaskService().claim(task.getId(), USER_ID);
                    //设置流程变量
                    variables.put("action", "提交申请");
                    variables.put("approved", true);
                    variables.put("lc", lc);
                    String  comment = "批准";

                    workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
                    Authentication.setAuthenticatedUserId(USER_ID);
                    workFlow.getTaskService().addComment(task.getId(),null,comment);
                    workFlow.getTaskService().complete(task.getId(),variables);

                	/*workFlow.getTaskService().setVariablesLocal(task.getId(), variables);*/
                    pd.put("instance_status", 2);   //流程状态  2代表流程启动,等待审核
                    nonStandradService.updateMasterInstance(pd);//更新流程状态
                	/*workFlow.getTaskService().complete(task.getId());*/
                    //获取下一个任务的信息
                    Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                    map.put("task_name",tasks.getName());
                    map.put("status", "1");
                    
            	}
            }
            if((instance_id !=null && !"".equals(instance_id))){
                map.put("status", "3");
            }
            map.put("msg", "success");
        }catch(Exception e){
            logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return net.sf.json.JSONObject.fromObject(map);
    }

    /**
     * 显示待我处理的合同
     *
     * @param page
     * @return
     */
    @RequestMapping(value = "/listAuditNonstandrad")
    public ModelAndView listAuditNonstandrad(Page page) {
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
            mv.setViewName("system/nonStandrad/nonStandradAuditList");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> nonStandList = new ArrayList<>();
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
            
            int thlCount = 0;
            if(StringUtils.isBlank(pd.getString("project_name"))
            		&& StringUtils.isBlank(pd.getString("subsidiary_company"))
            		&& StringUtils.isBlank(pd.getString("operate_name"))
            		&& StringUtils.isBlank(pd.getString("operate_date"))) {
            	
            	//List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
                //        .processDefinitionKey("nonStandrad").orderByTaskCreateTime().desc().active().list();
                List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID)
                        .processDefinitionKey("nonStandrad").orderByTaskCreateTime().desc().active().list();
                        //.listPage(firstResult, maxResults);
                for (Task task : toHandleList) {
                    PageData nonStandMaster = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery()
                            .processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey)) {
                        // leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        nonStandMaster.put(info[1], info[2]);
                        
                        if (pd.getString("flag")!=null &&pd.getString("flag").equals("shouye")) {
                        	if(nonStandMaster.getNoneNULLString("non_standrad_id").equals(pd.get("non_standrad_id"))) {
                        		nonStandMaster = nonStandradService.findNonStandradMasterById(nonStandMaster);
                        		if(nonStandMaster!=null) {
                        			nonStandMaster.put("task_name", task.getName());
                                    nonStandMaster.put("task_id", task.getId());
                                    if (task.getAssignee() != null) {
                                        nonStandMaster.put("type", "1");// 待处理
                                    } else {
                                        nonStandMaster.put("type", "0");// 待签收
                                    }
                                    nonStandList.add(nonStandMaster);
                        		}
                                break;
                        	} else {
    							 continue;
    						 }
                        }
                        
                        nonStandMaster = nonStandradService.findNonStandradMasterById(nonStandMaster);
                        		
                        if(nonStandMaster==null) continue;
                        nonStandMaster.put("task_name", task.getName());
                        nonStandMaster.put("task_id", task.getId());
                        if (task.getAssignee() != null) {
                            nonStandMaster.put("type", "1");// 待处理
                        } else {
                            nonStandMaster.put("type", "0");// 待签收
                        }
                        nonStandList.add(nonStandMaster);
                    }
                }
            	
                thlCount = nonStandList.size();
            } else {
            	PageData nonStandMaster = new PageData();
                nonStandMaster.put("user_id", USER_ID);
                nonStandMaster.put("process_definition_key", "nonStandrad");
                nonStandMaster.put("project_name", pd.getString("project_name"));
                nonStandMaster.put("subsidiary_company", pd.getString("subsidiary_company"));
                nonStandMaster.put("operate_name", pd.getString("operate_name"));
                nonStandMaster.put("operate_date", pd.getString("operate_date"));
                /*List<PageData> toHandleListCount = nonStandradService.findAuditNonstandradPage(nonStandMaster);
                nonStandMaster.put("firstResult", firstResult);
                nonStandMaster.put("maxResults", maxResults);*/
                nonStandList = nonStandradService.findAuditNonstandradPage(nonStandMaster);

                thlCount = nonStandList.size();
            }
            
            
            // 设置分页数据
            int totalResult = thlCount;
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
            page.setCurrentResult(nonStandList.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            // 如果有多个form,设置第几个,从0开始
            page.setFormNo(0);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            // 待处理任务的count
            pd.put("page1", page);
            pd.put("count", thlCount);
            pd.put("isActive2", "1");
            mv.addObject("pd", pd);
            mv.addObject("nonStandList", nonStandList);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 显示我已经处理的任务
     *
     * @return
     */
    @RequestMapping("/listDoneNonstandradList")
    public ModelAndView listDoneE_offer(Page page) {
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
            mv.setViewName("system/nonStandrad/nonStandradAuditList");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务集合
            List<PageData> nonStandDoneList = new ArrayList<>();
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();

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
            int thlCount = 0;
            if(StringUtils.isBlank(pd.getString("project_name"))
            		&& StringUtils.isBlank(pd.getString("subsidiary_company"))
            		&& StringUtils.isBlank(pd.getString("operate_name"))
            		&& StringUtils.isBlank(pd.getString("operate_date"))) {
            	
            	//获取已处理的任务
                List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().
                        taskAssignee(USER_ID).processDefinitionKey("nonStandrad").orderByTaskCreateTime().desc().list();
                //移除重复的
                for (HistoricTaskInstance instance:historicTaskInstances)
                {
                    String processInstanceId = instance.getProcessInstanceId();
                    HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().
                            processInstanceId(processInstanceId).singleResult();
                    String businessKey = historicProcessInstance.getBusinessKey();
                    map.put(businessKey,instance);
                }


                @SuppressWarnings("rawtypes")
                Iterator iter = map.entrySet().iterator();
                while (iter.hasNext()){
                    @SuppressWarnings("rawtypes")
                    Map.Entry entry = (Map.Entry) iter.next();
                    list.add((HistoricTaskInstance)entry.getValue());
                }
                
                //int listCount =(list.size()<=maxResults?list.size():maxResults);
                int listCount = list.size();
                //从分页参数开始
                for (int i = firstResult; i <listCount ; i++) {
                    HistoricTaskInstance historicTaskInstance = list.get(i);
                    PageData stra = new PageData();
                    String processInstanceId = historicTaskInstance.getProcessInstanceId();
                    HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                    String businessKey = historicProcessInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        stra.put(info[1],info[2]);
                        stra = nonStandradService.findNonStandradMasterById(stra);
                        //检查申请者是否是本人,如果是,跳过
                       if (stra==null||stra.getString("operate_id").equals(USER_ID))
                            continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (stra!=null) {
                            if (runing==null||runing.size()<=0){
                                stra.put("isRuning",0);
                            }else{
                                stra.put("isRuning",1);
                                //正在运行,查询当前的任务信息
                                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                                stra.put("task_name",task.getName());
                                stra.put("task_id",task.getId());
                            }
                            nonStandDoneList.add(stra);
                        }
                    }
                }
            	
                thlCount = nonStandDoneList.size();
            } else {
            	PageData nonStandMaster = new PageData();
                nonStandMaster.put("user_id", USER_ID);
                nonStandMaster.put("process_definition_key", "nonStandrad");
                nonStandMaster.put("project_name", pd.getString("project_name"));
                nonStandMaster.put("subsidiary_company", pd.getString("subsidiary_company"));
                nonStandMaster.put("operate_name", pd.getString("operate_name"));
                nonStandMaster.put("operate_date", pd.getString("operate_date"));
                /*List<PageData> toHandleListCount = nonStandradService.findDoneAuditNonstandradPage(nonStandMaster);
                nonStandMaster.put("firstResult", firstResult);
                nonStandMaster.put("maxResults", maxResults);*/
                nonStandDoneList = nonStandradService.findDoneAuditNonstandradPage(nonStandMaster);

                thlCount = nonStandDoneList.size();
            }
            
            
            //设置分页数据
            int totalResult = thlCount;
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
            page.setCurrentResult(nonStandDoneList.size());
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
            pd.put("count1",nonStandDoneList.size());
            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("nonStandDoneList", nonStandDoneList);
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
    @SuppressWarnings("unchecked")
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
    //请求办理任务页面
    @RequestMapping("/preAuditNonStandrad")
    public ModelAndView preAuditNonStandrad(){
        ModelAndView mv = this.getModelAndView();
        PageData pd=this.getPageData();
        WorkFlow workFlow = new WorkFlow();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String task_id=pd.getString("task_id");
            String operateType=pd.getString("operateType");
            pd=nonStandradService.findNonStandradMasterById(pd);
            pd.put("task_id",task_id);
            pd.put("audit_name",pds.getString("NAME"));
            List<PageData> detailList=nonStandradService.listNonStandradDetailList(pd);
            mv.addObject("detailList",detailList);
            
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            if(task.getTaskDefinitionKey().equals("usertask8")
            		||task.getTaskDefinitionKey().equals("usertask6")
            		||task.getTaskDefinitionKey().equals("usertask11")
            		||task.getTaskDefinitionKey().equals("usertask12")){//财务审核
                mv.addObject("iscaiwu","1");
            }else if(task.getTaskDefinitionKey().equals("usertask2")||task.getTaskDefinitionKey().equals("usertask3")||task.getTaskDefinitionKey().equals("usertask9")){
                mv.addObject("iscaiwu","2");
                mv.addObject("isjishu","1");//技术审核
                mv.addObject("isshowjishu","1");
            }else if(task.getTaskDefinitionKey().equals("usertask4")) {
                mv.addObject("iscaiwu","3");
                mv.addObject("isjishu","1");//技术电气审核
                mv.addObject("isshowjishu","1");
            }
            else {
                mv.addObject("iscaiwu","3");
                mv.addObject("isjishu","2");
            }
            
            if(task.getTaskDefinitionKey().equals("usertask9")) {
                mv.addObject("isshowjishu","2");
            }
            
            
            if(task.getTaskDefinitionKey().equals("usertask8")) {
            	mv.addObject("iscaiwu2","1");
            }
            
            if(task.getTaskDefinitionKey().equals("usertask7")){//采购审核
                mv.addObject("iscaigou","1");
            }else {
                mv.addObject("iscaigou","2");
            }
            mv.addObject("msg","AuditNonStandrad");
            mv.addObject("historys",getViewHistory(pd.getString("instance_id")));
            mv.addObject("costread",getCostReadRight());
            mv.addObject("pd",pd);
            mv.setViewName("system/nonStandrad/auditNonStandrad");
        }catch (Exception e){
            e.printStackTrace();
        }
        return mv;
    }
    //办理任务
    @RequestMapping("/AuditNonStandrad")
    public ModelAndView AuditNonStandrad(NonStandrad nonstandrad){
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
            boolean isEnd=false;
            String action = pd.getString("action");
            boolean iscaigou="1".equals(pd.getString("iscaigou"));
            @SuppressWarnings("unused")
            int status;
            if (action.equals("approve")){
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
                if(task.getTaskDefinitionKey().equals("usertask11")||task.getTaskDefinitionKey().equals("usertask12"))
                {//财务审核
                    status = 2;    //已完成
                    pd.put("instance_status",4);             //流程状态   4.已通过
                    variables.put("approved", true);
                    variables.put("iscaigou", iscaigou);
                    isApproved=true;
                    isEnd=true;

                    //nonStandradService.deleteDetail(nonstandrad);
                    //nonStandradService.saveDetail(nonstandrad);
                    //nonStandradService.updateMasterInstance(pd);//修改流程状态
                    nonStandradService.updateAuditNonStandrad(pd, nonstandrad);
                }else if(task.getTaskDefinitionKey().equals("usertask7")
                		|| task.getTaskDefinitionKey().equals("usertask6")
                		|| task.getTaskDefinitionKey().equals("usertask8")){//采购审核
                    status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    variables.put("iscaigou", iscaigou);
                    isApproved=true;

                    //nonStandradService.deleteDetail(nonstandrad);
                    //nonStandradService.saveDetail(nonstandrad);
                    //nonStandradService.updateMasterInstance(pd);//修改流程状态
                    nonStandradService.updateAuditNonStandrad(pd, nonstandrad);
                }else if(task.getTaskDefinitionKey().equals("usertask9")){//飞尚货梯电气技术审核
                    status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    variables.put("iscaigou", iscaigou);
                    isApproved=true;
                    
                    //nonStandradService.deleteDetail(nonstandrad);
                    //nonStandradService.saveDetail(nonstandrad);
                    //nonStandradService.updateMasterInstance(pd);//修改流程状态
                    nonStandradService.updateAuditNonStandrad(pd, nonstandrad);
                }else if(task.getTaskDefinitionKey().equals("usertask2")||
                        task.getTaskDefinitionKey().equals("usertask3")||
                        task.getTaskDefinitionKey().equals("usertask4")){//技术审核
                    status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    variables.put("iscaigou", iscaigou);
                    isApproved=true;
                    
                    //nonStandradService.deleteDetail(nonstandrad);
                    //nonStandradService.saveDetail(nonstandrad);
                    //nonStandradService.updateMasterInstance(pd);//修改流程状态
                    nonStandradService.updateAuditNonStandrad(pd, nonstandrad);
                }else {
                    status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    variables.put("iscaigou", iscaigou);
                    isApproved=true;
                    nonStandradService.updateMasterInstance(pd);//修改流程状态
                }
            }else if(action.equals("reject")) {
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            	if(task.getTaskDefinitionKey().equals("usertask6")
            			|| task.getTaskDefinitionKey().equals("usertask11")
            			|| task.getTaskDefinitionKey().equals("usertask7")
            			|| task.getTaskDefinitionKey().equals("usertask8")
            			|| task.getTaskDefinitionKey().equals("usertask12")) {
            		
            		status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", false);
                    boolean isrejectjishu="1".equals(pd.getString("isrejectjishu"));
                    variables.put("isrejectcaigou", isrejectjishu);
                    
                    nonStandradService.updateMasterInstance(pd);//修改流程状态
            		
            	} else {

                    status = 4;
                    pd.put("instance_status",5);             //流程状态  5代表 被驳回
                    variables.put("approved", false);
                    nonStandradService.updateMasterInstance(pd);//修改流程状态
            	}
            	
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            if(isEnd)
            {
                variables.put("action","通过,流程结束！");
            }
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
        mv.addObject("id", "zhjView");
        mv.addObject("form", "leaveForm2");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 重新提交流程
     *
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/restartNonStandrad")
    @ResponseBody
    public Object restartNonStandrad() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");  //流程id
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
            pd.put("instance_status", 2); //流程状态 2.待审核
            nonStandradService.updateMasterInstance(pd);//更新流程状态
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    @RequestMapping(value="getNonStandradHandle")
	@ResponseBody
    public Object getNonStandradHandle() {
		JSONArray result = new JSONArray();
		PageData pd = this.getPageData();
		
		try {
			List<PageData> list = nonStandradService.getNonStandradHandle(pd);
			result.addAll(list);
		} catch (Exception e) {
            logger.error(e.toString(), e);
		}
		
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
			PageData qxcb=new PageData();
        	qxcb.put("process_definition_id", "nonStandrad:2:237504");
        	qxcb.put("user_id", getUser().getUSER_ID());
        	List<Dict> dictList = DictUtils.getDictList("fbtype");
			List<PageData> pdss = nonStandradService.findDefinitionIdForUserId(qxcb);
			int isqxShow = 0;
        	if(pdss !=null && pdss.size() > 0 ) {
        		isqxShow = 1;
        	}
			
			
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("单号");
			titles.add("项目名称");
			titles.add("项目归属分公司");
			titles.add("项目地址");
			titles.add("项目归属区域");
			titles.add("申请人");
			titles.add("申请日期");
			titles.add("梯形");
			titles.add("载重(kg)");
			titles.add("层站门");
			titles.add("速度(m/s)");
			titles.add("底坑深(mm)");
			titles.add("顶层高(mm)");
			titles.add("提升高度(mm)");
			titles.add("井道总高(mm)");
			titles.add("开门尺寸");
			titles.add("轿厢规格");
			titles.add("角度");
			titles.add("梯级宽度");
			titles.add("轿厢高度");
			titles.add("台数");
			titles.add("井道尺寸HW(mm)xHD(mm)");
			titles.add("开门形式");
			titles.add("水平梯级");
			titles.add("土建图图号");
			titles.add("备注");
			titles.add("审核状态");
			titles.add("非标类型");
			titles.add("非标描述");
			titles.add("技术处理");
			titles.add("有效");
			if(isqxShow == 1) {
				titles.add("差价");
				titles.add("加成本");
			}
			titles.add("加价");
			titles.add("计量单位");
			titles.add("单台用量");
			titles.add("单台报价");
			//titles.add("总价");
			titles.add("可打折");
			titles.add("明细备注");
			
			dataMap.put("titles", titles);
			
			//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = new SelectByRole().findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
			/*List<PageData> itemList = itemService.findItemList();*/
			List<PageData> nonStandradList = nonStandradService.findNonStandradToExcel(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < nonStandradList.size(); i++){
				PageData nonStandrad = nonStandradList.get(i);
				PageData vpd = new PageData();
				vpd.put("var1", nonStandrad.getString("non_standrad_id"));
				vpd.put("var2", nonStandrad.getString("project_name"));
				vpd.put("var3", nonStandrad.getString("subsidiary_company"));
				vpd.put("var4", nonStandrad.getString("project_address"));
				vpd.put("var5", nonStandrad.getString("project_area"));
				vpd.put("var6", nonStandrad.getString("operate_name"));
				vpd.put("var7", nonStandrad.getString("operate_date"));
				vpd.put("var8", nonStandrad.getString("lift_name"));
				vpd.put("var9", nonStandrad.getString("rated_load"));
				vpd.put("var10", nonStandrad.getString("lift_c")+"/"+nonStandrad.getString("lift_z")+"/"+nonStandrad.getString("lift_m"));
				vpd.put("var11", nonStandrad.getString("lift_speed"));
				vpd.put("var12", nonStandrad.getString("pit_depth"));
				vpd.put("var13", nonStandrad.getString("headroom_height"));
				vpd.put("var14", nonStandrad.getString("traveling_height"));
				vpd.put("var15", nonStandrad.getString("well_depth"));
				vpd.put("var16", nonStandrad.getString("opening_width"));
				vpd.put("var17", nonStandrad.getString("car_size"));
				vpd.put("var18", nonStandrad.getString("lift_angle"));
				vpd.put("var19", nonStandrad.getString("step_width"));
				vpd.put("var20", nonStandrad.getString("car_height"));
				vpd.put("var21", nonStandrad.getString("lift_num"));
				if(StringUtils.isNoneBlank(nonStandrad.getString("JDK"))
						|| StringUtils.isNoneBlank(nonStandrad.getString("JDS"))){
					vpd.put("var22", nonStandrad.getString("JDK")+"x"+nonStandrad.getString("JDS"));
				} else {
					vpd.put("var22", "");
				}
				vpd.put("var23", nonStandrad.getString("kmxs"));
				vpd.put("var24", nonStandrad.getString("sptj"));
				vpd.put("var25", nonStandrad.getString("TJTTH"));
				vpd.put("var26", nonStandrad.getString("NON_BZ"));
				String instanceStatus = nonStandrad.getString("instance_status");
				if("1".equals(instanceStatus)) {
					vpd.put("var27", "待启动");
				} else if("2".equals(instanceStatus)) {
					vpd.put("var27", "待审核");
				} else if("3".equals(instanceStatus)) {
					vpd.put("var27", "审核中");
				} else if("4".equals(instanceStatus)) {
					vpd.put("var27", "已通过");
				} else if("5".equals(instanceStatus)) {
					vpd.put("var27", "被驳回");
				} else if("6".equals(instanceStatus)) {
					vpd.put("var27", "已通过");
				} else {
					vpd.put("var27", "");
				}
				vpd.put("var28", getDictNameOfValue(dictList, nonStandrad.getString("nonstandrad_spec"), nonStandrad.getString("nonstandrad_spec")));
				vpd.put("var29", nonStandrad.getString("nonstandrad_describe"));
				vpd.put("var30", nonStandrad.getString("nonstandrad_handle"));
				vpd.put("var31", "1".equals(nonStandrad.getString("nonstandrad_valid"))?"是":"否");
				if(isqxShow == 1) {
					vpd.put("var32", nonStandrad.getString("nonstandrad_CJ"));
					vpd.put("var33", nonStandrad.getString("nonstandrad_JCB"));
					vpd.put("var34", nonStandrad.getString("nonstandrad_JJ"));
					vpd.put("var35", nonStandrad.getString("nonstandrad_JLDW"));
					vpd.put("var36", nonStandrad.getString("nonstandrad_DTYL"));
					vpd.put("var37", nonStandrad.getString("nonstandrad_DTBJ"));
					//vpd.put("var38", nonStandrad.getString("nonstandrad_ZJ"));
					String kdz = nonStandrad.getString("nonstandrad_KDZ");
					vpd.put("var38", "1".equals(kdz)?"是":"2".equals(kdz)?"否":"");
					vpd.put("var39", nonStandrad.getString("nonstandrad_BZ"));
				} else {
					vpd.put("var32", nonStandrad.getString("nonstandrad_JJ"));
					vpd.put("var33", nonStandrad.getString("nonstandrad_JLDW"));
					vpd.put("var34", nonStandrad.getString("nonstandrad_DTYL"));
					vpd.put("var35", nonStandrad.getString("nonstandrad_DTBJ"));
					//vpd.put("var36", nonStandrad.getString("nonstandrad_ZJ"));
					String kdz = nonStandrad.getString("nonstandrad_KDZ");
					vpd.put("var36", "1".equals(kdz)?"是":"2".equals(kdz)?"否":"");
					vpd.put("var37", nonStandrad.getString("nonstandrad_BZ"));
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
	
	private String getDictNameOfValue(List<Dict> dictList, String v, String defaultLabel) {
    	for (Dict dict : dictList) {
			if(StringUtils.equals(dict.getValue(), v)) {
				return dict.getName();
			}
		}
    	return defaultLabel;
    }
	
    @RequestMapping(value="getBjcs")
    @ResponseBody
	public Map<String, Object> getBjcsForMasterIdAndItemId() {
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();

    	try {
			List<PageData> bjcs = nonStandradService.findBjcsForMasterIdAndItemId(pd);
			returnMap.put("bjcs", bjcs);
			returnMap.put("code", 1);
		} catch (Exception e) {
			returnMap.put("code", 0);
			e.printStackTrace();
		}
    	
    	
		return returnMap;
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
    /* ===============================权限================================== */
    @SuppressWarnings("unchecked")
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }

    private String getCostReadRight(){
        //获取当前登陆用户信息
        Subject currentUser=SecurityUtils.getSubject();
        Session session=currentUser.getSession();
        PageData pds=new PageData();
        pds=(PageData) session.getAttribute("userpds");
        //获取当前登陆用户用户组信息

        String costread="";
        try{

            List<String> rolelist= Arrays.asList(pds.getString("ROLE_ID").split(","));
            for (String roleid:rolelist){
                if("1".equals(roleid)){
                    costread="1";
                }
            }
            if(!costread.equals("1")){
                List<PageData> prolelist=nonStandradService.getParentRoleByUserid(rolelist);
                for (PageData rpd:prolelist){
                    if(rpd.getString("ROLE_NAME").equals("财务部")
                            ||rpd.getString("ROLE_NAME").equals("采购部")
                            ||rpd.getString("ROLE_NAME").equals("技术部")){
                        costread="1";
                    }
                }
            }
        }catch (Exception e){
            costread="3";
            e.printStackTrace();
        }
        return costread;
    }

    private List<Map> getViewHistory(String processInstanceId) throws Exception{
        WorkFlow workFlow = new WorkFlow();
        //获取历史instance记录
        List<HistoricProcessInstance> historicProcessInstances = workFlow.getHistoryService().
                                                                    createHistoricProcessInstanceQuery().
                                                                    processInstanceId(processInstanceId).list();

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
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    
    private String isCaiwuRole(String USER_ID) throws Exception {
    	//是否是财务角色
        PageData cwpd = new PageData();
        cwpd.put("user_id", USER_ID);
        cwpd.put("role_name", "财务");
        List<PageData> cwuserList = nonStandradService.findUserForRoleName(cwpd);
        if(cwuserList != null && cwuserList.size() > 0) {
        	return "1";
        }
        return "";
    }

}

