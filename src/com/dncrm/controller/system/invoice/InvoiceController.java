package com.dncrm.controller.system.invoice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

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
import com.dncrm.service.system.invoice.InvoiceService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@RequestMapping("/invoice")
@Controller
public class InvoiceController extends BaseController
{
	@Resource(name = "invoiceService")
	private InvoiceService invoiceService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	/**
	 * 显示来款基本信息
	 *
	 * @return
	 */
	@RequestMapping("/invoice")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> invoiceList = invoiceService.invoicelistPage(page);
			mv.setViewName("system/invoice/invoice");
			mv.addObject("invoiceList", invoiceList);
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
		mv.setViewName("system/invoice/invoice_edit");
		try {
			List<PageData> comefundList = invoiceService.comeFundlistPage(getPage());  //查询来款信息
			mv.addObject("comefundList", comefundList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		return mv;
	}
	 /**
		 * 加载来款信息
		 * 
		 * @return
		 */
		@RequestMapping("/checkedcom")
		@ResponseBody
		public JSONObject checkedcom(@RequestParam(value = "com_no")String com_no) {
			JSONObject result = new JSONObject();
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				pd=  invoiceService.findComeFundById(pd);
				result.put("comefund", pd);
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			return result;
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
			String inv_no=("FP"+time+number);
			//获取系统时间
			String df=DateUtil.getTime().toString();
			//获取系统当前登陆人
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			User user=(User) session.getAttribute(Const.SESSION_USER);
			String user_id=user.getUSER_ID();
			try {
				pd = this.getPageData();
				pd.put("inv_uuid", UUID.randomUUID().toString());
				pd.put("inv_no", inv_no);  
				pd.put("inv_states", 0);
				pd.put("input_user", user_id);
				pd.put("input_time", df);
				invoiceService.saveS(pd);//保存信息
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
				invoiceService.delInvoice(pd);   //删除发票
				invoiceService.delCarriage(pd); //删除承运单
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
					pd.put("inv_no", com_no);
					invoiceService.delInvoice(pd);
				}
				map.put("msg", "success");
			} catch (Exception e) {
				map.put("msg", "failed");
			}
			return JSONObject.fromObject(map);
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
				List<PageData> comefundList = invoiceService.comeFundlistPage(getPage());  //查询来款信息
				mv.addObject("comefundList", comefundList);
				pd = invoiceService.findInvoiceById(pd);   //根据编号查询信息
				mv.setViewName("system/invoice/invoice_edit");
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
				invoiceService.editS(pd);
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
		 * 跳到录入承运单页面
		 *
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/Carriage")
		public ModelAndView Carriage() throws Exception {
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				pd = invoiceService.findInvoiceById(pd);   //根据编号查询信息
				mv.setViewName("system/invoice/invoice_carriage");
				mv.addObject("pd", pd);
				mv.addObject("msg", "Carr");
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			return mv;
		}
		/**
		 * 保存新增承运单
		 * @return
		 */
		@RequestMapping("/Carr")
		public ModelAndView AddCarriage() {
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			try {
				pd = this.getPageData();
				pd.put("car_uuid", UUID.randomUUID().toString());
				invoiceService.AddCarriage(pd);//保存信息
			    mv.addObject("msg", "success");
			    pd.put("inv_states",1);
			    invoiceService.editStates(pd);
			} catch (Exception e) {
				mv.addObject("msg", "failed");
			}
			mv.addObject("id", "EditShops");
			mv.addObject("form", "shopForm");
			mv.setViewName("save_result");
			return mv;
		}
		/**
		 * 跳到承运单信息页面
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/record")
		public ModelAndView record() throws Exception {
			ModelAndView mv = new ModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			try {
				pd= invoiceService.findCarriageById(pd);   //根据编号查询信息
				mv.setViewName("system/invoice/invoice_record");
				mv.addObject("pd", pd);
				mv.addObject("msg", "Carr");
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
		@RequestMapping("/delCarriage")
		@ResponseBody
		public Object delCarriage() {
			PageData pd = this.getPageData();
			Map<String, Object> map = new HashMap<String, Object>();
			try {
				Page page = this.getPage();
				page.setPd(pd);
				invoiceService.delCarriage(pd); //删除承运单
				map.put("msg", "success");
				pd.put("inv_states",0);
				invoiceService.editStates(pd);  //修改状态为  未寄出
			} catch (Exception e) {
				map.put("msg", "failed");
			}
			return JSONObject.fromObject(map);
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
				titles.add("发票uuid");
				titles.add("发票编号");
				titles.add("发票金额");
				titles.add("项目名称");
				titles.add("公司");
				titles.add("公司地址");
				titles.add("开票时间");
				titles.add("备注");
				titles.add("所属来款编号");
				titles.add("发票状态");
				titles.add("录入人");
				titles.add("录入时间");
				dataMap.put("titles", titles);
				List<PageData> itemList = invoiceService.findInvoiceList();
				List<PageData> varList = new ArrayList<PageData>();
				for(int i = 0; i < itemList.size(); i++){
					PageData vpd = new PageData();
					vpd.put("var1", itemList.get(i).getString("inv_uuid"));
					vpd.put("var2", itemList.get(i).getString("inv_no"));
					vpd.put("var3", itemList.get(i).getString("inv_money"));
					vpd.put("var4", itemList.get(i).getString("inv_item_no"));
					vpd.put("var5", itemList.get(i).getString("inv_company"));
					vpd.put("var6", itemList.get(i).getString("inv_comp_address"));
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
					String str = df.format(itemList.get(i).get("inv_time"));
					vpd.put("var7", str);
					vpd.put("var8", itemList.get(i).getString("inv_remarks"));
					vpd.put("var9", itemList.get(i).getString("inv_com_no"));
					
					String inv_states=itemList.get(i).getString("inv_states");
					if(inv_states.equals("0"))
					{
						vpd.put("var10", "未寄出");
					}else
					{
						vpd.put("var10", "已寄出");
					}
					vpd.put("var11", itemList.get(i).getString("input_user"));
					vpd.put("var12", itemList.get(i).getString("input_time"));
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
	    			    //来款编号验证
	    			    String inv_com_no=listPd.get(i).getString("var6");
	    			    if(inv_com_no==null || inv_com_no.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "来款编号不能为空!");
	    	        		 errPd.put("errCol", "7");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			    //发票金额 验证
	    			    String inv_money=listPd.get(i).getString("var0");
	    			    if(inv_money==null || inv_money.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "发票金额不能为空!");
	    	        		 errPd.put("errCol", "1");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			    //项目名称 验证
	    			    String inv_item_no=listPd.get(i).getString("var1");
	    			    if(inv_item_no==null || inv_item_no.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "项目名称不能为空!");
	    	        		 errPd.put("errCol", "2");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			   //所属公司 验证
	    			    String inv_company=listPd.get(i).getString("var2");
	    			    if(inv_company==null || inv_company.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "所属公司不能为空!");
	    	        		 errPd.put("errCol", "3");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			   //公司地址 验证
	    			    String inv_comp_address=listPd.get(i).getString("var3");
	    			    if(inv_comp_address==null || inv_comp_address.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "公司地址不能为空!");
	    	        		 errPd.put("errCol", "4");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			   //公司地址 验证
	    			    String inv_time=listPd.get(i).getString("var4");
	    			    if(inv_time==null || inv_time.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "开票时间不能为空!");
	    	        		 errPd.put("errCol", "5");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			    //发票状态
	    			    String inv_states=listPd.get(i).getString("var7");
	    			    if(inv_states==null || inv_states.equals(""))
	    			    {
	    			    	 PageData errPd = new PageData();
	    	        		 errPd.put("errMsg", "发票状态不能为空!");
	    	        		 errPd.put("errCol", "8");
	    	        		 errPd.put("errRow", i+1);
	    	        		 errList.add(errPd);
	    			    }
	    			    else
	    			    {
	    			    	if(inv_states.equals("未寄出"))
				        	{
				        		pd.put("inv_states", 0);//
				        	}
				        	else if(inv_states.equals("已寄出"))
				        	{
				        		pd.put("inv_states", 1);
				        	}
				        	else
				        	{
				        		 PageData errPd = new PageData();
		    	        		 errPd.put("errMsg", "填写错误的参数!");
		    	        		 errPd.put("errCol", "8");
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
							String inv_no=("FP"+time+number);
				        	pd.put("inv_uuid",UUID.randomUUID().toString());
				        	pd.put("inv_no",inv_no);//
				        	pd.put("inv_money", listPd.get(i).getString("var0"));
				        	pd.put("inv_item_no",  listPd.get(i).getString("var1"));
				        	pd.put("inv_company", listPd.get(i).getString("var2"));
				        	pd.put("inv_comp_address", listPd.get(i).get("var3"));
				        	pd.put("inv_time", listPd.get(i).get("var4").toString());
				        	pd.put("inv_remarks", listPd.get(i).getString("var5"));
				        	pd.put("inv_com_no", listPd.get(i).getString("var6"));
				        	pd.put("input_user", user_id);
				        	pd.put("input_time", df);
				        	
				        	invoiceService.saveS(pd);
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
