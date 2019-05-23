package com.dncrm.controller.system.synUser;

import com.dncrm.common.WorkFlow;
import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.dao.SqlServerDaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.listener.SynUserListener;
import com.dncrm.service.system.synUser.synUserService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.PageData;
import net.sf.json.JSONObject;
import org.activiti.engine.impl.persistence.entity.UserEntity;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 *类名:SynUserController 
 * 创建人:Arisu
 * 创建时间:2016年9月1日
 */
@Controller
@RequestMapping(value = "/synUser")
public class SynUserController extends BaseController{
	
	@Resource(name="synUserService")
	private synUserService synUserService;
	@Resource(name="sysUserService")
	private sysUserService sysUserService;
	@Resource(name="sqlServerDaoSupport")
	private SqlServerDaoSupport ssdDao;
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	public SqlServerDaoSupport getSsdDao() {
		return ssdDao;
	}
	public void setSsdDao(SqlServerDaoSupport ssdDao) {
		this.ssdDao = ssdDao;
	}
	public synUserService getSynUserService() {
		return synUserService;
	}
	public void setSynUserService(synUserService synUserService) {
		this.synUserService = synUserService;
	}
	
	
	/**
	 *页面加载时检测按钮状态
	 */
	@RequestMapping(value="checkButtonStatus")
	@ResponseBody
	public Object checkButtonStatus(){
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("buttonStatus", SynUserListener.SynAuto);
		return JSONObject.fromObject(map);
	}
	
