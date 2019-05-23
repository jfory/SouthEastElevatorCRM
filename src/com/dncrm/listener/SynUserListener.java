package com.dncrm.listener;

import com.dncrm.dao.DaoSupport;
import com.dncrm.dao.HrDaoSupport;
import com.dncrm.dao.SqlServerDaoSupport;
import com.dncrm.entity.system.User;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.PageData;
import com.dncrm.util.UuidUtil;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.*;
/**
 *类名:SynUserListener
 *创建人:arisu
 *创建时间:2016年8月30日
 *描述: 同步用户信息;
 *相关数据库:sys_user_syn,sys_user_synlog
 */
public class SynUserListener implements ServletContextListener {
    // private int totalRecords;//总记录数
    // PRIVATE INT RECORDSIZE=100;
    // PRIVATE INT TOTALPAGENUM=1;
    private Timer timer = new Timer();
    Integer period_time = 10;
    private ApplicationContext app;
    private DaoSupport dao;
    private SqlServerDaoSupport ssdDao;
    private HrDaoSupport hrDao;
    public static boolean SynAuto = false;

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {

    }

    @Override
    public void contextInitialized(ServletContextEvent event) {
        app = WebApplicationContextUtils.getWebApplicationContext(event
                .getServletContext());
        dao = (DaoSupport) app.getBean("daoSupport");
        ssdDao = (SqlServerDaoSupport)app.getBean("sqlServerDaoSupport");

        try {
            timer.scheduleAtFixedRate(new GetUsersTask(), 1000, 1000 * 30);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    class GetUsersTask extends TimerTask {
        @Override
        public void run() {
            this.execute();
        }

        /**
         * @param min 正整数 执行扫描添加
         */
        public void execute() {
        	System.out.println("synuserlistener:  "+SynAuto);
    		try {
            	if(SynAuto){
            		PageData pd = getSynIds(dao,hrDao);
            		/*String userAddIds = pd.get("userAddIds").toString();
            		String userEditIds = pd.get("userAddIds").toString();
            		String userDelIds = pd.get("userAddIds").toString();
            		String userDelCodes = pd.get("userAddIds").toString();*/
					SynResource(dao,ssdDao,pd);
            	}
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
    }
    /**
     *获取需要同步的用户id,code 
     */
    public PageData getSynIds(DaoSupport dao,HrDaoSupport hrDao){
    	PageData rePd = new PageData();
    	try {
        	@SuppressWarnings("unchecked")
			List<PageData> zlEmployeeList = (List<PageData>)hrDao.findForList("HrSynchronizationMapper.findZlEmployee", "");
    		boolean if_edit = false;
    		int add_count=0;//保存新增总数量
    		int edit_count=0;//保存修改总数量
    		int del_count=0;//保存删除总数量
    		StringBuffer userAddIds = new StringBuffer();//保存需要新增的用户id
    		StringBuffer userEditIds = new StringBuffer();//保存需要修改的用户id
    		StringBuffer userDelIds = new StringBuffer();//保存需要删除的用户id
    		StringBuffer userDelCodes = new StringBuffer();//保存需要删除的用户code
    		
    		PageData pd = new PageData();
    		PageData logPd = new PageData();
    		//
    		for(PageData zlEmployeePd : zlEmployeeList){
    			if_edit = false;
    			String employeeId = zlEmployeePd.get("ID").toString();
    			pd = new PageData();
    			pd.put("ID", employeeId);
    			pd = (PageData)dao.findForObject("SynUserMapper.findById", pd);
    			if(pd==null){
    				add_count++;
    				userAddIds.append(zlEmployeePd.get("ID").toString()+",");
    				pd = new PageData();

    				/*logPd.put("SynDate", DateUtil.getTime().toString());
    				logPd.put("BeforeContent", "");
    				logPd.put("AfterContent", "");
    				logPd.put("SynCode", zlEmployeePd.get("Code").toString());
    				logPd.put("SynType", "add");
    				logPd.put("SynMsg", "新增编号为"+zlEmployeePd.get("Code").toString()+"的数据");
    				logArray.add(logPd);*/
    				/*dao.save("SynUserLogMapper.insertSynLog", logPd);*/
    			}else{
    				logPd.put("SynDate", DateUtil.getTime().toString());
					logPd.put("BeforeContent", "");
					logPd.put("AfterContent", "");
					logPd.put("SynCode", zlEmployeePd.get("Code").toString());
					logPd.put("SynType", "edit");
					logPd.put("SynMsg", "修改编号为"+zlEmployeePd.get("Code").toString()+"的数据");
					
    				zlEmployeePd = replaceNullValue(zlEmployeePd);
    				if(!zlEmployeePd.get("Code").toString().equals(pd.getString("Code"))){
        				logPd.put("BeforeContent",logPd.get("BeforeContent").toString()+","+ pd.getString("Code"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("Code").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("Name").toString().equals(pd.getString("Name"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("Name"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("Name").toString());
    					if_edit=true;
    				}
    				if(!(((boolean)zlEmployeePd.get("Sex")==false&&pd.getString("Sex").equals("0"))||((boolean)zlEmployeePd.get("Sex")==true&&pd.getString("Sex").equals("1")))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("Sex"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("Sex").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("State").toString().equals(pd.getString("State"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("State"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("State").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("PyDate").toString().equals(pd.getString("PyDate"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("PyDate"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("PyDate").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("Dept").toString().equals(pd.getString("Dept"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("Dept"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("Dept").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("ZhiWu").toString().equals(pd.getString("ZhiWu"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("ZhiWu"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("ZhiWu").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("G_gzdd").toString().equals(pd.getString("G_gzdd"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("G_gzdd"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("G_gzdd").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("BornDate").toString().equals(pd.getString("BornDate"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("BornDate"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("BornDate").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("LzDate").toString().equals(pd.getString("LzDate"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("LzDate"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("LzDate").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("G_bm1").toString().equals(pd.getString("G_bm1"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("G_bm1"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("G_bm1").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("G_bm2").toString().equals(pd.getString("G_bm2"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("G_bm2"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("G_bm2").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("G_bm3").toString().equals(pd.getString("G_bm3"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("G_bm3"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("G_bm3").toString());
    					if_edit=true;
    				}
    				if(!zlEmployeePd.get("G_bm4").toString().equals(pd.getString("G_bm4"))){
        				logPd.put("BeforeContent", logPd.get("BeforeContent").toString()+","+pd.getString("G_bm4"));
        				logPd.put("AfterContent", logPd.get("AfterContent").toString()+","+zlEmployeePd.get("G_bm4").toString());
    					if_edit=true;
    				}
    				if(if_edit){
    					edit_count++;
    					userEditIds.append(zlEmployeePd.get("ID").toString()+",");
    					/*logArray.add(logPd);*/
        				/*dao.save("SynUserLogMapper.insertSynLog", logPd);*/
    				}
    			}
    		}
    		List<PageData> userList = (List<PageData>) dao.findForList("SynUserMapper.findAllUser","");
    		List<String> ifDelIds = new ArrayList<String>();
    		for(PageData zlEmployeePd : zlEmployeeList){
    			ifDelIds.add(zlEmployeePd.get("ID").toString());
    		}
    		for(PageData userPd : userList){
    			if(!ifDelIds.contains(userPd.get("ID"))){
    				
    				/*logPd.put("SynDate", DateUtil.getTime().toString());
    				logPd.put("BeforeContent", "");
    				logPd.put("AfterContent", "");
    				logPd.put("SynCode", userPd.get("Code").toString());
    				logPd.put("SynType", "del");
    				logPd.put("SynMsg", "删除编号为"+userPd.get("Code").toString()+"的数据");
    				logArray.add(logPd);*/
    				/*dao.save("SynUserLogMapper.insertSynLog", logPd);*/
    				
        			del_count++;
        			userDelIds.append(userPd.get("ID")+",");
        			userDelCodes.append(userPd.get("Code")+",");
    			}
    		}
    		rePd.put("userAddIds", userAddIds.toString());
    		rePd.put("userEditIds", userEditIds.toString());
    		rePd.put("userDelIds", userDelIds.toString());
    		rePd.put("userDelCodes", userDelCodes.toString());
    		rePd.put("add_count", add_count);
    		rePd.put("edit_count", edit_count);
    		rePd.put("del_count", del_count);
    		return rePd;
        } catch (Exception e) {
            e.printStackTrace();
        	return rePd;
        }
    }
    
    public PageData replaceNullValue(PageData zlEmployeePd){
    	if(zlEmployeePd.get("Code")==null){
			zlEmployeePd.put("Code", "");
		}
		if(zlEmployeePd.get("Name")==null){
			zlEmployeePd.put("Name", "");
		}
		if(zlEmployeePd.get("Sex")==null){
			zlEmployeePd.put("Sex", "");
		}
		if(zlEmployeePd.get("State")==null){
			zlEmployeePd.put("State", "");
		}
		if(zlEmployeePd.get("PyDate")==null){
			zlEmployeePd.put("PyDate", "");
		}
		if(zlEmployeePd.get("Dept")==null){
			zlEmployeePd.put("Dept", "");
		}
		if(zlEmployeePd.get("ZhiWu")==null){
			zlEmployeePd.put("ZhiWu", "");
		}
		if(zlEmployeePd.get("G_gzdd")==null){
			zlEmployeePd.put("G_gzdd", "");
		}
		if(zlEmployeePd.get("BornDate")==null){
			zlEmployeePd.put("BornDate", "");
		}
		if(zlEmployeePd.get("LzDate")==null){
			zlEmployeePd.put("LzDate", "");
		}
		if(zlEmployeePd.get("G_bm1")==null){
			zlEmployeePd.put("G_bm1", "");
		}
		if(zlEmployeePd.get("G_bm2")==null){
			zlEmployeePd.put("G_bm2", "");
		}
		if(zlEmployeePd.get("G_bm3")==null){
			zlEmployeePd.put("G_bm3", "");
		}
		if(zlEmployeePd.get("G_bm4")==null){
			zlEmployeePd.put("G_bm4", "");
		}
        return zlEmployeePd;
    }
    /**
     *同步人员方法 
     */
    public boolean SynResource(DaoSupport dao,SqlServerDaoSupport ssdDao,PageData pd) throws Exception{
    	boolean isError = true;
		//shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		String OPERATE_ID = new UuidUtil().get32UUID();
    	try{
			PageData userPd = new PageData();
			PageData logPd = new PageData();
			/*String addIds = userAddIds==null?"":userAddIds;
			String editIds = userEditIds==null?"":userEditIds;
			String delIds = userDelIds==null?"":userDelIds;
			String delCodes = userDelCodes==null?"":userDelCodes;*/
			String addIds = pd.get("userAddIds").toString();
			String editIds = pd.get("userEditIds").toString();
			String delIds = pd.get("userDelIds").toString();
			String delCodes = pd.get("userDelCodes").toString();
			
			if(addIds!=null&&addIds!=""&&!addIds.equals("")){
				userPd = new PageData();
				List<String> ids = Arrays.asList(addIds.substring(0,addIds.length()-1).split(","));
				List<PageData> zlEmployeeList = (List<PageData>)ssdDao.findForList("SynUserMapper.findZlEmployeeByIds", ids);
				System.out.println(zlEmployeeList);
				for(PageData zlEmployeePd : zlEmployeeList){
					zlEmployeePd = replaceNullValue(zlEmployeePd);
					userPd.put("ID", zlEmployeePd.get("ID").toString());
					userPd.put("Code", zlEmployeePd.get("Code").toString());
					userPd.put("Name", zlEmployeePd.get("Name").toString());
					userPd.put("Sex", (boolean)zlEmployeePd.get("Sex")==true?"1":"0");
					userPd.put("State", zlEmployeePd.get("State").toString());
					userPd.put("PyDate", zlEmployeePd.get("PyDate").toString());
					userPd.put("Dept", zlEmployeePd.get("Dept").toString());
					userPd.put("ZhiWu", zlEmployeePd.get("ZhiWu").toString());
					userPd.put("G_gzdd", zlEmployeePd.get("G_gzdd").toString());
					userPd.put("BornDate", zlEmployeePd.get("BornDate").toString());
					userPd.put("LzDate", zlEmployeePd.get("LzDate").toString());
					userPd.put("G_bm1", zlEmployeePd.get("G_bm1").toString());
					userPd.put("G_bm2", zlEmployeePd.get("G_bm2").toString());
					userPd.put("G_bm3", zlEmployeePd.get("G_bm3").toString());
					userPd.put("G_bm4", zlEmployeePd.get("G_bm4").toString());
					dao.save("SynUserMapper.insertSynUser", userPd);
					
					//添加同步日志信息
					logPd.put("SynDate", DateUtil.getTime().toString());
					logPd.put("BeforeContent", "");
					logPd.put("AfterContent", "");
					logPd.put("SynCode", zlEmployeePd.get("Code").toString());
					logPd.put("SynType", "add");
					logPd.put("SynMsg", "新增编号为"+zlEmployeePd.get("Code").toString()+"的数据");
					logPd.put("USER_ID", user.getUSER_ID());
					logPd.put("OPERATE_ID", OPERATE_ID);
					logPd.put("SynStatus", "toSyn");
					dao.save("SynUserLogMapper.insertSynLog", logPd);
				}
			}
			
			if(editIds!=null&&editIds!=""&&!editIds.equals("")){
				userPd = new PageData();
				List<String> ids = Arrays.asList(editIds.substring(0,editIds.length()-1).split(","));
				List<PageData> zlEmployeeList = (List<PageData>)ssdDao.findForList("SynUserMapper.findZlEmployeeByIds", ids);
				for(PageData zlEmployeePd : zlEmployeeList){
					zlEmployeePd = replaceNullValue(zlEmployeePd);
					userPd.put("ID", zlEmployeePd.get("ID").toString());
					userPd.put("Code", zlEmployeePd.get("Code").toString());
					userPd.put("Name", zlEmployeePd.get("Name").toString());
					userPd.put("Sex", (boolean)zlEmployeePd.get("Sex")==true?"1":"0");
					userPd.put("State", zlEmployeePd.get("State").toString());
					userPd.put("PyDate", zlEmployeePd.get("PyDate").toString());
					userPd.put("Dept", zlEmployeePd.get("Dept").toString());
					userPd.put("ZhiWu", zlEmployeePd.get("ZhiWu").toString());
					userPd.put("G_gzdd", zlEmployeePd.get("G_gzdd").toString());
					userPd.put("BornDate", zlEmployeePd.get("BornDate").toString());
					userPd.put("LzDate", zlEmployeePd.get("LzDate").toString());
					userPd.put("G_bm1", zlEmployeePd.get("G_bm1").toString());
					userPd.put("G_bm2", zlEmployeePd.get("G_bm2").toString());
					userPd.put("G_bm3", zlEmployeePd.get("G_bm3").toString());
					userPd.put("G_bm4", zlEmployeePd.get("G_bm4").toString());
					dao.update("SynUserMapper.editById", userPd);;
					//修改同步表信息时将记录更新到系统用户sys_user
					userPd.put("STATUS", Integer.parseInt(zlEmployeePd.get("State").toString())<=9?1:0);
					dao.update("UserMapper.updateAuto", userPd);
					//添加同步日志信息
					logPd.put("SynDate", DateUtil.getTime().toString());
					logPd.put("BeforeContent", "");
					logPd.put("AfterContent", "");
					logPd.put("SynCode", zlEmployeePd.get("Code").toString());
					logPd.put("SynType", "edit");
					logPd.put("SynMsg", "修改编号为"+zlEmployeePd.get("Code").toString()+"的数据");
					logPd.put("USER_ID", user.getUSER_ID());
					logPd.put("OPERATE_ID", OPERATE_ID);
					logPd.put("SynStatus", "toSyn");
					dao.save("SynUserLogMapper.insertSynLog", logPd);
				}
			}
			
			if(delIds!=null&&delIds!=""&&!delIds.equals("")){
				List<String> ids = Arrays.asList(delIds.substring(0,delIds.length()-1).split(","));
				dao.delete("SynUserMapper.deleteByIds",ids);
				//删除同步表信息时将记录更新到系统用户表sys_user
				List<String> codes = Arrays.asList(delCodes.substring(0,delCodes.length()-1).split(","));
				dao.delete("UserMapper.deleteAuto", codes);
				//添加同步日志信息
				for(String code : codes){
					logPd.put("SynDate", DateUtil.getTime().toString());
					logPd.put("BeforeContent", "");
					logPd.put("AfterContent", "");
					logPd.put("SynCode", code);
					logPd.put("SynType", "del");
					logPd.put("SynMsg", "删除编号为"+code+"的数据");
					logPd.put("USER_ID", user.getUSER_ID());
					logPd.put("OPERATE_ID", OPERATE_ID);
					logPd.put("SynStatus", "toSyn");
					dao.save("SynUserLogMapper.insertSynLog", logPd);
				}
			}
			isError = false;
		}catch(Exception e){
			isError = true;
		}
    	return isError;
	}

}
       

