package com.dncrm.controller.system.competitor;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.competitor.CompetitorService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RequestMapping("/competitor")
@Controller
public class CompetitorController extends BaseController
{
	@Resource(name = "competitorService")
	private CompetitorService competitorService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	
	
	/**
	 * 显示竞争对手基本信息
	 *
	 * @return
	 */
	@RequestMapping("/competitor")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> competitorList = competitorService.listPdPageCompetitor(page);
			mv.setViewName("system/competitor/competitor");
			mv.addObject("competitorList", competitorList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

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
			pd = competitorService.findCompetitorById(pd);
			mv.setViewName("system/competitor/competitor_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 跳到添加页面 并且加载需要的数据到页面
	 * 
	 * @return
	 */

	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		 try {
		mv.setViewName("system/competitor/competitor_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 删除一条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/delShop")
	@ResponseBody
	public Object delShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			competitorService.deletecompetitor(pd);
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
			String comp_ids = (String) pd.get("comp_ids");
			for (String comp_id : comp_ids.split(",")) {
				pd.put("comp_id", comp_id);
				competitorService.deletecompetitor(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	/**
	 * 判断名称是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/CompName")
	@ResponseBody
	public Object CompName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = competitorService.findCompByName(pd);
			if (shop != null) {
				map.put("msg", "error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
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
		 Date dt=new Date();
	     SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	     String time= matter1.format(dt);
	    int number=(int)((Math.random()*9+1)*100000);
	    String comp_no=("DNC"+time+number);
	    //获取系统时间
	  	String df=DateUtil.getTime().toString();
	  	//获取系统当前登陆人
	  	Subject currentUser = SecurityUtils.getSubject();
	  	Session session = currentUser.getSession();
	  	User user=(User) session.getAttribute(Const.SESSION_USER);
	  	String user_id=user.getUSER_ID();
		try {
			pd = this.getPageData();
			pd.put("comp_id", comp_no);
			pd.put("input_user",user_id);
			pd.put("input_time",df);
			competitorService.saveS(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

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
		try {
			pd = this.getPageData();
			competitorService.editS(pd);
			mv.addObject("msg", "success");
		} 
		catch (Exception e)
		{
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}

	
	 /**
		 *导出到Excel 
		 */
		@RequestMapping(value="toExcel")
		public ModelAndView toExcel(){
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("竞争对手编号");
				titles.add("竞争对手公司名称");
				titles.add("竞争对手公司地址");
				titles.add("竞争对手公司电话");
				titles.add("竞争对手公司邮箱");
				titles.add("录入人");
				titles.add("录入时间");
				dataMap.put("titles", titles);
				
				List<PageData> itemList = competitorService.findCompetitorList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("comp_id"));
					vpd.put("var2", itemList.get(i).getString("comp_name"));
					vpd.put("var3", itemList.get(i).getString("comp_address"));
					vpd.put("var4", itemList.get(i).getString("comp_phone"));
					vpd.put("var5", itemList.get(i).getString("comp_email"));
					vpd.put("var6", itemList.get(i).getString("input_user"));
					vpd.put("var7", itemList.get(i).getString("input_time"));
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
		
		/**
		 *导入Excel到数据库 
		 */
		@RequestMapping(value="importExcel")
		@ResponseBody
		public Object importExcel(@RequestParam(value = "file") MultipartFile file){
			Map<String, Object> map = new HashMap<String, Object>();
		  	String df=DateUtil.getTime().toString(); //获取系统时间
		  	//获取系统当前登陆人
		  	Subject currentUser = SecurityUtils.getSubject();
		  	Session session = currentUser.getSession();
		  	User user=(User) session.getAttribute(Const.SESSION_USER);
		  	String user_id=user.getUSER_ID();
			try{
				if(file!=null && !file.isEmpty()){
		            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
		            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
					List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
					
					//保存错误信息集合
	    			List<PageData> allErrList = new ArrayList<PageData>();
	    			//导入全部失败（true）
					boolean allErr=true;
					PageData pd = new PageData();
					for(int i = 0;i<listPd.size();i++)
					{
						//保存本次for数据错误集合
						List<PageData> errList  = new ArrayList<PageData>();
						
						Date dt=new Date();
					    SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
					    String time= matter1.format(dt);
					    int number=(int)((Math.random()*9+1)*100000);
					    String comp_no=("DNC"+time+number);
			        	
					    String comp_name=listPd.get(i).getString("var0");
					    if(comp_name!=null && !comp_name.equals(""))
					    {
					    	 PageData compPd=new PageData();
						     compPd.put("comp_name", comp_name);
						     PageData shop = competitorService.findCompByName(compPd);
						     if(shop!=null)
						     {
						    	  //保存具体的字段的错误信息
					        	  PageData errPd = new PageData();
			    	        	  errPd.put("errMsg", "竞争对手名称重复!");
			    	        	  errPd.put("errCol", "1");
			    	        	  errPd.put("errRow", i+1);
			    	        	  errList.add(errPd);
						     }
					    }
					    if(errList.size()==0)
					    {
					    	pd.put("comp_id",comp_no);
				        	pd.put("comp_name", comp_name);
				        	pd.put("comp_address", listPd.get(i).getString("var1"));
				        	pd.put("comp_phone",  listPd.get(i).getString("var2"));
				        	pd.put("comp_email",  listPd.get(i).getString("var3"));
				        	pd.put("input_user", user_id );
				        	pd.put("input_time", df);
					    	allErr = false;
							//保存至数据库
					        competitorService.saveS(pd);
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
		    	}else{
		    		map.put("msg", "exception");
		    		map.put("errorMsg", "上传失败");
		    	}
			}catch(Exception e){
				logger.error(e.getMessage(), e);
				map.put("msg", "exception");
				map.put("errorUpload", "系统错误，请稍后重试！");
			}
			return JSONObject.fromObject(map);
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
	/* ===============================用户================================== */
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
}
