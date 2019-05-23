package com.dncrm.controller.system.message;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.message.MessageService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

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

@RequestMapping("/message")
@Controller
public class MessageController extends BaseController {
	
	@Resource(name="messageService")
	private MessageService messageService;
	@Resource(name="sysUserService")
	private sysUserService sysUserService;
	
	private PageData statusPd;
	
	/**
	 *跳转收件箱
	 */
	@RequestMapping(value="mailMain")
	public ModelAndView toMenu(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		PageData titlePd = new PageData();
		try{
			String status = "";
			pd = this.getPageData();
			pd.put("user_id", getUser().getUSER_ID());
			if(!pd.containsKey("status")){
				status = "0";
				pd.put("status", status);
			}else{
				status = pd.getString("status");
			}
			switch(status){
				case "0":
					titlePd.put("title", "收件箱");
					titlePd.put("titleFlag", "0");
					mv.addObject("count", statusPd.get("sjx").toString());
					break;
				case "1":
					titlePd.put("title", "重要");
					titlePd.put("titleFlag", "1");
					mv.addObject("count", statusPd.get("zy").toString());
					break;
				case "2":
					titlePd.put("title", "草稿");
					titlePd.put("titleFlag", "2");
					mv.addObject("count", statusPd.get("cg").toString());
					break;
				case "3":
					titlePd.put("titleFlag", "3");
					titlePd.put("title", "回收站");
					mv.addObject("count", statusPd.get("hsz").toString());
					break;
			}
			page.setPd(pd);
			List<PageData> mesPd = messageService.listPagefindByStatus(page);
			mv.addObject("mesList" ,mesPd);
			mv.addObject("statusPd", statusPd);
			mv.addObject("titlePd", titlePd);
			mv.addObject("page", page);
			mv.addObject("status", status);
			mv.setViewName("system/message/mail_main");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *站内信页面 
	 */
	@RequestMapping(value="mailView")
	public ModelAndView mailView(){
		ModelAndView mv = new ModelAndView();
		try{
			statusPd = updateStatusPd();
			mv.addObject("statusPd", statusPd);
			mv.setViewName("system/message/mail_box");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *更新各个状态的信息总数 
	 */
	public PageData updateStatusPd(){
		try{
			statusPd = new PageData();
			statusPd = messageService.findStatusCount(getUser().getUSER_ID());
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return statusPd;
	}
	
	/**
	 *跳转新建信息 
	 */
	@RequestMapping(value="mailNew")
	public ModelAndView mailNew(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> userList = messageService.findUserList();
			mv.addObject("userList", userList);
			mv.setViewName("system/message/mail_new");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *修改已读状态 
	 */
	@RequestMapping(value="editRead")
	@ResponseBody
	public Object editRead(){
		PageData pd;
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			pd = this.getPageData();
			pd.put("is_read", "1");
			messageService.editRead(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 *跳转到查看详情 
	 */
	@RequestMapping(value="mailDetail")
	public ModelAndView mailDetail(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String recv = pd.containsKey("recv")?pd.getString("recv"):"true";
			PageData detailPd = messageService.findMailDetail(pd.get("id").toString());
			mv.addObject("detailPd", detailPd);
			mv.addObject("recv", recv);
			mv.setViewName("system/message/mail_detail");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到回复 
	 */
	@RequestMapping(value="mailRecv")
	public ModelAndView mailRecv(){
		ModelAndView mv = new ModelAndView();
		PageData newPd;
		try{
			newPd = this.getPageData();
			String recv_id = newPd.get("recv_id").toString();
			//回复时,拆分拼接的recv_id,在mail_new页面选中
			List<String> recvList = new ArrayList<String>();
			if(recv_id.contains(",")){
				recvList = Arrays.asList(recv_id.split(","));
			}else{
				recvList.add(recv_id);
			}
			List<PageData> userList = messageService.findUserList();
			mv.addObject("userList", userList);
			mv.addObject("newPd", newPd);
			mv.addObject("recvList", recvList);
			mv.setViewName("system/message/mail_new");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *发送消息 
	 */
	@RequestMapping(value="sendMail")
	public ModelAndView sendMail(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			pd.put("recv_id", pd.get("recv_id_selected").toString());
			pd.put("send_id", getUser().getUSER_ID());
			pd.put("is_read", "0");
			pd.put("status", "0");
			pd.put("answ_id", "0");
			pd.put("flag", "0");
			messageService.saveNewMail(pd);
			//发送完成后跳转到发件箱
			PageData dataPd = this.getPageData();
			dataPd.put("user_id", getUser().getUSER_ID());
			page.setPd(dataPd);
			List<PageData> sendList = messageService.listPagefindMailSend(page);
			mv.addObject("sendList", sendList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_send");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到发件箱 
	 */
	@RequestMapping(value="mailSend")
	public ModelAndView mailSend(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			PageData pd = this.getPageData();
			pd.put("user_id", getUser().getUSER_ID());
			page.setPd(pd);
			List<PageData> sendList = messageService.listPagefindMailSend(page);
			mv.addObject("sendList", sendList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_send");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *修改状态 
	 */
	@RequestMapping(value="editStatus")
	public ModelAndView editStatus(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存草稿 
	 */
	@RequestMapping(value="saveDraft")
	public ModelAndView saveDraft(Page page){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			pd.put("recv_id", pd.get("recv_id_selected").toString());
			pd.put("send_id", getUser().getUSER_ID());
			pd.put("status", "2");
			pd.put("flag", "0");
			pd.put("is_read", "0");
			messageService.saveDraft(pd);
			PageData dataPd = new PageData();
			dataPd.put("status", "2");
			dataPd.put("user_id", getUser().getUSER_ID());
			page.setPd(dataPd);
			List<PageData> draftList = messageService.listPagefindMailDraft(page);
			mv.addObject("draftList", draftList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_draft");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *草稿列表 
	 */
	@RequestMapping(value="mailDraft")
	public ModelAndView mailDraft(Page page){
		PageData pd = new PageData();
		ModelAndView mv = new ModelAndView();
		try{
			pd.put("status", "2");
			pd.put("user_id", getUser().getUSER_ID());
			page.setPd(pd);
			List<PageData> draftList = messageService.listPagefindMailDraft(page);
			mv.addObject("draftList", draftList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_draft");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转编辑草稿 
	 */
	@RequestMapping(value="mailEdit")
	public ModelAndView mailEdit(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd =this.getPageData();
			String id = pd.getString("id");
			PageData editPd = messageService.findMailEdit(id);
			//回复时,拆分拼接的recv_id,在mail_edit页面选中
			String recv_id = editPd.get("recv_id").toString();
			List<String> recvList = new ArrayList<String>();
			if(recv_id.contains(",")){
				recvList = Arrays.asList(recv_id.split(","));
			}else{
				recvList.add(recv_id);
			}
			List<PageData> userList = messageService.findUserList();
			mv.addObject("userList", userList);
			mv.addObject("recvList", recvList);
			mv.addObject("editPd", editPd);
			mv.setViewName("system/message/mail_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存草稿更改 
	 */
	@RequestMapping(value="saveEdit")
	public ModelAndView saveEdit(Page page){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			pd.put("recv_id", pd.get("recv_id_selected").toString());
			messageService.mailEdit(pd);
			PageData dataPd = new PageData();
			dataPd.put("status", "2");
			dataPd.put("user_id", getUser().getUSER_ID());
			page.setPd(dataPd);
			List<PageData> draftList = messageService.listPagefindMailDraft(page);
			mv.addObject("draftList", draftList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_draft");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *草稿界面发送 
	 */
	@RequestMapping(value="sendDraft")
	public ModelAndView sendDraft(Page page){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			pd.put("recv_id", pd.get("recv_id_selected").toString());
			pd.put("status", "0");
			messageService.sendDraft(pd);
			
			PageData dataPd = new PageData();
			dataPd.put("user_id", getUser().getUSER_ID());
			page.setPd(dataPd);
			List<PageData> sendList = messageService.listPagefindMailSend(page);
			mv.addObject("sendList", sendList);
			mv.addObject("page", page);
			mv.setViewName("system/message/mail_send");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *批量操作,设置已读 
	 */
	@RequestMapping(value="setRead")
	public ModelAndView setRead(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			String url = pd.getString("url");
			String ids = pd.getString("ids");
			List<String> list = new ArrayList<String>();
			if(ids.contains(",")){
				list = Arrays.asList(ids.split(","));
			}else{
				list.add(ids);
			}
			messageService.setRead(list);
			mv.setViewName("system/message/"+url);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *批量操作,设置重要
	 */
	@RequestMapping(value="setImpt")
	public ModelAndView setImpt(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			String url = pd.getString("url");
			String ids = pd.getString("ids");
			List<String> list = new ArrayList<String>();
			if(ids.contains(",")){
				list = Arrays.asList(ids.split(","));
			}else{
				list.add(ids);
			}
			messageService.setImpt(list);
			mv.setViewName("system/message/"+url);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *批量操作,设置删除
	 */
	@RequestMapping(value="setDel")
	public ModelAndView setDel(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			String url = pd.getString("url");
			String ids = pd.getString("ids");
			List<String> list = new ArrayList<String>();
			if(ids.contains(",")){
				list = Arrays.asList(ids.split(","));
			}else{
				list.add(ids);
			}
			messageService.setDel(list);
			mv.setViewName("system/message/"+url);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *刷新来信 
	 */
	@RequestMapping(value="refreshMail")
	@ResponseBody
	public Object refreshMail(){
		Map<String, Object>map = new HashMap<String, Object>();
		try{
			updateStatusPd();
			String count = messageService.refreshMail(getUser().getUSER_ID());
			map.put("msg", "success");
			map.put("count", count);
		}catch(Exception e){
			map.put("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 *彻底删除 
	 */
	@RequestMapping(value="mailDel")
	@ResponseBody
	public Object mailDel(){
		PageData pd;
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<String> list = new ArrayList<String>();
			pd = this.getPageData();
			String ids = pd.getString("ids");
			if(ids.contains(",")){
				list = Arrays.asList(ids.split(","));
			}else{
				list.add(ids);
			}
			messageService.mailDel(list);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *逻辑删除 
	 */
	@RequestMapping(value="editFlag")
	public ModelAndView editFlag(){
		PageData pd;
		ModelAndView mv = new ModelAndView();
		try{
			pd = this.getPageData();
			String id = pd.getString("id");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	//**********************************************************************************************
	
	/**
	 *跳转至消息列表
	 */
	@RequestMapping(value="listMessage")
	public ModelAndView listMessage(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd.put("USER_ID", getUser().getUSER_ID());
			page.setPd(pd);
			List<PageData> mesPd = messageService.listPageAllMessage(page);
			mv.addObject("mesList" ,mesPd);
			/*mv.setViewName("system/message/message_list");*/
			mv.setViewName("system/message/mail_box");
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 *从服务器拉取数据 
	 */
	@RequestMapping(value="recvMesCount")
	@ResponseBody
	public Object recvMesCount(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		try{
			PageData mesPd = new PageData();
			//获取当前用户id
			String USER_ID = getUser().getUSER_ID();
			//获取当前用户未读信息总数
			pd.put("USER_ID", USER_ID);
			mesPd = messageService.recvMesCount(pd);
			map.put("msg", "success");
			map.put("Count", mesPd.get("count").toString());
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(),e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转至新建消息页面 
	 */
	@RequestMapping(value="goAddMessage")
	public ModelAndView goAddMessage(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String operateType= "";
			operateType = pd.containsKey("operateType")?pd.get("operateType").toString():"";
	        List<PageData> sysUserList = sysUserService.findAllUserNotAdmin();
	        mv.addObject("sysUserList",sysUserList);
			mv.addObject("User",getUser());
			mv.addObject("operateType", operateType);
			mv.addObject("msg", "sendMes");
			mv.setViewName("system/message/message_edit");
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
		
	}
	
	/**
	 *跳转至查看\回复消息信息页面 
	 */
	@RequestMapping(value="goEditMessage")
	public ModelAndView goEditMessage(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		PageData mesPd = new PageData();
		try{
			pd = this.getPageData();
			mesPd = messageService.findMesById(pd);
			//将消息状态改为已读
			mesPd.put("status", "1");
			messageService.editMesStatus(mesPd);
			mv.addObject("pd", mesPd);
			String operateType = pd.containsKey("operateType")?pd.get("operateType").toString():"";
			mv.addObject("operateType", operateType);
			mv.addObject("msg", "recvMes");
			mv.setViewName("system/message/message_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	/**
	 *发送回复信息数据 
	 */
	@RequestMapping(value="recvMes")
	public ModelAndView recvMes(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		PageData msgPd = new PageData();
		try{
			//获取当前用户id
			String USER_ID = getUser().getUSER_ID();
			pd = this.getPageData();
			msgPd.put("answ_id", pd.get("id").toString());
			msgPd.put("send_id", USER_ID);
			msgPd.put("recv_id", pd.get("send_id").toString());
			msgPd.put("title", pd.get("title").toString());
			msgPd.put("mes_text", pd.get("mes_text").toString());
			msgPd.put("status", "0");
			msgPd.put("flag", "0");
			messageService.saveMes(msgPd);
			mv.addObject("msg", "success");
			mv.addObject("id", "EditMessage");
			mv.addObject("form", "MessageForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return mv;
	}

	/**
	 *发送数据,页面跳转用
	 */
	@RequestMapping(value="sendMes")
	public ModelAndView sendMes(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String recvId = "";
		try{
			pd = this.getPageData();
			//获取当前用户id
			String USER_ID = getUser().getUSER_ID();
			pd.put("send_id", USER_ID);
			pd.put("status", "0");
			pd.put("answ_id", "0");
			pd.put("flag", "0");
			recvId = pd.containsKey("recv_id")?pd.get("recv_id").toString():"";
			if(recvId.lastIndexOf(",")>-1){
				for(String recv_id : recvId.split(",")){
					pd.put("recv_id", recv_id);
					messageService.saveMes(pd);
				}
			}else{
				pd.put("recv_id", recvId);
				messageService.saveMes(pd);
			}
			//获取接收对象id
			//插入tb_message表
			mv.addObject("msg", "success");
			mv.addObject("id", "EditMessage");
			mv.addObject("form", "MessageForm");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg","faild");
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 *将状态标记为已读\已删除 
	 */
	/*@RequestMapping(value="editStatus")
	@ResponseBody
	public Object editStatus(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		PageData pd = new PageData();
		PageData msgPd = new PageData();
		try{
			pd = this.getPageData();
			String operateType = pd.get("operateType").toString();
			String message_ids = pd.get("message_ids").toString();
			for(String id : message_ids.split(",")){
				msgPd.put("id", id);
				if(operateType.equals("status")){
					msgPd.put("status", "1");
					//修改已读
					messageService.editMesStatus(msgPd);
				}else if(operateType.equals("del")){
					msgPd.put("flag", "1");
					//逻辑删除
					messageService.editMesDelete(msgPd);
				}
			}

			map.put("msg", "success");
            obj = JSONObject.fromObject(map);
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
            obj = JSONObject.fromObject(map);
		}
		return obj;
	}*/
	
	
	
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
