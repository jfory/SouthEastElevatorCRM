package com.dncrm.controller.system.product;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.product.ProductService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.Const;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/product")
public class ProductController extends BaseController{

	@Resource(name = "productService")
	private ProductService productService;
	@Resource(name = "modelsService")
	private ModelsService modelsService;
	
	/**
	 * 产品线列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/productList")
	public ModelAndView productList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> productList = productService.listPdPageProduct(page);
		
		mv.addObject("product_name", pd.get("product_name"));
		mv.addObject("productList", productList);
		mv.addObject("page", page);
		mv.setViewName("system/product/product");
		return mv;
	}
	
	/**
	 * 跳转产品线新增页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toProductAdd")
	public ModelAndView toProductAdd() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		//查询电梯全部类型
		List<PageData> elevatorLits=productService.elevatorList(pd);
		mv.addObject("elevatorLits", elevatorLits);
		mv.addObject("msg", "productAdd");
		mv.setViewName("system/product/product_edit");
		return mv;
	}
	
	/**
	 * 跳转产品线编辑页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/toProductEdit")
	public ModelAndView toProductEdit() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			pd = productService.findProductById(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//查询电梯全部类型
		List<PageData> elevatorLits=productService.elevatorList(pd);
		mv.addObject("elevatorLits", elevatorLits);
		mv.addObject("pd", pd);
		mv.addObject("msg", "productEdit");
		mv.setViewName("system/product/product_edit");
		return mv;
	}
	
	/**
	 * 添加产品线
	 * @return
	 */
	@RequestMapping(value = "/productAdd")
	public ModelAndView productAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		pd.put("product_no", "0");
		try {
			productService.productAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("id", "AddProduct");
		mv.addObject("form", "productForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 编辑产品线
	 * @return
	 */
	@RequestMapping(value = "/productEdit")
	public ModelAndView productEdit(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			productService.productUpdate(pd);
			mv.addObject("id", "EditProduct");
			mv.addObject("form", "productForm");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		}
		
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除产品线
	 * @param product_id
	 * @param out
	 */
	@RequestMapping(value = "/productDelete")
	public void productDelete(String product_id,PrintWriter out){
		
		PageData pd = this.getPageData();
		try {
			productService.productDelete(pd);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 批量删除产品线
	 * @return\
	 */
	@RequestMapping(value = "/productDeleteAll")
	@ResponseBody
	public Object productDeleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<>();
		PageData pd = this.getPageData();
		String DATA_IDS  = pd.getString("DATA_IDS");
		try {
			if(DATA_IDS !=null && !"".equals(DATA_IDS)){
				String[] ArrayDATA_IDS = DATA_IDS.split(",");
				
					productService.productDeleteAll(ArrayDATA_IDS);
					pd.put("msg", "ok");
					pdList.add(pd);
					map.put("list", pdList);
				
			}else{
				pd.put("msg", "no");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}	
		return AppUtil.returnObject(pd, map);
	}
	

	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		PageData pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			//产品线导出
			titles.add("产品线ID");
			titles.add("产品线名称");
			titles.add("产品线编号");
			titles.add("产品线描述");
			dataMap.put("titles", titles);
			List<PageData> itemList = productService.findProductByIdList(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).get("product_id").toString());
				vpd.put("var2", itemList.get(i).getString("product_name"));
				vpd.put("var3", itemList.get(i).get("product_no").toString());
				vpd.put("var4", itemList.get(i).getString("product_description"));
				
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
		PageData pd = this.getPageData();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				PageData pds = new PageData();
				for(int i = 0;i<listPd.size();i++){
					if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
						pds.put("product_name", listPd.get(i).getString("var0"));
						pds.put("product_no", 0);
						pds.put("product_description", listPd.get(i).getString("var1"));
						productService.productAdd(pds);
					}
				}
				map.put("msg", "success");
	    	}else{
	    		map.put("errorMsg", "上传失败");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
}
