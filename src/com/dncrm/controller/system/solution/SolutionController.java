package com.dncrm.controller.system.solution;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.dncrm.service.system.houseType.HouseTypeService;
import com.dncrm.service.system.solution.SolutionService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@RequestMapping("/solution")
@Controller
public class SolutionController extends BaseController
{
	@Resource(name = "solutionService")
	private SolutionService solutionService;
	@Resource(name = "housetypeService")
	private HouseTypeService housetypeService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	/**
	 * 显示全部信息
	 * @return
	 */
	@RequestMapping("/solution")
	public ModelAndView listHouseType(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> solutionList = solutionService.SolutionlistPage(page);
			mv.setViewName("system/solution/solution");
			mv.addObject("solutionList", solutionList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "solution");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	
	/**
	 * 跳到添加页面
	 * @return
	 */
	@RequestMapping("/goAddS")
	public ModelAndView goAddS(Page page) {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		Date dt=new Date();
		SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	    String time= matter1.format(dt);
		int number=(int)((Math.random()*9+1)*1000);
		String so_id="S"+time+number;
		try 
		{
		 List<PageData> houseTypeList=solutionService.houseTypelistPage(page);
		 mv.addObject("houseTypeList", houseTypeList); //加载户型信息到下拉列表
		 List<PageData> housesList=housetypeService.HouseslistPage(page);
		 mv.addObject("housesList", housesList); //加载楼盘信息到下拉列表
		 mv.setViewName("system/solution/solution_edit");
		 pd.put("so_id", so_id);
		 mv.addObject("pd", pd);
		 mv.addObject("msg", "saveS");
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
	public ModelAndView goEditS(Page page) throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			List<PageData> housesList=housetypeService.HouseslistPage(page);
			mv.addObject("housesList", housesList); //加载楼盘信息到下拉列表
			List<PageData> houseTypeList=solutionService.houseTypelistPage(page);
			mv.addObject("houseTypeList", houseTypeList); //加载户型信息到下拉列表
			pd = solutionService.findSolutionById(pd);
			mv.setViewName("system/solution/solution_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
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
	@RequestMapping("/delSolution")
	@ResponseBody
	public Object delSolution() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			solutionService.delSolution(pd);
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
	@RequestMapping("/delSolutions")
	@ResponseBody
	public Object delSolutions() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String ids = (String) pd.get("ids");
			for (String id : ids.split(",")) {
				pd.put("so_id", id);
				solutionService.delSolution(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
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
		//获取系统时间
		String edtTime=DateUtil.getTime().toString();
		try {
			pd = this.getPageData();
		    solutionService.saveS(pd); //保存户型信息
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
			solutionService.editS(pd);
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
			titles.add("解决方案编号");
			titles.add("解决方案名称");
			titles.add("解决方案图纸");
			titles.add("解决方案描述");
			titles.add("建议价格");
			titles.add("所属户型");
			titles.add("所属楼盘");
			dataMap.put("titles", titles);
			
			List<PageData> itemList = solutionService.findSolutionList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("so_id"));
				vpd.put("var2", itemList.get(i).getString("so_name"));
				vpd.put("var3", itemList.get(i).getString("so_drawing"));
				vpd.put("var4", itemList.get(i).getString("so_describe"));
				vpd.put("var5", itemList.get(i).getString("so_price"));
				vpd.put("var6", itemList.get(i).getString("hou_name"));
				vpd.put("var7", itemList.get(i).getString("houses_name"));
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
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				@SuppressWarnings("unchecked")
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				//保存总错误信息集合
    			List<PageData> allErrList = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++)
				{
					//保存错误信息集合
	    			List<PageData> errList = new ArrayList<PageData>();
					Date dt=new Date();
					SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
				    String time= matter1.format(dt);
					int number=(int)((Math.random()*9+1)*1000);
					String so_id="S"+time+number;//生成户型解决方案id
					
					//-------------字段检验开始-----------------
					//方案名称检验
					String so_name=listPd.get(i).getString("var0");
					if(so_name==null || so_name.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "方案名称不能为空！");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//所属楼盘---------检验
					PageData Housespd = new PageData();
					PageData Housespd2 = new PageData();
					String houses_name = listPd.get(i).getString("var5");
					if(houses_name!=null && !houses_name.equals(""))
					{
						String house_name  = listPd.get(i).getString("var4");
						if(house_name!=null && !house_name.equals(""))
						{
							Housespd.put("house_name", house_name);
							Housespd.put("houses_name", houses_name);
							Housespd2= solutionService.housesByName(Housespd);
							if(Housespd2==null)
							{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "户型和楼盘不存在！");
		    	        		errPd.put("errCol", "5-6");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
						else
						{
							PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "所属户型不能为空！");
	    	        		errPd.put("errCol", "5");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "所属楼盘不能为空！");
    	        		errPd.put("errCol", "6");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//建议价格------------检验
					String so_price=listPd.get(i).get("var3").toString();
					if(so_price==null || so_price.equals(""))
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "建议价格不能为空！");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//------------------字段检验结束--------------------
					
		        	if(errList.size()==0)
				    {
		        		pd.put("so_id",so_id);
			        	pd.put("so_name", listPd.get(i).getString("var0"));
			        	pd.put("so_drawing_json", listPd.get(i).getString("var1"));
			        	pd.put("so_describe", listPd.get(i).getString("var2"));
			        	pd.put("so_price", listPd.get(i).get("var3").toString());
		        		pd.put("house_name",Housespd2.getString("hou_id"));
			        	pd.put("houses_name",Housespd2.getString("houses_no"));
				    	allErr = false;
				    	//保存至数据库
			        	solutionService.saveS(pd);
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
