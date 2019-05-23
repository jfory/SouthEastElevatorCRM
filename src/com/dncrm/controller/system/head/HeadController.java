package com.dncrm.controller.system.head;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.system.Menu;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.contractModify.ContractModifyService;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.newInvoice.NewInvoiceService;
import com.dncrm.service.system.nonstandrad.NonStandradService;
import com.dncrm.service.system.sysAgent.SysAgentService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;
import com.dncrm.util.SmsUtil;
import com.dncrm.util.Tools;
import com.dncrm.util.Watermark;
import com.dncrm.util.mail.SimpleMailSender;

import net.sf.json.JSONArray;

/**
 * 类名称：HeadController
 * 创建人：Simon
 * 创建时间：2014年8月16日
 */
@Controller
@RequestMapping(value = "/head")
public class HeadController extends BaseController {

    @Resource(name = "sysUserService")
    private sysUserService sysUserService;
    @Resource(name="e_offerService")
   	private E_offerService e_offerService;
    @Resource(name="contractNewService")
	private ContractNewService contractNewService;
    @Resource(name="contractNewAzService")
	private ContractNewAzService contractNewAzService;
    @Resource(name = "contractModifyService")
	private ContractModifyService contractModifyService;
    @Resource(name="nonStandradService")
    private NonStandradService nonStandradService;
    @Resource(name="itemService")
	private ItemService itemService;
    @Resource(name = "newInvoiceService")
    private NewInvoiceService newInvoiceService;
    @Resource(name="departmentService")
	private DepartmentService departmentService;
    @Resource(name = "sysAgentService")
    private SysAgentService sysAgentService;
    
