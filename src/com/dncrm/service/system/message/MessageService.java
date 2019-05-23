package com.dncrm.service.system.message;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.Menu;
import com.dncrm.util.PageData;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;

@Service("messageService")
public class MessageService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    public void sendMesAction(String send_id,String recv_id,String content)throws Exception{
    	PageData pd = new PageData();
    	pd.put("send_id", send_id);
    	pd.put("recv_id", recv_id);
    	pd.put("mes_text", content);
    	pd.put("status", "0");
    	dao.save("MessageMapper.saveMes", pd);
    }
    
    public List<PageData> listPageAllMessage(Page page)throws Exception{
    	return (List<PageData>)dao.findForList("listPageAllMessage", page);
    }
    
    public PageData recvMesCount(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("MessageMapper.recvMesCount", pd);
    }
    
    public void saveMes(PageData pd)throws Exception{
    	dao.save("MessageMapper.saveMes", pd);
    }
    
    public void editMesStatus(PageData pd)throws Exception{
    	dao.update("MessageMapper.editMesStatus", pd);
    }
    
    public void editMesDelete(PageData pd)throws Exception{
    	dao.update("MessageMapper.editMesDelete", pd);
    }

    public PageData findMesById(PageData pd) throws Exception{
    	return (PageData)dao.findForObject("MessageMapper.findMesById", pd);
    }
    
    //*************************************************************
    
    /**
     *查询各状态消息数量
     *0:收件箱;1:重要;2:草稿;3:回收站 
     */
    public PageData findStatusCount(String user_id)throws Exception{
    	return (PageData) dao.findForObject("MessageMapper.findStatusCount", user_id);
    }
    
    /**
     *根据登录人id和状态查询 
     */
    public List<PageData> listPagefindByStatus(Page page)throws Exception{
    	return (List<PageData>) dao.findForList("MessageMapper.listPagefindByStatus", page);
    }
    
    /**
     *修改已读未读状态 
     */
    public void editRead(PageData pd)throws Exception{
    	dao.update("MessageMapper.editRead", pd);
    }
    
    /**
     *根据id查看信息详情 
     */
    public PageData findMailDetail(String id)throws Exception{
    	return (PageData) dao.findForObject("MessageMapper.findMailDetail", id);
    }
    
    /**
     *发送 
     */
    public void saveNewMail(PageData pd)throws Exception{
    	dao.save("MessageMapper.saveNewMail", pd);
    }
    
    /**
     *查询发件箱 
     */
    public List<PageData> listPagefindMailSend(Page page)throws Exception{
    	return (List<PageData>)dao.findForList("MessageMapper.listPagefindMailSend", page);
    }
    
    /**
     *修改状态 
     */
    public void editStatus(PageData pd)throws Exception{
    	dao.update("MessageMapper.editStatus", pd);
    }
    
    /**
     *保存草稿 
     */
    public void saveDraft(PageData pd)throws Exception{
    	dao.save("MessageMapper.saveDraft", pd);
    }
    
    /**
     *查询草稿 
     */
    public List<PageData> listPagefindMailDraft(Page page)throws Exception{
    	return (List<PageData>) dao.findForList("MessageMapper.listPagefindMailDraft", page);
    }
    
    /**
     *根据id查询,跳转编辑草稿用 
     */
    public PageData findMailEdit(String id)throws Exception{
    	return (PageData) dao.findForObject("MessageMapper.findMailEdit", id);
    }
    
    /**
     *编辑草稿 
     */
    public void mailEdit(PageData pd)throws Exception{
    	dao.update("MessageMapper.mailEdit", pd);
    }
    
    /**
     *发送草稿 
     */
    public void sendDraft(PageData pd)throws Exception{
    	dao.update("MessageMapper.sendDraft", pd);
    }
    
    /**
     *批量设置已读 
     */
    public void setRead(List<String> list)throws Exception{
    	dao.update("MessageMapper.setRead", list);
    }
    
    /**
     *批量设置重要
     */
    public void setImpt(List<String> list)throws Exception{
    	dao.update("MessageMapper.setImpt", list);
    }
    
    /**
     *批量设置回收
     */
    public void setDel(List<String> list)throws Exception{
    	dao.update("MessageMapper.setDel", list);
    }
    
    /**
     *查询未读收件数量 
     */
    public String refreshMail(String user_id)throws Exception{
    	return (String)dao.findForObject("MessageMapper.refreshMail", user_id);
    }
    
    /**
     *彻底删除 
     */
    public void mailDel(List<String> list)throws  Exception{
    	dao.delete("MessageMapper.mailDel", list);
    }
    
    /**
     *获取用户列表用于发送 
     */
    public List<PageData> findUserList()throws Exception{
    	return (List<PageData>) dao.findForList("MessageMapper.findUserList", "");
    }
    
    /**
     *修改flag为1,用于逻辑删除 
     */
    public void updateMailFlag(String id)throws Exception{
    	dao.update("MessageMapper.updateMailFlag", id);
    }
}
