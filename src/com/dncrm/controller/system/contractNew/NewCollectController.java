package com.dncrm.controller.system.contractNew;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.collect.CollectService;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

import javax.annotation.Resource;

@RequestMapping("/newcollect")
@Controller
public class NewCollectController extends BaseController {
	
	@Resource(name="contractNewAzService")
	private ContractNewAzService contractNewAzService;
	@Resource(name="contractNewService")
	private ContractNewService contractNewService;
	
	@RequestMapping("/collectList")
	public ModelAndView collectList(Page page) {
		ModelAndView mv =new ModelAndView();
		SelectByRole sbr = new SelectByRole();
		PageData pd=new PageData();
		pd=this.getPageData();
		try 
		{
			//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
			page.setPd(pd);
			List<PageData> SoYskList=contractNewAzService.SoYsklistPage(page);
			//跳转位置
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("DQTS", pd.get("DQTS"));
			mv.addObject("SoYskList", SoYskList);
			mv.setViewName("system/contractNew/newcollect_list");	
			
		}catch(Exception e){
		logger.error(e.getMessage(), e);	
		}
		
		return mv;
	}
	@RequestMapping("/getCollect")
	public ModelAndView getCollect() {
		ModelAndView mv =new ModelAndView();
		PageData pd =new PageData();
		try {
		pd=this.getPageData();
		
		PageData YskPd=contractNewAzService.findYskById(pd);
		pd.put("item_id", YskPd.get("YSK_ITEM_ID").toString());
		PageData itemPd=contractNewService.findItemById(pd);
		PageData FkfsPd=contractNewAzService.findFkfsById(YskPd);
		PageData InvPd=contractNewAzService.findInvoiceById(YskPd);
		PageData LkPd=contractNewAzService.findLkById(YskPd);
		
		mv.addObject("itemPd",itemPd);
		mv.addObject("FkfsPd",FkfsPd);
		mv.addObject("YskPd",YskPd);
		mv.addObject("InvPd",InvPd);
		mv.addObject("LkPd",LkPd);
        mv.addObject("msg", "view");
		mv.setViewName("system/contractNew/newcollect_info");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		
		return mv;
	}
	
	@RequestMapping("/getEdit")
	public ModelAndView getEdit() {
		ModelAndView mv =new ModelAndView();
		PageData pd =new PageData();
		try {
		pd=this.getPageData();
		
		PageData YskPd=contractNewAzService.findYskById(pd);
		pd.put("item_id", YskPd.get("YSK_ITEM_ID").toString());
		PageData itemPd=contractNewService.findItemById(pd);
		PageData FkfsPd=contractNewAzService.findFkfsById(YskPd);
		PageData InvPd=contractNewAzService.findInvoiceById(YskPd);
		PageData LkPd=contractNewAzService.findLkById(YskPd);
		
		mv.addObject("itemPd",itemPd);
		mv.addObject("FkfsPd",FkfsPd);
		mv.addObject("YskPd",YskPd);
		mv.addObject("InvPd",InvPd);
		mv.addObject("LkPd",LkPd);
        mv.addObject("msg", "edit");
		mv.setViewName("system/contractNew/newcollect_info");	
		}catch(Exception e){
			logger.error(e.getMessage(), e);		
		}
		
		return mv;
	}

	@RequestMapping("/editLK")
	@ResponseBody
	public Map<String, Object> editLK(){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		
		try {
			pd.put("input_user", getUser().getUSER_ID());
			contractNewAzService.editLK(pd);
			resultMap.put("code", "1");
		} catch (Exception e) {
			resultMap.put("code", "0");
			e.printStackTrace();
		}
		
		return resultMap;
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
	/* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
}
