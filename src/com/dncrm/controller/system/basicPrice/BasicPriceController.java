package com.dncrm.controller.system.basicPrice;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.basicPrice.BasicPriceService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;


@Controller
@RequestMapping(value = "/basicPrice")
public class BasicPriceController extends BaseController{

	@Resource(name = "basicPriceService")
	private BasicPriceService basicPriceService;
    //直梯基础价格维护相关功能
	/**
	 * 电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "regelevStandardList")
	public ModelAndView elevatorStandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setFormNo(0);
		page.setPd(pd);
		List<PageData> regelevStandardList = basicPriceService.listPageRegelevStandard(page);
		pd.put("isActive2","1");
		mv.addObject("pd",pd);
		mv.addObject("regelevStandardList", regelevStandardList);
		//将页面的参数继续保存到页面
		mv.addObject("ZNAME", pd.get("NAME"));
		mv.addObject("SD", pd.get("SD"));
		mv.addObject("ZZ", pd.get("ZZ"));
		mv.addObject("C", pd.get("C"));
		mv.addObject("TSGD", pd.get("TSGD"));
		mv.setViewName("system/basicPrice/regelevStandard");
		return mv;
	}
	
	/**
	 * 跳转到新增
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddRegelevStandard")
	public ModelAndView goAddElevatorStandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		//跳转新增页面,弹出框选择cod
		mv.setViewName("system/basicPrice/regelevStandard_edit");
		
		mv.addObject("msg", "addRegelevStandard");
		return mv;
	}
	
	/**
	 * 保存 新增基础价格维护
	 * @return
	 */
	@RequestMapping(value = "addRegelevStandard")
	public ModelAndView addElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			pd.put("ID", this.get32UUID());
			basicPriceService.regelevStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到编辑
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goEditBasicPrice")
	public ModelAndView goEditBasicPrice() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		try {
			pd=basicPriceService.findById(pd);
		} catch (Exception e) {
			// TODO: handle exception
		}
		//跳转新增页面,弹出框选择cod
		mv.setViewName("system/basicPrice/regelevStandard_edit");
		mv.addObject("pd", pd);
		mv.addObject("msg", "EditBasicPrice");
		return mv;
	}
	
	
	/**
	 * 保存 编辑
	 * @return
	 */
	@RequestMapping(value = "EditBasicPrice")
	public ModelAndView EditBasicPrice(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			basicPriceService.editS(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除数据
	 * @param binder
	 */
	@RequestMapping("/delBasicPrice")
	@ResponseBody
	public Object delBasicPrice() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try {
			basicPriceService.delete(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 删除多条数据
	 * @param binder
	 */
	@RequestMapping("/delAll")
	@ResponseBody
	public Object delAll() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String ids = (String) pd.get("ids");
			for (String id : ids.split(",")) {
				pd.put("ID", id);
				basicPriceService.delete(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
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
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				
				//保存总错误信息集合
    			List<PageData> allErrList  = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				PageData existPd = new PageData();
				for(int i = 0;i<listPd.size();i++)
				{
					//保存该条数据错误信息
					List<PageData> errList = new ArrayList<PageData>();
					
			        //↓↓↓----如果字段检验没有错误，执行保存操作----↓↓↓
				   if(errList.size()==0)
			       {
					   String name = listPd.get(i).getString("var0");
					   String c = listPd.get(i).getString("var1");
					   String sd = listPd.get(i).get("var4").toString();
					   String zz = listPd.get(i).get("var5").toString();
					   existPd.put("NAME", name);
					   existPd.put("SD", sd);
					   existPd.put("ZZ", zz);
					   existPd.put("C", c);
					   List<PageData> exList = basicPriceService.findbasicPriceList(existPd);
					   if(exList != null && exList.size() > 0) {
						   PageData epd = exList.get(0);
						   epd.put("Z", listPd.get(i).getString("var2"));
						   epd.put("M", listPd.get(i).getString("var3"));
						   epd.put("TSGD", listPd.get(i).getString("var6"));
						   epd.put("BZDKS", listPd.get(i).getString("var7"));
						   epd.put("BZDCG", listPd.get(i).getString("var8"));
						   epd.put("BZJDG", listPd.get(i).getString("var9"));
						   epd.put("EWAI", listPd.get(i).getString("var10"));
						   epd.put("JJ", listPd.get(i).getString("var11"));
						   epd.put("PRICE", listPd.get(i).getString("var12"));
						   epd.put("KS_TIME", "");
						   epd.put("END_TIME","");
						   basicPriceService.editS(epd);
					   } else {
						   Date dt=new Date();
					        pd.put("ID", this.get32UUID());
					        pd.put("NAME", listPd.get(i).getString("var0"));
					        pd.put("C", listPd.get(i).getString("var1"));
					        pd.put("Z", listPd.get(i).getString("var2"));
					        pd.put("M", listPd.get(i).getString("var3"));
					        pd.put("SD", listPd.get(i).get("var4").toString());
					        pd.put("ZZ", listPd.get(i).get("var5").toString());
					        pd.put("TSGD", listPd.get(i).getString("var6"));
					        pd.put("BZDKS", listPd.get(i).getString("var7"));
					        pd.put("BZDCG", listPd.get(i).getString("var8"));
					        pd.put("BZJDG", listPd.get(i).getString("var9"));
					        pd.put("EWAI", listPd.get(i).getString("var10"));
					        pd.put("JJ", listPd.get(i).getString("var11"));
					        pd.put("PRICE", listPd.get(i).getString("var12"));
					        pd.put("KS_TIME", "");
					        pd.put("END_TIME","");
						    allErr = false;
				        	//保存至数据库
						    basicPriceService.regelevStandardAdd(pd);
					   }
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
	
	//扶梯基础价格维护相关功能
	/**
	 * 扶梯基础价格 列表
	 */
	@RequestMapping(value = "F_basicPricelistPage")
	public ModelAndView F_basicPricelistPage(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//如果有多个form,设置第几个,从0开始设置分页
		page.setFormNo(1);
		page.setPd(pd);
		List<PageData> F_basicPriceList = basicPriceService.F_basicPricelistPage(page);
		pd.put("isActive3","1");
		mv.addObject("pd",pd);
		mv.addObject("F_basicPriceList", F_basicPriceList);
		//将页面的参数继续保存到页面
		mv.addObject("NAME", pd.get("NAME"));
		mv.addObject("GG", pd.get("GG"));
		mv.addObject("XJ", pd.get("XJ"));
		mv.addObject("KD", pd.get("KD"));
		mv.setViewName("system/basicPrice/regelevStandard");
		return mv;
	}
	
	/**
	 * 跳转到新增
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddFbasicPrice")
	public ModelAndView goAddFbasicPrice() throws Exception{
		ModelAndView mv = new ModelAndView();
		//跳转新增页面,弹出框选择cod
		mv.setViewName("system/basicPrice/regelevStandard_editF");
		
		mv.addObject("msg", "saveF");
		return mv;
	}
	
	/**
	 * 保存 新增基础价格维护
	 * @return
	 */
	@RequestMapping(value = "saveF")
	public ModelAndView saveF(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			pd.put("ID", this.get32UUID());
			basicPriceService.saveF(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 跳转到编辑
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goEditF_BasicPrice")
	public ModelAndView goEditF_BasicPrice() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		try {
			pd=basicPriceService.findByF_BPId(pd);
		} catch (Exception e) {
			// TODO: handle exception
		}
		//跳转新增页面,弹出框选择cod
		mv.setViewName("system/basicPrice/regelevStandard_editF");
		mv.addObject("pd", pd);
		mv.addObject("msg", "EditF");
		return mv;
	}
	
	
	/**
	 * 保存 编辑
	 * @return
	 */
	@RequestMapping(value = "EditF")
	public ModelAndView EditF(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			basicPriceService.editF(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除数据
	 * @param binder
	 */
	@RequestMapping("/deleteF")
	@ResponseBody
	public Object deleteF() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try {
			basicPriceService.deleteF(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 删除多条数据
	 * @param binder
	 */
	@RequestMapping("/delFAll")
	@ResponseBody
	public Object delFAll() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String ids = (String) pd.get("ids");
			for (String id : ids.split(",")) {
				pd.put("ID", id);
				basicPriceService.deleteF(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *导入Excel到数据库 
	 */
	@RequestMapping(value="importExcelF")
	@ResponseBody
	public Object importExcelF(@RequestParam(value = "file") MultipartFile file){
		Map<String, Object> map = new HashMap<String, Object>();
		//获取系统时间
		String df=DateUtil.getTime().toString();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				
				//保存总错误信息集合
    			List<PageData> allErrList  = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				PageData existPd = new PageData();
				for(int i = 0;i<listPd.size();i++)
				{
					//保存该条数据错误信息
					List<PageData> errList = new ArrayList<PageData>();
					
			        //↓↓↓----如果字段检验没有错误，执行保存操作----↓↓↓
				   if(errList.size()==0)
			       {
					   String name = listPd.get(i).getString("var0");
					   String tsgd = listPd.get(i).getString("var1");
					   String qxjd = listPd.get(i).getString("var2");
					   String tjkd = listPd.get(i).getString("var3");
					   existPd.put("NAME", name);
					   existPd.put("TSGD", tsgd);
					   existPd.put("QXJD", qxjd);
					   existPd.put("TJKD", tjkd);
					   List<PageData> exList = basicPriceService.findbasicPriceFList(existPd);
					   if(exList != null && exList.size() > 0) {
						   PageData epd = exList.get(0);
						   epd.put("PRICE", listPd.get(i).get("var4").toString());
						   epd.put("KS_TIME", "");
						   epd.put("END_TIME","");
						   basicPriceService.editF(epd);
					   } else {
						   	pd.put("ID", this.get32UUID());
					        pd.put("NAME", listPd.get(i).getString("var0"));
					        pd.put("TSGD", listPd.get(i).getString("var1"));
					        pd.put("QXJD", listPd.get(i).getString("var2"));
					        pd.put("TJKD", listPd.get(i).getString("var3"));
					        pd.put("PRICE", listPd.get(i).get("var4").toString());
					        pd.put("KS_TIME", "");
					        pd.put("END_TIME","");
						    allErr = false;
				        	//保存至数据库
						    basicPriceService.saveF(pd);
					   }
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
	
	@RequestMapping(value="isExistBascPrice")
	@ResponseBody
	public Object isExistBascPrice(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			boolean existBascPrice = basicPriceService.isExistBascPrice(pd);
			map.put("exist", "1");
			if(!existBascPrice) {
				map.put("exist", "0");
			}
			map.put("code", "1");
		}catch(Exception e){
			map.put("code", "0");
			logger.error(e.getMessage(), e);
		}
		return map;
	}

	@RequestMapping(value="isExistBascPriceF")
	@ResponseBody
	public Object isExistBascPriceF(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			boolean existBascPrice = basicPriceService.isExistBascPriceF(pd);
			map.put("exist", "1");
			if(!existBascPrice) {
				map.put("exist", "0");
			}
			map.put("code", "1");
		}catch(Exception e){
			map.put("code", "0");
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
}
