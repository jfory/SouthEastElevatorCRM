package com.dncrm.controller.system.houseType;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.dncrm.service.system.houseType.HouseTypeService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@RequestMapping("/houseType")
@Controller
public class HouseTypeController extends BaseController
{
	@Resource(name = "housetypeService")
	private HouseTypeService housetypeService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	/**
	 * 显示户型信息
	 *
	 * @return
	 */
	@RequestMapping("/houseType")
	public ModelAndView listHouseType(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> housetypeList = housetypeService.HouseTypelistPage(page);
			mv.setViewName("system/houseType/houseType");
			mv.addObject("housetypeList", housetypeList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "houseType");
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
		String hou_id="H"+time+number;
		try 
		{
		List<PageData> housesList=housetypeService.HouseslistPage(page);
		mv.addObject("housesList", housesList); //加载楼盘信息到下拉列表
		mv.setViewName("system/houseType/houseType_edit");
		pd.put("hou_id", hou_id);
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
			pd = housetypeService.findHouseTypeById(pd);
			mv.setViewName("system/houseType/houseType_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 *请求跳转单元页面
	 * @return
	 */
	@RequestMapping("/cell")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> cellList =housetypeService.celllistPage(page);
			mv.setViewName("system/cell/cell");
			mv.addObject("cellList", cellList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "houseType");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
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
	@RequestMapping("/delHouseType")
	@ResponseBody
	public Object delHouseType() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			housetypeService.delHouseType(pd);
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
	@RequestMapping("/delHouseTypes")
	@ResponseBody
	public Object delHouseTypes() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String ids = (String) pd.get("ids");
			for (String id : ids.split(",")) {
				pd.put("id", id);
				housetypeService.delHouseType(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 判断户型名称是否唯一
	 * @param binder
	 */
	@RequestMapping("/HouseTypeName")
	@ResponseBody
	public Object HouseTypeName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = housetypeService.findHouseTypeByName(pd);
			if (shop != null) {
				map.put("msg","error");
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
		//获取系统时间
		String edtTime=DateUtil.getTime().toString();
		try {
			pd = this.getPageData();
			pd.put("edtTime", edtTime);
		    housetypeService.saveS(pd); //保存户型信息
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
		//获取系统时间
		String edtTime=DateUtil.getTime().toString();
		try {
			pd = this.getPageData();
			pd.put("edtTime", edtTime);
			housetypeService.editS(pd);
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
	 *显示所属该户型的解决方案
	 * @return
	 */
	@RequestMapping("/solution")
	public ModelAndView solutionlistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> solutionList = housetypeService.solutionlistPage(page);
			mv.setViewName("system/solution/solution");
			if(solutionList.size()>0)
			{
				pd.put("houses_no",solutionList.get(0).getString("houses_no"));
			}
			mv.addObject("solutionList", solutionList);
			mv.addObject("pd", pd);
			mv.addObject("msg", "houseType");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
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
			titles.add("户型编号");
			titles.add("户型名称");
			titles.add("户型描述");
			titles.add("户型图附件");
			titles.add("录入时间");
			titles.add("所属楼盘ID");
			dataMap.put("titles", titles);
			List<PageData> itemList = housetypeService.findHouseTypeList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("hou_id"));
				vpd.put("var2", itemList.get(i).getString("hou_name"));
				vpd.put("var3", itemList.get(i).getString("hou_explain"));
				vpd.put("var4", itemList.get(i).getString("hou_drawing"));
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
				String edtTime = df.format(itemList.get(i).get("edtTime"));
				vpd.put("var5", edtTime);
				vpd.put("var6", itemList.get(i).getString("houses_name"));
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
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				//保存错误信息集合
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
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义时间格式
					String edtTime=df.format(dt);//获取当前系统日期
				    String time= matter1.format(dt);
					int number=(int)((Math.random()*9+1)*1000);
					String hou_id="H"+time+number;//生成户型编号
					//字段检验开始---------------------↓↓↓
					//楼盘名称----------检验
					String houses_name=listPd.get(i).getString("var3");
					PageData housesPd=new PageData();
					PageData housesPd2=new PageData();
					if(houses_name!=null && !houses_name.equals(""))
					{
						housesPd.put("houses_name", houses_name);//楼盘名称
						housesPd2=housetypeService.findHousesByName(housesPd);//获取楼盘id
						if(housesPd2==null)
						{
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "所属楼盘不存在!");
	    	        		errPd.put("errCol", "4");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);	
						}
						else
						{
							//户型名称----------检验
							String hou_name=listPd.get(i).getString("var0");
							if(hou_name!=null && !hou_name.equals(""))
							{
								housesPd.put("hou_name", hou_name);//户型名称
								PageData housesPd3=housetypeService.findHouseTypeByName(housesPd);//判断户型名称是否唯一
								if(housesPd3!=null)
								{
									//保存具体的字段的错误信息
					        		PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "户型名称重复!");
			    	        		errPd.put("errCol", "1");
			    	        		errPd.put("errRow", i+1);
			    	        		errList.add(errPd);
								}
							}
							else
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "户型名称不能为空!");
		    	        		errPd.put("errCol", "1");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "所属楼盘不能为空!");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//字段检验结束*********************
					
					if(errList.size()==0)
					{
						pd.put("hou_id",hou_id);
			        	pd.put("hou_name",listPd.get(i).getString("var0"));
			        	pd.put("explain",listPd.get(i).getString("var1"));
			        	pd.put("drawing_json",listPd.get(i).getString("var2"));
			        	pd.put("edtTime",edtTime);
			        	pd.put("houses_name",housesPd2.get("houses_no").toString());
						allErr = false;
			        	//保存至数据库
			        	housetypeService.saveS(pd);
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
	
	 /**
     * 异步上传
     * @param file
     * @return
     */
    @RequestMapping(value = "/upload")
    @ResponseBody
    public Object upload(@RequestParam(value = "file") MultipartFile file){
    	String ffile=DateUtil.getDay(),fileName="";
    	JSONObject result = new JSONObject();
    	if(file!=null && !file.isEmpty()){
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"houses/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "houseType/" + ffile + "/" + fileName);   //houses是存放上传的文件的文件夹
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }

	
    /**
     * 下载文件
     */
    @RequestMapping(value = "/down")
    public void downExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String downFile = request.getParameter("downFile");
        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + downFile, downFile);
    }
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
}
