package com.dncrm.service.system.sysLog;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.StringUtil;

@Service("sysLogService")
public class SysLogService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> listPdPageLog(Page page) throws Exception{
		return (List<PageData>) dao.findForList("LogMapper.loglistPage", page);
	}
	//保存日志  type为操作类型(add,edit,delete), title为目录位置(信息管理-资讯管理-新增), loggingId为添加的ID, logging为日志内容(添加：酷爱分公司)
	public void logAdd(String type,String title,String loggingId,String logging,HttpServletRequest request) throws Exception{
		logAdd(type, title, loggingId, loggingId, request.getParameterMap().toString(), request);
	}
	
	public void logAdd(String type,String title,String loggingId,String logging, String params, HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
		BaseController base = new BaseController();
		 pd.put("id", base.get32UUID());
	     pd.put("type", type);
	     pd.put("title",title);
	     pd.put("loggingId", loggingId);
	     pd.put("logging", logging);
	     pd.put("create_by", user.getUSERNAME());
	     pd.put("create_role", user.getNAME());
	     pd.put("create_date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
	     pd.put("remote_addr", StringUtil.getRemoteAddr(request));
	     pd.put("user_agent", request.getHeader("user-agent"));
	     pd.put("request_uri", request.getRequestURI());
	     pd.put("params", params);
	     pd.put("method", request.getMethod());
	     pd.put("exception", "");
		dao.save("LogMapper.logAdd", pd);
	}
	
	public void logUpdate(PageData pd) throws Exception{
		dao.update("LogMapper.logUpdate", pd);
	}
	
	public void logDeleteById(String log_no) throws Exception{
		dao.delete("LogMapper.logDeleteById", log_no);
	}
	public List<PageData> findLogById(String log_no) throws Exception{
		return (List<PageData>) dao.findForList("LogMapper.findLogById", log_no);
	}
	/*
	* 批量删除
	*/
	public void logDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("LogMapper.logDeleteAll", ArrayDATA_IDS);
	}
	 
}