	/**
	 *列表日志 
	 */
	@RequestMapping(value="listSynLog")
	public ModelAndView listSynLog(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
			pd = this.getPageData();
	        page.setPd(pd);
	        //取到同步日志列表
			List<PageData> synlogPdList = synUserService.findAllSynLog(page);
			mv.setViewName("system/sysUser/user_syn");
			mv.addObject("synlogPdList",synlogPdList);
			mv.addObject("pd",pd);
			mv.addObject("page",page);
			mv.addObject("flag",SynUserListener.SynAuto);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			return mv;
	}
	
	
	/**
	 *取到同步总数,同步id字符串 
	 */
	@RequestMapping(value="synInfo")
	@ResponseBody
	public Object synInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			//创建SynUserListener,取到同步信息
			SynUserListener sul = new SynUserListener();
//			PageData msgPd = sul.getSynIds(dao,ssdDao);
//			map.put("msgPd", msgPd);
			map.put("msg", "success");
			return JSONObject.fromObject(map);
		}catch(Exception e){
			map.put("msg", "error");
			return JSONObject.fromObject(map);
		}
		
	}
	
	
	/**
	 *修改按钮状态 
	 */
	@RequestMapping(value="synAuto")
	@ResponseBody
	public Object synAuto(
			@RequestParam(value = "flag") Object flag
			){
		Map<String , Object> map = new HashMap<String, Object>();
		if(flag.equals("open")){
			SynUserListener.SynAuto=true;
			map.put("msg", "success_open");
		}else if(flag.equals("close")){
			SynUserListener.SynAuto=false;
			map.put("msg", "success_close");
		}else{
			map.put("msg", "error");
		}
		
		return JSONObject.fromObject(map);
	}
	
	/**
	 *执行同步
	 *userAddIds:同步添加员工id
	 *userEditIds:同步修改员工id
	 *userDelIds:同步删除员工id
	 *userDelCodes:同步删除员工编号
	 **/
	@RequestMapping(value="synUserData")
	@ResponseBody
	public Object synUserData(
			@RequestParam(value = "userAddIds") Object userAddIds,
			@RequestParam(value = "userEditIds") Object userEditIds,
			@RequestParam(value = "userDelIds") Object userDelIds,
			@RequestParam(value = "userDelCodes") Object userDelCodes
			) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		SynUserListener sul = new SynUserListener();
		PageData pd = new PageData();
		pd.put("userAddIds", userAddIds);
		pd.put("userEditIds", userEditIds);
		pd.put("userDelIds", userDelIds);
		pd.put("userDelCodes", userDelCodes);
		//执行同步
		boolean isError = sul.SynResource(dao, ssdDao, pd);
		if(!isError){
			map.put("msg", "success");
		}else{
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
		
	}
	
	@RequestMapping(value="synToLocal")
	@ResponseBody
	public Object synToLocal() throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		List<PageData> pd = synUserService.findAllUser();
		for(PageData synPd : pd){
			synPd.put("USERNAME", synPd.getString("Code"));
			PageData edit_sysPd = sysUserService.findByUId(synPd);
			if(edit_sysPd!=null){
				/*edit_sysPd.put("NAME",synPd.getString("Name"));
				edit_sysPd.put("STATUS", Integer.parseInt(synPd.get("State").toString())>9?"0":"1");
				sysUserService.updateByUId(edit_sysPd);*/
			}else{
				PageData add_sysPd = new PageData();
				int state = Integer.parseInt(synPd.get("State").toString())<=9?1:0;
				add_sysPd.put("USER_ID", this.get32UUID());
				add_sysPd.put("USERNAME", synPd.getString("Code"));
				add_sysPd.put("PASSWORD", new SimpleHash("SHA-1", synPd.getString("Code").trim(), "123456").toString());
				add_sysPd.put("NAME", synPd.getString("Name"));
				add_sysPd.put("RIGHTS", "");
				add_sysPd.put("ROLE_ID", "06e6e74a24674ae2ac65e66667261911");
				add_sysPd.put("LAST_LOGIN", "");
				add_sysPd.put("SYN_TIME", DateUtil.getTime().toString());
				add_sysPd.put("CREATE_TIME", DateUtil.getTime().toString());
				add_sysPd.put("MODIFY_TIME", "");
				add_sysPd.put("IP", "");
				add_sysPd.put("BZ", "");
				add_sysPd.put("SKIN", "default");
				add_sysPd.put("EMAIL", "");
				add_sysPd.put("NUMBER", synPd.getString("Code"));
				add_sysPd.put("PHONE", "");
				add_sysPd.put("AVATAR", "");
				add_sysPd.put("HX_USERNAME", "");
				add_sysPd.put("HX_PASSWORD", "");
				add_sysPd.put("STATUS", state+"");
				add_sysPd.put("POSITION_ID", "");
                sysUserService.saveU(add_sysPd);
				PageData update_pd = new PageData();
				update_pd.put("SynCode",synPd.getString("Code"));
				update_pd = synUserService.findByCode(update_pd);
				//更新log的状态,toSyn为待同步,toLocal已同步到本地
				if (update_pd!=null){
					update_pd.put("SynStatus","toLocal");
					//shiro管理的session
					Subject currentUser = SecurityUtils.getSubject();
					Session session = currentUser.getSession();
					PageData pds = new PageData();
					pds = (PageData) session.getAttribute("userpds");
					String USER_ID = pds.getString("USER_ID");
					//操作用户的ID
					update_pd.put("USER_ID",USER_ID);
					synUserService.updateStatus(update_pd);
				}
				//保存用户信息到activiti
				WorkFlow workFlow = new WorkFlow();
				org.activiti.engine.identity.User user = new UserEntity();
				user.setId(add_sysPd.getString("USER_ID"));
				user.setPassword(add_sysPd.getString("PASSWORD"));
				user.setEmail(add_sysPd.getString("EMAIL"));
				workFlow.getIdentityService().saveUser(user);
				//更新membership
				workFlow.getIdentityService().createMembership(add_sysPd.getString("USER_ID"),add_sysPd.getString("ROLE_ID"));
			}
		}
		List<PageData> del_sysPd = sysUserService.findToDelSyn();
		for(PageData sysPd : del_sysPd){
			sysUserService.deleteByUId(sysPd);
		}
		map.put("msg", "success");
		return JSONObject.fromObject(map);
	}
	
	
	/* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