    //保存所有父节点
    private List<PageData> parentDepartments = new ArrayList<PageData>();
    /**
     * 获取头部信息
     */
    @RequestMapping(value = "/getUname")
    @ResponseBody
    public Object getList() {
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();

            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");

            if (null == pds) {
                String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();    //获取当前登录者loginname
                pd.put("USERNAME", USERNAME);
                pds = sysUserService.findByUId(pd);
                session.setAttribute("userpds", pds);
            }

            pdList.add(pds);
            map.put("list", pdList);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 保存皮肤
     */
    @RequestMapping(value = "/setSKIN")
    public void setSKIN(PrintWriter out) {
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();

            String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();//获取当前登录者loginname
            pd.put("USERNAME", USERNAME);
            sysUserService.setSKIN(pd);
            session.removeAttribute(Const.SESSION_userpds);
            session.removeAttribute(Const.SESSION_USERROL);
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }

    /**
     * 去编辑邮箱页面
     */
    @RequestMapping(value = "/editEmail")
    public ModelAndView editEmail() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/head/edit_email");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 去发送短信页面
     */
    @RequestMapping(value = "/goSendSms")
    public ModelAndView goSendSms() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/head/send_sms");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 发送短信
     */
    @RequestMapping(value = "/sendSms")
    @ResponseBody
    public Object sendSms() {
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        String msg = "ok";        //发送状态
        int count = 0;            //统计发送成功条数
        int zcount = 0;            //理论条数


        List<PageData> pdList = new ArrayList<PageData>();

        String PHONEs = pd.getString("PHONE");                    //对方邮箱
        String CONTENT = pd.getString("CONTENT");                //内容
        String isAll = pd.getString("isAll");                    //是否发送给全体成员 yes or no
        String TYPE = pd.getString("TYPE");                        //类型 1：短信接口1   2：短信接口2
        String fmsg = pd.getString("fmsg");                        //判断是系统用户还是会员 "appuser"为会员用户


        if ("yes".endsWith(isAll)) {
            try {
                List<PageData> userList = new ArrayList<PageData>();

                userList =  sysUserService.listAllUser(pd);

                zcount = userList.size();
                try {
                    for (int i = 0; i < userList.size(); i++) {
                        if (Tools.checkMobileNumber(userList.get(i).getString("PHONE"))) {            //手机号格式不对就跳过
                            if ("1".equals(TYPE)) {
                                SmsUtil.sendSms1(userList.get(i).getString("PHONE"), CONTENT);        //调用发短信函数1
                            } else {
                                SmsUtil.sendSms2(userList.get(i).getString("PHONE"), CONTENT);        //调用发短信函数2
                            }
                            count++;
                        } else {
                            continue;
                        }
                    }
                    msg = "ok";
                } catch (Exception e) {
                    msg = "error";
                }

            } catch (Exception e) {
                msg = "error";
            }
        } else {
            PHONEs = PHONEs.replaceAll("；", ";");
            PHONEs = PHONEs.replaceAll(" ", "");
            String[] arrTITLE = PHONEs.split(";");
            zcount = arrTITLE.length;
            try {
                for (int i = 0; i < arrTITLE.length; i++) {
                    if (Tools.checkMobileNumber(arrTITLE[i])) {            //手机号式不对就跳过
                        if ("1".equals(TYPE)) {
                            SmsUtil.sendSms1(arrTITLE[i], CONTENT);        //调用发短信函数1
                        } else {
                            SmsUtil.sendSms2(arrTITLE[i], CONTENT);        //调用发短信函数2
                        }
                        count++;
                    } else {
                        continue;
                    }
                }
                msg = "ok";
            } catch (Exception e) {
                msg = "error";
            }
        }
        pd.put("msg", msg);
        pd.put("count", count);                        //成功数
        pd.put("ecount", zcount - count);                //失败数
        pdList.add(pd);
        map.put("list", pdList);
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 去发送电子邮件页面
     */
    @RequestMapping(value = "/goSendEmail")
    public ModelAndView goSendEmail() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/head/send_email");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 发送电子邮件
     */
    @RequestMapping(value = "/sendEmail")
    @ResponseBody
    public Object sendEmail() {
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        String msg = "ok";        //发送状态
        int count = 0;            //统计发送成功条数
        int zcount = 0;            //理论条数

        String strEMAIL = Tools.readTxtFile(Const.EMAIL);        //读取邮件配置

        List<PageData> pdList = new ArrayList<PageData>();

        String toEMAIL = pd.getString("EMAIL");                    //对方邮箱
        String TITLE = pd.getString("TITLE");                    //标题
        String CONTENT = pd.getString("CONTENT");                //内容
        String TYPE = pd.getString("TYPE");                        //类型
        String isAll = pd.getString("isAll");                    //是否发送给全体成员 yes or no

        String fmsg = pd.getString("fmsg");                        //判断是系统用户还是会员 "appuser"为会员用户

        if (null != strEMAIL && !"".equals(strEMAIL)) {
            String strEM[] = strEMAIL.split(",DNCRM,");
            if (strEM.length == 4) {
                if ("yes".endsWith(isAll)) {
                    try {
                        List<PageData> userList = new ArrayList<PageData>();

                        userList = sysUserService.listAllUser(pd);

                        zcount = userList.size();
                        try {
                            for (int i = 0; i < userList.size(); i++) {
                                if (Tools.checkEmail(userList.get(i).getString("EMAIL"))) {        //邮箱格式不对就跳过
                                    SimpleMailSender.sendEmail(strEM[0], strEM[1], strEM[2], strEM[3], userList.get(i).getString("EMAIL"), TITLE, CONTENT, TYPE);//调用发送邮件函数
                                    count++;
                                } else {
                                    continue;
                                }
                            }
                            msg = "ok";
                        } catch (Exception e) {
                            msg = "error";
                        }

                    } catch (Exception e) {
                        msg = "error";
                    }
                } else {
                    toEMAIL = toEMAIL.replaceAll("；", ";");
                    toEMAIL = toEMAIL.replaceAll(" ", "");
                    String[] arrTITLE = toEMAIL.split(";");
                    zcount = arrTITLE.length;
                    try {
                        for (int i = 0; i < arrTITLE.length; i++) {
                            if (Tools.checkEmail(arrTITLE[i])) {        //邮箱格式不对就跳过
                                SimpleMailSender.sendEmail(strEM[0], strEM[1], strEM[2], strEM[3], arrTITLE[i], TITLE, CONTENT, TYPE);//调用发送邮件函数
                                count++;
                            } else {
                                continue;
                            }
                        }
                        msg = "ok";
                    } catch (Exception e) {
                        msg = "error";
                    }
                }
            } else {
                msg = "error";
            }
        } else {
            msg = "error";
        }
        pd.put("msg", msg);
        pd.put("count", count);                        //成功数
        pd.put("ecount", zcount - count);                //失败数
        pdList.add(pd);
        map.put("list", pdList);

        return AppUtil.returnObject(pd, map);
    }


    /**
     * 去系统设置页面
     */
    @RequestMapping(value = "/goSystem")
    public ModelAndView goEditEmail() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("YSYNAME", Tools.readTxtFile(Const.SYSNAME));    //读取系统名称
        pd.put("COUNTPAGE", Tools.readTxtFile(Const.PAGE));        //读取每页条数
        String strEMAIL = Tools.readTxtFile(Const.EMAIL);        //读取邮件配置
        String strSMS1 = Tools.readTxtFile(Const.SMS1);            //读取短信1配置
        String strSMS2 = Tools.readTxtFile(Const.SMS2);            //读取短信2配置
        String strFWATERM = Tools.readTxtFile(Const.FWATERM);    //读取文字水印配置
        String strIWATERM = Tools.readTxtFile(Const.IWATERM);    //读取图片水印配置
        pd.put("Token", Tools.readTxtFile(Const.WEIXIN));        //读取微信配置

        if (null != strEMAIL && !"".equals(strEMAIL)) {
            String strEM[] = strEMAIL.split(",DNCRM,");
            if (strEM.length == 4) {
                pd.put("SMTP", strEM[0]);
                pd.put("PORT", strEM[1]);
                pd.put("EMAIL", strEM[2]);
                pd.put("PAW", strEM[3]);
            }
        }

        if (null != strSMS1 && !"".equals(strSMS1)) {
            String strS1[] = strSMS1.split(",DNCRM,");
            if (strS1.length == 2) {
                pd.put("SMSU1", strS1[0]);
                pd.put("SMSPAW1", strS1[1]);
            }
        }

        if (null != strSMS2 && !"".equals(strSMS2)) {
            String strS2[] = strSMS2.split(",DNCRM,");
            if (strS2.length == 2) {
                pd.put("SMSU2", strS2[0]);
                pd.put("SMSPAW2", strS2[1]);
            }
        }

        if (null != strFWATERM && !"".equals(strFWATERM)) {
            String strFW[] = strFWATERM.split(",DNCRM,");
            if (strFW.length == 5) {
                pd.put("isCheck1", strFW[0]);
                pd.put("fcontent", strFW[1]);
                pd.put("fontSize", strFW[2]);
                pd.put("fontX", strFW[3]);
                pd.put("fontY", strFW[4]);
            }
        }

        if (null != strIWATERM && !"".equals(strIWATERM)) {
            String strIW[] = strIWATERM.split(",DNCRM,");
            if (strIW.length == 4) {
                pd.put("isCheck2", strIW[0]);
                pd.put("imgUrl", strIW[1]);
                pd.put("imgX", strIW[2]);
                pd.put("imgY", strIW[3]);
            }
        }

        mv.setViewName("system/head/sys_edit");
        mv.addObject("pd", pd);

        return mv;
    }

    /**
     * 保存系统设置1
     */
    @RequestMapping(value = "/saveSys")
    public ModelAndView saveSys() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            Tools.writeFile(Const.SYSNAME, pd.getString("YSYNAME"));    //写入系统名称
            Tools.writeFile(Const.PAGE, pd.getString("COUNTPAGE"));    //写入每页条数
            Tools.writeFile(Const.EMAIL, pd.getString("SMTP") + ",DNCRM," + pd.getString("PORT") + ",DNCRM," + pd.getString("EMAIL") + ",DNCRM," + pd.getString("PAW"));    //写入邮件服务器配置
            Tools.writeFile(Const.SMS1, pd.getString("SMSU1") + ",DNCRM," + pd.getString("SMSPAW1"));    //写入短信1配置
            Tools.writeFile(Const.SMS2, pd.getString("SMSU2") + ",DNCRM," + pd.getString("SMSPAW2"));    //写入短信2配置
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "修改系统设置1失败！");
        }
        mv.addObject("id", "EditSys");
        mv.addObject("form", "Form");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存系统设置2
     */
    @RequestMapping(value = "/saveSys2")
    public ModelAndView saveSys2() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            Tools.writeFile(Const.FWATERM, pd.getString("isCheck1") + ",DNCRM," + pd.getString("fcontent") + ",DNCRM," + pd.getString("fontSize") + ",DNCRM," + pd.getString("fontX") + ",DNCRM," + pd.getString("fontY"));    //文字水印配置
            Tools.writeFile(Const.IWATERM, pd.getString("isCheck2") + ",DNCRM," + pd.getString("imgUrl") + ",DNCRM," + pd.getString("imgX") + ",DNCRM," + pd.getString("imgY"));    //图片水印配置
            Watermark.fushValue();
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "修改系统设置2失败！");
        }

        mv.addObject("id", "EditSys");
        mv.addObject("form", "Form2");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存系统设置3
     */
    @RequestMapping(value = "/saveSys3")
    public ModelAndView saveSys3() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            Tools.writeFile(Const.WEIXIN, pd.getString("Token"));    //写入微信配置
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "保存系统设置3失败！");
        }
        mv.addObject("id", "EditSys");
        mv.addObject("form", "Form3");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 去代码生成器页面
     */
    @RequestMapping(value = "/goProductCode")
    public ModelAndView goProductCode() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("system/head/productCode");
        return mv;
    }

    /**
     * 去webim页面
     */
    @RequestMapping(value = "/goWebIM")
    public ModelAndView goWebIM() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("system/webim/index");
        return mv;
    }

    /**
     * 去layim页面
     */
    @RequestMapping(value = "/goLayIM")
    public ModelAndView goLayIM() throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("system/layim/index");
        return mv;
    }

    /**
     * 去默认页面
     */
    @RequestMapping(value = "/goDefault")
    public ModelAndView goDefault() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        SelectByRole sbr = new SelectByRole();
        pd.put("input_user", getUser().getUSER_ID());
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
        //找到滞留项目
        String zltype= "滞留";
        pd.put("zltype", zltype);
        String itemCount = itemService.listPageAllItemByRoleCount(pd);
        //找到应收款项 默认7天
        String DQTS = "7";
        pd.put("DQTS", DQTS);
        String yskCount = contractNewAzService.yskCount(pd);
        mv.addObject("itemCount", itemCount);
        mv.addObject("yskCount", yskCount);
        
        List<Menu> menuList=this.getQX();
        //找到有权限的菜单
        String caidan = "";
        for(int i=0;i<menuList.size();i++){
        	List<Menu> subcaidan=menuList.get(i).getSubMenu();
        	for(int j=0;j<subcaidan.size();j++) {
        		if(subcaidan.get(j).isHasMenu()) {
        			caidan += subcaidan.get(j).getMENU_NAME()+",";
        		}
        	 }
        	}     
        //调用获取待办任务的方法
		List<PageData> Tasks=null;//Tasks();
        mv.addObject("Tasks", Tasks);
        mv.addObject("caidan", caidan);
        mv.addObject("DQTS", DQTS);
        mv.setViewName("system/admin/default");
        mv.addObject("pd", pd);
        return mv;
    }
    
   
    
    
    /**
     * 重新加载
     */
    @RequestMapping(value = "/goDefaultc")
    public ModelAndView goDefaultc() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData(); 
        SelectByRole sbr = new SelectByRole();
        pd.put("input_user", getUser().getUSER_ID());
		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
		pd.put("userList", userList);
        //找到滞留项目
        String zltype= "滞留";
        pd.put("zltype", zltype);
        String itemCount = itemService.listPageAllItemByRoleCount(pd);
        //找到应收款项 前台代入
        String DQTS = pd.getString("DQTS");
        String yskCount = contractNewAzService.yskCount(pd);
        mv.addObject("itemCount", itemCount);
        mv.addObject("yskCount", yskCount);
        mv.addObject("DQTS", DQTS);
        
        
        List<Menu> menuList=this.getQX();
        //找到有权限的菜单
        String caidan = "";
        for(int i=0;i<menuList.size();i++){
        	List<Menu> subcaidan=menuList.get(i).getSubMenu();
        	for(int j=0;j<subcaidan.size();j++) {
        		if(subcaidan.get(j).isHasMenu()) {
        			caidan += subcaidan.get(j).getMENU_NAME()+",";
        		}
        	 }
        	}     
        //调用获取待办任务的方法
		List<PageData> Tasks=null;//Tasks();
        mv.addObject("Tasks", Tasks);
        mv.setViewName("system/admin/default");
        mv.addObject("caidan", caidan);
        mv.addObject("pd", pd);
        return mv;
    }
    
    
    /**
	 * 列出当前登录人的待办事项
	 * Stone 2018-01-02
	 */
	public List<PageData> Tasks() throws Exception
	{
		 
       Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute("sessionUser");
        String USER_ID = user.getUSER_ID();

        SelectByRole sbr = new SelectByRole();

		WorkFlow workFlow = new WorkFlow();
		//存放任务集合
        List<PageData> consultApplys = new ArrayList<>();
        try 
        {
        	//--------------------------报价模块  
        	//根据user_id和流程的key获取任务
        	//非货梯折扣审核流程
            /*List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguifeihuoti").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount.size()!=0)
            {
            	   for (Task task : toHandleListCount) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        //根据uuiid查询信息
                        consultApply = e_offerService.findByuuId(consultApply);
                        if(consultApply!=null) {
                            consultApply.put("item_name", consultApply.getString("item_name"));
                            consultApply.put("TASK_TIME", consultApply.getString("offer_date"));
                            consultApply.put("user_name", consultApply.getString("USERNAME"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            consultApply.put("TASK_TYPE", "1");//任务类型 1报价折扣审核
                        }
                    }
                    consultApplys.add(consultApply);
                }
            }*/

            List<String> userList = sbr.findUserList(getUser().getUSER_ID());
          
            //常规货梯折扣审核流程
            List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguihuoti").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount2.size()!=0)
            {
            	   for (Task task : toHandleListCount2) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList", userList);
                        //根据uuiid查询信息
                        consultApply = e_offerService.findByuuId(consultApply);
                        if(consultApply!=null && StringUtils.isNoneBlank(consultApply.getString("item_name"))) {
                            consultApply.put("item_name", consultApply.getString("item_name"));
                            consultApply.put("TASK_TIME", consultApply.getString("offer_date"));
                            consultApply.put("user_name", consultApply.getString("USERNAME"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            if(task.getAssignee()!=null){
                            	consultApply.put("type","1");//待处理
	  						}else{
  							  	consultApply.put("type","0");//待签收
	  						}
                            consultApply.put("TASK_TYPE", "1");//任务类型 1报价折扣审核
                            consultApplys.add(consultApply);
                        }else{
                            continue;
                        }
                    }
                }
            }
            
          //分包商审核审核流程
            /*List<Task> toHandleListCount10 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("contractor").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount10.size()!=0)
            {
            	   for (Task task : toHandleListCount10) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        //根据uuiid查询信息
                        consultApply = sysAgentService.findById(consultApply);
                        if(consultApply!=null) {
                            consultApply.put("item_name", consultApply.getString("item_name"));
                            consultApply.put("TASK_TIME", consultApply.getString("offer_date"));
                            consultApply.put("user_name", consultApply.getString("USERNAME"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            consultApply.put("TASK_TYPE", "2");//任务类型 1报价折扣审核
                        }else{
                            continue;
                        }
                    }
                    consultApplys.add(consultApply);
                }
            }*/
            
            //代理商审核审核流程
            List<Task> toHandleListCount11 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("agent").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount11.size()!=0)
            {
            	   for (Task task : toHandleListCount11) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList", userList);
                        //根据uuiid查询信息
                        consultApply = sysAgentService.findAById(consultApply);
                        if(consultApply!=null) {
                            consultApply.put("item_name", consultApply.getString("agent_name"));
                            consultApply.put("TASK_TIME", consultApply.getString("create_time"));
                            consultApply.put("user_name", consultApply.getString("USERNAME"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            if(task.getAssignee()!=null){
                            	consultApply.put("type","1");//待处理
	  						}else{
  							  	consultApply.put("type","0");//待签收
	  						}
                            consultApply.put("TASK_TYPE", "3");//任务类型 1报价折扣审核
                        }else{
                            continue;
                        }
                    }
                    consultApplys.add(consultApply);
                }
            }
            
            //设备合同审核流程
            List<Task> toHandleListCount3 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNew").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount3.size()!=0)
            {
            	   for (Task task : toHandleListCount3) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList",userList);
                        if(consultApply.get("HT_UUID")!="" && consultApply.get("HT_UUID")!=null) 
                        {
                        	//根据uuiid查询信息
                            consultApply = contractNewService.findSoConByUUid(consultApply);
                            if(consultApply!=null) {
                                consultApply.put("item_name", consultApply.getString("item_name"));
                                consultApply.put("TASK_TIME", consultApply.getString("INPUT_TIME"));
                                consultApply.put("user_name", consultApply.getString("user_name"));
                                consultApply.put("task_name", task.getName());
                                consultApply.put("task_id", task.getId());
                                if(task.getAssignee()!=null){
                                	consultApply.put("type","1");//待处理
    	  						}else{
      							  	consultApply.put("type","0");//待签收
    	  						}
                                consultApply.put("TASK_TYPE", "4");//任务类型 4.设备合同审核

                                consultApplys.add(consultApply);
                            }
                        }
                        
                    }
                   
                }
            }
            
            //安装合同审核流程
            List<Task> toHandleListCount4 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNewAZ").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount4.size()!=0)
            {
            	   for (Task task : toHandleListCount4) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList",userList);
                        if(consultApply.get("AZ_UUID")!="" && consultApply.get("AZ_UUID")!=null) 
                        {
                        	//根据uuiid查询信息
                            consultApply = contractNewAzService.findAzConByUUid(consultApply);
                            if(consultApply!=null) {
                                consultApply.put("item_name", consultApply.getString("item_name"));
                                consultApply.put("TASK_TIME", consultApply.getString("INPUT_TIME"));
                                consultApply.put("user_name", consultApply.getString("user_name"));
                                consultApply.put("task_name", task.getName());
                                consultApply.put("task_id", task.getId());
                                if(task.getAssignee()!=null){
                                	consultApply.put("type","1");//待处理
    	  						}else{
      							  	consultApply.put("type","0");//待签收
    	  						}
                                consultApply.put("TASK_TYPE", "5");//任务类型 5.安装合同审核

                                consultApplys.add(consultApply);
                            }
                        }
                        
                    }
                    
                }
            }
            
           //变更协议审核流程
            List<Task> toHandleListCount5 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractModify").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount5.size()!=0)
            {
            	   for (Task task : toHandleListCount5) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList",userList);
                    	//根据uuiid查询信息
                        consultApply = contractModifyService.findContractModify(consultApply);
                        if(consultApply!=null){
                        	consultApply.put("modify_id",consultApply.getNoneNULLString("id"));
                            consultApply.put("item_name",consultApply.getString("item_name"));
                            consultApply.put("TASK_TIME",consultApply.getString("input_date"));
                            consultApply.put("user_name",consultApply.getString("NAME"));
                            consultApply.put("task_name",task.getName());
                            consultApply.put("task_id",task.getId());
                            if(task.getAssignee()!=null){
                            	consultApply.put("type","1");//待处理
	  						}else{
  							  	consultApply.put("type","0");//待签收
	  						}
                            consultApply.put("TASK_TYPE","6");//任务类型 6.变更协议审核

                            consultApplys.add(consultApply);
                        }
                    }
                    
                }
            }

            //非标审核流程
            List<Task> toHandleListCount6 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("nonStandrad").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount6.size()!=0)
            {
                for (Task task : toHandleListCount6)
                {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList",userList);
                        //根据uuiid查询信息
                        consultApply = nonStandradService.findNonStandradMasterById(consultApply);
                        if(consultApply!=null) {
                            consultApply.put("item_name", consultApply.getString("project_name"));
                            consultApply.put("TASK_TIME", consultApply.getString("operate_date"));
                            consultApply.put("user_name", consultApply.getString("operate_name"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            if(task.getAssignee()!=null){
                            	consultApply.put("type","1");//待处理
	  						}else{
  							  	consultApply.put("type","0");//待签收
	  						}
                            consultApply.put("TASK_TYPE", "7");//任务类型 7.非标审核流程

                            consultApplys.add(consultApply);
                        }
                    }

                }
            }
            
          //项目跨区审核流程
            List<Task> toHandleListCount7 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("CrossZone").orderByTaskCreateTime().desc().active().list();
            if(toHandleListCount7.size()!=0)
            {
            	   for (Task task : toHandleListCount7) 
                   {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {
                    	//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                             //111
                        	//根据uuiid查询信息
                            consultApply = itemService.findItemByUUid(consultApply);
                            //判断当前登录人是否有权限查看该条待办理数据
                            parentDepartments=new ArrayList<PageData>();

                            if(consultApply!=null) {
                                PageData kqPd=new PageData();
                                kqPd.put("item_id", consultApply.getString("item_id"));
                                kqPd.put("user_id", USER_ID);
                                String kqqx=kqqx(kqPd);
                            	if(kqqx!=null && kqqx.equals("success")){
                                	consultApply.put("item_name", consultApply.getString("item_name"));
                                    consultApply.put("TASK_TIME", consultApply.getString("input_date"));
                                    consultApply.put("user_name", consultApply.getString("user_name"));
                                    consultApply.put("task_name", task.getName());
                                    consultApply.put("task_id", task.getId());
                                    if(task.getAssignee()!=null){
                                    	consultApply.put("type","1");//待处理
        	  						}else{
          							  	consultApply.put("type","0");//待签收
        	  						}
                                    consultApply.put("TASK_TYPE", "8");//任务类型 8.项目跨区审核流程

                                    consultApply.put("HTLRSJ", "");

                                    consultApplys.add(consultApply);
                                } 
                            }  
                    }
                   
                }
            }

            //开票审核流程
            List<Task> toHandleListCount8 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("SubInvoice").orderByTaskCreateTime().desc().active().list();
            List<Task> toHandleListCount9 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("JscInvoice").orderByTaskCreateTime().desc().active().list();
            if (toHandleListCount8!=null){
                toHandleListCount8.addAll(toHandleListCount9);
            }
            if(toHandleListCount8.size()!=0)
            {
                for (Task task : toHandleListCount8)
                {
                    PageData consultApply = new PageData();
                    String processInstanceId = task.getProcessInstanceId();
                    ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                    String businessKey = processInstance.getBusinessKey();
                    if (!StringUtils.isEmpty(businessKey))
                    {//leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        consultApply.put(info[1],info[2]);
                        consultApply.put("userList",userList);
                        consultApply = newInvoiceService.findInvoice(consultApply);
                        if(consultApply!=null) {
                            consultApply.put("item_name", consultApply.getString("item_name"));
                            consultApply.put("invoice_id", consultApply.getString("id"));
                            consultApply.put("TASK_TIME", consultApply.getString("input_date"));
                            consultApply.put("user_name", consultApply.getString("NAME"));
                            consultApply.put("task_name", task.getName());
                            consultApply.put("task_id", task.getId());
                            if(task.getAssignee()!=null){
                            	consultApply.put("type","1");//待处理
	  						}else{
  							  	consultApply.put("type","0");//待签收
	  						}
                            consultApply.put("TASK_TYPE", "9");//任务类型 8.开票审核流程

                            consultApplys.add(consultApply);
                        }
                    }
                }
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return consultApplys;
	}
    
	//跨区项目审核权限
	public String kqqx(PageData pd)
    {
    	String kqshqx = null;
    	try {
    		PageData itemPd=new PageData();
        	PageData userPd=new PageData();
    		//获取项目所属分公司id
			itemPd= itemService.getFgsIdByItemId(pd);
			String itemfromfgs=itemPd.getString("itemsubbranch");
			//
			PageData parentPd=new PageData();
			parentPd.put("parentId", itemfromfgs);
			List<PageData> parentNodes = getAllParentDepartments(parentPd);
			//获取登录人所属分公司id
			userPd= itemService.getFgsIdByUserId(pd);
			String userfromfgs=userPd.getString("parentId");
			for(PageData forPd : parentNodes)
			{
				if(userfromfgs.equals(forPd.get("id").toString()))
				{
					kqshqx="success";
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return kqshqx;
    }

    @SuppressWarnings("unchecked")
    @RequestMapping("/getTaskData")
    @ResponseBody
    public Object getTaskData(){
    	PageData pd = this.getPageData();
        List<PageData> tasklist=new ArrayList<PageData>();
	    try {
	    	if(StringUtils.isNoneBlank(pd.getString("project_name"))
	    			|| StringUtils.isNoneBlank(pd.getString("task_type"))){
	    		
	    		tasklist = sreachTask(pd.getString("project_name"), pd.getString("task_type"));
	    		
	    	} else {
	             tasklist=Tasks();
	    	}
            // Collections.sort(tasklist,new MyComparator());
        }catch (Exception e){
	        e.printStackTrace();
        }

        return JSONArray.fromObject(tasklist).toString();
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
    
    public List<PageData> sreachTask(String projectName, String taskType){
    	Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute("sessionUser");
        String USER_ID = user.getUSER_ID();

        SelectByRole sbr = new SelectByRole();

		//存放任务集合
        List<PageData> consultApplys = new ArrayList<>();

        PageData pd = new PageData();
        pd.put("project_name", projectName);
        pd.put("user_id", USER_ID);
        
        try {
            List<String> userList = sbr.findUserList(getUser().getUSER_ID());
            pd.put("userList", userList);
            
			if("1".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//报价折扣审核
				List<PageData> agentPage = e_offerService.findAuditOfferPage(pd);
				consultApplys.addAll(agentPage);
			}
			
			if("3".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//代理商审核
				pd.put("agent_name", projectName);
				List<PageData> agentPage = sysAgentService.findAuditAgentPage(pd);
				consultApplys.addAll(agentPage);
			}

			if("4".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//设备合同审核
				
                List<PageData> contractNewPage = contractNewService.findAuditContractNewPage(pd);
                consultApplys.addAll(contractNewPage);
			}

			if("5".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//安装合同审核
				List<PageData> contractNewAzPage = contractNewAzService.findAuditContractNewAzPage(pd);
                consultApplys.addAll(contractNewAzPage);
			}

			if("6".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//变更协议审核
				List<PageData> modifyPage = contractModifyService.findAuditcontractModifyPage(pd);
				consultApplys.addAll(modifyPage);
			}

			if("7".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//非标申请审核
				pd.put("process_definition_key", "nonStandrad");
				List<PageData> nonstandradPage = nonStandradService.findAuditNonstandradPage(pd);
				consultApplys.addAll(nonstandradPage);
			}

			if("8".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//项目报备跨区审核
				List<PageData> itemPage = itemService.findAuditItemPage(pd);
				consultApplys.addAll(itemPage);
			}

			if("9".equals(taskType) 
					|| StringUtils.isBlank(taskType)) {//开票审核
				List<PageData> invoicePage = newInvoiceService.findAuditNewInvoicePage(pd);
				consultApplys.addAll(invoicePage);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	
		return consultApplys;
    }
    
	
	  /* ===============================权限================================== */
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
    /* ===============================用户================================== */
    @SuppressWarnings("unchecked")
	public  List<Menu> getQX() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<Menu>) session.getAttribute(Const.SESSION_menuList);
      
    }
}

class MyComparator implements Comparator<PageData>{

    @Override
    public int compare(PageData o1, PageData o2) {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
        int retval=0;
        Date dt1,dt2;
        try {
            if(o1.getString("TASK_TIME").length()==10){
                dt1=sdf1.parse(o1.getString("TASK_TIME"));
            }else {
               dt1 =sdf.parse(o1.getString("TASK_TIME"));
            }
            if(o2.getString("TASK_TIME").length()==10){
                dt2=sdf1.parse(o1.getString("TASK_TIME"));
            }else {
                dt2=sdf.parse(o2.getString("TASK_TIME"));
            }
            if(dt1.getTime()>dt2.getTime()){
                retval=-1;
            }else if(dt1.getTime()<dt2.getTime()){
                retval=1;
            }
        }catch (Exception e){
            e.printStackTrace();
            return retval;
        }
        return retval;
    }
}
