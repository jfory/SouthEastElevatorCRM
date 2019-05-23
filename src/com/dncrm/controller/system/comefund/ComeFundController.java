package com.dncrm.controller.system.comefund;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.comefund.ComeFundService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/comefund")
@Controller
public class ComeFundController extends BaseController
{
	@Resource(name = "comefundService")
	private ComeFundService comefundService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	/**
	 * 显示来款基本信息
	 *
	 * @return
	 */
	@RequestMapping("/comeFund")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> comeFundList = comefundService.listPdPageComeFund(page);
			mv.setViewName("system/comefund/comefund");
			mv.addObject("comeFundList", comeFundList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 跳到添加页面
	 * 
	 * @return
	 */

	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		mv.setViewName("system/comefund/comefund_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		return mv;
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
		String com_no=("LK"+time+number);
		//获取系统时间
		String df=DateUtil.getTime().toString();
		//获取系统当前登陆人
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user=(User) session.getAttribute(Const.SESSION_USER);
		String user_id=user.getUSER_ID();
		try {
			pd = this.getPageData();
			
			pd.put("com_uuid", UUID.randomUUID().toString());
			pd.put("com_no", com_no);
			pd.put("com_type", 0);
			pd.put("com_states", 0);
			pd.put("input_user", user_id);
			pd.put("input_time", df);
		    comefundService.saveS(pd);//保存信息
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
			pd = comefundService.findComeFundById(pd);
			mv.setViewName("system/comefund/comefund_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
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
			comefundService.editS(pd);
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
			comefundService.delComeFund(pd);
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
			String cell_ids = (String) pd.get("cell_ids");
			for (String com_no : cell_ids.split(",")) {
				pd.put("com_no", com_no);
				comefundService.delComeFund(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	/**
	 * 跳到分款页面
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goClaim")
	public ModelAndView goClaim() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd=comefundService.findComeFundById(pd);  //来款信息
			mv.addObject("pd", pd);
			mv.setViewName("system/comefund/comefund_claim");
			List<PageData> collectSet = comefundService.collectSetlistPage(getPage()); //查询应收款信息
			mv.addObject("collectSet", collectSet);
			mv.addObject("msg", "claim");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 保存分款
	 *
	 * @return
	 */
	@RequestMapping("/claim")
	public ModelAndView claimSave() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//获取系统时间
		String df=DateUtil.getTime().toString();
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		PageData pds = new PageData();
    	pds = (PageData) session.getAttribute("userpds");
		String USER_ID = pds.getString("USER_ID");
		String data = pd.get("data").toString();
		String uuid=UUID.randomUUID().toString();//分款的uuid
		try {
			pd.put("uuid",uuid);
			pd.put("time", df);
			pd.put("input_user", USER_ID);
		    comefundService.claimsaveS(pd);//保存分款信息（分给某个阶段）
		    mv.addObject("msg", "success");
		    //保存每台电梯的分款信息
			JSONArray jsonArray = JSONArray.fromObject(data);
			PageData dataPd = new PageData();
			for(int i=0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				dataPd.put("id", this.get32UUID());
				dataPd.put("info_id",uuid);
				dataPd.put("details_id", jsonObj.get("details_id").toString());
				dataPd.put("total", jsonObj.get("total").toString());
				comefundService.saveEle(dataPd); //保存分给电梯的钱
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}
	 /**
	 * 加载应收款信息
	 * 
	 * @return
	 */
	@RequestMapping("/checkeditem")
	@ResponseBody
	public JSONObject checkeditem(@RequestParam(value = "item_id")String com_no) {
		JSONObject result = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd=  comefundService.findCollectSetById(pd);
			result.put("collectSet", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return result;
	}
	 /**
		 * 选择某个阶段后，加载该阶段的电梯应收款信息。
		 * @return
		 */
		@RequestMapping("/checkedele")
		@ResponseBody
		public JSONObject checkedele(String stage_no,String item_id) {
			JSONObject result = new JSONObject();
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				List<PageData> sagteList=comefundService.findCollectStageById(pd);
				result.put("collectStage", sagteList);
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
			ModelAndView mv = new ModelAndView();
			try{
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("来款uuid");
				titles.add("来款编号");
				titles.add("来款金额");
				titles.add("来款账户");
				titles.add("来款公司");
				titles.add("来款时间");
				titles.add("来款备注");
				titles.add("来款状态");
				titles.add("来款类型");
				titles.add("录入人");
				titles.add("录入时间");
				dataMap.put("titles", titles);
				List<PageData> itemList = comefundService.findComFundList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("com_uuid"));
					vpd.put("var2", itemList.get(i).getString("com_no"));
					vpd.put("var3", itemList.get(i).getString("com_money"));
					vpd.put("var4", itemList.get(i).getString("com_account"));
					vpd.put("var5", itemList.get(i).getString("com_company"));
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
					String str = df.format(itemList.get(i).get("com_time"));
					vpd.put("var6", str);
					vpd.put("var7", itemList.get(i).getString("com_remarks"));
					String com_states=itemList.get(i).getString("com_states");
					if(com_states.equals("0"))
					{
						vpd.put("var8", "未认领");
					}
					else if(com_states.equals("1"))
					{
						vpd.put("var8", "已认领");
					}
					String com_type=itemList.get(i).getString("com_type");
					if(com_type.equals("0"))
					{
						vpd.put("var9", "现金");
					}
					else if(com_type.equals("1"))
					{
						vpd.put("var9", "额度");
					}
					else if(com_type.equals("2"))
					{
						vpd.put("var9", "特批");
					}
					vpd.put("var10", itemList.get(i).getString("input_user"));
					vpd.put("var11", itemList.get(i).getString("input_time"));
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
			//获取系统时间
			String df=DateUtil.getTime().toString();
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
					//保存全部错误信息集合
    			    List<PageData> allErrList  = new ArrayList<PageData>();
    			    //导入全部失败（true）
				    boolean allErr=true;
					PageData pd = new PageData();
					for(int i = 0;i<listPd.size();i++)
					{
						//保存错误信息集合
	    			    List<PageData> errList = new ArrayList<PageData>();
						//字段验证-------开始
						//来款金额验证
						String com_money=listPd.get(i).getString("var0");
						if(com_money==null || com_money.equals(""))
						{
                             PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "来款金额不能为空!");
	    	        		 errPd.put("errCol", "1");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
						}
                        //来款账户验证
						String com_account=listPd.get(i).getString("var1");
						if(com_account==null || com_account.equals(""))
						{
                             PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "来款账户不能为空!");
	    	        		 errPd.put("errCol", "2");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
						}
						 //来款公司验证
						String com_compsany=listPd.get(i).getString("var2");
						if(com_compsany==null || com_compsany.equals(""))
						{
                             PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "来款账公司不能为空!");
	    	        		 errPd.put("errCol", "3");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
						}
						//认领状态
						String com_states=listPd.get(i).getString("var5");
						if(com_states!=null && !com_states.equals(""))
						{
							if(com_states.equals("未认领"))
				        	{
				        		pd.put("com_states", 0);
				        	}
				        	else if(com_states.equals("已认领"))
				        	{
				        		pd.put("com_states", 1);
				        	}
				        	else
				        	{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "填写错误的参数!");
		    	        		errPd.put("errCol", "6");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
				        	}
						}
			        	//款项类型
			            String com_type=listPd.get(i).getString("var6");
			            if(com_type!=null && !com_type.equals(""))
			            {
                            if(com_type.equals("现金"))
				        	{
				        		pd.put("com_type",0);
				        	}else if(com_type.equals("额度"))
				        	{
				        		pd.put("com_type",1);
				        	}else if(com_type.equals("特批"))
				        	{
				        		pd.put("com_type",2);
				        	}
				        	else
				        	{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "填写错误的参数!");
		    	        		errPd.put("errCol", "6");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
				        	}
			            }
			        	//字段验证结束
			        	if(errList.size()==0)
			        	{
                            Date dt=new Date();
							SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
							String time= matter1.format(dt);
						    int number=(int)((Math.random()*9+1)*100000);
							String com_no=("LK"+time+number);
				        	pd.put("com_uuid", UUID.randomUUID().toString());//
				        	pd.put("com_no",com_no);//
				        	pd.put("com_money", listPd.get(i).getString("var0"));//
				        	pd.put("com_account",  listPd.get(i).getString("var1"));//
				        	pd.put("com_compsany", listPd.get(i).getString("var2"));//
				        	pd.put("com_time", listPd.get(i).get("var3"));//
				        	pd.put("com_remarks", listPd.get(i).get("var4"));//
				        	pd.put("input_user", user_id);
				        	pd.put("input_time", df);
			        	
				        	//保存至数据库
					        comefundService.saveS(pd);
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
		    		map.put("errorMsg", "上传失败,没有数据！");
		    	}
			}catch(Exception e){
				logger.error(e.getMessage(), e);
				map.put("msg", "exception");
				map.put("errorUpload", "系统错误，请稍后重试！");
			}
			return JSONObject.fromObject(map);
		}	
		
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
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
}
